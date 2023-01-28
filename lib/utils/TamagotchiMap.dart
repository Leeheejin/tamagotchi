import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:tamahaem/event/events/HungryEvent.dart';

import '../action/FeedAction.dart';

// TODO event <-> action. button <-> action
// action String, button int(index), event Provider Object -> name
class TamagotchiMap {

  //TODO Action - index mapping.
  final Map<int, Widget> _actionButtonMap = {
    0: FeedAction(),
    // 1: "Water",
    // 2: "Play",
    // 3: "Clean",
    // 4: "Care",
    // 5: "Not impl",
    // 6: "Not impl"
  };

  final Map<Type, void> _eventHandleMap = {
    FeedAction: HungryEvent().handleEvent()
  };

  Map get actionButtonMap => _actionButtonMap;
  Map get eventHandleMap => _eventHandleMap;
}