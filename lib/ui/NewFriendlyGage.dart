import 'package:flutter/material.dart';

class NewFriendlyGage extends StatelessWidget {
  final double friendly;

  const NewFriendlyGage({
    required Key key,
    required this.friendly,
  }) : super(key: key);

  //TODO when friendly value changed, should gage updated with.
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


