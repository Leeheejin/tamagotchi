import 'dart:math';

import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';
import 'package:tamahaem/event/impl/FoundToyEvent.dart';
import 'package:tamahaem/event/impl/HungryEvent.dart';
import 'package:tamahaem/event/impl/PoopEvent.dart';
import 'package:tamahaem/event/impl/SickEvent.dart';
import 'package:tamahaem/event/impl/ThirstyEvent.dart';

class EventGenerator {
  final _random = Random();

  final List<AbstractTamagotchiEvent> _events = [
    SickEvent(),
    HungryEvent(),
    ThirstyEvent(),
    PoopEvent(),
    FoundToyEvent(),
  ];

  AbstractTamagotchiEvent getRandomEvent() {
    return _events[_random.nextInt(_events.length - 1) + 1];
  }
}