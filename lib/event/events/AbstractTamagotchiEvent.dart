import 'package:flutter/cupertino.dart';
import 'package:tamahaem/action/AbstractAction.dart';
import 'package:tamahaem/domain/Tamagotchi.dart';
import 'package:tamahaem/domain/TamagotchiProvider.dart';

abstract class AbstractTamagotchiEvent {
  Tamagotchi tamagotchi = TamagotchiProvider().tamagotchi;
  late Icon eventIcon;
  bool isHandled = false;
  late Type actionKey;

  //TODO 이벤트 타입과 액션 타입을 비교하여 핸들되었는지 체크 필요.
  void handleEvent(Type actionType) {

    if (actionKey == actionType) {
      isHandled = true;
    }
  }

  void doAct();
}
