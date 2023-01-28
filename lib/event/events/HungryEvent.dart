import 'package:flutter/material.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';

class HungryEvent extends AbstractTamagotchiEvent {

  String eventName = "Hungry";
  Icon eventIcon = Icon(Icons.no_meals ,size: 75);

  @override
  void doAct() {
    tamagotchi.hungry();
  }

}