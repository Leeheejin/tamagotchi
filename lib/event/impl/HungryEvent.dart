import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/FeedAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class HungryEvent extends AbstractTamagotchiEvent {

  Type actionKey = FeedAction().runtimeType;
  AssetImage eventImage = AssetImage("assets/images/events/hungry.png");

  @override
  void eventEffect() {
    tamagotchi.hungry();
  }

}