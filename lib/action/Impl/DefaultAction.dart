
import 'package:flutter/material.dart';
import 'package:tamahaem/action/AbstractAction.dart';
import 'package:tamahaem/utils/TamagotchiMap.dart';

class DefaultAction extends AbstractAction {

  @override
  _DefaultActionState createState() => _DefaultActionState();
}

class _DefaultActionState extends State<DefaultAction> {
  int currentStep = 1;
  final List<String> messages = [
    "Step 1: See the red box.",
    "Step 2: Now it turns green.",
    "Step 3: Finally, blue.",
  ];

  @override
  Widget build(BuildContext context) {
    TamagotchiMap().actionNotifier(runtimeType);
    return Container();
  }
}