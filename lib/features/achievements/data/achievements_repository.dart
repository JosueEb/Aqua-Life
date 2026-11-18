import '../../../core/database/app_database.dart';

class AchievementView {
  const AchievementView({
    required this.id,
    required this.title,
    required this.description,
    required this.conditionType,
    required this.conditionValue,
    required this.coinReward,
    this.unlockedAt,
  });

  final String id;
  final String title;
  final String description;
  final String conditionType;
  final int conditionValue;
  final int coinReward;
  final DateTime? unlockedAt;

  bool get unlocked => unlockedAt != null;
}

abstract interface class AchievementsRepository {
  Stream<List<AchievementView>> watchAll(String userId);
}

class AchievementsRepositoryImpl implements AchievementsRepository {
  AchievementsRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Stream<List<AchievementView>> watchAll(String userId) => _db.gamificationDao.watchAchievements(userId).map(
        (rows) => [
          for (final (a, unlockedAt) in rows)
            AchievementView(
              id: a.id,
              title: a.title,
              description: a.description,
              conditionType: a.conditionType,
              conditionValue: a.conditionValue,
              coinReward: a.coinReward,
              unlockedAt: unlockedAt?.toLocal(),
            ),
        ],
      );
}
