import 'package:aqua_life/core/database/app_database.dart';
import 'package:aqua_life/core/errors/failures.dart';
import 'package:aqua_life/core/utils/volume_format.dart';
import 'package:aqua_life/features/backup/data/backup_service.dart';
import 'package:aqua_life/features/hydration/data/repositories/hydration_repository_impl.dart';
import 'package:aqua_life/features/missions/data/missions_repository.dart';
import 'package:aqua_life/features/pet/domain/pet_accessories.dart';
import 'package:aqua_life/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:aqua_life/features/profile/domain/entities/user_profile.dart';
import 'package:aqua_life/features/shop/data/shop_repository.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase db;
  late HydrationRepositoryImpl hydration;
  late String userId;
  late DateTime now;

  setUp(() async {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    now = DateTime(2026, 11, 17, 9);
    db = AppDatabase(NativeDatabase.memory());
    hydration = HydrationRepositoryImpl(db, const Uuid(), () => now);
    userId = await ProfileRepositoryImpl(db, const Uuid()).completeOnboarding(
      const OnboardingData(isGuest: true, dailyGoalMl: 1000, unitSystem: UnitSystem.metric),
      now,
    );
  });

  tearDown(() => db.close());

  Future<void> setCoins(int coins) =>
      (db.update(db.gamificationProfiles)..where((p) => p.userId.equals(userId)))
          .write(GamificationProfilesCompanion(coins: Value(coins)));

  group('Tienda', () {
    test('comprar descuenta monedas, registra el ledger y permite equipar', () async {
      final shop = ShopRepositoryImpl(db);
      await setCoins(100);
      await shop.purchase(userId, 'hat_cap', now);

      final state = await shop.watch(userId).first;
      expect(state.coins, 70);
      expect(state.items.firstWhere((i) => i.id == 'hat_cap').owned, isTrue);
      final spend = await (db.select(db.rewardTransactions)..where((r) => r.source.equals('shop_purchase'))).getSingle();
      expect(spend.amount, -30);

      await shop.setEquipped(userId, 'hat_cap', equip: true);
      final pet = await db.select(db.pets).getSingle();
      expect(EquippedAccessories.decode(pet.equippedAccessory)[AccessoryCategory.hat], 'hat_cap');
    });

    test('valida saldo, nivel y duplicados', () async {
      final shop = ShopRepositoryImpl(db);
      await setCoins(10);
      expect(() => shop.purchase(userId, 'hat_cap', now), throwsA(isA<ValidationFailure>()));
      await setCoins(500);
      expect(() => shop.purchase(userId, 'fx_bubbles', now), throwsA(isA<ValidationFailure>())); // nivel 5
      await shop.purchase(userId, 'neck_bow', now);
      expect(() => shop.purchase(userId, 'neck_bow', now), throwsA(isA<ValidationFailure>()));
      expect(() => shop.setEquipped(userId, 'hat_party', equip: true), throwsA(isA<ValidationFailure>()));
    });
  });

  group('Misiones y cofres', () {
    test('reclamar otorga XP una sola vez y el cofre diario requiere 3', () async {
      final missions = MissionsRepositoryImpl(db);
      // 9:00 (antes de las 10), 13:00 y 19:00 → 3 registros, 3 franjas, 90 % de 1000 ml.
      await hydration.addIntake(userId, 300, DateTime(2026, 11, 17, 9));
      await hydration.addIntake(userId, 300, DateTime(2026, 11, 17, 13));
      now = DateTime(2026, 11, 17, 20);
      await hydration.addIntake(userId, 300, DateTime(2026, 11, 17, 19));

      final board = await missions.watchBoard(userId, '2026-11-17').first;
      final claimable = board.daily.where((m) => m.claimable).map((m) => m.def.id).toSet();
      expect(claimable, containsAll(['d_morning', 'd_three_logs', 'd_half_goal', 'd_spread']));
      expect(board.daily.firstWhere((m) => m.def.id == 'd_goal').completed, isFalse);

      expect(() => missions.openChest(userId, ChestKind.daily, now), throwsA(isA<ValidationFailure>()));

      final g = await missions.claim(userId, 'd_morning', now);
      expect(g?.xp, 15);
      expect(await missions.claim(userId, 'd_morning', now), isNull); // idempotente
      expect(() => missions.claim(userId, 'd_goal', now), throwsA(isA<ValidationFailure>()));
      await missions.claim(userId, 'd_three_logs', now);
      await missions.claim(userId, 'd_spread', now);

      final coins = await missions.openChest(userId, ChestKind.daily, now);
      expect(coins, inInclusiveRange(10, 25));
      expect(await missions.openChest(userId, ChestKind.daily, now), 0);

      final after = await missions.watchBoard(userId, '2026-11-17').first;
      expect(after.dailyChest.opened, isTrue);
      expect(after.daily.where((m) => m.claimed), hasLength(3));
    });
  });

  group('Respaldo JSON', () {
    test('exportar e importar conserva datos y progreso', () async {
      await hydration.addIntake(userId, 1000, now);
      await setCoins(80);
      await ShopRepositoryImpl(db).purchase(userId, 'hat_cap', now);
      final json = await BackupService(db).exportJson(quickAmounts: [200, 400], now: now);

      final other = AppDatabase(NativeDatabase.memory());
      addTearDown(other.close);
      // El dispositivo nuevo ya tenía un perfil propio, que se reemplaza.
      await ProfileRepositoryImpl(other, const Uuid()).completeOnboarding(
        const OnboardingData(isGuest: true, dailyGoalMl: 3000, unitSystem: UnitSystem.metric),
        now,
      );
      final result = await BackupService(other).importJson(json);

      expect(result.userId, userId);
      expect(result.quickAmounts, [200, 400]);
      expect(await other.select(other.users).get(), hasLength(1));
      expect(await other.select(other.waterIntakes).get(), hasLength(1));
      final profile = await other.select(other.gamificationProfiles).getSingle();
      final original = await db.select(db.gamificationProfiles).getSingle();
      expect(profile.totalXp, original.totalXp);
      expect(profile.coins, original.coins);
      expect(await other.select(other.inventoryItems).get(), hasLength(1));
    });

    test('rechaza archivos inválidos sin tocar los datos', () async {
      await hydration.addIntake(userId, 500, now);
      final svc = BackupService(db);
      expect(() => svc.importJson('no es json'), throwsA(isA<ValidationFailure>()));
      expect(() => svc.importJson('{"format":"otra-app"}'), throwsA(isA<ValidationFailure>()));
      expect(
        () => svc.importJson('{"format":"aqualife-backup","version":1,"schemaVersion":1,'
            '"users":[{"id":"x"}]}'),
        throwsA(isA<ValidationFailure>()),
      );
      expect(await db.select(db.waterIntakes).get(), hasLength(1));
    });
  });
}
