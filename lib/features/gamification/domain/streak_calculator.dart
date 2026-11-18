import '../../../core/utils/local_date.dart';

class StreakResult {
  const StreakResult({required this.current, required this.longest, this.currentStart});
  final int current;
  final int longest;

  /// Primer día de la racha actual (identifica la racha en el ledger).
  final String? currentStart;
}

/// Rachas basadas en días con la meta cumplida.
///
/// Política no punitiva: si hoy todavía no se cumple la meta, la racha
/// actual se cuenta hasta ayer (el día aún no termina).
abstract final class StreakCalculator {
  static StreakResult compute(Set<String> completedDates, String today) {
    var cursor = completedDates.contains(today) ? today : LocalDate.addDays(today, -1);
    var current = 0;
    String? start;
    while (completedDates.contains(cursor)) {
      current++;
      start = cursor;
      cursor = LocalDate.addDays(cursor, -1);
    }

    final sorted = completedDates.toList()..sort();
    var longest = 0;
    var run = 0;
    String? prev;
    for (final d in sorted) {
      run = (prev != null && LocalDate.addDays(prev, 1) == d) ? run + 1 : 1;
      if (run > longest) longest = run;
      prev = d;
    }
    return StreakResult(current: current, longest: longest, currentStart: start);
  }
}
