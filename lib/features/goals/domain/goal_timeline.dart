/// Periodo de una meta diaria: aplica de [start] a [end] (inclusive, nulo = vigente).
class GoalPeriod {
  const GoalPeriod({required this.id, required this.start, required this.end, required this.dailyGoalMl});
  final int id;
  final String start;
  final String? end;
  final int dailyGoalMl;

  bool covers(String date) => start.compareTo(date) <= 0 && (end == null || end!.compareTo(date) >= 0);
}

/// Resuelve la meta que aplicaba en cada fecha a partir del historial.
/// Misma regla que la consulta SQL: el periodo más reciente que cubre la fecha.
class GoalTimeline {
  GoalTimeline(Iterable<GoalPeriod> periods)
      : _periods = periods.toList()
          ..sort((a, b) {
            final c = b.start.compareTo(a.start);
            return c != 0 ? c : b.id.compareTo(a.id);
          });

  final List<GoalPeriod> _periods;

  int goalFor(String date) {
    for (final p in _periods) {
      if (p.covers(date)) return p.dailyGoalMl;
    }
    return 0;
  }
}
