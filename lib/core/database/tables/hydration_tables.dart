import 'package:drift/drift.dart';

import 'profile_tables.dart';

/// Historial de metas: cada fila aplica desde [startDate] hasta [endDate]
/// (inclusive). La meta vigente tiene [endDate] nulo.
@DataClassName('HydrationGoalRow')
class HydrationGoals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get dailyGoalMl => integer()();
  TextColumn get startDate => text()(); // yyyy-MM-dd
  TextColumn get endDate => text().nullable()();
}

/// Fuente de verdad del consumo.
@TableIndex(name: 'idx_intakes_user_date', columns: {#userId, #localDate})
@DataClassName('WaterIntakeRow')
class WaterIntakes extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id, onDelete: KeyAction.cascade)();
  // ignore: recursive_getters — patrón de Drift para restricciones CHECK.
  IntColumn get amountMl => integer().check(amountMl.isBiggerThanValue(0))();

  /// Instante del consumo (UTC).
  DateTimeColumn get consumedAt => dateTime()();

  /// Fecha local de agrupación (ver `LocalDate`).
  TextColumn get localDate => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Resumen/caché derivado de water_intakes. No es fuente primaria.
@DataClassName('DailyProgressRow')
class DailyProgress extends Table {
  TextColumn get userId => text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get date => text()();
  IntColumn get totalMl => integer()();
  IntColumn get goalMl => integer()();
  BoolColumn get completed => boolean()();
  RealColumn get completionPercentage => real()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {userId, date};
}
