import 'package:flutter/material.dart';

class BlindsTransition extends StatelessWidget {
  final Animation<double> animation;
  final bool isHorizontal;
  final Color transitionColor;

  const BlindsTransition({
    required this.animation,
    required this.isHorizontal,
    required this.transitionColor
  });

  @override
  Widget build(BuildContext context) {
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
            double position = isHorizontal ? blindSize * index : 0.0;

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
                color: transitionColor,
              ),
            );
          }),
        );
      },
    );
  }
}
