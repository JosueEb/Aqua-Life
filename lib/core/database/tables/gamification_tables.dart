import 'package:drift/drift.dart';

import 'profile_tables.dart';

@DataClassName('GamificationProfileRow')
class GamificationProfiles extends Table {
  TextColumn get userId => text().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get coins => integer().withDefault(const Constant(0))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {userId};
}

/// Ledger de recompensas. La clave única (user, type, source, reference)
/// impide otorgar dos veces la misma recompensa.
@TableIndex(name: 'idx_rewards_user_source_date', columns: {#userId, #source, #localDate})
@DataClassName('RewardTransactionRow')
class RewardTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()(); // xp | coins
  IntColumn get amount => integer()();
  TextColumn get source => text()();
  TextColumn get referenceId => text()();
  TextColumn get localDate => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {userId, type, source, referenceId},
      ];
}

@DataClassName('AchievementRow')
class Achievements extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get iconPath => text()();
  TextColumn get conditionType => text()();
  IntColumn get conditionValue => integer()();
  IntColumn get xpReward => integer().withDefault(const Constant(0))();
  IntColumn get coinReward => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UserAchievementRow')
class UserAchievements extends Table {
  TextColumn get userId => text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get achievementId => text().references(Achievements, #id)();
  DateTimeColumn get unlockedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {userId, achievementId};
}

@DataClassName('MissionRow')
class Missions extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get period => text()(); // daily | weekly
  TextColumn get metric => text()();
  IntColumn get target => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UserMissionRow')
class UserMissions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get missionId => text().references(Missions, #id)();
  TextColumn get periodStart => text()();
  IntColumn get progress => integer().withDefault(const Constant(0))();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  BoolColumn get claimed => boolean().withDefault(const Constant(false))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {userId, missionId, periodStart},
      ];
}

@DataClassName('PetRow')
class Pets extends Table {
  TextColumn get userId => text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get species => text().withDefault(const Constant('aqua'))();
  IntColumn get evolutionStage => integer().withDefault(const Constant(1))();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get happiness => integer().withDefault(const Constant(50))();
  TextColumn get mood => text().withDefault(const Constant('idle'))();
  TextColumn get equippedAccessory => text().nullable()();

  @override
  Set<Column> get primaryKey => {userId};
}

@DataClassName('ShopItemRow')
class ShopItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  IntColumn get priceCoins => integer()();
  TextColumn get assetPath => text()();
  IntColumn get unlockLevel => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('InventoryItemRow')
class InventoryItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get itemId => text().references(ShopItems, #id)();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  DateTimeColumn get acquiredAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {userId, itemId},
      ];
}
