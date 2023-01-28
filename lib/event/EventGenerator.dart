import 'dart:math';

import 'package:tamahaem/event/events/FoundToyEvent.dart';
import 'package:tamahaem/event/events/SickEvent.dart';

import 'events/AbstractTamagotchiEvent.dart';
import 'events/HungryEvent.dart';
import 'events/ThirstyEvent.dart';
import 'events/TiredEvent.dart';

class EventGenerator {
  final _random = Random();

  final List<AbstractTamagotchiEvent> _events = [
    SickEvent(),
    HungryEvent(),
    ThirstyEvent(),
    TiredEvent(),
    FoundToyEvent(),
  ];

  AbstractTamagotchiEvent getRandomEvent() {
    return _events[_random.nextInt(_events.length - 1) + 1];
  }
}