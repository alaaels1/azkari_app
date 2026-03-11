import 'package:flutter/material.dart';
import 'dart:math';

class HalfCirclePainter extends CustomPainter {
  final Color color;
  final bool isLeft;

  HalfCirclePainter({
    required this.color,
    required this.isLeft,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 2;

    double startAngle;
    double sweepAngle = pi;

    if (isLeft) {
      startAngle = pi / 2;
    } else {
      startAngle = -pi / 2;
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant HalfCirclePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.isLeft != isLeft;
}