// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hydration_dao.dart';

// ignore_for_file: type=lint
mixin _$HydrationDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $WaterIntakesTable get waterIntakes => attachedDatabase.waterIntakes;
  $HydrationGoalsTable get hydrationGoals => attachedDatabase.hydrationGoals;
  $DailyProgressTable get dailyProgress => attachedDatabase.dailyProgress;
  HydrationDaoManager get managers => HydrationDaoManager(this);
}

class HydrationDaoManager {
  final _$HydrationDaoMixin _db;
  HydrationDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$WaterIntakesTableTableManager get waterIntakes =>
      $$WaterIntakesTableTableManager(_db.attachedDatabase, _db.waterIntakes);
  $$HydrationGoalsTableTableManager get hydrationGoals =>
      $$HydrationGoalsTableTableManager(
        _db.attachedDatabase,
        _db.hydrationGoals,
      );
  $$DailyProgressTableTableManager get dailyProgress =>
      $$DailyProgressTableTableManager(_db.attachedDatabase, _db.dailyProgress);
}
