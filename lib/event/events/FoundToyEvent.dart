import 'package:flutter/material.dart';
import 'package:tamahaem/action/PlayAction.dart';
import 'package:tamahaem/domain/TamagotchiProvider.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';

class FoundToyEvent extends AbstractTamagotchiEvent {

  Type actionKey = PlayAction().runtimeType;
  Icon eventIcon = Icon(Icons.smart_toy_outlined, size: 75);

  @override
  void doAct() {
    tamagotchi.unhappiness();
  }

}