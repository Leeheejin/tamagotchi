import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:logger/logger.dart';
import 'package:tamahaem/domain/TamagotchiProvider.dart';
import 'package:tamahaem/event/EventHandler.dart';

import '../domain/Tamagotchi.dart';

class TamagotchiCounterController {
  late Timer _timer;
  EventHandler _eventHandler = EventHandler();
  Tamagotchi _tamagotchi = TamagotchiProvider().tamagotchi;
  VoidCallback _onTick;
  Logger logger = Logger();

  TamagotchiCounterController(this._onTick) {
    _timer = Timer.periodic(const Duration(hours: 1), _afkPenalty);
    _timer = Timer.periodic(const Duration(minutes: 1), _defaultPenalty);
    _timer = Timer.periodic(const Duration(minutes: 1), startEventLoop);
  }

  void _afkPenalty(Timer timer) {
    // TODO when offline, should active this timer.
    _tamagotchi.afkPenalty();

    logger.v("afk penalty ${_tamagotchi.hunger} ${_tamagotchi.thirst} ${_tamagotchi.happiness}");
  }

  void _defaultPenalty(Timer timer) {
    _tamagotchi.defaultPenalty();

    logger.v("default penalty ${_tamagotchi.hunger} ${_tamagotchi.thirst} ${_tamagotchi.happiness}");
  }

  void stop() {
    _timer.cancel();
    _onTick();
  }

  // there is a bug, when expanded button list, then rerendering tamagotchi's movement
  // so, i deleted ontick call in every functions. i dont knwo that is right solution.
  void startEventLoop(Timer timer) {
    _eventHandler.startEvent();

    logger.v("event start ${_tamagotchi.hunger} ${_tamagotchi.thirst} ${_tamagotchi.happiness}");
  }
}