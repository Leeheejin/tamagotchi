import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/PlayAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class FoundToyEvent extends AbstractTamagotchiEvent {

  Type actionKey = PlayAction().runtimeType;
  Icon eventIcon = Icon(Icons.smart_toy_outlined, size: 75);

  @override
  void doAct() {
    tamagotchi.unhappiness();
  }

}