import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

final class ArcValueModel {
  final Color color;
  final double value;

  const ArcValueModel({
    required this.color,
    required this.value,
  });
}

final class CustomArc180Painter extends CustomPainter {
  final double start;
  final double end;
  final double width;
  final double bgWidth;
  final double blurWidth;
  final double space;
  final List<ArcValueModel> drawArcs;

  const CustomArc180Painter({
    super.repaint,
    this.start = 0,
    this.end = 180,
    this.width = 15,
    this.bgWidth = 10,
    this.blurWidth = 4,
    this.space = 5,
    required this.drawArcs,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.width / 2,
    );

    final backgroundPaint = Paint();
    backgroundPaint.color = AppPalette.gray60.withOpacity(0.5);
    backgroundPaint.style = PaintingStyle.stroke;
    backgroundPaint.strokeWidth = bgWidth;
    backgroundPaint.strokeCap = StrokeCap.round;

    final startVal = 180.0 + start;
    var drawStart = startVal;

    canvas.drawArc(
      rect,
      radians(startVal),
      radians(180),
      false,
      backgroundPaint,
    );

    for (final arc in drawArcs) {
      final activePaint = Paint();
      activePaint.color = arc.color;
      activePaint.style = PaintingStyle.stroke;
      activePaint.strokeWidth = width;
      activePaint.strokeCap = StrokeCap.round;

      final shadowPaint = Paint()
        ..color = arc.color.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = width + blurWidth
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

      // Draw the shadowing arc
      final path = Path();
      path.addArc(rect, radians(drawStart), radians(arc.value - space));
      canvas.drawPath(path, shadowPaint);

      canvas.drawArc(
        rect,
        radians(drawStart),
        radians(arc.value - space),
        false,
        activePaint,
      );

      drawStart = drawStart + arc.value + space;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    return false;
  }
}
