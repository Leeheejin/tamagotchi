import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/WaterAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class ThirstyEvent extends AbstractTamagotchiEvent {

  Type actionKey = WaterAction().runtimeType;
  Image eventImage = Image.asset("assets/images/events/thirsty.png");

  @override
  void doAct() {
    tamagotchi.thirsty();
  }

}