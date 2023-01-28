import 'package:flutter/material.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';

class TiredEvent extends AbstractTamagotchiEvent {

  String eventName = "Tired";
  Icon eventIcon = Icon(Icons.mood_bad_sharp, size: 75);

  @override
  void doAct() {
    tamagotchi.tired();
  }

}