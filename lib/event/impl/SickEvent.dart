import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/CareAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class SickEvent extends AbstractTamagotchiEvent {

  Type actionKey = CareAction().runtimeType;
  Icon eventIcon = Icon(Icons.sick, size: 75);

  @override
  void doAct() {
    tamagotchi.sick();
  }

}