import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';
import 'package:tamahaem/event/impl/DefaultEvent.dart';

import '../../domain/Tamagotchi.dart';
import '../../utils/Constants.dart';
import 'EventGenerator.dart';

class EventHandlerProvider extends ChangeNotifier {
  static final EventHandlerProvider _instance = EventHandlerProvider._internal();

  Tamagotchi _tamagotchi = Tamagotchi();
  final EventGenerator _eventGenerator = EventGenerator();
  AbstractTamagotchiEvent _currentEvent = DefaultEvent();
  bool _isEventActive = false;
  Logger logger = Logger();

  late Timer _eventTimer;

  factory EventHandlerProvider() {
    return _instance;
  }

  EventHandlerProvider._internal() {
    setCurrentEvent(_eventGenerator.getDefaultEvent());
  }

  void setCurrentEvent(AbstractTamagotchiEvent event) {
    _currentEvent = event;

    notifyListeners();
  }

  void setEventActive() {
    setCurrentEvent(_eventGenerator.getRandomEvent());
    currentEvent.eventEffect();
    logger.v("current event: ${currentEvent.runtimeType}");
    _isEventActive = true;

    notifyListeners();
  }

  void setEventInactive() {
    _eventTimer.cancel();
    setCurrentEvent(_eventGenerator.getDefaultEvent());
    currentEvent.eventEffect();
    _isEventActive = false;

    notifyListeners();
  }

  void handleEvent() {
    logger.v("event succeed: ${currentEvent.runtimeType}");
    _tamagotchi.increaseFriendly();
    setEventInactive();
  }

  bool get isEventActive => _isEventActive;

  AbstractTamagotchiEvent get currentEvent => _currentEvent;

  void startEvent() {

    setEventActive();

    _eventTimer = Timer(const Duration(minutes: DAMAGOCHI_EVENT_TIME_MINUTE), () {
      if (_eventTimer.isActive) {
        _tamagotchi.decreaseFriendly();
        logger.v("event failed ${_tamagotchi.friendlyValue}");
      }
      setEventInactive();
    });
  }
}