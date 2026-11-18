import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../hydration/presentation/providers/hydration_providers.dart';
import '../domain/pet_evolution.dart';

/// Estado de ánimo momentáneo (bebiendo, celebrando, evolución) que dura
/// unos segundos tras una acción del usuario.
class PetMomentNotifier extends Notifier<PetMood?> {
  Timer? _timer;

  @override
  PetMood? build() {
    ref.onDispose(() => _timer?.cancel());
    return null;
  }

  void trigger(PetMood mood, {Duration duration = const Duration(seconds: 3)}) {
    _timer?.cancel();
    state = mood;
    _timer = Timer(duration, () => state = null);
  }
}

final petMomentProvider = NotifierProvider<PetMomentNotifier, PetMood?>(PetMomentNotifier.new);

final petMoodProvider = Provider<PetMood>((ref) {
  final moment = ref.watch(petMomentProvider);
  if (moment != null) return moment;
  ref.watch(todayKeyProvider); // reevaluar al cambiar de día
  final completed = ref.watch(todaySummaryProvider).value?.completed ?? false;
  return PetMoodResolver.resting(now: ref.read(clockProvider)(), goalCompleted: completed);
});
