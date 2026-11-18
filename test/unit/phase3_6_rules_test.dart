import 'package:aqua_life/core/constants/gamification_rules.dart';
import 'package:aqua_life/features/achievements/domain/achievement_evaluator.dart';
import 'package:aqua_life/features/gamification/domain/reward_engine.dart';
import 'package:aqua_life/features/gamification/domain/streak_calculator.dart';
import 'package:aqua_life/features/goals/domain/goal_timeline.dart';
import 'package:aqua_life/features/hydration/domain/usecases/intake_usecases.dart';
import 'package:aqua_life/features/reminders/domain/reminder_config.dart';
import 'package:aqua_life/features/statistics/domain/day_stat.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StreakCalculator', () {
    test('cuenta hasta hoy si hoy está cumplido', () {
      final r = StreakCalculator.compute({'2026-11-15', '2026-11-16', '2026-11-17'}, '2026-11-17');
      expect(r.current, 3);
      expect(r.currentStart, '2026-11-15');
      expect(r.longest, 3);
    });

    test('hoy sin cumplir no rompe la racha (cuenta hasta ayer)', () {
      final r = StreakCalculator.compute({'2026-11-15', '2026-11-16'}, '2026-11-17');
      expect(r.current, 2);
    });

    test('un día sin cumplir antes de ayer rompe la racha', () {
      final r = StreakCalculator.compute({'2026-11-10', '2026-11-11', '2026-11-12', '2026-11-15'}, '2026-11-17');
      expect(r.current, 0);
      expect(r.longest, 3);
    });

    test('cruza meses', () {
      final r = StreakCalculator.compute({'2026-10-31', '2026-11-01'}, '2026-11-01');
      expect(r.current, 2);
    });
  });

  group('RewardEngine.forStreak', () {
    test('premia múltiplos de 7 con referencia única por racha', () {
      expect(RewardEngine.forStreak(current: 6, streakStart: '2026-11-01'), isEmpty);
      final g = RewardEngine.forStreak(current: 7, streakStart: '2026-11-01');
      expect(g.single.xp, GamificationRules.xpStreak7Days);
      expect(g.single.referenceId, '2026-11-01:7');
      expect(RewardEngine.forStreak(current: 14, streakStart: '2026-11-01').single.referenceId, '2026-11-01:14');
    });
  });

  group('GoalTimeline', () {
    test('aplica la meta vigente en cada fecha', () {
      final t = GoalTimeline(const [
        GoalPeriod(id: 1, start: '2026-11-01', end: '2026-11-09', dailyGoalMl: 1500),
        GoalPeriod(id: 2, start: '2026-11-10', end: null, dailyGoalMl: 2500),
      ]);
      expect(t.goalFor('2026-10-31'), 0);
      expect(t.goalFor('2026-11-05'), 1500);
      expect(t.goalFor('2026-11-10'), 2500);
      expect(t.goalFor('2027-01-01'), 2500);
    });
  });

  group('PeriodSummary', () {
    test('promedio solo sobre días con registros', () {
      final s = PeriodSummary(const [
        DayStat(date: 'a', totalMl: 2000, goalMl: 2000),
        DayStat(date: 'b', totalMl: 1000, goalMl: 2000),
        DayStat(date: 'c', totalMl: 0, goalMl: 2000),
      ]);
      expect(s.averageMl, 1500);
      expect(s.completedDays, 1);
      expect(s.totalMl, 3000);
    });
  });

  group('ReminderScheduler', () {
    const base = ReminderConfig(
      enabled: true,
      startMinutes: 8 * 60,
      endMinutes: 10 * 60,
      intervalMinutes: 60,
      weekdays: {1, 2, 3, 4, 5, 6, 7},
      snoozeMinutes: 15,
    );

    test('genera solo horas futuras dentro del horario', () {
      final times = ReminderScheduler.upcoming(base, DateTime(2026, 11, 17, 8, 30), max: 5);
      expect(times, [
        DateTime(2026, 11, 17, 9),
        DateTime(2026, 11, 17, 10),
        DateTime(2026, 11, 18, 8),
        DateTime(2026, 11, 18, 9),
        DateTime(2026, 11, 18, 10),
      ]);
    });

    test('respeta días de la semana y omite hoy si la meta se cumplió', () {
      // 17/11/2026 es martes (2).
      final c = base.copyWith(weekdays: {2, 4});
      final times = ReminderScheduler.upcoming(c, DateTime(2026, 11, 17, 7), skipDate: '2026-11-17', max: 3);
      expect(times.first, DateTime(2026, 11, 19, 8)); // jueves
    });

    test('desactivado o inválido no programa nada', () {
      expect(ReminderScheduler.upcoming(base.copyWith(enabled: false), DateTime(2026, 11, 17)), isEmpty);
      expect(ReminderScheduler.upcoming(base.copyWith(endMinutes: 7 * 60), DateTime(2026, 11, 17)), isEmpty);
    });

    test('no supera el límite (iOS permite 64 pendientes)', () {
      final c = base.copyWith(startMinutes: 0, endMinutes: 23 * 60, intervalMinutes: 15);
      expect(ReminderScheduler.upcoming(c, DateTime(2026, 11, 17)).length, ReminderScheduler.maxCount);
    });

    test('codifica días', () {
      expect(ReminderConfig.encodeWeekdays({3, 1, 7}), '1,3,7');
      expect(ReminderConfig.decodeWeekdays('1,3,x,9'), {1, 3});
    });
  });

  group('AchievementEvaluator', () {
    const m = AchievementMetrics(intakeCount: 1, goalsCompleted: 1, longestStreak: 3, petStage: 2, latestIntakeHour: 7);

    test('desbloquea los cumplidos que faltan', () {
      final ids = AchievementEvaluator.newlyUnlocked(const [
        AchievementRule('first_sip', 'intake_count', 1),
        AchievementRule('first_goal', 'goals_completed', 1),
        AchievementRule('streak_3', 'streak', 3),
        AchievementRule('streak_7', 'streak', 7),
        AchievementRule('early_bird', 'intake_before_hour', 8),
        AchievementRule('pet_stage_3', 'pet_stage', 3),
      ], {'first_goal'}, m);
      expect(ids, ['first_sip', 'streak_3', 'early_bird']);
    });
  });

  group('IntakeWindow', () {
    test('solo los últimos 7 días, sin futuro', () {
      expect(IntakeWindow.isEditable('2026-11-17', '2026-11-17'), isTrue);
      expect(IntakeWindow.isEditable('2026-11-11', '2026-11-17'), isTrue);
      expect(IntakeWindow.isEditable('2026-11-10', '2026-11-17'), isFalse);
      expect(IntakeWindow.isEditable('2026-11-18', '2026-11-17'), isFalse);
    });
  });
}
