import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../domain/reminder_config.dart';

abstract interface class ReminderRepository {
  Stream<ReminderConfig> watch(String userId);
  Future<ReminderConfig> get(String userId);
  Future<void> save(String userId, ReminderConfig config);
}

class ReminderRepositoryImpl implements ReminderRepository {
  ReminderRepositoryImpl(this._db);
  final AppDatabase _db;

  static const _defaults = ReminderConfig(
    enabled: false,
    startMinutes: AppConstants.defaultReminderStartMinutes,
    endMinutes: AppConstants.defaultReminderEndMinutes,
    intervalMinutes: AppConstants.defaultReminderIntervalMinutes,
    weekdays: {1, 2, 3, 4, 5, 6, 7},
    snoozeMinutes: AppConstants.defaultSnoozeMinutes,
  );

  static ReminderConfig _toConfig(ReminderSettingsRow? r) => r == null
      ? _defaults
      : ReminderConfig(
          enabled: r.enabled,
          startMinutes: r.startMinutes,
          endMinutes: r.endMinutes,
          intervalMinutes: r.intervalMinutes,
          weekdays: ReminderConfig.decodeWeekdays(r.weekdays),
          snoozeMinutes: r.snoozeMinutes,
        );

  @override
  Stream<ReminderConfig> watch(String userId) => _db.userDao.watchReminderSettings(userId).map(_toConfig);

  @override
  Future<ReminderConfig> get(String userId) async => _toConfig(await _db.userDao.getReminderSettings(userId));

  @override
  Future<void> save(String userId, ReminderConfig c) => _db.userDao.saveReminderSettings(ReminderSettingsCompanion(
        userId: Value(userId),
        enabled: Value(c.enabled),
        startMinutes: Value(c.startMinutes),
        endMinutes: Value(c.endMinutes),
        intervalMinutes: Value(c.intervalMinutes),
        weekdays: Value(ReminderConfig.encodeWeekdays(c.weekdays)),
        snoozeMinutes: Value(c.snoozeMinutes),
      ));
}
