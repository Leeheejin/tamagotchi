import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:logger/logger.dart';

import '../domain/Tamagotchi.dart';
import '../event/EventHandleProvider.dart';
import '../utils/Constants.dart';

class TamagotchiCounterController {
  late Timer _timer;
  Tamagotchi _tamagotchi = Tamagotchi();
  VoidCallback _onTick;
  Logger logger = Logger();

  TamagotchiCounterController(this._onTick) {
    _timer = Timer.periodic(const Duration(hours: AFK_PENALTY_EVENT_TIME_HOUR), _afkPenalty);
    _timer = Timer.periodic(const Duration(hours: DEAFULT_EVENT_TIME_HOUR), _defaultPenalty);
    _timer = Timer.periodic(const Duration(minutes: DAMAGOCHI_EVENT_TIME_MINUTE), startEventLoop);
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
    EventHandlerProvider().setEventInactive();
    _timer.cancel();
    _onTick();
  }

  void startEventLoop(Timer timer) {
    EventHandlerProvider().startEvent();

    logger.v("event start ${_tamagotchi.hunger} ${_tamagotchi.thirst} ${_tamagotchi.happiness}");
  }
}