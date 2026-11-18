import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../core/utils/local_date.dart';
import '../../../../core/utils/volume_format.dart';
import '../../../../shared/widgets/month_calendar.dart';
import '../../../gamification/domain/gamification_status.dart';
import '../../../hydration/presentation/providers/hydration_providers.dart';
import '../../domain/day_stat.dart';
import '../providers/statistics_providers.dart';

enum StatsPeriod { week, month }

/// /progress — estadísticas, calendario e historial.
class StatisticsScreen extends ConsumerStatefulWidget {
  const StatisticsScreen({super.key});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  StatsPeriod _period = StatsPeriod.week;

  /// 0 = periodo actual, -1 = anterior, …
  int _offset = 0;

  (String, String) _range(String today) {
    final t = LocalDate.parse(today);
    if (_period == StatsPeriod.week) {
      final start = LocalDate.addDays(LocalDate.weekStart(today), 7 * _offset);
      return (start, LocalDate.addDays(start, 6));
    }
    final first = DateTime(t.year, t.month + _offset);
    return (LocalDate.keyOf(first), LocalDate.keyOf(DateTime(first.year, first.month + 1, 0)));
  }

  String _title((String, String) r) {
    final from = LocalDate.parse(r.$1);
    final to = LocalDate.parse(r.$2);
    if (_period == StatsPeriod.month) return toBeginningOfSentenceCase(DateFormat.yMMMM('es').format(from));
    final f = DateFormat("d 'de' MMM", 'es');
    return '${f.format(from)} – ${f.format(to)}';
  }

  @override
  Widget build(BuildContext context) {
    final today = ref.watch(todayKeyProvider);
    final unit = ref.watch(unitSystemProvider);
    final status = ref.watch(gamificationStatusProvider).value ?? GamificationStatus.empty;
    final range = _range(today);
    final stats = ref.watch(dayStatsRangeProvider(range));
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progreso'),
        actions: [
          IconButton(
            tooltip: 'Historial',
            icon: const Icon(Icons.history),
            onPressed: () => context.push('/hydration/history'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          SegmentedButton<StatsPeriod>(
            segments: const [
              ButtonSegment(value: StatsPeriod.week, label: Text('Semana')),
              ButtonSegment(value: StatsPeriod.month, label: Text('Mes')),
            ],
            selected: {_period},
            onSelectionChanged: (s) => setState(() {
              _period = s.first;
              _offset = 0;
            }),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                tooltip: 'Periodo anterior',
                icon: const Icon(Icons.chevron_left),
                onPressed: () => setState(() => _offset--),
              ),
              Expanded(child: Text(_title(range), textAlign: TextAlign.center, style: t.titleMedium)),
              IconButton(
                tooltip: 'Periodo siguiente',
                icon: const Icon(Icons.chevron_right),
                onPressed: _offset >= 0 ? null : () => setState(() => _offset++),
              ),
            ],
          ),
          stats.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(40),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => const Padding(
              padding: EdgeInsets.all(24),
              child: Text('No pudimos calcular tus estadísticas.', textAlign: TextAlign.center),
            ),
            data: (days) {
              final elapsed = days.where((d) => d.date.compareTo(today) <= 0).toList();
              final summary = PeriodSummary(elapsed);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.water_drop,
                          label: 'Promedio diario',
                          value: VolumeFormat.format(summary.averageMl, unit),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.check_circle,
                          color: AppColors.success,
                          label: 'Metas cumplidas',
                          value: '${summary.completedDays}/${elapsed.length}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.local_fire_department,
                          color: AppColors.reward,
                          label: 'Racha actual',
                          value: _days(status.currentStreak),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.emoji_events,
                          color: AppColors.reward,
                          label: 'Mejor racha',
                          value: _days(status.longestStreak),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 16, 8),
                      child: SizedBox(
                        height: 220,
                        child: summary.totalMl == 0
                            ? const Center(child: Text('Sin registros en este periodo.'))
                            : _ConsumptionChart(days: days, unit: unit, period: _period),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const _Legend(),
                  if (_period == StatsPeriod.month) ...[
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: MonthCalendar(
                          month: LocalDate.parse(range.$1),
                          stats: {for (final d in days) d.date: d},
                          today: today,
                          onSelect: (_) => context.push('/hydration/history'),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    'Total del periodo: ${VolumeFormat.format(summary.totalMl, unit)}. '
                    'Calculado a partir de tus registros.',
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  static String _days(int n) => n == 1 ? '1 día' : '$n días';
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.label, required this.value, this.color = AppColors.primary});
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primaryDark),
                      overflow: TextOverflow.ellipsis),
                  Text(label, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    Widget item(Color c, String text, {bool dashed = false}) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 14,
              height: dashed ? 3 : 14,
              decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(width: 6),
            Text(text, style: const TextStyle(fontSize: 12)),
          ],
        );
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      children: [
        item(AppColors.primary, 'Consumo'),
        item(AppColors.success, 'Meta cumplida'),
        item(AppColors.reward, 'Meta', dashed: true),
      ],
    );
  }
}

class _ConsumptionChart extends StatelessWidget {
  const _ConsumptionChart({required this.days, required this.unit, required this.period});
  final List<DayStat> days;
  final UnitSystem unit;
  final StatsPeriod period;

  static const _weekLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    final goals = days.map((d) => d.goalMl).where((g) => g > 0).toList();
    final goalLine = goals.isEmpty ? 0.0 : goals.reduce((a, b) => a + b) / goals.length;
    final maxTotal = days.fold<int>(0, (m, d) => d.totalMl > m ? d.totalMl : m);
    final maxY = ([maxTotal.toDouble(), goalLine].reduce((a, b) => a > b ? a : b) * 1.15).clamp(500, double.infinity);
    final barWidth = period == StatsPeriod.week ? 22.0 : 6.0;

    return BarChart(
      BarChartData(
        maxY: maxY.toDouble(),
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          for (var i = 0; i < days.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: days[i].totalMl.toDouble(),
                  width: barWidth,
                  color: days[i].completed ? AppColors.success : AppColors.primary,
                  borderRadius: BorderRadius.circular(barWidth / 2),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: maxY.toDouble(),
                    color: AppColors.primaryLight.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
        ],
        extraLinesData: ExtraLinesData(horizontalLines: [
          if (goalLine > 0)
            HorizontalLine(y: goalLine, color: AppColors.reward, strokeWidth: 2, dashArray: const [6, 4]),
        ]),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 48,
              interval: maxY / 4,
              getTitlesWidget: (value, meta) => value == 0 || value >= meta.max
                  ? const SizedBox.shrink()
                  : SideTitleWidget(
                      meta: meta,
                      child: Text(VolumeFormat.format(value.round(), unit),
                          style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                    ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                final String label;
                if (period == StatsPeriod.week) {
                  label = _weekLabels[i % 7];
                } else {
                  final day = i + 1;
                  label = (day == 1 || day % 5 == 0) ? '$day' : '';
                }
                return SideTitleWidget(
                  meta: meta,
                  child: Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                );
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => AppColors.primaryDark,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final d = days[group.x];
              final date = DateFormat("d MMM", 'es').format(LocalDate.parse(d.date));
              return BarTooltipItem(
                '$date\n${VolumeFormat.format(d.totalMl, unit)}',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
              );
            },
          ),
        ),
      ),
    );
  }
}
