import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:tamahaem/domain/Tamagotchi.dart';
import 'package:tamahaem/event/impl/EventHandleProvider.dart';

abstract class AbstractTamagotchiEvent {
  Tamagotchi tamagotchi = Tamagotchi();
  late Image eventImage;
  late Type actionKey;
  Logger logger = Logger();

  void handleEvent(Type actionType) {
    if (actionKey == actionType) {
      EventHandlerProvider().handleEvent();
    }
  }

  void doAct();
}
