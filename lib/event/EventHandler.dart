import 'dart:async';

import 'package:logger/logger.dart';
import 'package:tamahaem/domain/Tamagotchi.dart';
import 'package:tamahaem/domain/TamagotchiProvider.dart';
import 'package:tamahaem/event/EventGenerator.dart';
import 'package:tamahaem/event/EventMarkerProvider.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';

class EventHandler {
  late Timer _eventTimer;
  late AbstractTamagotchiEvent _tamagotchiEvent;
  Tamagotchi _tamagotchi = TamagotchiProvider().tamagotchi;
  EventGenerator _eventGenerator = EventGenerator();
  Logger logger = Logger();

  void startEvent() {
    _tamagotchiEvent = _eventGenerator.getRandomEvent();
    _tamagotchiEvent.doAct();
    EventMarkerProvider().setCurrentImage(_tamagotchiEvent.eventIcon);
    EventMarkerProvider().activeEvent();
    _eventTimer = Timer(const Duration(minutes: 1), () {
      if (_tamagotchiEvent.isHandled == false) {
        _tamagotchi.decreaseFriendly();
        logger.v("event failed ${_tamagotchi.friendlyValue}");
      }
      EventMarkerProvider().inactiveEvent();
    });
  }

  void endEvent() {
    _eventTimer.cancel();
    EventMarkerProvider().inactiveEvent();
  }
}