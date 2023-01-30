import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:tamahaem/action/Impl/CareAction.dart';
import 'package:tamahaem/action/Impl/CleanAction.dart';
import 'package:tamahaem/action/Impl/PlayAction.dart';
import 'package:tamahaem/action/Impl/WaterAction.dart';
import 'package:tamahaem/event/EventHandleProvider.dart';

import '../action/Impl/FeedAction.dart';

class TamagotchiMap {

  final Map<int, Widget> _actionButtonMap = {
    0: FeedAction(),
    1: WaterAction(),
    2: PlayAction(),
    3: CleanAction(),
    4: CareAction(),
  };

  void actionNotifier(Type type) => { EventHandleProvider().currentEvent.handleEvent(type) };

  Map get actionButtonMap => _actionButtonMap;
}