import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:tamahaem/domain/Tamagotchi.dart';
import 'package:tamahaem/event/EventHandleProvider.dart';

abstract class AbstractTamagotchiEvent {
  Tamagotchi tamagotchi = Tamagotchi();
  late AssetImage eventImage;
  late Type actionKey;
  Logger logger = Logger();

  void handleEvent(Type actionType) {
    if (actionKey == actionType) {
      EventHandlerProvider().handleEvent();
    }
  }

  void eventEffect();
}
