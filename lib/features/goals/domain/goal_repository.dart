abstract interface class GoalRepository {
  Future<int?> currentGoalMl(String userId);

  /// Cambia la meta a partir de [today]. Los días anteriores conservan la
  /// meta que tenían (no se recalculan retrospectivamente).
  Future<void> setDailyGoal(String userId, int dailyGoalMl, String today);
}
