import 'pet_evolution.dart';

/// Mapa central etapa/estado → recurso gráfico.
///
/// Cada etapa usa una ilustración SVG; los estados de ánimo se animan en
/// código (`AnimatedAqua`). Si en el futuro se añaden animaciones Lottie,
/// se registran en [_animations] y la interfaz las usará automáticamente.
abstract final class PetAssets {
  /// Etapas que traen un tocado propio (sombrero/corona).
  static const _stagesWithHeadwear = {PetStage.adventurer, PetStage.magic, PetStage.guardian};

  /// [bare] devuelve la variante sin tocado, para lucir un sombrero equipado.
  static String stageImage(PetStage stage, {bool bare = false}) {
    final suffix = bare && _stagesWithHeadwear.contains(stage) ? '_bare' : '';
    return 'assets/images/mascot/stage_${stage.number}/aqua_stage_${stage.number}$suffix.svg';
  }

  static String accessory(String itemId) => 'assets/images/accessories/$itemId.svg';

  static const Map<(PetStage, PetMood), String> _animations = {};

  static String? animation(PetStage stage, PetMood mood) => _animations[(stage, mood)];
}
