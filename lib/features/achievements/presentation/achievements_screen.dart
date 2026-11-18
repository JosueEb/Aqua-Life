import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/providers/core_providers.dart';
import '../../gamification/domain/gamification_status.dart';
import '../../hydration/presentation/providers/hydration_providers.dart';
import '../../profile/presentation/providers/session_providers.dart';
import '../data/achievements_repository.dart';

final achievementsRepositoryProvider =
    Provider<AchievementsRepository>((ref) => AchievementsRepositoryImpl(ref.watch(appDatabaseProvider)));

final achievementsProvider = StreamProvider<List<AchievementView>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value(const []);
  return ref.watch(achievementsRepositoryProvider).watchAll(userId);
});

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  static IconData iconFor(String conditionType) => switch (conditionType) {
        'intake_count' => Icons.water_drop,
        'goals_completed' => Icons.flag,
        'streak' => Icons.local_fire_department,
        'intake_before_hour' => Icons.wb_twilight,
        'pet_stage' => Icons.auto_awesome,
        _ => Icons.emoji_events,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievements = ref.watch(achievementsProvider);
    final status = ref.watch(gamificationStatusProvider).value ?? GamificationStatus.empty;

    return Scaffold(
      appBar: AppBar(title: const Text('Logros')),
      body: achievements.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('No pudimos cargar tus logros.')),
        data: (list) {
          final unlocked = list.where((a) => a.unlocked).length;
          final sorted = [...list]..sort((a, b) {
              if (a.unlocked != b.unlocked) return a.unlocked ? -1 : 1;
              return a.conditionValue.compareTo(b.conditionValue);
            });
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 26,
                        backgroundColor: AppColors.reward,
                        child: Icon(Icons.emoji_events, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$unlocked de ${list.length} logros',
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: list.isEmpty ? 0 : unlocked / list.length,
                                minHeight: 8,
                                color: AppColors.reward,
                                backgroundColor: AppColors.primaryLight,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text('Racha actual: ${status.currentStreak} · Mejor: ${status.longestStreak}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.82,
                ),
                itemCount: sorted.length,
                itemBuilder: (context, i) => _AchievementCard(achievement: sorted[i]),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({required this.achievement});
  final AchievementView achievement;

  @override
  Widget build(BuildContext context) {
    final a = achievement;
    final date = a.unlockedAt == null ? null : DateFormat("d MMM yyyy", 'es').format(a.unlockedAt!);
    return Semantics(
      label: '${a.title}. ${a.unlocked ? 'Desbloqueado' : 'Bloqueado'}. ${a.description}',
      child: Card(
        color: a.unlocked ? AppColors.surface : AppColors.surface.withValues(alpha: 0.6),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: a.unlocked ? AppColors.reward : AppColors.primaryLight,
                child: Icon(
                  a.unlocked ? AchievementsScreen.iconFor(a.conditionType) : Icons.lock_outline,
                  color: a.unlocked ? Colors.white : AppColors.textSecondary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                a.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: a.unlocked ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  a.description,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Text(
                date ?? '+${a.coinReward} monedas',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: date != null ? AppColors.success : AppColors.reward,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
