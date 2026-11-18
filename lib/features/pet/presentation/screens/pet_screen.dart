import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../gamification/domain/gamification_status.dart';
import '../../../hydration/presentation/providers/hydration_providers.dart';
import '../../domain/pet_evolution.dart';
import '../widgets/aqua_pet_image.dart';

class PetScreen extends ConsumerWidget {
  const PetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(gamificationStatusProvider).value ?? GamificationStatus.empty;
    final stage = status.petStage;
    final next = stage.next;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Aqua')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AquaPetImage(stage: stage, size: 200),
                  Text(stage.displayName, style: t.headlineSmall),
                  const SizedBox(height: 4),
                  Text('${status.totalXp} XP · Nivel ${status.level}'),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: PetEvolution.progressToNext(status.totalXp),
                      minHeight: 12,
                      backgroundColor: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(next == null
                      ? '¡Aqua alcanzó su forma final!'
                      : 'Faltan ${next.minXp - status.totalXp} XP para ${next.displayName}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Evolución', style: t.titleMedium),
          const SizedBox(height: 10),
          for (final s in PetStage.values)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                child: ListTile(
                  leading: AquaPetImage(stage: s, size: 48, locked: s.number > stage.number),
                  title: Text('${s.number}. ${s.displayName}'),
                  subtitle: Text('${s.minXp} XP'),
                  trailing: s.number <= stage.number
                      ? const Icon(Icons.check_circle, color: AppColors.success)
                      : const Icon(Icons.lock_outline),
                ),
              ),
            ),
          const SizedBox(height: 8),
          const Text('La evolución es permanente: Aqua nunca retrocede, aunque hagas una pausa.',
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
