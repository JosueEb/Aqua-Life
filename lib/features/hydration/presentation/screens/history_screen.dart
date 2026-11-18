import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../core/utils/local_date.dart';
import '../../../../core/utils/volume_format.dart';
import '../../../../shared/widgets/month_calendar.dart';
import '../../../statistics/presentation/providers/statistics_providers.dart';
import '../../domain/usecases/intake_usecases.dart';
import '../providers/hydration_providers.dart';
import '../widgets/intake_actions.dart';
import '../widgets/intake_tile.dart';

/// /hydration/history — calendario y registros de cualquier día.
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  late DateTime _month;
  late String _selected;

  @override
  void initState() {
    super.initState();
    final now = ref.read(clockProvider)();
    _month = DateTime(now.year, now.month);
    _selected = LocalDate.keyOf(now);
  }

  @override
  Widget build(BuildContext context) {
    final today = ref.watch(todayKeyProvider);
    final unit = ref.watch(unitSystemProvider);
    final from = LocalDate.keyOf(_month);
    final to = LocalDate.keyOf(DateTime(_month.year, _month.month + 1, 0));
    final stats = ref.watch(dayStatsRangeProvider((from, to))).value ?? const [];
    final day = ref.watch(daySummaryProvider(_selected));
    final editable = IntakeWindow.isEditable(_selected, today);
    final t = Theme.of(context).textTheme;
    final selectedDate = LocalDate.parse(_selected);

    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: MonthCalendar(
                month: _month,
                stats: {for (final s in stats) s.date: s},
                today: today,
                selected: _selected,
                onSelect: (d) => setState(() => _selected = d),
                onMonthChanged: (m) => setState(() => _month = m),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  toBeginningOfSentenceCase(DateFormat("EEEE d 'de' MMMM", 'es').format(selectedDate)),
                  style: t.titleMedium,
                ),
              ),
              if (editable)
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar'),
                  onPressed: () => _addFor(selectedDate, today),
                ),
            ],
          ),
          day.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => const Text('No pudimos cargar este día.'),
            data: (d) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  d.goalMl > 0
                      ? '${VolumeFormat.format(d.totalMl, unit)} de ${VolumeFormat.format(d.goalMl, unit)} · ${d.percent} %'
                      : VolumeFormat.format(d.totalMl, unit),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: d.completed ? AppColors.success : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                if (d.intakes.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text('Sin registros este día.', textAlign: TextAlign.center),
                  )
                else
                  for (final i in d.intakes)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: IntakeTile(intake: i, unit: unit, editable: editable),
                    ),
                if (!editable && d.intakes.isNotEmpty)
                  const Text(
                    'Los registros de más de ${IntakeWindow.editableDays} días ya no se pueden editar.',
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addFor(DateTime date, String today) async {
    final now = ref.read(clockProvider)();
    final initial = LocalDate.keyOf(date) == today ? now : DateTime(date.year, date.month, date.day, 12);
    final result = await showModalBottomSheet<(int, DateTime)>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => IntakeFormSheet(initialTime: initial, title: 'Agregar consumo'),
    );
    if (result == null || !mounted) return;
    await IntakeActions.add(context, ref, result.$1, consumedAt: result.$2);
  }
}
