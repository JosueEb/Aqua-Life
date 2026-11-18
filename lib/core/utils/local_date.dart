/// Política temporal de AquaLife.
///
/// * `consumed_at` se guarda como instante (UTC).
/// * La **fecha local de agrupación** (`local_date`, formato `yyyy-MM-dd`) se
///   calcula con la zona horaria del dispositivo **en el momento del registro**
///   y se guarda junto al consumo. Así, viajar o cambiar de horario de verano
///   no mueve consumos ya registrados a otro día ni rompe rachas pasadas.
/// * Al editar la hora de un consumo, la fecha local se recalcula.
abstract final class LocalDate {
  static String keyOf(DateTime dateTime) {
    final d = dateTime.toLocal();
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }

  /// Convierte una clave `yyyy-MM-dd` en medianoche local de ese día.
  static DateTime parse(String key) {
    final parts = key.split('-');
    return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }

  /// Suma días de calendario (seguro ante cambios de horario de verano,
  /// porque opera sobre año/mes/día y no sobre horas).
  static String addDays(String key, int days) {
    final d = parse(key);
    return keyOf(DateTime(d.year, d.month, d.day + days));
  }

  /// Lunes de la semana de la fecha dada (inicio del periodo semanal).
  static String weekStart(String key) {
    final d = parse(key);
    return keyOf(DateTime(d.year, d.month, d.day - (d.weekday - DateTime.monday)));
  }
}
