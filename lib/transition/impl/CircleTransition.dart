import 'package:flutter/material.dart';

class CircleTransition extends StatelessWidget {
  final Animation<double> animation;

  const CircleTransition({required this.animation});

  @override
  Widget build(BuildContext context) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    );

    final size = MediaQuery.of(context).size;
    final radius = (1.0 - curvedAnimation.value) * size.width;

    return Center(
      child: ClipOval(
        clipper: CircleClipper(radius),
        child: Container(
          color: Colors.black,
        ),
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Rect> {
  final double radius;

  CircleClipper(this.radius);

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius);
  }

  @override
  bool shouldReclip(CircleClipper oldClipper) {
    return radius != oldClipper.radius;
  }
}