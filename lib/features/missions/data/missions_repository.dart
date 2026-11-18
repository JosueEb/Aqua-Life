import 'package:drift/drift.dart';

import '../../../core/constants/gamification_rules.dart';
import '../../../core/database/app_database.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/local_date.dart';
import '../../gamification/domain/reward_engine.dart';
import '../../goals/domain/goal_timeline.dart';
import '../domain/mission_rules.dart';

class MissionView {
  const MissionView({
    required this.def,
    required this.periodStart,
    required this.progress,
    required this.target,
    required this.claimed,
  });

  final MissionDef def;
  final String periodStart;
  final int progress;
  final int target;
  final bool claimed;

  bool get completed => progress >= target;
  bool get claimable => completed && !claimed;
}

enum ChestKind { daily, weekly }

class ChestView {
  const ChestView({
    required this.kind,
    required this.claims,
    required this.required,
    required this.opened,
    required this.coins,
  });

  final ChestKind kind;
  final int claims;
  final int required;
  final bool opened;
  final int coins;

  bool get available => !opened && claims >= required;
}

class MissionBoard {
  const MissionBoard({
    required this.today,
    required this.weekStart,
    required this.daily,
    required this.weekly,
    required this.dailyChest,
    required this.weeklyChest,
  });

  final String today;
  final String weekStart;
  final List<MissionView> daily;
  final List<MissionView> weekly;
  final ChestView dailyChest;
  final ChestView weeklyChest;
}

abstract interface class MissionsRepository {
  Stream<MissionBoard> watchBoard(String userId, String today);
  Future<RewardGrant?> claim(String userId, String missionId, DateTime now);
  Future<int> openChest(String userId, ChestKind kind, DateTime now);
}

class MissionsRepositoryImpl implements MissionsRepository {
  MissionsRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Stream<MissionBoard> watchBoard(String userId, String today) async* {
    yield await _board(userId, today);
    await for (final _ in _db.tableUpdates(TableUpdateQuery.onAllTables([
      _db.waterIntakes,
      _db.hydrationGoals,
      _db.userMissions,
      _db.rewardTransactions,
    ]))) {
      yield await _board(userId, today);
    }
  }

  Future<MissionBoard> _board(String userId, String today) async {
    final weekStart = LocalDate.weekStart(today);
    final hydration = _db.hydrationDao;
    final gamification = _db.gamificationDao;

    final defs = (await gamification.allMissions())
        .map((m) => MissionDef(
              id: m.id,
              title: m.title,
              description: m.description,
              period: m.period,
              metric: m.metric,
              target: m.target,
            ))
        .toList();
    final dailyDefs = defs.where((d) => d.isDaily).toList();
    final weeklyDefs = defs.where((d) => !d.isDaily).toList();

    // Métricas de cada día de la semana hasta hoy.
    final timeline = GoalTimeline((await hydration.allGoals(userId))
        .map((g) => GoalPeriod(id: g.id, start: g.startDate, end: g.endDate, dailyGoalMl: g.dailyGoalMl)));
    final intakes = await hydration.intakesBetween(userId, weekStart, today);
    final week = <DayMetrics>[];
    for (var d = weekStart; d.compareTo(today) <= 0; d = LocalDate.addDays(d, 1)) {
      week.add(DayMetrics.fromIntakes(
        d,
        intakes.where((i) => i.localDate == d).map((i) => (i.consumedAt.toLocal(), i.amountMl)),
        timeline.goalFor(d),
      ));
    }
    final todayMetrics = week.last;

    final claimed = {
      for (final u in await gamification.userMissionsSince(userId, weekStart))
        if (u.claimed) '${u.missionId}:${u.periodStart}',
    };

    final daily = [
      for (final m in dailyDefs)
        MissionView(
          def: m,
          periodStart: today,
          progress: MissionEvaluator.dailyProgress(m, todayMetrics),
          target: MissionEvaluator.targetOf(m),
          claimed: claimed.contains('${m.id}:$today'),
        ),
    ];
    final weekly = [
      for (final m in weeklyDefs)
        MissionView(
          def: m,
          periodStart: weekStart,
          progress: MissionEvaluator.weeklyProgress(m, week, dailyDefs),
          target: MissionEvaluator.targetOf(m),
          claimed: claimed.contains('${m.id}:$weekStart'),
        ),
    ];

    return MissionBoard(
      today: today,
      weekStart: weekStart,
      daily: daily,
      weekly: weekly,
      dailyChest: ChestView(
        kind: ChestKind.daily,
        claims: daily.where((m) => m.claimed).length,
        required: ChestRules.dailyRequiredClaims,
        opened: await gamification.hasReward(userId, RewardSource.chest, 'daily:$today'),
        coins: ChestRules.dailyCoins(today),
      ),
      weeklyChest: ChestView(
        kind: ChestKind.weekly,
        claims: weekly.where((m) => m.claimed).length,
        required: ChestRules.weeklyRequiredClaims(weekly.length),
        opened: await gamification.hasReward(userId, RewardSource.chest, 'weekly:$weekStart'),
        coins: ChestRules.weeklyCoins(weekStart),
      ),
    );
  }

  @override
  Future<RewardGrant?> claim(String userId, String missionId, DateTime now) {
    return _db.transaction(() async {
      final today = LocalDate.keyOf(now);
      final board = await _board(userId, today);
      final mission = [...board.daily, ...board.weekly].where((m) => m.def.id == missionId).firstOrNull;
      if (mission == null) throw const NotFoundFailure('La misión no existe.');
      if (mission.claimed) return null;
      if (!mission.completed) throw const ValidationFailure('Completa la misión para reclamarla.');

      await _db.gamificationDao.markMissionClaimed(userId, missionId, mission.periodStart, mission.progress);
      final applied = await _db.gamificationDao.applyGrants(
        userId,
        today,
        [RewardGrant.ofXp(mission.def.rewardSource, '$missionId:${mission.periodStart}', mission.def.xpReward)],
        now.toUtc(),
      );
      return applied.firstOrNull;
    });
  }

  @override
  Future<int> openChest(String userId, ChestKind kind, DateTime now) {
    return _db.transaction(() async {
      final today = LocalDate.keyOf(now);
      final board = await _board(userId, today);
      final chest = kind == ChestKind.daily ? board.dailyChest : board.weeklyChest;
      if (chest.opened) return 0;
      if (!chest.available) throw const ValidationFailure('Reclama más misiones para abrir este cofre.');
      final ref = kind == ChestKind.daily ? 'daily:$today' : 'weekly:${board.weekStart}';
      final applied = await _db.gamificationDao.applyGrants(
        userId,
        today,
        [RewardGrant(source: RewardSource.chest, referenceId: ref, xp: 0, coins: chest.coins)],
        now.toUtc(),
      );
      return applied.fold<int>(0, (s, g) => s + g.coins);
    });
  }
}
