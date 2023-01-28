import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:tamahaem/event/events/HungryEvent.dart';

import '../action/FeedAction.dart';

class TamagotchiMap {

  final Map<int, Widget> _actionButtonMap = {
    0: FeedAction(),
    // 1: "Water",
    // 2: "Play",
    // 3: "Clean",
    // 4: "Care",
    // 5: "Not impl",
    // 6: "Not impl"
  };

  //TODO find out this event is handled.
  final Map<Type, void> _eventHandleMap = {
    FeedAction: HungryEvent().handleEvent()
  };

  Map get actionButtonMap => _actionButtonMap;
  Map get eventHandleMap => _eventHandleMap;
}