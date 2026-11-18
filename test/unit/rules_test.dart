import 'package:aqua_life/core/constants/gamification_rules.dart';
import 'package:aqua_life/core/utils/local_date.dart';
import 'package:aqua_life/core/utils/volume_format.dart';
import 'package:aqua_life/features/gamification/domain/reward_engine.dart';
import 'package:aqua_life/features/pet/domain/pet_evolution.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Niveles y monedas', () {
    test('nivel = 1 + XP / 100', () {
      expect(GamificationRules.levelForXp(0), 1);
      expect(GamificationRules.levelForXp(99), 1);
      expect(GamificationRules.levelForXp(100), 2);
      expect(GamificationRules.levelForXp(1050), 11);
    });

    test('1 moneda por cada 10 XP', () {
      expect(GamificationRules.coinsForXp(5), 0);
      expect(GamificationRules.coinsForXp(15), 1);
      expect(GamificationRules.coinsForXp(50), 5);
      expect(GamificationRules.coinsForXp(100), 10);
    });

    test('validación de cantidad 1–2000 ml', () {
      expect(GamificationRules.isValidIntakeAmount(0), isFalse);
      expect(GamificationRules.isValidIntakeAmount(1), isTrue);
      expect(GamificationRules.isValidIntakeAmount(2000), isTrue);
      expect(GamificationRules.isValidIntakeAmount(2001), isFalse);
    });
  });

  group('Evolución de Aqua', () {
    test('umbrales de etapa', () {
      expect(PetEvolution.stageForXp(0), PetStage.baby);
      expect(PetEvolution.stageForXp(99), PetStage.baby);
      expect(PetEvolution.stageForXp(100), PetStage.happy);
      expect(PetEvolution.stageForXp(300), PetStage.adventurer);
      expect(PetEvolution.stageForXp(600), PetStage.magic);
      expect(PetEvolution.stageForXp(1000), PetStage.guardian);
      expect(PetEvolution.stageForXp(99999), PetStage.guardian);
    });

    test('nunca retrocede', () {
      expect(PetEvolution.nonRegressing(PetStage.magic, 0), PetStage.magic);
      expect(PetEvolution.nonRegressing(PetStage.baby, 350), PetStage.adventurer);
    });

    test('progreso hacia la siguiente etapa', () {
      expect(PetEvolution.progressToNext(200), closeTo(0.5, 1e-9));
      expect(PetEvolution.progressToNext(1500), 1);
    });
  });

  group('RewardEngine', () {
    DayRewardSnapshot day({int rewarded = 0, int total = 0, int goal = 2000}) =>
        DayRewardSnapshot(localDate: '2026-11-17', rewardedIntakesToday: rewarded, totalMl: total, goalMl: goal);

    test('registro válido da 5 XP', () {
      final g = RewardEngine.forNewIntake(intakeId: 'a', amountMl: 250, day: day(total: 250));
      expect(g, [RewardGrant.ofXp(RewardSource.intake, 'a', 5)]);
    });

    test('límite de 10 registros premiados por día', () {
      final g = RewardEngine.forNewIntake(intakeId: 'k', amountMl: 250, day: day(rewarded: 10, total: 500));
      expect(g, isEmpty);
    });

    test('alcanzar la meta añade 50 XP y 5 monedas', () {
      final g = RewardEngine.forNewIntake(intakeId: 'z', amountMl: 500, day: day(rewarded: 3, total: 2000));
      expect(g.map((e) => e.source), [RewardSource.intake, RewardSource.dailyGoal]);
      final goal = g.last;
      expect(goal.xp, 50);
      expect(goal.coins, 5);
      expect(goal.referenceId, '2026-11-17');
    });

    test('cantidad inválida no da XP', () {
      expect(RewardEngine.forNewIntake(intakeId: 'x', amountMl: 5000, day: day()), isEmpty);
    });
  });

  group('LocalDate', () {
    test('suma de días cruza meses y años', () {
      expect(LocalDate.addDays('2026-12-31', 1), '2027-01-01');
      expect(LocalDate.addDays('2026-03-01', -1), '2026-02-28');
    });

    test('inicio de semana es lunes', () {
      expect(LocalDate.weekStart('2026-11-17'), '2026-11-16'); // martes → lunes
      expect(LocalDate.weekStart('2026-11-22'), '2026-11-16'); // domingo → lunes
    });
  });

  group('VolumeFormat', () {
    test('formato métrico e imperial', () {
      expect(VolumeFormat.format(250, UnitSystem.metric), '250 ml');
      expect(VolumeFormat.format(1500, UnitSystem.metric), '1,5 L');
      expect(VolumeFormat.format(296, UnitSystem.imperial), '10 oz');
    });
  });
}
