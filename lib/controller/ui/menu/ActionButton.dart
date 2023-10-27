import 'package:flutter/material.dart';
import 'package:tamahaem/action/AbstractAction.dart';
import 'package:tamahaem/action/ActionHandler.dart';
import 'package:tamahaem/controller/TamagotchiController.dart';
import 'package:tamahaem/transition/AnimationPageRoute.dart';

class ActionButton extends StatefulWidget {
  int index = 0;

  ActionButton({Key? key, required this.index}) : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return button(context);
  }

  Widget button(BuildContext context) {
    return GestureDetector(
        onTapDown: (TapDownDetails) {
          setState(() {
            pressed = true;
          });
        },
        onTapUp: (TapUpDetails) {
          setState(() {
            pressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            pressed = false;
          });
        },
        onTap: () {
          AbstractAction action = ActionHandler().getAction(widget.index);
          Navigator.of(context).pop(true);
          Navigator.of(context).push(
            AnimationPageRoute(
              currentScreen: widget,
              nextScreen: action,
              transitionColor: action.transitionColor
            ),
          );

          action.doAction();
        },
        child: Stack(
          children: [
            Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: pressed
                            ? AssetImage(
                                "assets/images/button/${widget.index}_pressed.png")
                            : AssetImage(
                                "assets/images/button/${widget.index}_default.png"),
                        fit: BoxFit.cover)),
                child: null),
            Positioned(
              top: 15,
              left: 15,
              bottom: 25,
              right: 15,
              //TODO: 버튼 클릭에 따라 아이콘이 움직이던가, 아니면 버튼이랑 아이콘이 한쌍이어야 함.
              child: pressed
                  ? Image.asset(
                      "assets/images/icon/tile00${widget.index}.png",
                      fit: BoxFit.fill,
                      color: Colors.black.withOpacity(0.1),
                    )
                  : Image.asset(
                      "assets/images/icon/tile00${widget.index}.png",
                      fit: BoxFit.fill,
                    ),
            )
          ],
        ));
  }
}
