/// Métricas con las que se evalúan los logros.
class AchievementMetrics {
  const AchievementMetrics({
    required this.intakeCount,
    required this.goalsCompleted,
    required this.longestStreak,
    required this.petStage,
    this.latestIntakeHour,
  });

  final int intakeCount;
  final int goalsCompleted;
  final int longestStreak;
  final int petStage;

  /// Hora local del consumo recién registrado (para logros por horario).
  final int? latestIntakeHour;

  /// Valor actual de la métrica para un tipo de condición.
  int? valueFor(String conditionType) => switch (conditionType) {
        'intake_count' => intakeCount,
        'goals_completed' => goalsCompleted,
        'streak' => longestStreak,
        'pet_stage' => petStage,
        _ => null,
      };
}

class AchievementRule {
  const AchievementRule(this.id, this.conditionType, this.conditionValue);
  final String id;
  final String conditionType;
  final int conditionValue;
}

abstract final class AchievementEvaluator {
  static bool isMet(AchievementRule rule, AchievementMetrics m) {
    if (rule.conditionType == 'intake_before_hour') {
      final h = m.latestIntakeHour;
      return h != null && h < rule.conditionValue;
    }
    final v = m.valueFor(rule.conditionType);
    return v != null && v >= rule.conditionValue;
  }

  /// Logros cumplidos que aún no están desbloqueados.
  static List<String> newlyUnlocked(Iterable<AchievementRule> rules, Set<String> unlocked, AchievementMetrics m) => [
        for (final r in rules)
          if (!unlocked.contains(r.id) && isMet(r, m)) r.id,
      ];
}
