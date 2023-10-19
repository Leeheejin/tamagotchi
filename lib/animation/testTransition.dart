import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPageRoute2 extends PageRouteBuilder {
  final Widget widget;

  CustomPageRoute2({required this.widget})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => TransitionEffectWidget(key: const ValueKey('someUniqueValue'), animation: animation, child: child),
    transitionDuration: const Duration(seconds: 1),
  );
}

class TransitionEffectWidget extends StatefulWidget {
  final Widget child;
  final Animation<double> animation;

  const TransitionEffectWidget({
    required Key? key,
    required this.child,
    required this.animation,
  }) : super(key: key);

  @override
  _TransitionEffectWidgetState createState() => _TransitionEffectWidgetState();
}

class _TransitionEffectWidgetState extends State<TransitionEffectWidget> {
  late final bool useCircle;
  late final bool isHorizontal;

  @override
  void initState() {
    super.initState();
    useCircle = Random().nextBool();
    isHorizontal = Random().nextBool();
    print("TransitionEffectWidget initialized");
  }

  @override
  Widget build(BuildContext context) {
    print("TransitionEffectWidget building");
    return AbsorbPointer(
      absorbing: widget.animation.status == AnimationStatus.forward,
      child: Stack(
        children: [
          widget.child,
          CombinedTransition(animation: widget.animation, useCircle: useCircle, isHorizontal: isHorizontal),
        ],
      ),
    );
  }
}

class CombinedTransition extends StatelessWidget {
  final Animation<double> animation;
  final bool useCircle;
  final bool isHorizontal;

  const CombinedTransition({
    Key? key,
    required this.animation,
    required this.useCircle,
    required this.isHorizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: animation,
      builder: (context, value, child) {
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
              ),
            ),
          );
        }
        else {
          return LayoutBuilder(
            builder: (context, constraints) {
              const numOfBlinds = 20;
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
      },
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