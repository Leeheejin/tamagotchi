import 'package:flutter/material.dart';

import '../domain/Tamagotchi.dart';

abstract class AbstractAction extends StatefulWidget {
  Color transitionColor = Colors.black;
  Tamagotchi tamagotchi = Tamagotchi();

  void action();
}

extension ActionExecutor on AbstractAction {
  AbstractAction doAction() {
    action();
    return this;
  }
}
