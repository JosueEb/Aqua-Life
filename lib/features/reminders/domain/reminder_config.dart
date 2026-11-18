import '../../../core/utils/local_date.dart';

class ReminderConfig {
  const ReminderConfig({
    required this.enabled,
    required this.startMinutes,
    required this.endMinutes,
    required this.intervalMinutes,
    required this.weekdays,
    required this.snoozeMinutes,
  });

  final bool enabled;

  /// Minutos desde medianoche (hora local).
  final int startMinutes;
  final int endMinutes;
  final int intervalMinutes;

  /// Días ISO: 1 = lunes … 7 = domingo.
  final Set<int> weekdays;
  final int snoozeMinutes;

  ReminderConfig copyWith({
    bool? enabled,
    int? startMinutes,
    int? endMinutes,
    int? intervalMinutes,
    Set<int>? weekdays,
    int? snoozeMinutes,
  }) =>
      ReminderConfig(
        enabled: enabled ?? this.enabled,
        startMinutes: startMinutes ?? this.startMinutes,
        endMinutes: endMinutes ?? this.endMinutes,
        intervalMinutes: intervalMinutes ?? this.intervalMinutes,
        weekdays: weekdays ?? this.weekdays,
        snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
      );

  String? validate() {
    if (endMinutes <= startMinutes) return 'La hora de fin debe ser posterior a la de inicio.';
    if (weekdays.isEmpty) return 'Elige al menos un día.';
    if (intervalMinutes < 15) return 'El intervalo mínimo es de 15 minutos.';
    return null;
  }

  static String encodeWeekdays(Set<int> days) => (days.toList()..sort()).join(',');
  static Set<int> decodeWeekdays(String raw) =>
      raw.split(',').map(int.tryParse).whereType<int>().where((d) => d >= 1 && d <= 7).toSet();
}

/// Calcula las próximas horas de recordatorio.
///
/// En lugar de notificaciones periódicas del sistema se programan instantes
/// concretos (hasta [maxCount]) y se reprograman al abrir la app o al cambiar
/// la configuración. Así se respeta el horario de verano (las horas se
/// calculan en hora local de Dart) y el límite de 64 notificaciones de iOS.
abstract final class ReminderScheduler {
  static const int maxCount = 48;
  static const int daysAhead = 14;

  static List<DateTime> upcoming(ReminderConfig c, DateTime now, {String? skipDate, int max = maxCount}) {
    if (!c.enabled || c.validate() != null) return const [];
    final result = <DateTime>[];
    for (var i = 0; i < daysAhead && result.length < max; i++) {
      final day = DateTime(now.year, now.month, now.day + i);
      if (!c.weekdays.contains(day.weekday) || LocalDate.keyOf(day) == skipDate) continue;
      for (var m = c.startMinutes; m <= c.endMinutes && result.length < max; m += c.intervalMinutes) {
        final at = DateTime(day.year, day.month, day.day, m ~/ 60, m % 60);
        if (at.isAfter(now)) result.add(at);
      }
    }
    return result;
  }
}
