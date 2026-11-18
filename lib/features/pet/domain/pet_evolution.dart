/// Lógica de evolución de Aqua (servicio de dominio, sección 5 y 6).
///
/// La etapa se recalcula siempre desde la XP acumulada. Como la XP nunca se
/// descuenta, la evolución es permanente y no retrocede por inactividad.
enum PetStage {
  baby(1, 'Gotita bebé', 0),
  happy(2, 'Gotita feliz', 100),
  adventurer(3, 'Gotita aventurera', 300),
  magic(4, 'Gotita mágica', 600),
  guardian(5, 'Guardiana del agua', 1000);

  const PetStage(this.number, this.displayName, this.minXp);
  final int number;
  final String displayName;
  final int minXp;

  static PetStage fromNumber(int n) => values.firstWhere((s) => s.number == n, orElse: () => baby);

  PetStage? get next => number < values.length ? values[number] : null;
}

enum PetMood { idle, happy, drinking, celebrating, levelUp, sleeping }

abstract final class PetEvolution {
  static PetStage stageForXp(int totalXp) {
    var result = PetStage.baby;
    for (final stage in PetStage.values) {
      if (totalXp >= stage.minXp) result = stage;
    }
    return result;
  }

  /// Progreso 0..1 hacia la siguiente etapa (1 en la etapa final).
  static double progressToNext(int totalXp) {
    final stage = stageForXp(totalXp);
    final next = stage.next;
    if (next == null) return 1;
    return (totalXp - stage.minXp) / (next.minXp - stage.minXp);
  }

  /// Nunca devuelve una etapa menor a la ya alcanzada.
  static PetStage nonRegressing(PetStage current, int totalXp) {
    final computed = stageForXp(totalXp);
    return computed.number >= current.number ? computed : current;
  }
}
