
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tamahaem/action/AbstractAction.dart';

import '../../utils/TamagotchiMap.dart';
import '../ui/FeedActionUI.dart';
import '../ui/chat/ChatBox.dart';

class FeedAction extends AbstractAction {

  @override
  _FeedActionState createState() => _FeedActionState();
}

class _FeedActionState extends State<FeedAction> {
  bool animationDone = false;
  int currentStep = 0;
  final List<AnimatedText> messages = [
    TyperAnimatedText("햄쥐는 배가 고프다..."),
    TyperAnimatedText("맛있는 사과를 받았다!"),
    TyperAnimatedText("햄쥐는 의지가 차오른다."),
    TyperAnimatedText("")
  ];

  @override
  void initState() {
    TamagotchiMap().actionNotifier(runtimeType);
    super.initState();
  }

  void _updateStep() {
    if (animationDone && currentStep < messages.length - 1) {
      setState(() {
        currentStep++;
        animationDone = false;
      });
    }
  }

  void _onAnimationDone() {
    if (!animationDone) {
        animationDone = true;
    }
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
              child: GameWidget(
                  game: FeedActionUI(
                      context: context,
                      currentStep: currentStep,
                      onCompleted: _onAnimationDone
                  ))
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.1,
            child: ChatBox(
                message: messages[currentStep],
                onTap: _updateStep,
              ),
            ),
        ],
      ),
    );
  }
}