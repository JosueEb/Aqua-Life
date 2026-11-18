import '../../../../core/utils/volume_format.dart';

class UserProfile {
  const UserProfile({
    required this.id,
    required this.isGuest,
    required this.unitSystem,
    this.name,
    this.email,
    this.weightKg,
  });

  final String id;
  final bool isGuest;
  final UnitSystem unitSystem;
  final String? name;
  final String? email;
  final double? weightKg;

  String get displayName => (name == null || name!.trim().isEmpty) ? 'Invitado' : name!.trim();
}

/// Datos recogidos en el onboarding.
class OnboardingData {
  const OnboardingData({
    required this.isGuest,
    required this.dailyGoalMl,
    required this.unitSystem,
    this.name,
    this.email,
    this.weightKg,
  });

  final bool isGuest;
  final int dailyGoalMl;
  final UnitSystem unitSystem;
  final String? name;
  final String? email;
  final double? weightKg;
}
