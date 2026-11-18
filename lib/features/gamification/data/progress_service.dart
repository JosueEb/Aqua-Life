import '../../../core/constants/gamification_rules.dart';
import '../../../core/database/app_database.dart';
import '../../achievements/domain/achievement_evaluator.dart';
import '../../goals/domain/goal_timeline.dart';
import '../domain/reward_engine.dart';
import '../domain/streak_calculator.dart';

class ProgressOutcome {
  const ProgressOutcome({required this.rewards, required this.unlockedAchievements});
  static const none = ProgressOutcome(rewards: [], unlockedAchievements: []);

  final List<RewardGrant> rewards;

  /// Títulos de los logros desbloqueados en esta operación.
  final List<String> unlockedAchievements;
}

/// Efectos de progreso de un cambio de consumo. Siempre se ejecuta dentro de
/// la transacción del cambio (registro, edición o eliminación).
///
/// Reglas:
/// * La caché `daily_progress` y las rachas se recalculan siempre.
/// * XP y monedas solo se otorgan por cambios en el día de hoy: registrar o
///   editar días pasados no genera recompensas (evita “rellenar” días).
/// * Los logros se evalúan con datos reales y se desbloquean una sola vez.
class ProgressService {
  ProgressService(this._db);
  final AppDatabase _db;

  Future<ProgressOutcome> onDayChanged({
    required String userId,
    required String date,
    required String today,
    required DateTime nowUtc,
    String? newIntakeId,
    int? newIntakeAmountMl,
    int? newIntakeLocalHour,
  }) async {
    final hydration = _db.hydrationDao;
    final gamification = _db.gamificationDao;

    // 1. Totales reales y metas históricas.
    final totals = await hydration.dailyTotals(userId);
    final timeline = GoalTimeline((await hydration.allGoals(userId))
        .map((g) => GoalPeriod(id: g.id, start: g.startDate, end: g.endDate, dailyGoalMl: g.dailyGoalMl)));
    final dayTotal = totals[date] ?? 0;
    final dayGoal = timeline.goalFor(date);
    await hydration.upsertDailyProgress(DailyProgressCompanion.insert(
      userId: userId,
      date: date,
      totalMl: dayTotal,
      goalMl: dayGoal,
      completed: dayGoal > 0 && dayTotal >= dayGoal,
      completionPercentage: dayGoal > 0 ? dayTotal * 100 / dayGoal : 0,
      updatedAt: nowUtc,
    ));

    // 2. Rachas.
    final completed = {
      for (final e in totals.entries)
        if (timeline.goalFor(e.key) > 0 && e.value >= timeline.goalFor(e.key)) e.key,
    };
    final streak = StreakCalculator.compute(completed, today);
    await gamification.updateStreaks(userId, streak.current, streak.longest);

    // 3. Recompensas (solo cambios del día de hoy).
    final grants = <RewardGrant>[];
    if (date == today) {
      final snapshot = DayRewardSnapshot(
        localDate: date,
        rewardedIntakesToday: await gamification.countRewards(userId, RewardSource.intake, date),
        totalMl: dayTotal,
        goalMl: dayGoal,
      );
      if (newIntakeId != null && newIntakeAmountMl != null) {
        grants.addAll(RewardEngine.forNewIntake(intakeId: newIntakeId, amountMl: newIntakeAmountMl, day: snapshot));
      } else {
        grants.addAll(RewardEngine.forDayTotals(snapshot));
      }
      if (completed.contains(today)) {
        grants.addAll(RewardEngine.forStreak(current: streak.current, streakStart: streak.currentStart));
      }
    }
    final applied = await gamification.applyGrants(userId, date, grants, nowUtc);

    // 4. Logros.
    final pet = await gamification.getPet(userId);
    final profile = await gamification.getProfile(userId);
    final metrics = AchievementMetrics(
      intakeCount: await hydration.countIntakes(userId),
      goalsCompleted: completed.length,
      longestStreak: profile.longestStreak,
      petStage: pet.evolutionStage,
      latestIntakeHour: newIntakeLocalHour,
    );
    final catalog = await gamification.allAchievements();
    final unlockedIds = AchievementEvaluator.newlyUnlocked(
      catalog.map((a) => AchievementRule(a.id, a.conditionType, a.conditionValue)),
      await gamification.unlockedAchievementIds(userId),
      metrics,
    );
    final titles = <String>[];
    for (final id in unlockedIds) {
      final a = catalog.firstWhere((a) => a.id == id);
      await gamification.unlockAchievement(userId, id, nowUtc);
      applied.addAll(await gamification.applyGrants(
        userId,
        date,
        [RewardGrant(source: RewardSource.achievement, referenceId: id, xp: a.xpReward, coins: a.coinReward)],
        nowUtc,
      ));
      titles.add(a.title);
    }
    return ProgressOutcome(rewards: applied, unlockedAchievements: titles);
  }
}
