import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/DefaultAction.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';

class DefaultEvent extends AbstractTamagotchiEvent {

  Type actionKey = DefaultAction().runtimeType;
  Icon eventIcon = Icon(Icons.add_circle_outline, size: 75);

  @override
  void doAct() {
    // do nothing. is default.
  }

}