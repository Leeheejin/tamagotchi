import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class AbstractActionAnimation extends FlameGame {
  late BuildContext context;

  @override
  Color backgroundColor() => Colors.transparent;

  void dispose() {
    Navigator.of(context).pop();
  }
}