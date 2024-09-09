import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgressPainter extends CustomPainter {
  final double progress; // Progress (between 0.0 and 1.0)
  final double strokeWidth; // Stroke width
  final Color backgroundColor; // Background color
  final Color progressColor; // Progress color
  final Color outerCircleColor; // Outer circle color
  final Color outerCircleProgressColor; // Outer circle progress color

  CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
    required this.outerCircleColor,
    required this.outerCircleProgressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final Paint outerCirclePaint = Paint()
      ..color = outerCircleColor.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 20; // Outer circle width

    final Paint outerCircleProgressPaint = Paint()
      ..color = outerCircleProgressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 20
      ..strokeCap = StrokeCap.butt;

    final Paint dotPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill;

    final Paint innerDotBorderPaint = Paint()
      ..color = Color(0xFFFE6E68) // Border color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0; // Border width

    final Paint innerDotFillPaint = Paint()
      ..color = Colors.white // Fill color
      ..style = PaintingStyle.fill;

    final double radius = min(size.width / 2, size.height / 2) -
        strokeWidth / 2; // Inner circle radius
    final Offset center = Offset(size.width / 2, size.height / 2); // Center
    final double outerRadius =
        radius + (strokeWidth + 20) / 2; // Outer circle radius
    final double arcAngle = 2 * pi * progress; // Progress arc angle

    canvas.drawCircle(center, outerRadius, outerCirclePaint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerRadius),
      -pi / 2,
      2 * pi * progress,
      false,
      outerCircleProgressPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      progressPaint,
    );

    const double dotRadius = 10.0; // Dot radius
    final double dotAngle = -pi / 2 + arcAngle; // Dot angle position
    final double dotX =
        center.dx + (radius * cos(dotAngle)); // Dot X coordinate
    final double dotY =
        center.dy + (radius * sin(dotAngle)); // Dot Y coordinate

    // Draw the inner dot with a border
    canvas.drawCircle(Offset(dotX, dotY), dotRadius, innerDotBorderPaint);
    canvas.drawCircle(Offset(dotX, dotY),
        dotRadius - innerDotBorderPaint.strokeWidth / 2, innerDotFillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this; // Determines whether repainting is needed
  }
}
