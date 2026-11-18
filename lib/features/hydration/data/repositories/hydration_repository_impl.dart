import 'dart:async';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/local_date.dart';
import '../../../gamification/data/progress_service.dart';
import '../../domain/entities/water_intake.dart';
import '../../domain/repositories/hydration_repository.dart';

class HydrationRepositoryImpl implements HydrationRepository {
  HydrationRepositoryImpl(this._db, this._uuid, this._clock) : _progress = ProgressService(_db);

  final AppDatabase _db;
  final Uuid _uuid;
  final DateTime Function() _clock;
  final ProgressService _progress;

  static WaterIntake _toEntity(WaterIntakeRow r) =>
      WaterIntake(id: r.id, amountMl: r.amountMl, consumedAt: r.consumedAt.toLocal(), localDate: r.localDate);

  @override
  Stream<DailySummary> watchDay(String userId, String localDate) {
    final dao = _db.hydrationDao;
    late StreamController<DailySummary> controller;
    StreamSubscription<List<WaterIntakeRow>>? s1;
    StreamSubscription<HydrationGoalRow?>? s2;
    List<WaterIntakeRow>? intakes;
    HydrationGoalRow? goal;
    var goalLoaded = false;

    void emit() {
      if (intakes == null || !goalLoaded) return;
      controller.add(DailySummary(
        date: localDate,
        totalMl: intakes!.fold(0, (s, r) => s + r.amountMl),
        goalMl: goal?.dailyGoalMl ?? 0,
        intakes: intakes!.map(_toEntity).toList(),
      ));
    }

    controller = StreamController<DailySummary>(
      onListen: () {
        s1 = dao.watchIntakesForDate(userId, localDate).listen((v) {
          intakes = v;
          emit();
        }, onError: controller.addError);
        s2 = dao.watchGoalForDate(userId, localDate).listen((v) {
          goal = v;
          goalLoaded = true;
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

  IntakeResult _result(WaterIntake intake, ProgressOutcome o) =>
      IntakeResult(intake: intake, rewards: o.rewards, unlockedAchievements: o.unlockedAchievements);

  @override
  Future<IntakeResult> addIntake(String userId, int amountMl, DateTime consumedAt) {
    return _db.transaction(() async {
      final id = _uuid.v4();
      final now = _clock();
      final date = LocalDate.keyOf(consumedAt);
      await _db.hydrationDao.insertIntake(WaterIntakesCompanion.insert(
        id: id,
        userId: userId,
        amountMl: amountMl,
        consumedAt: consumedAt.toUtc(),
        localDate: date,
        createdAt: now.toUtc(),
        updatedAt: now.toUtc(),
      ));
      final outcome = await _progress.onDayChanged(
        userId: userId,
        date: date,
        today: LocalDate.keyOf(now),
        nowUtc: now.toUtc(),
        newIntakeId: id,
        newIntakeAmountMl: amountMl,
        newIntakeLocalHour: consumedAt.toLocal().hour,
      );
      return _result(
        WaterIntake(id: id, amountMl: amountMl, consumedAt: consumedAt.toLocal(), localDate: date),
        outcome,
      );
    });
  }

  @override
  Future<IntakeResult> updateIntake(String userId, String intakeId, int amountMl, DateTime consumedAt) {
    return _db.transaction(() async {
      final existing = await _db.hydrationDao.findIntake(intakeId);
      if (existing == null || existing.userId != userId) {
        throw const NotFoundFailure('El registro ya no existe.');
      }
      final now = _clock();
      final today = LocalDate.keyOf(now);
      final newDate = LocalDate.keyOf(consumedAt);
      await _db.hydrationDao.updateIntake(
        intakeId,
        WaterIntakesCompanion(
          amountMl: Value(amountMl),
          consumedAt: Value(consumedAt.toUtc()),
          localDate: Value(newDate),
          updatedAt: Value(now.toUtc()),
        ),
      );
      if (existing.localDate != newDate) {
        await _progress.onDayChanged(userId: userId, date: existing.localDate, today: today, nowUtc: now.toUtc());
      }
      final outcome = await _progress.onDayChanged(userId: userId, date: newDate, today: today, nowUtc: now.toUtc());
      return _result(
        WaterIntake(id: intakeId, amountMl: amountMl, consumedAt: consumedAt.toLocal(), localDate: newDate),
        outcome,
      );
    });
  }

  @override
  Future<void> deleteIntake(String userId, String intakeId) {
    return _db.transaction(() async {
      final existing = await _db.hydrationDao.findIntake(intakeId);
      if (existing == null || existing.userId != userId) return;
      await _db.hydrationDao.deleteIntake(intakeId);
      final now = _clock();
      await _progress.onDayChanged(
        userId: userId,
        date: existing.localDate,
        today: LocalDate.keyOf(now),
        nowUtc: now.toUtc(),
      );
    });
  }
}
