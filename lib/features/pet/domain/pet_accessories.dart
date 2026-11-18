/// Categorías de accesorio. Aqua puede llevar uno de cada categoría.
enum AccessoryCategory {
  hat('hat', 'Sombreros'),
  glasses('glasses', 'Gafas'),
  neck('neck', 'Cuello'),
  background('background', 'Fondos'),
  effect('effect', 'Efectos');

  const AccessoryCategory(this.key, this.displayName);
  final String key;
  final String displayName;

  static AccessoryCategory fromKey(String key) =>
      values.firstWhere((c) => c.key == key, orElse: () => AccessoryCategory.effect);

  /// Los fondos se dibujan detrás de Aqua; el resto, delante.
  bool get isBehind => this == AccessoryCategory.background;
}

/// Accesorios equipados, guardados en `pets.equipped_accessory` como
/// "categoria:id,categoria:id" (un accesorio por categoría).
class EquippedAccessories {
  const EquippedAccessories(this.byCategory);
  static const none = EquippedAccessories({});

  final Map<AccessoryCategory, String> byCategory;

  static EquippedAccessories decode(String? raw) {
    if (raw == null || raw.trim().isEmpty) return none;
    final map = <AccessoryCategory, String>{};
    for (final part in raw.split(',')) {
      final kv = part.split(':');
      if (kv.length == 2 && kv[1].isNotEmpty) map[AccessoryCategory.fromKey(kv[0])] = kv[1];
    }
    return EquippedAccessories(map);
  }

  String? encode() => byCategory.isEmpty
      ? null
      : (byCategory.entries.map((e) => '${e.key.key}:${e.value}').toList()..sort()).join(',');

  EquippedAccessories equip(AccessoryCategory c, String itemId) =>
      EquippedAccessories({...byCategory, c: itemId});

  EquippedAccessories unequip(AccessoryCategory c) => EquippedAccessories({...byCategory}..remove(c));

  bool isEquipped(String itemId) => byCategory.containsValue(itemId);

  String? operator [](AccessoryCategory c) => byCategory[c];
}
