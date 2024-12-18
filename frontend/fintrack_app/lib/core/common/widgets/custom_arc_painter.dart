import 'package:fintrack_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

final class CustomArcPainter extends CustomPainter {
  final double start;
  final double end;
  final double width;
  final double blurWidth;

  const CustomArcPainter({
    this.start = 0,
    this.end = 270,
    this.width = 15,
    this.blurWidth = 6,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);

    final gradientColor = LinearGradient(
      colors: [AppPalette.secondary, AppPalette.secondary],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final activePaint = Paint()..shader = gradientColor.createShader(rect);

    activePaint.style = PaintingStyle.stroke;
    activePaint.strokeWidth = width;
    activePaint.strokeCap = StrokeCap.round;

    Paint backgroundPaint = Paint();
    backgroundPaint.color = AppPalette.gray60.withOpacity(0.5);
    backgroundPaint.style = PaintingStyle.stroke;
    backgroundPaint.strokeWidth = width;
    backgroundPaint.strokeCap = StrokeCap.round;

    Paint shadowPaint = Paint()
      ..color = AppPalette.secondary.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width + blurWidth
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    final startVal = 135.0 + start;

    canvas.drawArc(
      rect,
      radians(startVal),
      radians(end),
      false,
      backgroundPaint,
    );

    // Draw shadow arc
    final path = Path();

    path.addArc(rect, radians(startVal), radians(end));
    canvas.drawPath(path, shadowPaint);

    canvas.drawArc(rect, radians(startVal), radians(end), false, activePaint);
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
