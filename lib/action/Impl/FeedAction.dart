
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tamahaem/action/AbstractAction.dart';
import 'package:tamahaem/domain/Tamagotchi.dart';
import 'package:tamahaem/domain/TamagotchiProvider.dart';

import '../ui/FeedActionUI.dart';

class FeedAction extends AbstractAction {
  Tamagotchi tamagotchi = TamagotchiProvider().tamagotchi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: 0.1,
          height: 0.1,
          child: GameWidget(game: FeedActionUI())
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.blueAccent,
    //   body: Center(
    //     child: ElevatedButton(
    //       child: const Text("돌아가기"),
    //       onPressed: () {
    //         TamagotchiMap().actionNotifier(runtimeType);
    //         Navigator.pop(context);
    //       },
    //     ),
    //   ),
    // );
  }
}