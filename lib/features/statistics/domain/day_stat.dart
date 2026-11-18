/// Consumo y meta de un día, calculados desde water_intakes (fuente de verdad)
/// y el historial de metas.
class DayStat {
  const DayStat({required this.date, required this.totalMl, required this.goalMl});

  final String date;
  final int totalMl;
  final int goalMl;

  bool get completed => goalMl > 0 && totalMl >= goalMl;
  double get progress => goalMl <= 0 ? 0 : (totalMl / goalMl).clamp(0, 1).toDouble();
}

class PeriodSummary {
  PeriodSummary(this.days);
  final List<DayStat> days;

  int get totalMl => days.fold(0, (s, d) => s + d.totalMl);
  int get daysWithData => days.where((d) => d.totalMl > 0).length;
  int get completedDays => days.where((d) => d.completed).length;

  /// Promedio sobre los días con registros (no penaliza días futuros).
  int get averageMl => daysWithData == 0 ? 0 : (totalMl / daysWithData).round();
}
