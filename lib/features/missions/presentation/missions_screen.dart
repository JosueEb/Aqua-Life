import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/errors/failures.dart';
import '../../../core/providers/core_providers.dart';
import '../../pet/domain/pet_evolution.dart';
import '../../pet/presentation/pet_mood_providers.dart';
import '../../profile/presentation/providers/session_providers.dart';
import '../data/missions_repository.dart';

final missionsRepositoryProvider =
    Provider<MissionsRepository>((ref) => MissionsRepositoryImpl(ref.watch(appDatabaseProvider)));

final missionBoardProvider = StreamProvider<MissionBoard>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  final today = ref.watch(todayKeyProvider);
  if (userId == null) return const Stream.empty();
  return ref.watch(missionsRepositoryProvider).watchBoard(userId, today);
});

/// /missions — misiones diarias y semanales, y cofres.
class MissionsScreen extends ConsumerWidget {
  const MissionsScreen({super.key});

  Future<void> _claim(BuildContext context, WidgetRef ref, MissionView m) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final grant = await ref.read(missionsRepositoryProvider).claim(userId, m.def.id, ref.read(clockProvider)());
      if (grant != null) {
        ref.read(petMomentProvider.notifier).trigger(PetMood.happy);
        messenger.showSnackBar(SnackBar(content: Text('¡${m.def.title}! +${grant.xp} XP · +${grant.coins} moneda${grant.coins == 1 ? '' : 's'}')));
      }
    } on ValidationFailure catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<void> _open(BuildContext context, WidgetRef ref, ChestView chest) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    try {
      final coins = await ref.read(missionsRepositoryProvider).openChest(userId, chest.kind, ref.read(clockProvider)());
      if (!context.mounted || coins == 0) return;
      ref.read(petMomentProvider.notifier).trigger(PetMood.celebrating);
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: const Icon(Icons.card_giftcard, size: 48, color: AppColors.reward),
          title: Text(chest.kind == ChestKind.daily ? 'Cofre diario' : 'Cofre semanal'),
          content: Text('¡Encontraste $coins monedas!', textAlign: TextAlign.center),
          actions: [FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('¡Genial!'))],
        ),
      );
    } on ValidationFailure catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(missionBoardProvider);
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Misiones')),
      body: board.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('No pudimos cargar las misiones.')),
        data: (b) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          children: [
            Row(
              children: [
                Expanded(child: _ChestCard(chest: b.dailyChest, onOpen: () => _open(context, ref, b.dailyChest))),
                const SizedBox(width: 10),
                Expanded(child: _ChestCard(chest: b.weeklyChest, onOpen: () => _open(context, ref, b.weeklyChest))),
              ],
            ),
            const SizedBox(height: 20),
            Text('Diarias', style: t.titleMedium),
            const Text('Se renuevan cada día.'),
            const SizedBox(height: 8),
            for (final m in b.daily) _MissionTile(mission: m, onClaim: () => _claim(context, ref, m)),
            const SizedBox(height: 20),
            Text('Semanales', style: t.titleMedium),
            const Text('De lunes a domingo.'),
            const SizedBox(height: 8),
            for (final m in b.weekly) _MissionTile(mission: m, onClaim: () => _claim(context, ref, m)),
          ],
        ),
      ),
    );
  }
}

class _MissionTile extends StatelessWidget {
  const _MissionTile({required this.mission, required this.onClaim});
  final MissionView mission;
  final VoidCallback onClaim;

  @override
  Widget build(BuildContext context) {
    final m = mission;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.def.title, style: Theme.of(context).textTheme.titleMedium),
                    Text(m.def.description),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: m.target == 0 ? 0 : m.progress / m.target,
                        minHeight: 8,
                        backgroundColor: AppColors.primaryLight,
                        color: m.completed ? AppColors.success : AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('${m.progress}/${m.target} · +${m.def.xpReward} XP', style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (m.claimed)
                const Icon(Icons.check_circle, color: AppColors.success, size: 32, semanticLabel: 'Reclamada')
              else
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(88, 44),
                    backgroundColor: AppColors.reward,
                    foregroundColor: AppColors.textPrimary,
                  ),
                  onPressed: m.claimable ? onClaim : null,
                  child: const Text('Reclamar'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChestCard extends StatelessWidget {
  const _ChestCard({required this.chest, required this.onOpen});
  final ChestView chest;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final title = chest.kind == ChestKind.daily ? 'Cofre diario' : 'Cofre semanal';
    final subtitle = chest.opened
        ? 'Abierto'
        : chest.available
            ? '¡Listo para abrir!'
            : '${chest.claims}/${chest.required} misiones';
    return Card(
      color: chest.available ? AppColors.reward.withValues(alpha: 0.25) : AppColors.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: chest.available ? onOpen : null,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Icon(
                chest.opened ? Icons.inventory_2_outlined : Icons.card_giftcard,
                size: 40,
                color: chest.opened ? AppColors.textSecondary : AppColors.reward,
              ),
              const SizedBox(height: 6),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              Text(subtitle, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
