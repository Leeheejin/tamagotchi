import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:tamahaem/domain/Tamagotchi.dart';
import 'package:tamahaem/domain/TamagotchiProvider.dart';
import 'package:tamahaem/event/impl/EventHandleProvider.dart';

abstract class AbstractTamagotchiEvent {
  Tamagotchi tamagotchi = TamagotchiProvider().tamagotchi;
  late Icon eventIcon;
  late Type actionKey;
  Logger logger = Logger();

  void handleEvent(Type actionType) {

    logger.v("action ocurred: $actionType");

    if (actionKey == actionType) {
      EventHandleProvider().handleEvent();
    }
  }

  void doAct();
}
