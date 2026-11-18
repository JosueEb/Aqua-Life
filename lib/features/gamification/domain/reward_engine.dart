import '../../../core/constants/gamification_rules.dart';

/// Recompensa decidida por el motor; el ledger la hace idempotente
/// mediante (source, referenceId).
class RewardGrant {
  const RewardGrant({required this.source, required this.referenceId, required this.xp, required this.coins});

  factory RewardGrant.ofXp(String source, String referenceId, int xp) =>
      RewardGrant(source: source, referenceId: referenceId, xp: xp, coins: GamificationRules.coinsForXp(xp));

  final String source;
  final String referenceId;
  final int xp;
  final int coins;

  @override
  bool operator ==(Object other) =>
      other is RewardGrant &&
      other.source == source &&
      other.referenceId == referenceId &&
      other.xp == xp &&
      other.coins == coins;

  @override
  int get hashCode => Object.hash(source, referenceId, xp, coins);

  @override
  String toString() => 'RewardGrant($source/$referenceId, $xp XP, $coins monedas)';
}

/// Estado del día necesario para decidir recompensas.
class DayRewardSnapshot {
  const DayRewardSnapshot({
    required this.localDate,
    required this.rewardedIntakesToday,
    required this.totalMl,
    required this.goalMl,
  });

  final String localDate;
  final int rewardedIntakesToday;
  final int totalMl;
  final int goalMl;
}

/// Reglas puras de recompensa (sin acceso a base de datos).
abstract final class RewardEngine {
  /// Recompensas al registrar un consumo nuevo.
  static List<RewardGrant> forNewIntake({
    required String intakeId,
    required int amountMl,
    required DayRewardSnapshot day,
  }) {
    final grants = <RewardGrant>[];
    if (GamificationRules.isValidIntakeAmount(amountMl) &&
        day.rewardedIntakesToday < GamificationRules.maxRewardedIntakesPerDay) {
      grants.add(RewardGrant.ofXp(RewardSource.intake, intakeId, GamificationRules.xpPerValidIntake));
    }
    grants.addAll(forDayTotals(day));
    return grants;
  }

  /// Recompensas que dependen del total del día (meta diaria). Se usa tras
  /// crear o editar consumos; el ledger evita repetirla en el mismo día.
  static List<RewardGrant> forDayTotals(DayRewardSnapshot day) {
    if (day.goalMl > 0 && day.totalMl >= day.goalMl) {
      return [RewardGrant.ofXp(RewardSource.dailyGoal, day.localDate, GamificationRules.xpDailyGoal)];
    }
    return const [];
  }

  /// Hito de racha: cada múltiplo de 7 días seguidos. La referencia incluye
  /// el inicio de la racha, así una racha nueva puede volver a premiarse.
  static List<RewardGrant> forStreak({required int current, required String? streakStart}) {
    if (streakStart == null || current <= 0 || current % GamificationRules.streakMilestoneDays != 0) {
      return const [];
    }
    return [RewardGrant.ofXp(RewardSource.streak, '$streakStart:$current', GamificationRules.xpStreak7Days)];
  }
}
