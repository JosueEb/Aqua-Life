// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dao.dart';

// ignore_for_file: type=lint
mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $ReminderSettingsTable get reminderSettings =>
      attachedDatabase.reminderSettings;
  $GamificationProfilesTable get gamificationProfiles =>
      attachedDatabase.gamificationProfiles;
  $PetsTable get pets => attachedDatabase.pets;
  UserDaoManager get managers => UserDaoManager(this);
}

class UserDaoManager {
  final _$UserDaoMixin _db;
  UserDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$ReminderSettingsTableTableManager get reminderSettings =>
      $$ReminderSettingsTableTableManager(
        _db.attachedDatabase,
        _db.reminderSettings,
      );
  $$GamificationProfilesTableTableManager get gamificationProfiles =>
      $$GamificationProfilesTableTableManager(
        _db.attachedDatabase,
        _db.gamificationProfiles,
      );
  $$PetsTableTableManager get pets =>
      $$PetsTableTableManager(_db.attachedDatabase, _db.pets);
}
