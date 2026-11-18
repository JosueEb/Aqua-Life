import 'dart:async';

import '../../../core/database/app_database.dart';
import '../../pet/domain/pet_evolution.dart';
import '../domain/gamification_status.dart';

class GamificationRepositoryImpl implements GamificationRepository {
  GamificationRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Stream<GamificationStatus> watchStatus(String userId) {
    final dao = _db.gamificationDao;
    late StreamController<GamificationStatus> controller;
    StreamSubscription<GamificationProfileRow?>? s1;
    StreamSubscription<PetRow?>? s2;
    GamificationProfileRow? profile;
    PetRow? pet;

    void emit() {
      final p = profile;
      if (p == null || pet == null) return;
      controller.add(GamificationStatus(
        totalXp: p.totalXp,
        level: p.level,
        coins: p.coins,
        currentStreak: p.currentStreak,
        longestStreak: p.longestStreak,
        petStage: PetStage.fromNumber(pet!.evolutionStage),
      ));
    }

    controller = StreamController<GamificationStatus>(
      onListen: () {
        s1 = dao.watchProfile(userId).listen((v) {
          profile = v;
          emit();
        }, onError: controller.addError);
        s2 = dao.watchPet(userId).listen((v) {
          pet = v;
          emit();
        }, onError: controller.addError);
      },
      onCancel: () async {
        await s1?.cancel();
        await s2?.cancel();
      },
    );
    return controller.stream;
  }
}
