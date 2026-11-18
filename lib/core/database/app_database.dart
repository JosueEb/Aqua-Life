import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../constants/app_constants.dart';
import '../constants/catalog_seed.dart';
import 'daos/gamification_dao.dart';
import 'daos/hydration_dao.dart';
import 'daos/user_dao.dart';
import 'tables/gamification_tables.dart';
import 'tables/hydration_tables.dart';
import 'tables/profile_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    ReminderSettings,
    HydrationGoals,
    WaterIntakes,
    DailyProgress,
    GamificationProfiles,
    RewardTransactions,
    Achievements,
    UserAchievements,
    Missions,
    UserMissions,
    Pets,
    ShopItems,
    InventoryItems,
  ],
  daos: [UserDao, HydrationDao, GamificationDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// Versión del esquema. Cada cambio debe incrementarla y añadir un paso
  /// en [migration.onUpgrade].
  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() => driftDatabase(name: AppConstants.databaseName);

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedCatalog();
        },
        onUpgrade: (m, from, to) async {
          // Migraciones futuras: if (from < 2) { ... }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<void> _seedCatalog() async {
    await batch((b) {
      b.insertAll(
        achievements,
        [
          for (final a in CatalogSeed.achievements)
            AchievementsCompanion.insert(
              id: a.id,
              title: a.title,
              description: a.description,
              iconPath: 'assets/images/achievements/${a.id}.png',
              conditionType: a.conditionType,
              conditionValue: a.conditionValue,
              xpReward: Value(a.xpReward),
              coinReward: Value(a.coinReward),
            ),
        ],
      );
      b.insertAll(
        missions,
        [
          for (final m in CatalogSeed.missions)
            MissionsCompanion.insert(
              id: m.id,
              title: m.title,
              description: m.description,
              period: m.period,
              metric: m.metric,
              target: m.target,
            ),
        ],
      );
      b.insertAll(
        shopItems,
        [
          for (final s in CatalogSeed.shopItems)
            ShopItemsCompanion.insert(
              id: s.id,
              name: s.name,
              category: s.category,
              priceCoins: s.priceCoins,
              assetPath: s.assetPath,
              unlockLevel: Value(s.unlockLevel),
            ),
        ],
      );
    });
  }
}
