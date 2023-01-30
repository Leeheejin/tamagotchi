import 'dart:async';

import 'package:logger/logger.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';
import 'package:tamahaem/event/events/DefaultEvent.dart';

import '../domain/Tamagotchi.dart';
import '../domain/TamagotchiProvider.dart';
import 'EventGenerator.dart';

class EventHandleProvider {
  Tamagotchi _tamagotchi = TamagotchiProvider().tamagotchi;
  EventGenerator _eventGenerator = EventGenerator();
  AbstractTamagotchiEvent _currentEvent = DefaultEvent();
  Logger logger = Logger();
  bool _isEventActive = false;
  late Timer _eventTimer;
  late AbstractTamagotchiEvent _tamagotchiEvent;

  static final EventHandleProvider _instance = EventHandleProvider._internal();

  factory EventHandleProvider() {
    return _instance;
  }

  EventHandleProvider._internal() {
  }

  void setCurrentEvent(AbstractTamagotchiEvent event) {
    _currentEvent = event;
  }

  void activeEvent() {
    _tamagotchiEvent = _eventGenerator.getRandomEvent();
    setCurrentEvent(_tamagotchiEvent);
    currentEvent.doAct();
    logger.v("current event: ${currentEvent.runtimeType}");
    _isEventActive = true;
  }

  void inactiveEvent() {
    _eventTimer.cancel();
    _isEventActive = false;
  }

  void handleEvent() {
    logger.v("event succeed: ${currentEvent.runtimeType}");
    inactiveEvent();
  }

  bool get isEventActive => _isEventActive;

  AbstractTamagotchiEvent get currentEvent => _currentEvent;

  void startEvent() {

    activeEvent();

    _eventTimer = Timer(const Duration(minutes: 30), () {
      if (_eventTimer.isActive) {
        _tamagotchi.decreaseFriendly();
        logger.v("event failed ${_tamagotchi.friendlyValue}");
      }
      inactiveEvent();
    });
  }
}