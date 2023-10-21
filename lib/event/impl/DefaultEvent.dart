import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/DefaultAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class DefaultEvent extends AbstractTamagotchiEvent {
  Type actionKey = DefaultAction().runtimeType;
  AssetImage eventImage = AssetImage("assets/images/events/happy.png");

  @override
  void eventEffect() {
    // do nothing. is default.
  }
}
