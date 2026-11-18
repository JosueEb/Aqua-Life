import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/pet_accessories.dart';
import '../../domain/pet_assets.dart';
import '../../domain/pet_evolution.dart';

/// Aqua con sus accesorios y una animación según el estado de ánimo.
///
/// Las animaciones se hacen en código (flotar, saltar, aplastarse al beber,
/// respirar dormida) para no depender de archivos Lottie.
class AnimatedAqua extends StatefulWidget {
  const AnimatedAqua({
    super.key,
    required this.stage,
    this.equipped = EquippedAccessories.none,
    this.mood = PetMood.idle,
    this.size = 160,
    this.animate = true,
  });

  final PetStage stage;
  final EquippedAccessories equipped;
  final PetMood mood;
  final double size;
  final bool animate;

  @override
  State<AnimatedAqua> createState() => _AnimatedAquaState();
}

class _AnimatedAquaState extends State<AnimatedAqua> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: _durationFor(widget.mood));

  static Duration _durationFor(PetMood mood) => switch (mood) {
        PetMood.sleeping => const Duration(milliseconds: 3600),
        PetMood.idle => const Duration(milliseconds: 2800),
        PetMood.happy => const Duration(milliseconds: 1400),
        PetMood.drinking => const Duration(milliseconds: 700),
        PetMood.celebrating || PetMood.levelUp => const Duration(milliseconds: 900),
      };

  /// Respeta la preferencia del sistema de reducir animaciones.
  bool get _shouldAnimate => widget.animate && !MediaQuery.disableAnimationsOf(context);

  void _sync() {
    if (_shouldAnimate) {
      if (!_c.isAnimating) _c.repeat();
    } else {
      _c.stop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(AnimatedAqua old) {
    super.didUpdateWidget(old);
    if (old.mood != widget.mood) {
      _c.duration = _durationFor(widget.mood);
      _c.stop();
    }
    _sync();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final hatOn = widget.equipped[AccessoryCategory.hat] != null;
    final bg = widget.equipped[AccessoryCategory.background];
    // La bebé se dibuja al 86 % desde la base: los accesorios siguen esa escala.
    final accessoryScale = widget.stage == PetStage.baby ? 0.86 : 1.0;
    const accessoryAlign = Alignment(0, 0.86);

    Widget layer(String asset) => SvgPicture.asset(asset, width: size, height: size);

    final front = [
      for (final c in [AccessoryCategory.neck, AccessoryCategory.glasses, AccessoryCategory.hat])
        if (widget.equipped[c] != null)
          Transform.scale(scale: accessoryScale, alignment: accessoryAlign, child: layer(PetAssets.accessory(widget.equipped[c]!))),
    ];

    final pet = Stack(children: [
      layer(PetAssets.stageImage(widget.stage, bare: hatOn)),
      ...front,
    ]);

    return Semantics(
      label: 'Aqua, ${widget.stage.displayName}, ${widget.mood.displayName}',
      image: true,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (bg != null) Positioned.fill(child: layer(PetAssets.accessory(bg))),
            AnimatedBuilder(
              animation: _c,
              builder: (context, child) => _transform(_c.value, child!),
              child: pet,
            ),
            if (widget.equipped[AccessoryCategory.effect] != null)
              AnimatedBuilder(
                animation: _c,
                builder: (context, child) => Transform.translate(
                  offset: Offset(0, -size * 0.03 * math.sin(_c.value * 2 * math.pi)),
                  child: child,
                ),
                child: layer(PetAssets.accessory(widget.equipped[AccessoryCategory.effect]!)),
              ),
            if (widget.mood == PetMood.sleeping) _Zzz(controller: _c, size: size),
            if (widget.mood == PetMood.celebrating || widget.mood == PetMood.levelUp)
              _Sparkles(controller: _c, size: size),
          ],
        ),
      ),
    );
  }

  Widget _transform(double t, Widget child) {
    final wave = math.sin(t * 2 * math.pi);
    final size = widget.size;
    switch (widget.mood) {
      case PetMood.idle:
        return Transform.translate(offset: Offset(0, -size * 0.025 * wave), child: child);
      case PetMood.sleeping:
        return Transform.scale(
          scaleY: 1 + 0.025 * wave,
          scaleX: 1 - 0.015 * wave,
          alignment: Alignment.bottomCenter,
          child: Opacity(opacity: 0.85, child: child),
        );
      case PetMood.happy:
        return Transform.translate(
          offset: Offset(0, -size * 0.06 * wave.abs()),
          child: Transform.rotate(angle: 0.05 * wave, child: child),
        );
      case PetMood.drinking:
        return Transform.scale(
          scaleY: 1 - 0.06 * wave.abs(),
          scaleX: 1 + 0.05 * wave.abs(),
          alignment: Alignment.bottomCenter,
          child: child,
        );
      case PetMood.celebrating:
      case PetMood.levelUp:
        return Transform.translate(
          offset: Offset(0, -size * 0.12 * wave.abs()),
          child: Transform.scale(scale: 1 + 0.04 * wave.abs(), child: child),
        );
    }
  }
}

class _Zzz extends StatelessWidget {
  const _Zzz({required this.controller, required this.size});
  final Animation<double> controller;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value;
        return Positioned(
          right: size * 0.08,
          top: size * (0.18 - 0.1 * t),
          child: Opacity(
            opacity: 1 - t,
            child: Text('z Z', style: TextStyle(fontSize: size * 0.12, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
          ),
        );
      },
    );
  }
}

class _Sparkles extends StatelessWidget {
  const _Sparkles({required this.controller, required this.size});
  final Animation<double> controller;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value;
        return Stack(children: [
          for (var i = 0; i < 6; i++)
            Positioned(
              left: size / 2 + math.cos(i * math.pi / 3) * size * (0.3 + 0.15 * t) - 10,
              top: size / 2 + math.sin(i * math.pi / 3) * size * (0.3 + 0.15 * t) - 10,
              child: Opacity(
                opacity: 1 - t,
                child: Icon(Icons.auto_awesome, size: 20, color: i.isEven ? AppColors.reward : AppColors.primary),
              ),
            ),
        ]);
      },
    );
  }
}
