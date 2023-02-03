import 'package:flutter/material.dart';
import 'package:tamahaem/controller/GameController.dart';

void main() {
  runApp(TamagotchiApp());
}

class TamagotchiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tamagotchi App',
      home: GameController(),
    );
  }
}