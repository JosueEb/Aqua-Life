import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/providers/core_providers.dart';
import '../../profile/presentation/providers/session_providers.dart';
import '../domain/reminder_config.dart';
import 'reminder_providers.dart';

/// /reminders — configuración de recordatorios locales.
class RemindersScreen extends ConsumerStatefulWidget {
  const RemindersScreen({super.key});

  @override
  ConsumerState<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends ConsumerState<RemindersScreen> with WidgetsBindingObserver {
  ReminderConfig? _draft;
  bool? _permission;
  bool _saving = false;

  static const _intervals = [30, 45, 60, 90, 120, 180];
  static const _snoozes = [5, 10, 15, 30];
  static const _dayLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Al volver de los ajustes del sistema, el permiso pudo cambiar.
    if (state == AppLifecycleState.resumed) _checkPermission();
  }

  Future<void> _checkPermission() async {
    try {
      final service = ref.read(notificationServiceProvider);
      await service.init();
      final granted = await service.hasPermission();
      if (mounted) setState(() => _permission = granted);
    } catch (_) {
      if (mounted) setState(() => _permission = false);
    }
  }

  Future<void> _toggle(ReminderConfig c, bool enabled) async {
    if (enabled && _permission != true) {
      final granted = await ref.read(notificationServiceProvider).requestPermission();
      if (!mounted) return;
      setState(() => _permission = granted);
      if (!granted) return;
    }
    setState(() => _draft = c.copyWith(enabled: enabled));
    await _save();
  }

  Future<void> _save() async {
    final c = _draft;
    final userId = ref.read(currentUserIdProvider);
    if (c == null || userId == null) return;
    final error = c.validate();
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    setState(() => _saving = true);
    await ref.read(reminderRepositoryProvider).save(userId, c);
    await ref.read(reminderSyncProvider).sync();
    if (!mounted) return;
    setState(() => _saving = false);
    final count = ReminderScheduler.upcoming(c, ref.read(clockProvider)()).length;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(c.enabled ? 'Recordatorios guardados · $count programados' : 'Recordatorios desactivados'),
    ));
  }

  Future<int?> _pickTime(int minutes) async {
    final t = await showTimePicker(context: context, initialTime: TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60));
    return t == null ? null : t.hour * 60 + t.minute;
  }

  String _fmt(int minutes) => '${(minutes ~/ 60).toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final saved = ref.watch(reminderConfigProvider);
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Recordatorios')),
      body: saved.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('No pudimos cargar los recordatorios.')),
        data: (savedConfig) {
          final c = _draft ?? savedConfig;
          final dirty = _draft != null && !_same(_draft!, savedConfig);
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            children: [
              Card(
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  title: Text('Recordatorios', style: t.titleMedium),
                  subtitle: const Text('Avisos locales para beber agua, sin internet.'),
                  value: c.enabled,
                  onChanged: _saving ? null : (v) => _toggle(c, v),
                ),
              ),
              if (_permission == false) ...[
                const SizedBox(height: 12),
                const _PermissionBanner(),
              ],
              const SizedBox(height: 20),
              Opacity(
                opacity: c.enabled ? 1 : 0.5,
                child: IgnorePointer(
                  ignoring: !c.enabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Horario', style: t.titleMedium),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.wb_sunny_outlined),
                              label: Text('Desde ${_fmt(c.startMinutes)}'),
                              onPressed: () async {
                                final m = await _pickTime(c.startMinutes);
                                if (m != null) setState(() => _draft = c.copyWith(startMinutes: m));
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.nightlight_outlined),
                              label: Text('Hasta ${_fmt(c.endMinutes)}'),
                              onPressed: () async {
                                final m = await _pickTime(c.endMinutes);
                                if (m != null) setState(() => _draft = c.copyWith(endMinutes: m));
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Cada cuánto', style: t.titleMedium),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final i in _intervals)
                            ChoiceChip(
                              label: Text(i < 60 ? '$i min' : i % 60 == 0 ? '${i ~/ 60} h' : '${i ~/ 60} h ${i % 60}'),
                              selected: c.intervalMinutes == i,
                              onSelected: (_) => setState(() => _draft = c.copyWith(intervalMinutes: i)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Días', style: t.titleMedium),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var d = 1; d <= 7; d++)
                            _DayToggle(
                              label: _dayLabels[d - 1],
                              selected: c.weekdays.contains(d),
                              onTap: () {
                                final days = {...c.weekdays};
                                days.contains(d) ? days.remove(d) : days.add(d);
                                setState(() => _draft = c.copyWith(weekdays: days));
                              },
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Posponer', style: t.titleMedium),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          for (final s in _snoozes)
                            ChoiceChip(
                              label: Text('$s min'),
                              selected: c.snoozeMinutes == s,
                              onSelected: (_) => setState(() => _draft = c.copyWith(snoozeMinutes: s)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      FilledButton(onPressed: dirty && !_saving ? _save : null, child: const Text('Guardar cambios')),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.notifications_active_outlined),
                        label: const Text('Enviar notificación de prueba'),
                        onPressed: () => ref.read(notificationServiceProvider).showTest(snoozeMinutes: c.snoozeMinutes),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Si cumples tu meta del día, Aqua deja de avisarte hasta mañana. '
                'El sistema puede retrasar o agrupar notificaciones para ahorrar batería.',
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }

  static bool _same(ReminderConfig a, ReminderConfig b) =>
      a.enabled == b.enabled &&
      a.startMinutes == b.startMinutes &&
      a.endMinutes == b.endMinutes &&
      a.intervalMinutes == b.intervalMinutes &&
      a.snoozeMinutes == b.snoozeMinutes &&
      a.weekdays.length == b.weekdays.length &&
      a.weekdays.containsAll(b.weekdays);
}

class _DayToggle extends StatelessWidget {
  const _DayToggle({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? AppColors.primary : AppColors.surface,
            border: Border.all(color: AppColors.primary),
          ),
          child: Text(label,
              style: TextStyle(fontWeight: FontWeight.w700, color: selected ? Colors.white : AppColors.primaryDark)),
        ),
      ),
    );
  }
}

class _PermissionBanner extends StatelessWidget {
  const _PermissionBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.reward.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.notifications_off_outlined, color: AppColors.textPrimary),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Las notificaciones están desactivadas para AquaLife. Actívalas en los ajustes del '
              'sistema para recibir recordatorios.',
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
