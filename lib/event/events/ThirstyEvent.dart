import 'package:flutter/material.dart';
import 'package:tamahaem/action/WaterAction.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';

class ThirstyEvent extends AbstractTamagotchiEvent {

  Type actionKey = WaterAction().runtimeType;
  Icon eventIcon = Icon(Icons.water_drop_outlined, size: 75);

  @override
  void doAct() {
    tamagotchi.thirsty();
  }

}