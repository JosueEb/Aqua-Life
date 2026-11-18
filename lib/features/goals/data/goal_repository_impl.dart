import 'package:drift/drift.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/local_date.dart';
import '../domain/goal_repository.dart';

class GoalRepositoryImpl implements GoalRepository {
  GoalRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Future<int?> currentGoalMl(String userId) async => (await _db.hydrationDao.currentGoal(userId))?.dailyGoalMl;

  @override
  Future<void> setDailyGoal(String userId, int dailyGoalMl, String today) {
    if (dailyGoalMl < AppConstants.minDailyGoalMl || dailyGoalMl > AppConstants.maxDailyGoalMl) {
      throw const ValidationFailure('La meta diaria está fuera del rango permitido.');
    }
    return _db.transaction(() async {
      final current = await _db.hydrationDao.currentGoal(userId);
      if (current != null && current.startDate == today) {
        // La meta de hoy se ajusta en sitio: no genera historial duplicado.
        await _db.hydrationDao.updateGoal(current.id, HydrationGoalsCompanion(dailyGoalMl: Value(dailyGoalMl)));
        return;
      }
      if (current != null) {
        await _db.hydrationDao.updateGoal(
          current.id,
          HydrationGoalsCompanion(endDate: Value(LocalDate.addDays(today, -1))),
        );
      }
      await _db.hydrationDao.insertGoal(
        HydrationGoalsCompanion.insert(userId: userId, dailyGoalMl: dailyGoalMl, startDate: today),
      );
    });
  }
}
