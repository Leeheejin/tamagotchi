import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'impl/BlindsTransition.dart';
import 'impl/CircleTransition.dart';

class TransitionEffectWidget extends StatelessWidget {
  final Widget currentScreen;
  final Widget nextScreen;
  final Animation<double> animation;
  final Color transitionColor;

  const TransitionEffectWidget({
    required this.currentScreen,
    required this.nextScreen,
    required this.animation,
    required this.transitionColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: animation,
      builder: (context, value, child) {
        if (animation.value <= 0.5) {
          return Stack(
            children: [
              currentScreen,
              CircleTransition(
                animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.0, 0.5, curve: Curves.easeOut),
                )),
                transitionColor: transitionColor,
              ),
            ],
          );
        } else {
          return Stack(
            children: [
              nextScreen,
              animation.value < 1.0 ? CircleTransition(
                animation: Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.5, 1.0, curve: Curves.easeIn),
                )),
                transitionColor: transitionColor,
              ) : const Column(),
            ],
          );
        }
      },
    );
  }
}

