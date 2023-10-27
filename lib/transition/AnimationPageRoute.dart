import 'package:flutter/material.dart';

import 'TransitionEffectWidget.dart';

class AnimationPageRoute extends PageRouteBuilder {
  final Widget widget;
  final Color transitionColor;

  AnimationPageRoute({required this.widget, required this.transitionColor})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              TransitionEffectWidget(
                  animation: animation,
                  transitionColor: transitionColor,
                  child: child,
              ),
          transitionDuration: const Duration(seconds: 1),
        );
}
