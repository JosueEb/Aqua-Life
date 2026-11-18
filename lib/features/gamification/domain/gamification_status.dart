import '../../pet/domain/pet_evolution.dart';

class GamificationStatus {
  const GamificationStatus({
    required this.totalXp,
    required this.level,
    required this.coins,
    required this.currentStreak,
    required this.longestStreak,
    required this.petStage,
  });

  static const empty = GamificationStatus(
      totalXp: 0, level: 1, coins: 0, currentStreak: 0, longestStreak: 0, petStage: PetStage.baby);

  final int totalXp;
  final int level;
  final int coins;
  final int currentStreak;
  final int longestStreak;
  final PetStage petStage;
}

abstract interface class GamificationRepository {
  Stream<GamificationStatus> watchStatus(String userId);
}
