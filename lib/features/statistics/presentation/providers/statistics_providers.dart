import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../hydration/domain/entities/water_intake.dart';
import '../../../hydration/presentation/providers/hydration_providers.dart';
import '../../../profile/presentation/providers/session_providers.dart';
import '../../data/statistics_repository.dart';
import '../../domain/day_stat.dart';

final statisticsRepositoryProvider =
    Provider<StatisticsRepository>((ref) => StatisticsRepositoryImpl(ref.watch(appDatabaseProvider)));

/// Estadísticas diarias de un rango (from, to) inclusivo.
final dayStatsRangeProvider = StreamProvider.family<List<DayStat>, (String, String)>((ref, range) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value(const []);
  return ref.watch(statisticsRepositoryProvider).watchRange(userId, range.$1, range.$2);
});

/// Detalle (registros y meta) de una fecha concreta.
final daySummaryProvider = StreamProvider.family<DailySummary, String>((ref, date) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const Stream.empty();
  return ref.watch(hydrationRepositoryProvider).watchDay(userId, date);
});
