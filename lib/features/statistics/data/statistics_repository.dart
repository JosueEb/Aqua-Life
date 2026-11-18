import '../../../core/database/app_database.dart';
import '../../../core/utils/local_date.dart';
import '../../../core/utils/streams.dart';
import '../../goals/domain/goal_timeline.dart';
import '../domain/day_stat.dart';

abstract interface class StatisticsRepository {
  /// Un [DayStat] por cada fecha de [from] a [to] (inclusive), con ceros
  /// en los días sin registros.
  Stream<List<DayStat>> watchRange(String userId, String from, String to);
}

class StatisticsRepositoryImpl implements StatisticsRepository {
  StatisticsRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Stream<List<DayStat>> watchRange(String userId, String from, String to) {
    final dao = _db.hydrationDao;
    return combineLatest2(
      dao.watchDailyTotals(userId, from: from, to: to),
      dao.watchAllGoals(userId),
      (Map<String, int> totals, List<HydrationGoalRow> goals) {
        final timeline = GoalTimeline(
            goals.map((g) => GoalPeriod(id: g.id, start: g.startDate, end: g.endDate, dailyGoalMl: g.dailyGoalMl)));
        final days = <DayStat>[];
        for (var d = from; d.compareTo(to) <= 0; d = LocalDate.addDays(d, 1)) {
          days.add(DayStat(date: d, totalMl: totals[d] ?? 0, goalMl: timeline.goalFor(d)));
        }
        return days;
      },
    );
  }
}
