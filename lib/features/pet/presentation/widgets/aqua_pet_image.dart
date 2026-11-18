import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

import '../../domain/pet_assets.dart';
import '../../domain/pet_evolution.dart';

class AquaPetImage extends StatelessWidget {
  const AquaPetImage({super.key, required this.stage, this.size = 120, this.locked = false});

  final PetStage stage;
  final double size;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    Widget image = SvgPicture.asset(
      PetAssets.stageImage(stage),
      width: size,
      height: size,
      semanticsLabel: 'Aqua, ${stage.displayName}',
    );
    if (locked) {
      image = Opacity(
        opacity: 0.35,
        child: ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.33, 0.33, 0.33, 0, 0, //
            0.33, 0.33, 0.33, 0, 0, //
            0.33, 0.33, 0.33, 0, 0, //
            0, 0, 0, 1, 0,
          ]),
          child: image,
        ),
      );
    }
    return image;
  }
}
