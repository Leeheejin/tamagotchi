import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/PlayAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class BoredomEvent extends AbstractTamagotchiEvent {

  Type actionKey = PlayAction().runtimeType;
  AssetImage eventImage = AssetImage("assets/images/events/boredom.png");

  @override
  void eventEffect() {
    tamagotchi.unhappiness();
  }

}