import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/CareAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class SickEvent extends AbstractTamagotchiEvent {

  Type actionKey = CareAction().runtimeType;
  AssetImage eventImage = AssetImage("assets/images/events/sick.png");

  @override
  void eventEffect() {
    tamagotchi.sick();
  }

}