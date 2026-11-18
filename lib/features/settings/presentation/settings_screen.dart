import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/gamification_rules.dart';
import '../../../core/utils/volume_format.dart';
import '../../hydration/presentation/providers/hydration_providers.dart';
import '../../profile/presentation/providers/session_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _maxQuickAmounts = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = ref.watch(unitSystemProvider);
    final amounts = ref.watch(quickAmountsProvider);
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Text('Unidades', style: t.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<UnitSystem>(
            segments: const [
              ButtonSegment(value: UnitSystem.metric, label: Text('Mililitros (ml)')),
              ButtonSegment(value: UnitSystem.imperial, label: Text('Onzas (oz)')),
            ],
            selected: {unit},
            onSelectionChanged: (s) {
              final userId = ref.read(currentUserIdProvider);
              if (userId != null) ref.read(profileRepositoryProvider).updateUnitSystem(userId, s.first);
            },
          ),
          const SizedBox(height: 24),
          Text('Accesos rápidos', style: t.titleMedium),
          const SizedBox(height: 4),
          const Text('Las cantidades que aparecen en Inicio para registrar con un toque.'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final ml in amounts)
                InputChip(
                  label: Text(VolumeFormat.format(ml, unit)),
                  onDeleted: amounts.length <= 1
                      ? null
                      : () => ref.read(quickAmountsProvider.notifier).set([...amounts]..remove(ml)),
                  deleteButtonTooltipMessage: 'Quitar',
                ),
              if (amounts.length < _maxQuickAmounts)
                ActionChip(
                  avatar: const Icon(Icons.add, size: 18),
                  label: const Text('Agregar'),
                  onPressed: () => _addAmount(context, ref, amounts, unit),
                ),
            ],
          ),
          TextButton(
            onPressed: () => ref.read(quickAmountsProvider.notifier).set(AppConstants.defaultQuickAmountsMl),
            child: const Text('Restablecer valores por defecto'),
          ),
          const SizedBox(height: 16),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              ListTile(
                leading: const Icon(Icons.notifications_outlined, color: AppColors.primary),
                title: const Text('Recordatorios y notificaciones'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/reminders'),
              ),
              ListTile(
                leading: const Icon(Icons.flag_outlined, color: AppColors.primary),
                title: const Text('Meta diaria'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/goals'),
              ),
            ]),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16)),
            child: const Text(
              'AquaLife es una herramienta de seguimiento de hábitos y no sustituye el consejo médico. '
              'Tus datos se guardan solo en este dispositivo.',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addAmount(BuildContext context, WidgetRef ref, List<int> amounts, UnitSystem unit) async {
    final ctrl = TextEditingController();
    final suffix = unit == UnitSystem.metric ? 'ml' : 'oz';
    int? parse(String text) {
      final v = double.tryParse(text.replaceAll(',', '.').trim());
      if (v == null) return null;
      return unit == UnitSystem.metric ? v.round() : VolumeFormat.fromFlOz(v);
    }

    final ml = await showDialog<int>(
      context: context,
      builder: (ctx) {
        final formKey = GlobalKey<FormState>();
        return AlertDialog(
          title: const Text('Nuevo acceso rápido'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: ctrl,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Cantidad', suffixText: suffix),
              validator: (v) {
                final ml = parse(v ?? '');
                if (ml == null || !GamificationRules.isValidIntakeAmount(ml)) return 'Cantidad no válida';
                if (amounts.contains(ml)) return 'Ya existe';
                return null;
              },
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size(64, 44)),
              onPressed: () {
                if (formKey.currentState!.validate()) Navigator.pop(ctx, parse(ctrl.text));
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
    ctrl.dispose();
    if (ml != null) {
      await ref.read(quickAmountsProvider.notifier).set([...amounts, ml]..sort());
    }
  }
}
