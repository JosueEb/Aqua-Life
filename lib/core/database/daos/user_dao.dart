import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/gamification_tables.dart';
import '../tables/profile_tables.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users, ReminderSettings, GamificationProfiles, Pets])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<UserRow?> findById(String id) => (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();

  Stream<UserRow?> watchById(String id) => (select(users)..where((u) => u.id.equals(id))).watchSingleOrNull();

  Future<void> insertUser(UsersCompanion user) => into(users).insert(user);

  Future<void> updateUser(String id, UsersCompanion changes) =>
      (update(users)..where((u) => u.id.equals(id))).write(changes);

  Future<void> insertReminderSettings(ReminderSettingsCompanion settings) =>
      into(reminderSettings).insert(settings);

  Future<ReminderSettingsRow?> getReminderSettings(String userId) =>
      (select(reminderSettings)..where((r) => r.userId.equals(userId))).getSingleOrNull();

  Stream<ReminderSettingsRow?> watchReminderSettings(String userId) =>
      (select(reminderSettings)..where((r) => r.userId.equals(userId))).watchSingleOrNull();

  Future<void> saveReminderSettings(ReminderSettingsCompanion settings) =>
      into(reminderSettings).insertOnConflictUpdate(settings);

  Future<void> insertGamificationProfile(String userId) =>
      into(gamificationProfiles).insert(GamificationProfilesCompanion.insert(userId: userId));

  Future<void> insertPet(String userId) => into(pets).insert(PetsCompanion.insert(userId: userId));
}
