import 'package:flutter/material.dart';
import 'package:tamahaem/domain/TamagotchiProvider.dart';
import 'package:tamahaem/event/events/AbstractTamagotchiEvent.dart';

class DefaultEvent extends AbstractTamagotchiEvent {

  String eventName = "default";
  Icon eventIcon = Icon(Icons.add_circle_outline, size: 75);

  @override
  void doAct() {
    // do nothing. is default.
  }

}