import 'package:flutter/material.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';

class SickEvent extends AbstractTamagotchiEvent {

  String eventName = "Sick";
  Icon eventIcon = Icon(Icons.sick, size: 75);

  @override
  void doAct() {
    tamagotchi.sick();
  }

}