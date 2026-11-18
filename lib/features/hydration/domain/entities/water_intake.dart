import '../../../gamification/domain/reward_engine.dart';

class WaterIntake {
  const WaterIntake({required this.id, required this.amountMl, required this.consumedAt, required this.localDate});

  final String id;
  final int amountMl;

  /// Hora local del consumo.
  final DateTime consumedAt;
  final String localDate;
}

class DailySummary {
  const DailySummary({required this.date, required this.totalMl, required this.goalMl, required this.intakes});

  final String date;
  final int totalMl;
  final int goalMl;
  final List<WaterIntake> intakes;

  double get progress => goalMl <= 0 ? 0 : (totalMl / goalMl).clamp(0, 1).toDouble();
  int get percent => goalMl <= 0 ? 0 : (totalMl * 100 / goalMl).floor();
  bool get completed => goalMl > 0 && totalMl >= goalMl;
  int get remainingMl => (goalMl - totalMl).clamp(0, goalMl);
}

/// Resultado de una operación de consumo, con las recompensas otorgadas.
class IntakeResult {
  const IntakeResult({required this.intake, required this.rewards, this.unlockedAchievements = const []});
  final WaterIntake intake;
  final List<RewardGrant> rewards;
  final List<String> unlockedAchievements;

  int get xpEarned => rewards.fold(0, (s, r) => s + r.xp);
  int get coinsEarned => rewards.fold(0, (s, r) => s + r.coins);
}
