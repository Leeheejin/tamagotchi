import 'package:flutter/material.dart';

class FriendlyGage extends StatelessWidget {
  final double friendly;

  const FriendlyGage({
    required Key key,
    required this.friendly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int intFriendly = (friendly * 10).toInt();
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Image.asset("assets/images/gage/GAUGE_$intFriendly.png"),
    );
  }
}


