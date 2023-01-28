import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';
import 'package:tamahaem/event/events/DefaultEvent.dart';

class EventProvider {
  bool _isEventActive = false;
  AbstractTamagotchiEvent _currentEvent = DefaultEvent();

  static final EventProvider _instance = EventProvider._internal();

  factory EventProvider() {
    return _instance;
  }

  EventProvider._internal() {
  }

  void setCurrentEvent(AbstractTamagotchiEvent event) {
    _currentEvent = event;
  }

  void activeEvent() {
    _isEventActive = true;
  }

  void inactiveEvent() {
    _isEventActive = false;
  }

  bool get isEventActive => _isEventActive;

  AbstractTamagotchiEvent get currentEvent => _currentEvent;
}