import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../gamification/domain/gamification_status.dart';
import '../../../hydration/presentation/providers/hydration_providers.dart';
import '../../domain/pet_evolution.dart';
import '../pet_mood_providers.dart';
import '../widgets/animated_aqua.dart';
import '../widgets/aqua_pet_image.dart';

class PetScreen extends ConsumerWidget {
  const PetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(gamificationStatusProvider).value ?? GamificationStatus.empty;
    final mood = ref.watch(petMoodProvider);
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
                  GestureDetector(
                    onTap: () => ref.read(petMomentProvider.notifier).trigger(PetMood.happy),
                    child: AnimatedAqua(stage: stage, equipped: status.equipped, mood: mood, size: 220),
                  ),
                  const SizedBox(height: 8),
                  Text(stage.displayName, style: t.headlineSmall),
                  const SizedBox(height: 4),
                  Chip(
                    avatar: Icon(_moodIcon(mood), size: 18, color: AppColors.primary),
                    label: Text(mood.displayName),
                    backgroundColor: AppColors.primaryLight,
                    side: BorderSide.none,
                  ),
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
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _Action(icon: Icons.storefront, label: 'Tienda', onTap: () => context.push('/shop'))),
              const SizedBox(width: 8),
              Expanded(
                child: _Action(icon: Icons.checkroom, label: 'Inventario', onTap: () => context.push('/inventory')),
              ),
              const SizedBox(width: 8),
              Expanded(child: _Action(icon: Icons.flag_circle, label: 'Misiones', onTap: () => context.push('/missions'))),
            ],
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

  static IconData _moodIcon(PetMood mood) => switch (mood) {
        PetMood.idle => Icons.sentiment_satisfied,
        PetMood.happy => Icons.sentiment_very_satisfied,
        PetMood.drinking => Icons.local_drink,
        PetMood.celebrating => Icons.celebration,
        PetMood.levelUp => Icons.auto_awesome,
        PetMood.sleeping => Icons.bedtime,
      };
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          ]),
        ),
      ),
    );
  }
}
