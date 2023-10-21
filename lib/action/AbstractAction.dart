
import 'package:flutter/material.dart';

import '../domain/Tamagotchi.dart';

abstract class AbstractAction extends StatefulWidget {
  Tamagotchi tamagotchi = Tamagotchi();

  void action();
}

extension ActionHandler on AbstractAction {
  AbstractAction doAction() {
    action();
    return this;
  }
}