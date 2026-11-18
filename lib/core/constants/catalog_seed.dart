/// Catálogo inicial de logros, misiones y artículos de tienda.
///
/// Se inserta en la base de datos al crearla. Es contenido provisional que se
/// puede ampliar en futuras migraciones sin tocar la lógica.
library;

class AchievementSeed {
  const AchievementSeed(this.id, this.title, this.description, this.conditionType, this.conditionValue,
      {this.xpReward = 0, this.coinReward = 10});
  final String id;
  final String title;
  final String description;

  /// Tipo de condición evaluada por el servicio de logros (fase 6).
  final String conditionType;
  final int conditionValue;
  final int xpReward;
  final int coinReward;
}

class MissionSeed {
  const MissionSeed(this.id, this.title, this.description, this.period, this.metric, this.target);
  final String id;
  final String title;
  final String description;

  /// 'daily' | 'weekly'
  final String period;

  /// Métrica que alimenta el progreso de la misión (fase 8).
  final String metric;
  final int target;
}

class ShopItemSeed {
  const ShopItemSeed(this.id, this.name, this.category, this.priceCoins, {this.unlockLevel = 1});
  final String id;
  final String name;

  /// 'hat' | 'glasses' | 'neck' | 'background' | 'effect'
  final String category;
  final int priceCoins;
  final int unlockLevel;

  String get assetPath => 'assets/images/accessories/$id.png';
}

abstract final class CatalogSeed {
  static const achievements = <AchievementSeed>[
    AchievementSeed('first_sip', 'Primer sorbo', 'Registra tu primer consumo de agua.', 'intake_count', 1),
    AchievementSeed('first_goal', 'Meta cumplida', 'Cumple tu meta diaria por primera vez.', 'goals_completed', 1),
    AchievementSeed('streak_3', 'Constancia', 'Mantén una racha de 3 días.', 'streak', 3),
    AchievementSeed('streak_7', 'Semana perfecta', 'Mantén una racha de 7 días.', 'streak', 7, coinReward: 25),
    AchievementSeed('streak_30', 'Hábito de hierro', 'Mantén una racha de 30 días.', 'streak', 30, coinReward: 100),
    AchievementSeed('goals_10', 'Diez de diez', 'Cumple tu meta 10 días.', 'goals_completed', 10, coinReward: 20),
    AchievementSeed('goals_50', 'Experta en hidratación', 'Cumple tu meta 50 días.', 'goals_completed', 50, coinReward: 60),
    AchievementSeed('early_bird', 'Madrugadora', 'Registra agua antes de las 8:00.', 'intake_before_hour', 8),
    AchievementSeed('pet_stage_3', 'Aventura en marcha', 'Haz que Aqua llegue a la etapa aventurera.', 'pet_stage', 3, coinReward: 30),
    AchievementSeed('pet_stage_5', 'Guardiana del agua', 'Haz que Aqua alcance su forma final.', 'pet_stage', 5, coinReward: 100),
  ];

  static const missions = <MissionSeed>[
    // Diarias
    MissionSeed('d_morning', 'Buenos días', 'Registra agua antes de las 10:00.', 'daily', 'intake_before_hour', 10),
    MissionSeed('d_three_logs', 'Tres sorbos', 'Haz 3 registros hoy.', 'daily', 'intake_count', 3),
    MissionSeed('d_half_goal', 'Mitad del camino', 'Alcanza el 50 % de tu meta.', 'daily', 'goal_percent', 50),
    MissionSeed('d_goal', 'Meta del día', 'Cumple tu meta diaria.', 'daily', 'goal_percent', 100),
    MissionSeed('d_spread', 'Bien repartido', 'Registra agua en 3 franjas del día.', 'daily', 'day_parts', 3),
    // Semanales
    MissionSeed('w_goal_5', 'Semana constante', 'Cumple tu meta 5 días esta semana.', 'weekly', 'goals_completed', 5),
    MissionSeed('w_logs_20', 'Veinte registros', 'Haz 20 registros esta semana.', 'weekly', 'intake_count', 20),
    MissionSeed('w_daily_missions_10', 'Misionera', 'Completa 10 misiones diarias esta semana.', 'weekly', 'daily_missions', 10),
  ];

  static const shopItems = <ShopItemSeed>[
    ShopItemSeed('hat_cap', 'Gorra azul', 'hat', 30),
    ShopItemSeed('hat_flower', 'Flor de loto', 'hat', 40),
    ShopItemSeed('hat_beanie', 'Gorrito de lana', 'hat', 50, unlockLevel: 2),
    ShopItemSeed('hat_party', 'Sombrero de fiesta', 'hat', 60, unlockLevel: 3),
    ShopItemSeed('glasses_round', 'Gafas redondas', 'glasses', 35),
    ShopItemSeed('glasses_sun', 'Gafas de sol', 'glasses', 45, unlockLevel: 2),
    ShopItemSeed('glasses_star', 'Gafas de estrella', 'glasses', 70, unlockLevel: 4),
    ShopItemSeed('neck_bow', 'Moño', 'neck', 25),
    ShopItemSeed('neck_scarf', 'Bufanda', 'neck', 40, unlockLevel: 2),
    ShopItemSeed('bg_ocean', 'Fondo océano', 'background', 80, unlockLevel: 3),
    ShopItemSeed('bg_rain', 'Fondo lluvia', 'background', 80, unlockLevel: 3),
    ShopItemSeed('fx_bubbles', 'Burbujas brillantes', 'effect', 120, unlockLevel: 5),
  ];
}
