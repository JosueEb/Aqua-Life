import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/notifications/notification_service.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/utils/local_date.dart';
import '../../profile/presentation/providers/session_providers.dart';
import '../data/reminder_repository.dart';
import '../domain/reminder_config.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) => NotificationService());

final reminderRepositoryProvider =
    Provider<ReminderRepository>((ref) => ReminderRepositoryImpl(ref.watch(appDatabaseProvider)));

final reminderConfigProvider = StreamProvider<ReminderConfig>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const Stream.empty();
  return ref.watch(reminderRepositoryProvider).watch(userId);
});

/// Mantiene programados los próximos recordatorios.
class ReminderSync {
  ReminderSync(this._ref);
  final Ref _ref;

  Future<void> sync() async {
    final userId = _ref.read(currentUserIdProvider);
    if (userId == null) return;
    try {
      final service = _ref.read(notificationServiceProvider);
      await service.init();
      final config = await _ref.read(reminderRepositoryProvider).get(userId);
      if (!config.enabled) {
        await service.cancelReminders();
        return;
      }
      final now = _ref.read(clockProvider)();
      final today = LocalDate.keyOf(now);
      final db = _ref.read(appDatabaseProvider);
      final total = await db.hydrationDao.totalForDate(userId, today);
      final goal = (await db.hydrationDao.goalForDate(userId, today))?.dailyGoalMl ?? 0;
      // Con la meta del día cumplida no se envían más avisos hoy.
      final skipToday = goal > 0 && total >= goal;
      await service.scheduleReminders(
        ReminderScheduler.upcoming(config, now, skipDate: skipToday ? today : null),
        snoozeMinutes: config.snoozeMinutes,
      );
    } catch (e, st) {
      // Las notificaciones son una mejora: un fallo nunca debe romper el registro.
      debugPrint('ReminderSync falló: $e\n$st');
    }
  }
}

final reminderSyncProvider = Provider<ReminderSync>((ref) => ReminderSync(ref));
