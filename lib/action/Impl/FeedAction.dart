
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tamahaem/action/AbstractAction.dart';

import '../../utils/TamagotchiMap.dart';
import '../ui/FeedActionUI.dart';

class FeedAction extends AbstractAction {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: 0.1,
          height: 0.1,
          child: ElevatedButton(
            onPressed: () {
              TamagotchiMap().actionNotifier(runtimeType);
            },
            child: GameWidget(game: FeedActionUI(context: context, currentStep: 4))
          ),
      ),
    );
    // Scaffold(
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