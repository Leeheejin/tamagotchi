import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget widget;
  final bool useCircle;
  final bool isHorizontal;

  factory CustomPageRoute({required Widget widget}) {
    final useCircle = Random().nextBool();
    final isHorizontal = Random().nextBool();
    return CustomPageRoute._internal(widget: widget, useCircle: useCircle, isHorizontal: isHorizontal);
  }

  CustomPageRoute._internal({required this.widget, required this.useCircle, required this.isHorizontal})
      : super(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Logger logger = Logger();
        logger.v("called");
        return AbsorbPointer(
          absorbing: animation.status == AnimationStatus.forward,
          child: Stack(
            children: [
              child,
              CombinedTransition(animation: animation, useCircle: useCircle, isHorizontal: isHorizontal),
            ],
          ),
        );
      }
  );

  @override
  Duration get transitionDuration => Duration(seconds: 1);
}


class CombinedTransition extends StatelessWidget {
  final Animation<double> animation;
  final bool useCircle;
  final bool isHorizontal;

  CombinedTransition({required this.animation, required this.useCircle, required this.isHorizontal});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final useCircle = random.nextBool();
    final isHorizontal = random.nextBool();

    // Circle Transition Logic
    if (useCircle) {
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
            width: size.width,
            height: size.height,
          ),
        ),
      );
    }

    // Blinds Transition Logic
    else {
      return LayoutBuilder(
        builder: (context, constraints) {
          final numOfBlinds = 20;
          final blindSize = isHorizontal
              ? constraints.maxWidth / numOfBlinds
              : constraints.maxHeight / numOfBlinds;

          return Stack(
            children: List.generate(numOfBlinds, (index) {
              final staggeredAnimation = CurvedAnimation(
                parent: animation,
                curve: Interval(
                  index * 0.05,
                  1.0,
                  curve: Curves.easeInOut,
                ),
              );

              double size = isHorizontal
                  ? blindSize * (1.0 - staggeredAnimation.value)
                  : constraints.maxHeight;
              double position = isHorizontal
                  ? blindSize * index
                  : 0.0;

              if (!isHorizontal) {
                size = blindSize * (1.0 - staggeredAnimation.value);
                position = blindSize * index;
              }

              return Positioned(
                top: isHorizontal ? 0 : position,
                left: isHorizontal ? position : 0,
                child: Container(
                  width: isHorizontal ? size : constraints.maxWidth,
                  height: isHorizontal ? constraints.maxHeight : size,
                  color: Colors.black,
                ),
              );
            }),
          );
        },
      );
    }
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