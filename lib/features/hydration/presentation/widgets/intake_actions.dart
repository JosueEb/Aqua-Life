import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/constants/gamification_rules.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/volume_format.dart';
import '../../../profile/presentation/providers/session_providers.dart';
import '../../../reminders/presentation/reminder_providers.dart';
import '../../domain/entities/water_intake.dart';
import '../providers/hydration_providers.dart';

/// Acciones de consumo reutilizables (registrar, editar, eliminar) con
/// manejo de errores y aviso de recompensas.
abstract final class IntakeActions {
  static Future<void> add(BuildContext context, WidgetRef ref, int amountMl, {DateTime? consumedAt}) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final unit = ref.read(unitSystemProvider);
    try {
      final result = await ref.read(addWaterIntakeProvider)(userId, amountMl, consumedAt: consumedAt);
      HapticFeedback.lightImpact();
      ref.read(reminderSyncProvider).sync();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(_message(result, unit))));
    } on ValidationFailure catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (_) {
      messenger.showSnackBar(const SnackBar(content: Text('No se pudo guardar el registro.')));
    }
  }

  static String _message(IntakeResult r, UnitSystem unit) {
    final base = '+${VolumeFormat.format(r.intake.amountMl, unit)} registrados';
    final rewards = [
      if (r.xpEarned > 0) '+${r.xpEarned} XP',
      if (r.coinsEarned > 0) '+${r.coinsEarned} monedas',
    ].join(' · ');
    final headline = r.unlockedAchievements.isNotEmpty
        ? '¡Logro desbloqueado: ${r.unlockedAchievements.join(', ')}!'
        : r.rewards.any((g) => g.source == RewardSource.streak)
            ? '¡Racha de 7 días!'
            : r.rewards.any((g) => g.source == RewardSource.dailyGoal)
                ? '¡Meta cumplida!'
                : base;
    return rewards.isEmpty ? headline : '$headline $rewards';
  }

  static Future<void> edit(BuildContext context, WidgetRef ref, WaterIntake intake) async {
    final result = await showModalBottomSheet<(int, DateTime)>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => IntakeFormSheet(initialMl: intake.amountMl, initialTime: intake.consumedAt, title: 'Editar registro'),
    );
    if (result == null || !context.mounted) return;
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final r = await ref.read(updateWaterIntakeProvider)(userId, intake.id, result.$1, result.$2);
      ref.read(reminderSyncProvider).sync();
      messenger.showSnackBar(SnackBar(
        content: Text(r.xpEarned > 0 ? 'Registro actualizado · +${r.xpEarned} XP' : 'Registro actualizado'),
      ));
    } on ValidationFailure catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } on NotFoundFailure catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  static Future<void> delete(BuildContext context, WidgetRef ref, WaterIntake intake) async {
    final unit = ref.read(unitSystemProvider);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar registro'),
        content: Text('¿Eliminar ${VolumeFormat.format(intake.amountMl, unit)} de las '
            '${DateFormat.Hm('es').format(intake.consumedAt)}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error, minimumSize: const Size(64, 44)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    await ref.read(deleteWaterIntakeProvider)(userId, intake.id);
    ref.read(reminderSyncProvider).sync();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registro eliminado')));
    }
  }
}

/// Formulario de cantidad y hora (crear personalizado o editar).
class IntakeFormSheet extends ConsumerStatefulWidget {
  const IntakeFormSheet({super.key, this.initialMl, this.initialTime, this.title = 'Otra cantidad', this.onSubmit});

  final int? initialMl;
  final DateTime? initialTime;
  final String title;

  /// Si se indica, se llama al guardar en lugar de cerrar con `Navigator.pop`.
  final void Function(int ml, DateTime time)? onSubmit;

  @override
  ConsumerState<IntakeFormSheet> createState() => _IntakeFormSheetState();
}

class _IntakeFormSheetState extends ConsumerState<IntakeFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _ctrl;
  late DateTime _time;
  late UnitSystem _unit;

  @override
  void initState() {
    super.initState();
    _unit = ref.read(unitSystemProvider);
    final ml = widget.initialMl;
    _ctrl = TextEditingController(
      text: ml == null
          ? ''
          : _unit == UnitSystem.metric
              ? '$ml'
              : VolumeFormat.toFlOz(ml).toStringAsFixed(1),
    );
    _time = widget.initialTime ?? DateTime.now();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  int? _parseMl(String? text) {
    final v = double.tryParse((text ?? '').replaceAll(',', '.').trim());
    if (v == null) return null;
    return _unit == UnitSystem.metric ? v.round() : VolumeFormat.fromFlOz(v);
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_time));
    if (t != null) {
      setState(() => _time = DateTime(_time.year, _time.month, _time.day, t.hour, t.minute));
    }
  }

  @override
  Widget build(BuildContext context) {
    final suffix = _unit == UnitSystem.metric ? 'ml' : 'oz';
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 24 + MediaQuery.viewInsetsOf(context).bottom),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ctrl,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Cantidad', suffixText: suffix),
              validator: (v) {
                final ml = _parseMl(v);
                if (ml == null) return 'Escribe una cantidad';
                if (!GamificationRules.isValidIntakeAmount(ml)) {
                  return 'Entre ${VolumeFormat.format(GamificationRules.minIntakeMl, _unit)} y '
                      '${VolumeFormat.format(GamificationRules.maxIntakeMl, _unit)}';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickTime,
              icon: const Icon(Icons.schedule),
              label: Text('Hora: ${DateFormat.Hm('es').format(_time)}'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                final ml = _parseMl(_ctrl.text)!;
                final submit = widget.onSubmit;
                if (submit != null) {
                  submit(ml, _time);
                } else {
                  Navigator.pop(context, (ml, _time));
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
