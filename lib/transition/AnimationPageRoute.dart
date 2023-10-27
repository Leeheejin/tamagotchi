import 'package:flutter/material.dart';

import 'TransitionEffectWidget.dart';

class AnimationPageRoute extends PageRouteBuilder {
  final Widget currentScreen;
  final Widget nextScreen;
  final Color transitionColor;

  AnimationPageRoute({
    required this.currentScreen,
    required this.nextScreen,
    required this.transitionColor,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => TransitionEffectWidget(
      currentScreen: currentScreen,
      nextScreen: nextScreen,
      animation: animation,
      transitionColor: transitionColor,
    ),
    transitionDuration: const Duration(seconds: 3),
    reverseTransitionDuration: const Duration(seconds: 3)
  );
}
