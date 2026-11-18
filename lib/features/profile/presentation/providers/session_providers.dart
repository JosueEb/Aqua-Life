import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(ref.watch(appDatabaseProvider), ref.watch(uuidProvider)),
);

/// Sesión local: id del usuario activo y si completó el onboarding.
/// Se guarda en SharedPreferences para que el router decida sin esperar
/// a la base de datos.
class Session {
  const Session({required this.userId, required this.onboardingCompleted});
  final String? userId;
  final bool onboardingCompleted;
}

class SessionNotifier extends Notifier<Session> {
  @override
  Session build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final userId = prefs.getString(PrefKeys.currentUserId);
    return Session(
      userId: userId,
      onboardingCompleted: userId != null && (prefs.getBool(PrefKeys.onboardingCompleted) ?? false),
    );
  }

  Future<void> completeOnboarding(OnboardingData data) async {
    final repo = ref.read(profileRepositoryProvider);
    final userId = await repo.completeOnboarding(data, ref.read(clockProvider)());
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(PrefKeys.currentUserId, userId);
    await prefs.setBool(PrefKeys.onboardingCompleted, true);
    state = Session(userId: userId, onboardingCompleted: true);
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, Session>(SessionNotifier.new);

final currentUserIdProvider = Provider<String?>((ref) => ref.watch(sessionProvider).userId);

final userProfileProvider = StreamProvider<UserProfile?>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value(null);
  return ref.watch(profileRepositoryProvider).watchProfile(userId);
});
