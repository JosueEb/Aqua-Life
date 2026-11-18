import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../utils/local_date.dart';

/// Se sobrescribe en `main()` con la instancia ya cargada.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider debe sobrescribirse en main()'),
);

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Reloj inyectable (permite pruebas deterministas de fechas).
final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

final uuidProvider = Provider<Uuid>((ref) => const Uuid());

/// Fecha local actual (`yyyy-MM-dd`). Se reevalúa periódicamente para
/// detectar el cambio de día o de zona horaria con la app abierta.
class TodayKeyNotifier extends Notifier<String> {
  @override
  String build() {
    final clock = ref.watch(clockProvider);
    final timer = Timer.periodic(const Duration(seconds: 30), (_) {
      final now = LocalDate.keyOf(clock());
      if (now != state) state = now;
    });
    ref.onDispose(timer.cancel);
    return LocalDate.keyOf(clock());
  }
}

final todayKeyProvider = NotifierProvider<TodayKeyNotifier, String>(TodayKeyNotifier.new);
