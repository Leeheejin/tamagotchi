import 'package:flutter/cupertino.dart';
import 'package:tamahaem/domain/Tamagotchi.dart';
import 'package:tamahaem/domain/TamagotchiProvider.dart';

abstract class AbstractTamagotchiEvent {
  Tamagotchi tamagotchi = TamagotchiProvider().tamagotchi;
  late String eventName;
  late Icon eventIcon;
  bool isHandled = false;

  void handleEvent() {
    isHandled = true;
  }

  void doAct();
}