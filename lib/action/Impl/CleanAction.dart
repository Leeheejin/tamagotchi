
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tamahaem/action/AbstractAction.dart';
import 'package:tamahaem/utils/TamagotchiMap.dart';

import '../ui/FeedActionUI.dart';

class CleanAction extends AbstractAction {

  @override
  _CleanActionState createState() => _CleanActionState();
}

class _CleanActionState extends State<CleanAction> {
  int currentStep = 1;
  final List<String> messages = [
    "Step 1: See the red box.",
    "Step 2: Now it turns green.",
    "Step 3: Finally, blue.",
  ];

  void _resetChatBox() {
    setState(() {
      currentStep = 1;
    });
  }

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