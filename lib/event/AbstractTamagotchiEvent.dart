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

  //TODO 이벤트 타입과 액션 타입을 비교하여 핸들되었는지 체크 필요.
  void handleEvent(Type actionType) {

    logger.v("action ocurred: $actionType");

    if (actionKey == actionType) {
      EventHandleProvider().handleEvent();
    }
  }

  void doAct();
}
