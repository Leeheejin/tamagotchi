import 'dart:async';

import 'package:logger/logger.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';
import 'package:tamahaem/event/impl/DefaultEvent.dart';

import '../../domain/Tamagotchi.dart';
import '../../utils/Constants.dart';
import 'EventGenerator.dart';

class EventHandleProvider {
  Tamagotchi _tamagotchi = Tamagotchi();
  EventGenerator _eventGenerator = EventGenerator();
  AbstractTamagotchiEvent _currentEvent = DefaultEvent();
  Logger logger = Logger();
  bool _isEventActive = false;
  late Timer _eventTimer;
  late AbstractTamagotchiEvent _tamagotchiEvent;

  static final EventHandleProvider instance = EventHandleProvider._internal();

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
    setCurrentEvent(_eventGenerator.getDefaultEvent());
    currentEvent.doAct();
    _isEventActive = false;
  }

  void handleEvent() {
    logger.v("event succeed: ${currentEvent.runtimeType}");
    _tamagotchi.increaseFriendly();
    inactiveEvent();
  }

  bool get isEventActive => _isEventActive;

  AbstractTamagotchiEvent get currentEvent => _currentEvent;

  void startEvent() {

    activeEvent();

    _eventTimer = Timer(const Duration(minutes: DAMAGOCHI_EVENT_TIME_MINUTE), () {
      if (_eventTimer.isActive) {
        _tamagotchi.decreaseFriendly();
        logger.v("event failed ${_tamagotchi.friendlyValue}");
      }
      inactiveEvent();
    });
  }
}