import 'package:flutter/material.dart';
import 'package:tamahaem/action/Impl/DefaultAction.dart';
import 'package:tamahaem/event/AbstractTamagotchiEvent.dart';

class DefaultEvent extends AbstractTamagotchiEvent {

  Type actionKey = DefaultAction().runtimeType;
  Image eventImage = Image.asset("assets/images/events/happy.png");

  @override
  void doAct() {
    // do nothing. is default.
  }

}