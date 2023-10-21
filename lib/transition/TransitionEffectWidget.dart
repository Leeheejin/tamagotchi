import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'impl/BlindsTransition.dart';
import 'impl/CircleTransition.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.animation.status == AnimationStatus.forward,
      child: Stack(
        children: [
          widget.child,
          ValueListenableBuilder(
              valueListenable: widget.animation,
              builder: (context, value, child) {
                if (useCircle) {
                  return CircleTransition(animation: widget.animation);
                } else {
                  return BlindsTransition(
                      animation: widget.animation, isHorizontal: isHorizontal);
                }
              })
        ],
      ),
    );
  }
}
