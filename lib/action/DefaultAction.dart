
import 'package:flutter/material.dart';
import 'package:tamahaem/action/AbstractAction.dart';
import 'package:tamahaem/utils/TamagotchiMap.dart';

import '../domain/Tamagotchi.dart';
import '../domain/TamagotchiProvider.dart';

class DefaultAction extends AbstractAction {

  @override
  Widget build(BuildContext context) {
    TamagotchiMap().actionNotifier(runtimeType);
    return Container();
  }
}