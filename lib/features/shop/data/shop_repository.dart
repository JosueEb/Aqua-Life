import 'package:drift/drift.dart';

import '../../../core/constants/gamification_rules.dart';
import '../../../core/database/app_database.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/local_date.dart';
import '../../pet/domain/pet_accessories.dart';

class ShopItemView {
  const ShopItemView({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.unlockLevel,
    required this.owned,
    required this.equipped,
  });

  final String id;
  final String name;
  final AccessoryCategory category;
  final int price;
  final int unlockLevel;
  final bool owned;
  final bool equipped;
}

class ShopState {
  const ShopState({required this.coins, required this.level, required this.items, required this.equipped});
  final int coins;
  final int level;
  final List<ShopItemView> items;
  final EquippedAccessories equipped;

  List<ShopItemView> get owned => items.where((i) => i.owned).toList();
}

abstract interface class ShopRepository {
  Stream<ShopState> watch(String userId);

  /// Compra un artículo cosmético con monedas (transacción atómica).
  Future<void> purchase(String userId, String itemId, DateTime now);

  /// Equipa (o quita, si [equip] es falso) un artículo del inventario.
  Future<void> setEquipped(String userId, String itemId, {required bool equip});
}

class ShopRepositoryImpl implements ShopRepository {
  ShopRepositoryImpl(this._db);
  final AppDatabase _db;

  static AccessoryCategory _category(String raw) => switch (raw) {
        'hat' => AccessoryCategory.hat,
        'glasses' => AccessoryCategory.glasses,
        'neck' => AccessoryCategory.neck,
        'background' => AccessoryCategory.background,
        _ => AccessoryCategory.effect,
      };

  @override
  Stream<ShopState> watch(String userId) async* {
    yield await _state(userId);
    await for (final _ in _db.tableUpdates(TableUpdateQuery.onAllTables([
      _db.shopItems,
      _db.inventoryItems,
      _db.pets,
      _db.gamificationProfiles,
    ]))) {
      yield await _state(userId);
    }
  }

  Future<ShopState> _state(String userId) async {
    final dao = _db.gamificationDao;
    final profile = await dao.getProfile(userId);
    final pet = await dao.getPet(userId);
    final equipped = EquippedAccessories.decode(pet.equippedAccessory);
    final owned = (await (_db.select(_db.inventoryItems)..where((i) => i.userId.equals(userId))).get())
        .map((i) => i.itemId)
        .toSet();
    final items = [
      for (final s in await dao.allShopItems())
        ShopItemView(
          id: s.id,
          name: s.name,
          category: _category(s.category),
          price: s.priceCoins,
          unlockLevel: s.unlockLevel,
          owned: owned.contains(s.id),
          equipped: equipped.isEquipped(s.id),
        ),
    ];
    return ShopState(coins: profile.coins, level: profile.level, items: items, equipped: equipped);
  }

  @override
  Future<void> purchase(String userId, String itemId, DateTime now) {
    return _db.transaction(() async {
      final dao = _db.gamificationDao;
      final item = await dao.findShopItem(itemId);
      if (item == null) throw const NotFoundFailure('Ese artículo no existe.');
      if (await dao.ownsItem(userId, itemId)) throw const ValidationFailure('Ya tienes este artículo.');
      final profile = await dao.getProfile(userId);
      if (profile.level < item.unlockLevel) {
        throw ValidationFailure('Se desbloquea en el nivel ${item.unlockLevel}.');
      }
      if (profile.coins < item.priceCoins) {
        throw ValidationFailure('Te faltan ${item.priceCoins - profile.coins} monedas.');
      }
      await dao.spendCoins(userId, item.priceCoins, RewardSource.shopPurchase, itemId, LocalDate.keyOf(now), now.toUtc());
      await dao.addToInventory(userId, itemId, now.toUtc());
    });
  }

  @override
  Future<void> setEquipped(String userId, String itemId, {required bool equip}) {
    return _db.transaction(() async {
      final dao = _db.gamificationDao;
      final item = await dao.findShopItem(itemId);
      if (item == null) throw const NotFoundFailure('Ese artículo no existe.');
      if (!await dao.ownsItem(userId, itemId)) throw const ValidationFailure('Primero compra este artículo.');
      final pet = await dao.getPet(userId);
      final current = EquippedAccessories.decode(pet.equippedAccessory);
      final category = _category(item.category);
      final next = equip ? current.equip(category, itemId) : current.unequip(category);
      await dao.setEquipped(userId, next.encode());
    });
  }
}
