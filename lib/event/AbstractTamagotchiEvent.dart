import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:tamahaem/domain/Tamagotchi.dart';
import 'package:tamahaem/domain/TamagotchiProvider.dart';
import 'package:tamahaem/event/impl/EventHandleProvider.dart';

abstract class AbstractTamagotchiEvent {
  Tamagotchi tamagotchi = TamagotchiProvider.instance.tamagotchi;
  late Image eventImage;
  late Type actionKey;
  Logger logger = Logger();

  void handleEvent(Type actionType) {

    logger.v("action ocurred: $actionType");

    if (actionKey == actionType) {
      EventHandleProvider.instance.handleEvent();
    }
  }

  void doAct();
}
