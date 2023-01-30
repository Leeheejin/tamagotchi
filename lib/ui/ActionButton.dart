
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamahaem/utils/TamagotchiMap.dart';

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
          Navigator.push(context, MaterialPageRoute(builder: (context) => TamagotchiMap().actionButtonMap[widget.index]!));
        },

        child: Stack(
          children: [
            Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: pressed ? AssetImage("assets/images/button/${widget.index}_pressed.png")
                            : AssetImage("assets/images/button/${widget.index}_default.png"),
                        fit:BoxFit.cover
                    )
                ),
                child: null
            ),
            Positioned(
              top: 15,
              left: 15,
              bottom: 25,
              right: 15,
              //TODO: 버튼 클릭에 따라 아이콘이 움직이던가, 아니면 버튼이랑 아이콘이 한쌍이어야 함.
              child: pressed ? Image.asset("assets/images/icon/tile00${widget.index}.png", fit: BoxFit.fill, color: Colors.black.withOpacity(0.1),)
                  : Image.asset("assets/images/icon/tile00${widget.index}.png", fit: BoxFit.fill,),
            )
          ],
        )
    );
  }
}
