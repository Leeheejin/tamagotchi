import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/CleanAction.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';

class PoopEvent extends AbstractTamagotchiEvent {

  Type actionKey = CleanAction().runtimeType;
  Icon eventIcon = Icon(Icons.mood_bad_sharp, size: 75);

  @override
  void doAct() {
    tamagotchi.poop();
  }

}