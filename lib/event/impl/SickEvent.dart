import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/CareAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class SickEvent extends AbstractTamagotchiEvent {

  Type actionKey = CareAction().runtimeType;
  Image eventImage = Image.asset("assets/images/events/sick.png");

  @override
  void doAct() {
    tamagotchi.sick();
  }

}