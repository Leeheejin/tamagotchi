import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/WaterAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class ThirstyEvent extends AbstractTamagotchiEvent {

  Type actionKey = WaterAction().runtimeType;
  AssetImage eventImage = AssetImage("assets/images/events/thirsty.png");

  @override
  void eventEffect() {
    tamagotchi.thirsty();
  }

}