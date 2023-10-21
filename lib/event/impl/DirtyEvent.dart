import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/CleanAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class DirtyEvent extends AbstractTamagotchiEvent {

  Type actionKey = CleanAction().runtimeType;
  Image eventImage = Image.asset("assets/images/events/dirty.png");

  @override
  void eventEffect() {
    tamagotchi.poop();
  }

}