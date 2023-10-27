import 'dart:math';

import 'package:flutter/material.dart';

class CircleTransition extends StatelessWidget {
  final Animation<double> animation;
  final Color transitionColor;

  const CircleTransition(
      {required this.animation, required this.transitionColor});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(animation: animation, color: transitionColor),
      child: Container(),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  CirclePainter({required this.animation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final center = Offset(size.width / 2, size.height / 2);

    // Calculate the diagonal to ensure the circle always covers the entire screen
    final diagonal = sqrt(size.width * size.width + size.height * size.height);
    final radius = (1.0 - animation.value) * diagonal / 2;

    final path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
