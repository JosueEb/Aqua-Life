import '../../../../core/utils/volume_format.dart';
import '../entities/user_profile.dart';

abstract interface class ProfileRepository {
  /// Crea el perfil local (invitado o con nombre), su meta inicial,
  /// perfil de gamificación, mascota y ajustes de recordatorios en una
  /// sola transacción. Devuelve el id del usuario.
  Future<String> completeOnboarding(OnboardingData data, DateTime now);

  Stream<UserProfile?> watchProfile(String userId);

  Future<void> updateUnitSystem(String userId, UnitSystem unit);
}
