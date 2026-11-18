import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/local_date.dart';
import '../../../../core/utils/volume_format.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._db, this._uuid);

  final AppDatabase _db;
  final Uuid _uuid;

  @override
  Future<String> completeOnboarding(OnboardingData data, DateTime now) async {
    if (!data.isGuest && (data.name == null || data.name!.trim().isEmpty)) {
      throw const ValidationFailure('Escribe un nombre para tu perfil.');
    }
    if (data.dailyGoalMl < AppConstants.minDailyGoalMl || data.dailyGoalMl > AppConstants.maxDailyGoalMl) {
      throw const ValidationFailure('La meta diaria está fuera del rango permitido.');
    }
    final id = _uuid.v4();
    String? clean(String? s) => (s == null || s.trim().isEmpty) ? null : s.trim();

    await _db.transaction(() async {
      await _db.userDao.insertUser(UsersCompanion.insert(
        id: id,
        name: Value(data.isGuest ? null : clean(data.name)),
        email: Value(data.isGuest ? null : clean(data.email)),
        weightKg: Value(data.weightKg),
        unitSystem: Value(data.unitSystem.name),
        isGuest: Value(data.isGuest),
        onboardingCompleted: const Value(true),
        createdAt: now.toUtc(),
      ));
      await _db.hydrationDao.insertGoal(HydrationGoalsCompanion.insert(
        userId: id,
        dailyGoalMl: data.dailyGoalMl,
        startDate: LocalDate.keyOf(now),
      ));
      await _db.userDao.insertGamificationProfile(id);
      await _db.userDao.insertPet(id);
      await _db.userDao.insertReminderSettings(ReminderSettingsCompanion.insert(
        userId: id,
        startMinutes: AppConstants.defaultReminderStartMinutes,
        endMinutes: AppConstants.defaultReminderEndMinutes,
        intervalMinutes: AppConstants.defaultReminderIntervalMinutes,
        snoozeMinutes: AppConstants.defaultSnoozeMinutes,
      ));
    });
    return id;
  }

  @override
  Future<void> updateUnitSystem(String userId, UnitSystem unit) =>
      _db.userDao.updateUser(userId, UsersCompanion(unitSystem: Value(unit.name)));

  @override
  Stream<UserProfile?> watchProfile(String userId) => _db.userDao.watchById(userId).map((row) => row == null
      ? null
      : UserProfile(
          id: row.id,
          isGuest: row.isGuest,
          unitSystem: UnitSystem.fromName(row.unitSystem),
          name: row.name,
          email: row.email,
          weightKg: row.weightKg,
        ));
}
