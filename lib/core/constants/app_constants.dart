abstract final class AppConstants {
  static const String appName = 'AquaLife';
  static const String databaseName = 'aqua_life';

  // ---- Hidratación ----
  static const int defaultDailyGoalMl = 2000;
  static const int minDailyGoalMl = 500;
  static const int maxDailyGoalMl = 5000;
  static const int dailyGoalStepMl = 50;

  /// Accesos rápidos por defecto (configurables por el usuario).
  static const List<int> defaultQuickAmountsMl = [150, 250, 500, 750];

  // ---- Recordatorios (valores por defecto, desactivados) ----
  static const int defaultReminderStartMinutes = 8 * 60;
  static const int defaultReminderEndMinutes = 22 * 60;
  static const int defaultReminderIntervalMinutes = 90;
  static const int defaultSnoozeMinutes = 15;
}

abstract final class PrefKeys {
  static const String onboardingCompleted = 'onboarding_completed';
  static const String currentUserId = 'current_user_id';
  static const String quickAmounts = 'quick_amounts_ml';
}
