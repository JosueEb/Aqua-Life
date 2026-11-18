import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/utils/local_date.dart';
import '../../../core/utils/volume_format.dart';
import '../../hydration/presentation/providers/hydration_providers.dart';
import '../../profile/presentation/providers/session_providers.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  int? _goal;
  bool _saving = false;

  Future<void> _save() async {
    final userId = ref.read(currentUserIdProvider);
    final goal = _goal;
    if (userId == null || goal == null) return;
    setState(() => _saving = true);
    await ref.read(goalRepositoryProvider).setDailyGoal(userId, goal, LocalDate.keyOf(ref.read(clockProvider)()));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Meta actualizada desde hoy')));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final current = ref.watch(todaySummaryProvider).value?.goalMl ?? AppConstants.defaultDailyGoalMl;
    final unit = ref.watch(unitSystemProvider);
    final goal = _goal ?? current;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Meta diaria')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text(VolumeFormat.format(goal, unit), style: t.displaySmall)),
            Slider(
              value: goal.toDouble(),
              min: AppConstants.minDailyGoalMl.toDouble(),
              max: AppConstants.maxDailyGoalMl.toDouble(),
              divisions: (AppConstants.maxDailyGoalMl - AppConstants.minDailyGoalMl) ~/ AppConstants.dailyGoalStepMl,
              label: VolumeFormat.format(goal, unit),
              onChanged: (v) => setState(() => _goal = v.round()),
            ),
            const SizedBox(height: 8),
            const Text('El cambio aplica desde hoy. Los días anteriores conservan la meta que tenían.'),
            const Spacer(),
            FilledButton(
              onPressed: _saving || goal == current ? null : _save,
              child: const Text('Guardar meta'),
            ),
          ],
        ),
      ),
    );
  }
}
