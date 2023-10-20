
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tamahaem/action/AbstractAction.dart';

import '../../utils/TamagotchiMap.dart';
import '../ui/FeedActionUI.dart';
import '../ui/chat/DamagochiChatBox.dart';

class FeedAction extends AbstractAction {

  @override
  _FeedActionState createState() => _FeedActionState();
}

class _FeedActionState extends State<FeedAction> {
  int currentStep = 0;
  final List<String> messages = [
    "",
    "Step 1: See the red box.",
    "Step 2: Now it turns green.",
    "Step 3: Finally, blue.",
  ];

  void _resetChatBox() {
    TamagotchiMap().actionNotifier(runtimeType);
    setState(() {
      currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(),
            ),
          ),
          SizedBox(
              width: 0.1,
              height: 0.1,
              child: GameWidget(game: FeedActionUI(context: context, currentStep: currentStep))
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.1,
            child: ChatBox(
                messages: messages,
                onFinished: _resetChatBox,
              ),
            ),
        ],
      ),
    );
  }
}