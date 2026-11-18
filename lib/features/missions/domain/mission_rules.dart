import 'dart:math' as math;

import '../../../core/constants/gamification_rules.dart';

/// Métricas de un día calculadas desde los consumos reales.
class DayMetrics {
  const DayMetrics({
    required this.date,
    required this.intakeCount,
    required this.totalMl,
    required this.goalMl,
    required this.dayParts,
    this.earliestHour,
  });

  factory DayMetrics.fromIntakes(String date, Iterable<(DateTime localTime, int ml)> intakes, int goalMl) {
    var total = 0;
    int? earliest;
    final parts = <int>{};
    var count = 0;
    for (final (t, ml) in intakes) {
      count++;
      total += ml;
      if (earliest == null || t.hour < earliest) earliest = t.hour;
      parts.add(partOfDay(t.hour));
    }
    return DayMetrics(
      date: date,
      intakeCount: count,
      totalMl: total,
      goalMl: goalMl,
      dayParts: parts.length,
      earliestHour: earliest,
    );
  }

  final String date;
  final int intakeCount;
  final int totalMl;
  final int goalMl;
  final int? earliestHour;

  /// Franjas distintas con registros: mañana (<12), tarde (12–18), noche (≥18).
  final int dayParts;

  int get percent => goalMl <= 0 ? 0 : (totalMl * 100 / goalMl).floor();
  bool get goalCompleted => goalMl > 0 && totalMl >= goalMl;

  static int partOfDay(int hour) => hour < 12 ? 0 : (hour < 18 ? 1 : 2);
}

class MissionDef {
  const MissionDef({
    required this.id,
    required this.title,
    required this.description,
    required this.period,
    required this.metric,
    required this.target,
  });

  final String id;
  final String title;
  final String description;

  /// 'daily' | 'weekly'
  final String period;
  final String metric;
  final int target;

  bool get isDaily => period == 'daily';
  int get xpReward => isDaily ? GamificationRules.xpDailyMission : GamificationRules.xpWeeklyMission;
  String get rewardSource => isDaily ? RewardSource.dailyMission : RewardSource.weeklyMission;
}

abstract final class MissionEvaluator {
  /// Meta visible de la misión (las de horario son de sí/no).
  static int targetOf(MissionDef m) => m.metric == 'intake_before_hour' ? 1 : m.target;

  static int dailyProgress(MissionDef m, DayMetrics d) {
    final value = switch (m.metric) {
      'intake_before_hour' => (d.earliestHour != null && d.earliestHour! < m.target) ? 1 : 0,
      'intake_count' => d.intakeCount,
      'goal_percent' => d.percent,
      'day_parts' => d.dayParts,
      _ => 0,
    };
    return math.min(value, targetOf(m));
  }

  static int completedDailyCount(Iterable<MissionDef> dailyMissions, DayMetrics d) =>
      dailyMissions.where((m) => dailyProgress(m, d) >= targetOf(m)).length;

  static int weeklyProgress(MissionDef m, List<DayMetrics> week, Iterable<MissionDef> dailyMissions) {
    final value = switch (m.metric) {
      'goals_completed' => week.where((d) => d.goalCompleted).length,
      'intake_count' => week.fold(0, (s, d) => s + d.intakeCount),
      'daily_missions' => week.fold(0, (s, d) => s + completedDailyCount(dailyMissions, d)),
      _ => 0,
    };
    return math.min(value, targetOf(m));
  }
}

/// Cofres: se abren al reclamar suficientes misiones. Dan solo monedas.
abstract final class ChestRules {
  static const int dailyRequiredClaims = 3;

  /// El semanal requiere reclamar todas las misiones semanales.
  static int weeklyRequiredClaims(int weeklyMissionCount) => weeklyMissionCount;

  /// Monedas deterministas por periodo: reintentar no cambia el premio.
  static int dailyCoins(String date) => 10 + _stableHash('d$date') % 16; // 10–25
  static int weeklyCoins(String weekStart) => 50 + _stableHash('w$weekStart') % 51; // 50–100

  static int _stableHash(String s) {
    var h = 17;
    for (final c in s.codeUnits) {
      h = (h * 31 + c) & 0x7fffffff;
    }
    return h;
  }
}
