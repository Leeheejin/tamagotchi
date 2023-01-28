import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:tamahaem/action/CareAction.dart';
import 'package:tamahaem/action/PlayAction.dart';
import 'package:tamahaem/event/events/FoundToyEvent.dart';
import 'package:tamahaem/event/events/HungryEvent.dart';
import 'package:tamahaem/event/events/PoopEvent.dart';
import 'package:tamahaem/event/events/SickEvent.dart';
import 'package:tamahaem/event/events/ThirstyEvent.dart';

import '../action/CleanAction.dart';
import '../action/FeedAction.dart';
import '../action/WaterAction.dart';

class TamagotchiMap {

  final Map<int, Widget> _actionButtonMap = {
    0: FeedAction(),
    1: WaterAction(),
    2: PlayAction(),
    3: CleanAction(),
    4: CareAction(),
  };

  //TODO find out this event is handled.
  final Map<Type, void> _eventHandleMap = {
    FeedAction: HungryEvent().handleEvent(),
    WaterAction: ThirstyEvent().handleEvent(),
    PlayAction: FoundToyEvent().handleEvent(),
    CleanAction: PoopEvent().handleEvent(),
    CareAction: SickEvent().handleEvent()
  };

  Map get actionButtonMap => _actionButtonMap;
  Map get eventHandleMap => _eventHandleMap;
}