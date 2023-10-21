import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/CleanRoomAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class DirtyEvent extends AbstractTamagotchiEvent {

  Type actionKey = CleanRoomAction().runtimeType;
  Image eventImage = Image.asset("assets/images/events/dirty.png");

  @override
  void eventEffect() {
    tamagotchi.poop();
  }

}