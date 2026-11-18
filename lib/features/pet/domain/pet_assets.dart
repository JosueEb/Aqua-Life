import 'pet_evolution.dart';

/// Mapa central etapa/estado → recurso gráfico.
///
/// Por ahora cada etapa usa una ilustración SVG estática para todos los
/// estados. Cuando existan las animaciones Lottie se registran en
/// [_animations] y la interfaz las usará automáticamente.
abstract final class PetAssets {
  static String stageImage(PetStage stage) =>
      'assets/images/mascot/stage_${stage.number}/aqua_stage_${stage.number}.svg';

  static const Map<(PetStage, PetMood), String> _animations = {};

  static String? animation(PetStage stage, PetMood mood) => _animations[(stage, mood)];
}
