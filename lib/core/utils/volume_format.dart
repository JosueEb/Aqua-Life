import 'package:intl/intl.dart';

enum UnitSystem {
  metric,
  imperial;

  static UnitSystem fromName(String? name) =>
      UnitSystem.values.firstWhere((u) => u.name == name, orElse: () => UnitSystem.metric);
}

/// Conversión y formato de volúmenes. La unidad canónica siempre es ml.
abstract final class VolumeFormat {
  static const double mlPerFlOz = 29.5735;

  static double toFlOz(int ml) => ml / mlPerFlOz;
  static int fromFlOz(double oz) => (oz * mlPerFlOz).round();

  static String format(int ml, UnitSystem unit, {String locale = 'es'}) {
    switch (unit) {
      case UnitSystem.metric:
        if (ml >= 1000) {
          final liters = NumberFormat('#,##0.##', locale).format(ml / 1000);
          return '$liters L';
        }
        return '$ml ml';
      case UnitSystem.imperial:
        return '${NumberFormat('#,##0.#', locale).format(toFlOz(ml))} oz';
    }
  }
}
