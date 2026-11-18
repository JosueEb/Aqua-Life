import 'package:aqua_life/features/missions/domain/mission_rules.dart';
import 'package:aqua_life/features/pet/domain/pet_accessories.dart';
import 'package:aqua_life/features/pet/domain/pet_evolution.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EquippedAccessories', () {
    test('uno por categoría y codificación estable', () {
      var e = EquippedAccessories.decode(null);
      expect(e.byCategory, isEmpty);
      expect(e.encode(), isNull);
      e = e.equip(AccessoryCategory.hat, 'hat_cap').equip(AccessoryCategory.glasses, 'glasses_sun');
      e = e.equip(AccessoryCategory.hat, 'hat_party'); // reemplaza el sombrero
      expect(e.encode(), 'glasses:glasses_sun,hat:hat_party');
      final round = EquippedAccessories.decode(e.encode());
      expect(round[AccessoryCategory.hat], 'hat_party');
      expect(round.isEquipped('glasses_sun'), isTrue);
      expect(round.unequip(AccessoryCategory.hat).encode(), 'glasses:glasses_sun');
    });
  });

  group('PetMoodResolver', () {
    test('duerme de noche, feliz con la meta, tranquila si no', () {
      expect(PetMoodResolver.resting(now: DateTime(2026, 11, 17, 23), goalCompleted: true), PetMood.sleeping);
      expect(PetMoodResolver.resting(now: DateTime(2026, 11, 17, 6), goalCompleted: false), PetMood.sleeping);
      expect(PetMoodResolver.resting(now: DateTime(2026, 11, 17, 15), goalCompleted: true), PetMood.happy);
      expect(PetMoodResolver.resting(now: DateTime(2026, 11, 17, 15), goalCompleted: false), PetMood.idle);
    });
  });

  group('MissionEvaluator', () {
    MissionDef daily(String metric, int target) =>
        MissionDef(id: metric, title: '', description: '', period: 'daily', metric: metric, target: target);
    MissionDef weekly(String metric, int target) =>
        MissionDef(id: 'w_$metric', title: '', description: '', period: 'weekly', metric: metric, target: target);

    final today = DayMetrics.fromIntakes(
      '2026-11-17',
      [(DateTime(2026, 11, 17, 9), 300), (DateTime(2026, 11, 17, 13), 300), (DateTime(2026, 11, 17, 19), 500)],
      2000,
    );

    test('métricas del día', () {
      expect(today.intakeCount, 3);
      expect(today.earliestHour, 9);
      expect(today.dayParts, 3);
      expect(today.percent, 55);
    });

    test('progreso diario acotado a la meta', () {
      expect(MissionEvaluator.dailyProgress(daily('intake_before_hour', 10), today), 1);
      expect(MissionEvaluator.dailyProgress(daily('intake_before_hour', 8), today), 0);
      expect(MissionEvaluator.dailyProgress(daily('intake_count', 2), today), 2);
      expect(MissionEvaluator.dailyProgress(daily('goal_percent', 50), today), 50);
      expect(MissionEvaluator.dailyProgress(daily('goal_percent', 100), today), 55);
      expect(MissionEvaluator.dailyProgress(daily('day_parts', 3), today), 3);
    });

    test('progreso semanal', () {
      final done = DayMetrics.fromIntakes('2026-11-16', [(DateTime(2026, 11, 16, 9), 2000)], 2000);
      final week = [done, today];
      final dailies = [daily('intake_count', 3), daily('goal_percent', 100)];
      expect(MissionEvaluator.weeklyProgress(weekly('goals_completed', 5), week, dailies), 1);
      expect(MissionEvaluator.weeklyProgress(weekly('intake_count', 20), week, dailies), 4);
      // 16: meta (1). 17: tres registros (1).
      expect(MissionEvaluator.weeklyProgress(weekly('daily_missions', 10), week, dailies), 2);
    });
  });

  group('ChestRules', () {
    test('monedas deterministas y en rango', () {
      expect(ChestRules.dailyCoins('2026-11-17'), ChestRules.dailyCoins('2026-11-17'));
      for (var d = 1; d <= 28; d++) {
        final key = '2026-02-${d.toString().padLeft(2, '0')}';
        expect(ChestRules.dailyCoins(key), inInclusiveRange(10, 25));
        expect(ChestRules.weeklyCoins(key), inInclusiveRange(50, 100));
      }
    });
  });
}
