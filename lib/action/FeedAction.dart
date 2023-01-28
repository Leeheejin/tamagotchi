
import 'package:flutter/material.dart';
import 'package:tamahaem/utils/TamagotchiMap.dart';

import '../domain/Tamagotchi.dart';
import '../domain/TamagotchiProvider.dart';

class FeedAction extends StatelessWidget {
  Tamagotchi tamagotchi = TamagotchiProvider().tamagotchi;

  FeedAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: ElevatedButton(
          child: const Text("돌아가기"),
          onPressed: () {
            TamagotchiMap().eventHandleMap[runtimeType];
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}