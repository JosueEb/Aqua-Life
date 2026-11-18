// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_dao.dart';

// ignore_for_file: type=lint
mixin _$GamificationDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $GamificationProfilesTable get gamificationProfiles =>
      attachedDatabase.gamificationProfiles;
  $RewardTransactionsTable get rewardTransactions =>
      attachedDatabase.rewardTransactions;
  $PetsTable get pets => attachedDatabase.pets;
  $AchievementsTable get achievements => attachedDatabase.achievements;
  $UserAchievementsTable get userAchievements =>
      attachedDatabase.userAchievements;
  GamificationDaoManager get managers => GamificationDaoManager(this);
}

class GamificationDaoManager {
  final _$GamificationDaoMixin _db;
  GamificationDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$GamificationProfilesTableTableManager get gamificationProfiles =>
      $$GamificationProfilesTableTableManager(
        _db.attachedDatabase,
        _db.gamificationProfiles,
      );
  $$RewardTransactionsTableTableManager get rewardTransactions =>
      $$RewardTransactionsTableTableManager(
        _db.attachedDatabase,
        _db.rewardTransactions,
      );
  $$PetsTableTableManager get pets =>
      $$PetsTableTableManager(_db.attachedDatabase, _db.pets);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db.attachedDatabase, _db.achievements);
  $$UserAchievementsTableTableManager get userAchievements =>
      $$UserAchievementsTableTableManager(
        _db.attachedDatabase,
        _db.userAchievements,
      );
}
