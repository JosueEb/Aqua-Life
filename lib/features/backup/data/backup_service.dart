import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/errors/failures.dart';

/// Exportación e importación manual de datos en JSON (respaldo y cambio de
/// dispositivo). Incluye todas las tablas del usuario; los catálogos
/// (logros, misiones, tienda) no se exportan porque vienen con la app.
class BackupService {
  BackupService(this._db);
  final AppDatabase _db;

  static const String format = 'aqualife-backup';
  static const int version = 1;

  Future<String> exportJson({required List<int> quickAmounts, required DateTime now}) async {
    final db = _db;
    List<Map<String, dynamic>> rows(List<dynamic> list) => [for (final r in list) (r as dynamic).toJson()];
    final data = <String, dynamic>{
      'format': format,
      'version': version,
      'schemaVersion': db.schemaVersion,
      'exportedAt': now.toUtc().toIso8601String(),
      'prefs': {'quickAmounts': quickAmounts},
      'users': rows(await db.select(db.users).get()),
      'hydrationGoals': rows(await db.select(db.hydrationGoals).get()),
      'waterIntakes': rows(await db.select(db.waterIntakes).get()),
      'dailyProgress': rows(await db.select(db.dailyProgress).get()),
      'reminderSettings': rows(await db.select(db.reminderSettings).get()),
      'gamificationProfiles': rows(await db.select(db.gamificationProfiles).get()),
      'pets': rows(await db.select(db.pets).get()),
      'rewardTransactions': rows(await db.select(db.rewardTransactions).get()),
      'userAchievements': rows(await db.select(db.userAchievements).get()),
      'userMissions': rows(await db.select(db.userMissions).get()),
      'inventoryItems': rows(await db.select(db.inventoryItems).get()),
    };
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  /// Valida y reemplaza todos los datos del usuario por los del respaldo.
  Future<ImportResult> importJson(String raw) async {
    final Map<String, dynamic> data;
    try {
      data = jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      throw const ValidationFailure('El archivo no es un JSON válido.');
    }
    if (data['format'] != format) throw const ValidationFailure('El archivo no es un respaldo de AquaLife.');
    if ((data['version'] as int? ?? 0) > version || (data['schemaVersion'] as int? ?? 0) > _db.schemaVersion) {
      throw const ValidationFailure('El respaldo es de una versión más nueva de AquaLife. Actualiza la app.');
    }

    List<Map<String, dynamic>> list(String key) =>
        [for (final e in (data[key] as List<dynamic>? ?? const [])) (e as Map).cast<String, dynamic>()];

    final users = list('users');
    if (users.isEmpty) throw const ValidationFailure('El respaldo no contiene ningún perfil.');

    try {
      await _db.transaction(() async {
        final db = _db;
        // Primero las tablas dependientes, luego los usuarios.
        for (final TableInfo t in [
          db.inventoryItems,
          db.userMissions,
          db.userAchievements,
          db.rewardTransactions,
          db.pets,
          db.gamificationProfiles,
          db.reminderSettings,
          db.dailyProgress,
          db.waterIntakes,
          db.hydrationGoals,
          db.users,
        ]) {
          await db.delete(t).go();
        }
        await db.batch((b) {
          b.insertAll(db.users, users.map(UserRow.fromJson));
          b.insertAll(db.hydrationGoals, list('hydrationGoals').map(HydrationGoalRow.fromJson));
          b.insertAll(db.waterIntakes, list('waterIntakes').map(WaterIntakeRow.fromJson));
          b.insertAll(db.dailyProgress, list('dailyProgress').map(DailyProgressRow.fromJson));
          b.insertAll(db.reminderSettings, list('reminderSettings').map(ReminderSettingsRow.fromJson));
          b.insertAll(db.gamificationProfiles, list('gamificationProfiles').map(GamificationProfileRow.fromJson));
          b.insertAll(db.pets, list('pets').map(PetRow.fromJson));
          b.insertAll(db.rewardTransactions, list('rewardTransactions').map(RewardTransactionRow.fromJson));
          b.insertAll(db.userAchievements, list('userAchievements').map(UserAchievementRow.fromJson));
          b.insertAll(db.userMissions, list('userMissions').map(UserMissionRow.fromJson));
          b.insertAll(db.inventoryItems, list('inventoryItems').map(InventoryItemRow.fromJson));
        });
      });
    } on ValidationFailure {
      rethrow;
    } catch (_) {
      throw const ValidationFailure('El respaldo está incompleto o dañado. No se cambió nada.');
    }

    final quick = (data['prefs'] as Map?)?['quickAmounts'];
    return ImportResult(
      userId: users.first['id'] as String,
      intakeCount: list('waterIntakes').length,
      quickAmounts: quick is List ? quick.whereType<int>().toList() : null,
    );
  }
}

class ImportResult {
  const ImportResult({required this.userId, required this.intakeCount, this.quickAmounts});
  final String userId;
  final int intakeCount;
  final List<int>? quickAmounts;
}
