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

    setEvent();

    _eventTimer = Timer(const Duration(minutes: 5), () {
      if (EventProvider().currentEvent.isHandled == false) {
        _tamagotchi.decreaseFriendly();
        logger.v("event failed ${_tamagotchi.friendlyValue}");
      }
      EventProvider().inactiveEvent();
    });
  }

  void endEvent() {
    _eventTimer.cancel();
    EventProvider().inactiveEvent();
  }

  void setEvent() {
    _tamagotchiEvent = _eventGenerator.getRandomEvent();
    EventProvider().setCurrentEvent(_tamagotchiEvent);
    EventProvider().currentEvent.doAct();
    EventProvider().activeEvent();
    logger.v("current event: ${EventProvider().currentEvent.eventName}");
  }
}