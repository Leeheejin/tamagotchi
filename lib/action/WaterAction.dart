
import 'package:flutter/material.dart';
import 'package:tamahaem/utils/TamagotchiMap.dart';

import '../domain/Tamagotchi.dart';
import '../domain/TamagotchiProvider.dart';
import 'AbstractAction.dart';

class WaterAction extends AbstractAction {
  Tamagotchi tamagotchi = TamagotchiProvider().tamagotchi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: ElevatedButton(
          child: const Text("돌아가기"),
          onPressed: () {
            TamagotchiMap().actionNotifier(runtimeType);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}