import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../core/utils/volume_format.dart';
import '../../../gamification/data/gamification_repository_impl.dart';
import '../../../gamification/domain/gamification_status.dart';
import '../../../goals/data/goal_repository_impl.dart';
import '../../../goals/domain/goal_repository.dart';
import '../../../profile/presentation/providers/session_providers.dart';
import '../../data/repositories/hydration_repository_impl.dart';
import '../../domain/entities/water_intake.dart';
import '../../domain/repositories/hydration_repository.dart';
import '../../domain/usecases/intake_usecases.dart';

final hydrationRepositoryProvider = Provider<HydrationRepository>((ref) => HydrationRepositoryImpl(
      ref.watch(appDatabaseProvider),
      ref.watch(uuidProvider),
      ref.watch(clockProvider),
    ));

final goalRepositoryProvider = Provider<GoalRepository>((ref) => GoalRepositoryImpl(ref.watch(appDatabaseProvider)));

final gamificationRepositoryProvider =
    Provider<GamificationRepository>((ref) => GamificationRepositoryImpl(ref.watch(appDatabaseProvider)));

final addWaterIntakeProvider = Provider(
  (ref) => AddWaterIntake(ref.watch(hydrationRepositoryProvider), ref.watch(clockProvider)),
);
final updateWaterIntakeProvider = Provider(
  (ref) => UpdateWaterIntake(ref.watch(hydrationRepositoryProvider), ref.watch(clockProvider)),
);
final deleteWaterIntakeProvider = Provider((ref) => DeleteWaterIntake(ref.watch(hydrationRepositoryProvider)));

final todaySummaryProvider = StreamProvider<DailySummary>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  final today = ref.watch(todayKeyProvider);
  if (userId == null) return const Stream.empty();
  return ref.watch(hydrationRepositoryProvider).watchDay(userId, today);
});

final gamificationStatusProvider = StreamProvider<GamificationStatus>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value(GamificationStatus.empty);
  return ref.watch(gamificationRepositoryProvider).watchStatus(userId);
});

final unitSystemProvider = Provider<UnitSystem>(
  (ref) => ref.watch(userProfileProvider).value?.unitSystem ?? UnitSystem.metric,
);

/// Accesos rápidos configurables (SharedPreferences).
class QuickAmountsNotifier extends Notifier<List<int>> {
  @override
  List<int> build() {
    final saved = ref.watch(sharedPreferencesProvider).getStringList(PrefKeys.quickAmounts);
    final parsed = saved?.map(int.tryParse).whereType<int>().toList();
    return (parsed == null || parsed.isEmpty) ? AppConstants.defaultQuickAmountsMl : parsed;
  }

  Future<void> set(List<int> amounts) async {
    state = amounts;
    await ref
        .read(sharedPreferencesProvider)
        .setStringList(PrefKeys.quickAmounts, amounts.map((e) => e.toString()).toList());
  }
}

final quickAmountsProvider = NotifierProvider<QuickAmountsNotifier, List<int>>(QuickAmountsNotifier.new);
