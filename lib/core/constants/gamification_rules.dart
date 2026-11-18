/// Reglas de gamificación centralizadas (sección 5 del documento).
///
/// Cualquier cambio en recompensas, límites o umbrales debe hacerse aquí;
/// la interfaz y los repositorios nunca deben tener números mágicos.
abstract final class GamificationRules {
  // ---- XP por evento ----
  static const int xpPerValidIntake = 5;

  /// Máximo de registros premiados por día (5 XP × 10 = 50 XP diarios).
  /// Premia el hábito, no el volumen: registros adicionales no dan XP.
  static const int maxRewardedIntakesPerDay = 10;

  static const int xpDailyGoal = 50;
  static const int xpDailyMission = 15;
  static const int xpWeeklyMission = 100;
  static const int xpStreak7Days = 100;
  static const int streakMilestoneDays = 7;

  // ---- Monedas ----
  /// 1 moneda por cada 10 XP otorgada en el mismo evento.
  static const int xpPerCoin = 10;
  static int coinsForXp(int xp) => xp ~/ xpPerCoin;

  // ---- Niveles ----
  static const int xpPerLevel = 100;

  /// nivel = 1 + XP total / 100 (división entera).
  static int levelForXp(int totalXp) => 1 + (totalXp < 0 ? 0 : totalXp) ~/ xpPerLevel;

  // ---- Validación de registros ----
  static const int minIntakeMl = 1;
  static const int maxIntakeMl = 2000;

  static bool isValidIntakeAmount(int ml) => ml >= minIntakeMl && ml <= maxIntakeMl;
}

/// Fuentes de recompensa del ledger `reward_transactions`.
/// Junto con `reference_id` forman la clave anti-duplicación.
abstract final class RewardSource {
  static const String intake = 'intake';
  static const String dailyGoal = 'daily_goal';
  static const String dailyMission = 'daily_mission';
  static const String weeklyMission = 'weekly_mission';
  static const String streak = 'streak';
  static const String achievement = 'achievement';
  static const String chest = 'chest';
  static const String shopPurchase = 'shop_purchase';
}

abstract final class RewardType {
  static const String xp = 'xp';
  static const String coins = 'coins';
}
