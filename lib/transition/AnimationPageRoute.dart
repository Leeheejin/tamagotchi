import 'package:flutter/material.dart';

import 'TransitionEffectWidget.dart';

class AnimationPageRoute extends PageRouteBuilder {
  final Widget widget;

  AnimationPageRoute({required this.widget})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              TransitionEffectWidget(
                  key: const ValueKey('someUniqueValue'),
                  animation: animation,
                  child: child),
          transitionDuration: const Duration(seconds: 1),
        );
}
