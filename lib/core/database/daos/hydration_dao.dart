import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/hydration_tables.dart';

part 'hydration_dao.g.dart';

@DriftAccessor(tables: [WaterIntakes, HydrationGoals, DailyProgress])
class HydrationDao extends DatabaseAccessor<AppDatabase> with _$HydrationDaoMixin {
  HydrationDao(super.db);

  // ---------- Consumos ----------
  Future<void> insertIntake(WaterIntakesCompanion intake) => into(waterIntakes).insert(intake);

  Future<WaterIntakeRow?> findIntake(String id) =>
      (select(waterIntakes)..where((w) => w.id.equals(id))).getSingleOrNull();

  Future<void> updateIntake(String id, WaterIntakesCompanion changes) =>
      (update(waterIntakes)..where((w) => w.id.equals(id))).write(changes);

  Future<int> deleteIntake(String id) => (delete(waterIntakes)..where((w) => w.id.equals(id))).go();

  SimpleSelectStatement<$WaterIntakesTable, WaterIntakeRow> _forDate(String userId, String date) =>
      select(waterIntakes)
        ..where((w) => w.userId.equals(userId) & w.localDate.equals(date))
        ..orderBy([(w) => OrderingTerm.desc(w.consumedAt)]);

  Stream<List<WaterIntakeRow>> watchIntakesForDate(String userId, String date) => _forDate(userId, date).watch();

  Future<List<WaterIntakeRow>> intakesForDate(String userId, String date) => _forDate(userId, date).get();

  Future<int> totalForDate(String userId, String date) async {
    final sum = waterIntakes.amountMl.sum();
    final row = await (selectOnly(waterIntakes)
          ..addColumns([sum])
          ..where(waterIntakes.userId.equals(userId) & waterIntakes.localDate.equals(date)))
        .getSingle();
    return row.read(sum) ?? 0;
  }

  /// Totales por fecha local. [from]/[to] son inclusivos y opcionales.
  Selectable<MapEntry<String, int>> _dailyTotals(String userId, {String? from, String? to}) {
    final sum = waterIntakes.amountMl.sum();
    var where = waterIntakes.userId.equals(userId);
    if (from != null) where = where & waterIntakes.localDate.isBiggerOrEqualValue(from);
    if (to != null) where = where & waterIntakes.localDate.isSmallerOrEqualValue(to);
    final q = selectOnly(waterIntakes)
      ..addColumns([waterIntakes.localDate, sum])
      ..where(where)
      ..groupBy([waterIntakes.localDate]);
    return q.map((r) => MapEntry(r.read(waterIntakes.localDate)!, r.read(sum) ?? 0));
  }

  Future<Map<String, int>> dailyTotals(String userId, {String? from, String? to}) async =>
      Map.fromEntries(await _dailyTotals(userId, from: from, to: to).get());

  Stream<Map<String, int>> watchDailyTotals(String userId, {String? from, String? to}) =>
      _dailyTotals(userId, from: from, to: to).watch().map(Map.fromEntries);

  Future<int> countIntakes(String userId) async {
    final count = waterIntakes.id.count();
    final row = await (selectOnly(waterIntakes)
          ..addColumns([count])
          ..where(waterIntakes.userId.equals(userId)))
        .getSingle();
    return row.read(count) ?? 0;
  }

  // ---------- Metas ----------
  Future<List<HydrationGoalRow>> allGoals(String userId) =>
      (select(hydrationGoals)..where((g) => g.userId.equals(userId))).get();

  Stream<List<HydrationGoalRow>> watchAllGoals(String userId) =>
      (select(hydrationGoals)..where((g) => g.userId.equals(userId))).watch();

  SimpleSelectStatement<$HydrationGoalsTable, HydrationGoalRow> _goalFor(String userId, String date) =>
      select(hydrationGoals)
        ..where((g) =>
            g.userId.equals(userId) &
            g.startDate.isSmallerOrEqualValue(date) &
            (g.endDate.isNull() | g.endDate.isBiggerOrEqualValue(date)))
        ..orderBy([(g) => OrderingTerm.desc(g.startDate), (g) => OrderingTerm.desc(g.id)])
        ..limit(1);

  /// Meta que aplicaba en [date] (respeta el historial; no recalcula el pasado).
  Future<HydrationGoalRow?> goalForDate(String userId, String date) => _goalFor(userId, date).getSingleOrNull();

  Stream<HydrationGoalRow?> watchGoalForDate(String userId, String date) =>
      _goalFor(userId, date).watchSingleOrNull();

  Future<HydrationGoalRow?> currentGoal(String userId) => (select(hydrationGoals)
        ..where((g) => g.userId.equals(userId) & g.endDate.isNull())
        ..orderBy([(g) => OrderingTerm.desc(g.startDate)])
        ..limit(1))
      .getSingleOrNull();

  Future<void> insertGoal(HydrationGoalsCompanion goal) => into(hydrationGoals).insert(goal);

  Future<void> updateGoal(int id, HydrationGoalsCompanion changes) =>
      (update(hydrationGoals)..where((g) => g.id.equals(id))).write(changes);

  // ---------- Caché diaria ----------
  Future<void> upsertDailyProgress(DailyProgressCompanion row) =>
      into(dailyProgress).insertOnConflictUpdate(row);
}
