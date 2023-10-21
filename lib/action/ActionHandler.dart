import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:tamahaem/action/AbstractAction.dart';
import 'package:tamahaem/action/Impl/CareAction.dart';
import 'package:tamahaem/action/Impl/CleanRoomAction.dart';
import 'package:tamahaem/action/Impl/PlayAction.dart';
import 'package:tamahaem/action/Impl/WaterAction.dart';
import 'package:tamahaem/event/EventHandleProvider.dart';

import 'Impl/FeedAction.dart';

class ActionHandler {

  static final Map<int, AbstractAction> _actionButtonMap = {
    0: FeedAction(),
    1: WaterAction(),
    2: PlayAction(),
    3: CleanRoomAction(),
    4: CareAction(),
  };

  void actionNotifier(Type type) => { EventHandlerProvider().currentEvent.handleEvent(type) };

  AbstractAction getAction(int index) {

    actionNotifier(_actionButtonMap[index].runtimeType);

    return _actionButtonMap[index]!;
  }
}