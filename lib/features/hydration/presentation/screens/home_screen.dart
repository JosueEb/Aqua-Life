import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/volume_format.dart';
import '../../../gamification/domain/gamification_status.dart';
import '../../../pet/domain/pet_evolution.dart';
import '../../../pet/presentation/widgets/aqua_pet_image.dart';
import '../../../profile/presentation/providers/session_providers.dart';
import '../../domain/entities/water_intake.dart';
import '../providers/hydration_providers.dart';
import '../widgets/intake_actions.dart';
import '../widgets/intake_tile.dart';
import '../widgets/progress_ring.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(todaySummaryProvider);
    final status = ref.watch(gamificationStatusProvider).value ?? GamificationStatus.empty;
    final profile = ref.watch(userProfileProvider).value;
    final unit = ref.watch(unitSystemProvider);

    return Scaffold(
      body: SafeArea(
        child: summary.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => _ErrorState(onRetry: () => ref.invalidate(todaySummaryProvider)),
          data: (day) => CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                sliver: SliverList.list(children: [
                  _Header(name: profile?.displayName ?? 'Invitado', status: status),
                  const SizedBox(height: 16),
                  _TodayCard(day: day, unit: unit, stage: status.petStage),
                  const SizedBox(height: 20),
                  Text('Registro rápido', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  const _QuickAddGrid(),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Text('Hoy', style: Theme.of(context).textTheme.titleMedium)),
                      TextButton(
                        onPressed: () => context.push('/hydration/history'),
                        child: const Text('Ver historial'),
                      ),
                    ],
                  ),
                ]),
              ),
              if (day.intakes.isEmpty)
                const SliverToBoxAdapter(child: _EmptyIntakes())
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  sliver: SliverList.separated(
                    itemCount: day.intakes.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, i) => IntakeTile(intake: day.intakes[i], unit: unit),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.name, required this.status});
  final String name;
  final GamificationStatus status;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final date = toBeginningOfSentenceCase(DateFormat("EEEE d 'de' MMMM", 'es').format(DateTime.now()));
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('¡Hola, $name!', style: t.headlineSmall, overflow: TextOverflow.ellipsis),
              Text(date),
            ],
          ),
        ),
        if (status.currentStreak > 0) ...[
          _Chip(icon: Icons.local_fire_department, color: AppColors.reward, label: '${status.currentStreak}'),
          const SizedBox(width: 6),
        ],
        _Chip(icon: Icons.star_rounded, color: AppColors.primary, label: 'Nv. ${status.level}'),
        const SizedBox(width: 6),
        _Chip(icon: Icons.monetization_on_rounded, color: AppColors.reward, label: '${status.coins}'),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.color, required this.label});
  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ]),
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard({required this.day, required this.unit, required this.stage});
  final DailySummary day;
  final UnitSystem unit;
  final PetStage stage;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final message = day.completed
        ? '¡Meta cumplida! Aqua está feliz.'
        : day.totalMl == 0
            ? 'Empieza tu día con un vaso de agua.'
            : 'Te faltan ${VolumeFormat.format(day.remainingMl, unit)}.';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                ProgressRing(
                  progress: day.progress,
                  size: 160,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(VolumeFormat.format(day.totalMl, unit),
                          style: t.headlineSmall?.copyWith(color: AppColors.primaryDark)),
                      Text('de ${VolumeFormat.format(day.goalMl, unit)}'),
                      Text('${day.percent} %',
                          style: t.titleMedium?.copyWith(
                              color: day.completed ? AppColors.success : AppColors.primary)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: AquaPetImage(stage: stage, size: 130)),
              ],
            ),
            const SizedBox(height: 12),
            Text(message, style: t.bodyLarge?.copyWith(color: AppColors.textPrimary), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _QuickAddGrid extends ConsumerWidget {
  const _QuickAddGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amounts = ref.watch(quickAmountsProvider);
    final unit = ref.watch(unitSystemProvider);
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final ml in amounts)
          _QuickButton(
            label: '+${VolumeFormat.format(ml, unit)}',
            icon: Icons.local_drink_rounded,
            onTap: () => IntakeActions.add(context, ref, ml),
          ),
        _QuickButton(
          label: 'Otra',
          icon: Icons.edit_rounded,
          outlined: true,
          onTap: () => context.push('/hydration/add'),
        ),
      ],
    );
  }
}

class _QuickButton extends StatelessWidget {
  const _QuickButton({required this.label, required this.icon, required this.onTap, this.outlined = false});
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.sizeOf(context).width - 40 - 20) / 3;
    return SizedBox(
      width: width,
      height: 64,
      child: Material(
        color: outlined ? AppColors.surface : AppColors.primaryLight,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(height: 2),
              Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryDark),
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyIntakes extends StatelessWidget {
  const _EmptyIntakes();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Column(
        children: [
          Icon(Icons.water_drop_outlined, size: 40, color: AppColors.primary),
          SizedBox(height: 8),
          Text('Aún no hay registros hoy.\nUsa un acceso rápido para empezar.', textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.error_outline, size: 40, color: AppColors.error),
        const SizedBox(height: 8),
        const Text('No pudimos cargar tus datos.'),
        TextButton(onPressed: onRetry, child: const Text('Reintentar')),
      ]),
    );
  }
}
