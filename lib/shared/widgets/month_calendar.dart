import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/app_colors.dart';
import '../../core/utils/local_date.dart';
import '../../features/statistics/domain/day_stat.dart';

/// Calendario mensual de actividad. Cada día muestra un relleno según el
/// avance hacia la meta y verde cuando se cumplió.
class MonthCalendar extends StatelessWidget {
  const MonthCalendar({
    super.key,
    required this.month,
    required this.stats,
    required this.today,
    this.selected,
    this.onSelect,
    this.onMonthChanged,
  });

  /// Cualquier fecha dentro del mes a mostrar.
  final DateTime month;
  final Map<String, DayStat> stats;
  final String today;
  final String? selected;
  final ValueChanged<String>? onSelect;
  final ValueChanged<DateTime>? onMonthChanged;

  static const _weekdays = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    final first = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leading = first.weekday - DateTime.monday;
    final title = toBeginningOfSentenceCase(DateFormat.yMMMM('es').format(first));
    final isCurrentMonth = LocalDate.keyOf(first).substring(0, 7) == today.substring(0, 7);

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              tooltip: 'Mes anterior',
              icon: const Icon(Icons.chevron_left),
              onPressed: onMonthChanged == null ? null : () => onMonthChanged!(DateTime(first.year, first.month - 1)),
            ),
            Expanded(
              child: Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
            ),
            IconButton(
              tooltip: 'Mes siguiente',
              icon: const Icon(Icons.chevron_right),
              onPressed: onMonthChanged == null || isCurrentMonth
                  ? null
                  : () => onMonthChanged!(DateTime(first.year, first.month + 1)),
            ),
          ],
        ),
        Row(
          children: [
            for (final w in _weekdays)
              Expanded(
                child: Center(
                  child: Text(w, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, childAspectRatio: 1),
          itemCount: leading + daysInMonth,
          itemBuilder: (context, i) {
            if (i < leading) return const SizedBox.shrink();
            final day = i - leading + 1;
            final key = LocalDate.keyOf(DateTime(first.year, first.month, day));
            return _DayCell(
              day: day,
              stat: stats[key],
              isToday: key == today,
              isSelected: key == selected,
              isFuture: key.compareTo(today) > 0,
              onTap: onSelect == null || key.compareTo(today) > 0 ? null : () => onSelect!(key),
            );
          },
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.stat,
    required this.isToday,
    required this.isSelected,
    required this.isFuture,
    this.onTap,
  });

  final int day;
  final DayStat? stat;
  final bool isToday;
  final bool isSelected;
  final bool isFuture;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final s = stat;
    final completed = s?.completed ?? false;
    final progress = s?.progress ?? 0;
    final Color fill = completed
        ? AppColors.success
        : progress > 0
            ? Color.lerp(AppColors.primaryLight, AppColors.primary, progress)!
            : Colors.transparent;
    final textColor = isFuture
        ? AppColors.textSecondary.withValues(alpha: 0.4)
        : (completed || progress > 0.6)
            ? Colors.white
            : AppColors.textPrimary;

    return Semantics(
      button: onTap != null,
      selected: isSelected,
      label: '$day${completed ? ', meta cumplida' : ''}',
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: fill,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: AppColors.primaryDark, width: 2.5)
                  : isToday
                      ? Border.all(color: AppColors.primary, width: 1.5)
                      : null,
            ),
            child: Center(
              child: Text('$day', style: TextStyle(fontWeight: FontWeight.w600, color: textColor)),
            ),
          ),
        ),
      ),
    );
  }
}
