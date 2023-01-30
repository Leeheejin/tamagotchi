import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/FeedAction.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';

class HungryEvent extends AbstractTamagotchiEvent {

  Type actionKey = FeedAction().runtimeType;
  Icon eventIcon = Icon(Icons.no_meals ,size: 75);

  @override
  void doAct() {
    tamagotchi.hungry();
  }

}