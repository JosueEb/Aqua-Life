import 'package:drift/drift.dart';

import '../../constants/gamification_rules.dart';
import '../../../features/gamification/domain/reward_engine.dart';
import '../../../features/pet/domain/pet_evolution.dart';
import '../app_database.dart';
import '../tables/gamification_tables.dart';

part 'gamification_dao.g.dart';

@DriftAccessor(tables: [
  GamificationProfiles,
  RewardTransactions,
  Pets,
  Achievements,
  UserAchievements,
  Missions,
  UserMissions,
  ShopItems,
  InventoryItems,
])
class GamificationDao extends DatabaseAccessor<AppDatabase> with _$GamificationDaoMixin {
  GamificationDao(super.db);

  Stream<GamificationProfileRow?> watchProfile(String userId) =>
      (select(gamificationProfiles)..where((g) => g.userId.equals(userId))).watchSingleOrNull();

  Future<GamificationProfileRow> getProfile(String userId) =>
      (select(gamificationProfiles)..where((g) => g.userId.equals(userId))).getSingle();

  Stream<PetRow?> watchPet(String userId) => (select(pets)..where((p) => p.userId.equals(userId))).watchSingleOrNull();

  Future<PetRow> getPet(String userId) => (select(pets)..where((p) => p.userId.equals(userId))).getSingle();

  /// Número de recompensas de [source] otorgadas en [localDate]
  /// (cada recompensa cuenta una vez aunque tenga filas de XP y monedas).
  Future<int> countRewards(String userId, String source, String localDate) async {
    final refs = rewardTransactions.referenceId.count(distinct: true);
    final row = await (selectOnly(rewardTransactions)
          ..addColumns([refs])
          ..where(rewardTransactions.userId.equals(userId) &
              rewardTransactions.source.equals(source) &
              rewardTransactions.localDate.equals(localDate)))
        .getSingle();
    return row.read(refs) ?? 0;
  }

  Future<bool> hasReward(String userId, String source, String referenceId) async {
    final row = await (select(rewardTransactions)
          ..where((r) => r.userId.equals(userId) & r.source.equals(source) & r.referenceId.equals(referenceId))
          ..limit(1))
        .getSingleOrNull();
    return row != null;
  }

  /// Aplica recompensas de forma idempotente. Debe llamarse dentro de una
  /// transacción junto con el cambio que las origina.
  ///
  /// Devuelve solo las recompensas efectivamente otorgadas (las ya existentes
  /// en el ledger se ignoran).
  Future<List<RewardGrant>> applyGrants(String userId, String localDate, List<RewardGrant> grants, DateTime now) async {
    final applied = <RewardGrant>[];
    for (final g in grants) {
      if (g.xp <= 0 && g.coins <= 0) continue;
      if (await hasReward(userId, g.source, g.referenceId)) continue;
      for (final (type, amount) in [(RewardType.xp, g.xp), (RewardType.coins, g.coins)]) {
        if (amount <= 0) continue;
        await into(rewardTransactions).insert(RewardTransactionsCompanion.insert(
          userId: userId,
          type: type,
          amount: amount,
          source: g.source,
          referenceId: g.referenceId,
          localDate: localDate,
          createdAt: now,
        ));
      }
      applied.add(g);
    }
    if (applied.isEmpty) return applied;

    final xp = applied.fold<int>(0, (s, g) => s + g.xp);
    final coins = applied.fold<int>(0, (s, g) => s + g.coins);
    final profile = await getProfile(userId);
    final totalXp = profile.totalXp + xp;
    await (update(gamificationProfiles)..where((p) => p.userId.equals(userId))).write(GamificationProfilesCompanion(
      totalXp: Value(totalXp),
      coins: Value(profile.coins + coins),
      level: Value(GamificationRules.levelForXp(totalXp)),
    ));

    final pet = await getPet(userId);
    final stage = PetEvolution.nonRegressing(PetStage.fromNumber(pet.evolutionStage), totalXp);
    await (update(pets)..where((p) => p.userId.equals(userId))).write(PetsCompanion(
      xp: Value(totalXp),
      evolutionStage: Value(stage.number),
    ));
    return applied;
  }

  /// La racha más larga nunca disminuye.
  Future<void> updateStreaks(String userId, int current, int longest) async {
    final profile = await getProfile(userId);
    await (update(gamificationProfiles)..where((p) => p.userId.equals(userId))).write(GamificationProfilesCompanion(
      currentStreak: Value(current),
      longestStreak: Value(longest > profile.longestStreak ? longest : profile.longestStreak),
    ));
  }

  // ---------- Logros ----------
  Future<List<AchievementRow>> allAchievements() => select(achievements).get();

  Future<Set<String>> unlockedAchievementIds(String userId) async =>
      (await (select(userAchievements)..where((u) => u.userId.equals(userId))).get())
          .map((u) => u.achievementId)
          .toSet();

  Future<void> unlockAchievement(String userId, String achievementId, DateTime now) =>
      into(userAchievements).insert(
        UserAchievementsCompanion.insert(userId: userId, achievementId: achievementId, unlockedAt: now),
        mode: InsertMode.insertOrIgnore,
      );

  Stream<List<(AchievementRow, DateTime?)>> watchAchievements(String userId) {
    final q = select(achievements).join([
      leftOuterJoin(
        userAchievements,
        userAchievements.achievementId.equalsExp(achievements.id) & userAchievements.userId.equals(userId),
      ),
    ]);
    return q.watch().map((rows) => [
          for (final r in rows) (r.readTable(achievements), r.readTableOrNull(userAchievements)?.unlockedAt),
        ]);
  }

  // ---------- Monedas y tienda ----------
  /// Descuenta monedas registrando un movimiento negativo en el ledger.
  /// Debe llamarse dentro de una transacción tras validar el saldo.
  Future<void> spendCoins(String userId, int amount, String source, String referenceId, String localDate, DateTime now) async {
    final profile = await getProfile(userId);
    await into(rewardTransactions).insert(RewardTransactionsCompanion.insert(
      userId: userId,
      type: RewardType.coins,
      amount: -amount,
      source: source,
      referenceId: referenceId,
      localDate: localDate,
      createdAt: now,
    ));
    await (update(gamificationProfiles)..where((p) => p.userId.equals(userId)))
        .write(GamificationProfilesCompanion(coins: Value(profile.coins - amount)));
  }

  Future<List<ShopItemRow>> allShopItems() =>
      (select(shopItems)..orderBy([(s) => OrderingTerm.asc(s.unlockLevel), (s) => OrderingTerm.asc(s.priceCoins)])).get();

  Stream<List<ShopItemRow>> watchShopItems() =>
      (select(shopItems)..orderBy([(s) => OrderingTerm.asc(s.unlockLevel), (s) => OrderingTerm.asc(s.priceCoins)])).watch();

  Future<ShopItemRow?> findShopItem(String id) => (select(shopItems)..where((s) => s.id.equals(id))).getSingleOrNull();

  Stream<List<InventoryItemRow>> watchInventory(String userId) =>
      (select(inventoryItems)..where((i) => i.userId.equals(userId))..orderBy([(i) => OrderingTerm.desc(i.acquiredAt)])).watch();

  Future<bool> ownsItem(String userId, String itemId) async =>
      await (select(inventoryItems)..where((i) => i.userId.equals(userId) & i.itemId.equals(itemId))).getSingleOrNull() !=
      null;

  Future<void> addToInventory(String userId, String itemId, DateTime now) =>
      into(inventoryItems).insert(InventoryItemsCompanion.insert(userId: userId, itemId: itemId, acquiredAt: now));

  Future<void> setEquipped(String userId, String? encoded) =>
      (update(pets)..where((p) => p.userId.equals(userId))).write(PetsCompanion(equippedAccessory: Value(encoded)));

  // ---------- Misiones ----------
  Future<List<MissionRow>> allMissions() => select(missions).get();

  Future<List<UserMissionRow>> userMissionsSince(String userId, String fromPeriodStart) => (select(userMissions)
        ..where((u) => u.userId.equals(userId) & u.periodStart.isBiggerOrEqualValue(fromPeriodStart)))
      .get();

  Future<void> markMissionClaimed(String userId, String missionId, String periodStart, int progress) =>
      into(userMissions).insert(
        UserMissionsCompanion.insert(
          userId: userId,
          missionId: missionId,
          periodStart: periodStart,
          progress: Value(progress),
          completed: const Value(true),
          claimed: const Value(true),
        ),
        onConflict: DoUpdate(
          (_) => UserMissionsCompanion(progress: Value(progress), completed: const Value(true), claimed: const Value(true)),
          target: [userMissions.userId, userMissions.missionId, userMissions.periodStart],
        ),
      );
}
