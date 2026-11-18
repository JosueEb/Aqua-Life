import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';

class ProgressRing extends StatelessWidget {
  const ProgressRing({super.key, required this.progress, required this.child, this.size = 180, this.stroke = 16});

  final double progress;
  final Widget child;
  final double size;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: progress.clamp(0, 1)),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) => SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _RingPainter(value, stroke, completed: progress >= 1),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.value, this.stroke, {required this.completed});
  final double value;
  final double stroke;
  final bool completed;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final arcRect = rect.deflate(stroke / 2);
    final bg = Paint()
      ..color = AppColors.primaryLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawArc(arcRect, 0, 2 * math.pi, false, bg);
    if (value <= 0) return;
    final fg = Paint()
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: completed
            ? const [AppColors.success, AppColors.success]
            : const [Color(0xFF7FD0F2), AppColors.primary, AppColors.primaryDark],
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;
    canvas.drawArc(arcRect, -math.pi / 2, 2 * math.pi * value, false, fg);
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.value != value || old.completed != completed;
}
