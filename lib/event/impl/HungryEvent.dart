import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/FeedAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class HungryEvent extends AbstractTamagotchiEvent {

  Type actionKey = FeedAction().runtimeType;
  Image eventImage = Image.asset("assets/images/events/hungry.png");

  @override
  void doAct() {
    tamagotchi.hungry();
  }

}