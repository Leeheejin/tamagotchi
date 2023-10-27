import 'package:flutter/material.dart';

class CircleTransition extends StatelessWidget {
  final Animation<double> animation;
  final Color transitionColor;

  const CircleTransition({
    required this.animation,
    required this.transitionColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // This animation value varies from 0 to 0.5 for the first phase and 0.5 to 1 for the second phase.
    double animationValue = animation.value;

    // Calculate the radius for the first and second phases.
    double firstPhaseRadius = (1.0 - (2 * animationValue).clamp(0.0, 1.0)) * size.width;
    double secondPhaseRadius = ((2 * animationValue - 1).clamp(0.0, 1.0)) * size.width;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(color: transitionColor),
        ),
        // Black circle covering the screen.
        ClipOval(
          clipper: CircleClipper(firstPhaseRadius),
          child: Container(
            color: transitionColor,
          ),
        ),
        // Transparent circle revealing the next screen.
        ClipOval(
          clipper: CircleClipper(secondPhaseRadius),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

class CircleClipper extends CustomClipper<Rect> {
  final double radius;

  CircleClipper(this.radius);

  @override
  Rect getClip(Size size) {
    final diameter = 2 * radius;
    return Rect.fromLTWH(
      size.width / 2 - radius,
      size.height / 2 - radius,
      diameter,
      diameter,
    );
  }

  @override
  bool shouldReclip(CircleClipper oldClipper) {
    return radius != oldClipper.radius;
  }
}
