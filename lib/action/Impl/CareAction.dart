import 'package:flutter/material.dart';
import 'package:tamahaem/action/AbstractAction.dart';

class CareAction extends AbstractAction {
  @override
  _CareActionState createState() => _CareActionState();

  @override
  void action() {
    tamagotchi.care();
  }
}

class _CareActionState extends State<CareAction> {
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
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
