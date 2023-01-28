import 'package:flutter/material.dart';

class FriendlyGage extends StatelessWidget {
  final double friendly;

  const FriendlyGage({
    required Key key,
    required this.friendly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LinearProgressIndicator(
          value: friendly,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
    );
  }
}


