import 'package:aqua_life/core/database/app_database.dart';
import 'package:aqua_life/core/utils/volume_format.dart';
import 'package:aqua_life/features/gamification/data/gamification_repository_impl.dart';
import 'package:aqua_life/features/goals/data/goal_repository_impl.dart';
import 'package:aqua_life/features/hydration/data/repositories/hydration_repository_impl.dart';
import 'package:aqua_life/features/pet/domain/pet_evolution.dart';
import 'package:aqua_life/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:aqua_life/features/profile/domain/entities/user_profile.dart';
import 'package:aqua_life/features/statistics/data/statistics_repository.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase db;
  late HydrationRepositoryImpl hydration;
  late GamificationRepositoryImpl gamification;
  late String userId;
  late DateTime now;

  setUp(() async {
    now = DateTime(2026, 11, 17, 10);
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    db = AppDatabase(NativeDatabase.memory());
    hydration = HydrationRepositoryImpl(db, const Uuid(), () => now);
    gamification = GamificationRepositoryImpl(db);
    userId = await ProfileRepositoryImpl(db, const Uuid()).completeOnboarding(
      const OnboardingData(isGuest: true, dailyGoalMl: 1000, unitSystem: UnitSystem.metric),
      now,
    );
  });

  tearDown(() => db.close());

  Future<int> totalXp() async => (await gamification.watchStatus(userId).first).totalXp;

  test('el catálogo se siembra al crear la base de datos', () async {
    expect(await db.select(db.achievements).get(), hasLength(10));
    expect(await db.select(db.missions).get(), hasLength(8));
    expect(await db.select(db.shopItems).get(), hasLength(12));
  });

  test('registrar consumo persiste y otorga 5 XP', () async {
    final r = await hydration.addIntake(userId, 250, now);
    expect(r.xpEarned, 5);
    final day = await hydration.watchDay(userId, '2026-11-17').first;
    expect(day.totalMl, 250);
    expect(day.goalMl, 1000);
    expect(await totalXp(), 5);
  });

  test('la meta diaria se premia una sola vez aunque se edite y vuelva a cumplir', () async {
    final a = await hydration.addIntake(userId, 600, now);
    final b = await hydration.addIntake(userId, 500, now);
    expect(b.rewards.where((g) => g.xp > 0).map((g) => g.xp), [5, 50]);

    // Baja del objetivo editando y vuelve a subir: no hay segundo premio.
    await hydration.updateIntake(userId, a.intake.id, 100, now);
    final again = await hydration.updateIntake(userId, a.intake.id, 600, now);
    expect(again.rewards, isEmpty);

    // Eliminar y volver a cumplir tampoco duplica.
    await hydration.deleteIntake(userId, b.intake.id);
    final c = await hydration.addIntake(userId, 500, now);
    expect(c.rewards.where((g) => g.xp > 0).map((g) => g.xp), [5]);

    expect(await totalXp(), 5 + 5 + 50 + 5);
    final profile = await db.select(db.gamificationProfiles).getSingle();
    // Meta: 50 XP → 5 monedas. Logros "Primer sorbo" y "Meta cumplida": 10 + 10.
    expect(profile.coins, 5 + 10 + 10);
  });

  test('máximo 10 registros premiados por día', () async {
    for (var i = 0; i < 14; i++) {
      await hydration.addIntake(userId, 10, now);
    }
    expect(await totalXp(), 50);
  });

  test('la mascota evoluciona con la XP y la etapa se guarda', () async {
    // 2 días de meta + registros: 2 × (50 + 5) = 110 XP → etapa feliz.
    await hydration.addIntake(userId, 1000, now);
    now = DateTime(2026, 11, 18, 10);
    await hydration.addIntake(userId, 1000, now);
    final status = await gamification.watchStatus(userId).first;
    expect(status.totalXp, 110);
    expect(status.petStage, PetStage.happy);
    expect(status.level, 2);
  });

  test('cambiar la meta no recalcula días anteriores', () async {
    await hydration.addIntake(userId, 800, now);
    await GoalRepositoryImpl(db).setDailyGoal(userId, 2500, '2026-11-18');

    final past = await hydration.watchDay(userId, '2026-11-17').first;
    final today = await hydration.watchDay(userId, '2026-11-18').first;
    expect(past.goalMl, 1000);
    expect(today.goalMl, 2500);

    final goals = await (db.select(db.hydrationGoals)..orderBy([(g) => OrderingTerm.asc(g.id)])).get();
    expect(goals.first.endDate, '2026-11-17');
    expect(goals.last.endDate, isNull);
  });

  test('daily_progress es una caché derivada coherente', () async {
    final a = await hydration.addIntake(userId, 400, now);
    await hydration.addIntake(userId, 700, now);
    await hydration.deleteIntake(userId, a.intake.id);
    final row = await db.select(db.dailyProgress).getSingle();
    expect(row.totalMl, 700);
    expect(row.completed, isFalse);
  });

  test('registrar días pasados no da XP pero cuenta para el historial', () async {
    now = DateTime(2026, 11, 20, 10);
    final r = await hydration.addIntake(userId, 1000, DateTime(2026, 11, 18, 9));
    expect(r.rewards.where((g) => g.xp > 0), isEmpty);
    final day = await hydration.watchDay(userId, '2026-11-18').first;
    expect(day.completed, isTrue);
  });

  test('racha de 7 días otorga 100 XP una sola vez y actualiza el perfil', () async {
    for (var d = 0; d < 7; d++) {
      now = DateTime(2026, 11, 17 + d, 12);
      await hydration.addIntake(userId, 1000, now);
    }
    final profile = await db.select(db.gamificationProfiles).getSingle();
    expect(profile.currentStreak, 7);
    expect(profile.longestStreak, 7);
    // 7 × (5 registro + 50 meta) + 100 racha.
    expect(profile.totalXp, 7 * 55 + 100);
    final streakRewards = await (db.select(db.rewardTransactions)
          ..where((r) => r.source.equals('streak') & r.type.equals('xp')))
        .get();
    expect(streakRewards, hasLength(1));

    // Volver a cumplir el mismo día no repite el hito.
    await hydration.addIntake(userId, 300, now);
    expect((await db.select(db.gamificationProfiles).getSingle()).totalXp, 7 * 55 + 100 + 5);
  });

  test('los logros se desbloquean una vez', () async {
    final first = await hydration.addIntake(userId, 300, DateTime(2026, 11, 17, 7));
    expect(first.unlockedAchievements, containsAll(['Primer sorbo', 'Madrugadora']));
    final second = await hydration.addIntake(userId, 300, DateTime(2026, 11, 17, 7, 30));
    expect(second.unlockedAchievements, isEmpty);
    expect(await db.select(db.userAchievements).get(), hasLength(2));
  });

  test('estadísticas por rango usan registros reales y metas históricas', () async {
    await hydration.addIntake(userId, 1200, now);
    await GoalRepositoryImpl(db).setDailyGoal(userId, 2000, '2026-11-18');
    final stats = await StatisticsRepositoryImpl(db).watchRange(userId, '2026-11-16', '2026-11-18').first;
    expect(stats.map((s) => s.date), ['2026-11-16', '2026-11-17', '2026-11-18']);
    expect(stats.map((s) => s.goalMl), [0, 1000, 2000]);
    expect(stats[1].completed, isTrue);
    expect(stats[2].totalMl, 0);
  });
}
