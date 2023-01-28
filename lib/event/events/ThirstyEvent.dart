import 'package:flutter/material.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';

class ThirstyEvent extends AbstractTamagotchiEvent {

  String eventName = "Thirsty";
  Icon eventIcon = Icon(Icons.water_drop_outlined, size: 75);

  @override
  void doAct() {
    tamagotchi.thirsty();
  }

}