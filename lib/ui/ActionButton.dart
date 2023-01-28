
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

        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TamagotchiMap().actionButtonMap[0]));
        },
        // index 0번에 대한 버튼으로, 클릭시 0번에 해당하는 액션 뷰를 띄워줘야 한다. 코드는 0번임을 알지만 개발자는 0번이 무슨 액션인지 모른다. 그렇기에 코드상의 인덱스와 실제 액션을 매핑을 해줘야 한다.
        child: pressed ? Image.asset("assets/images/button/${widget.index}_pressed.png", width: 75, height: 75, fit: BoxFit.fill,)
            : Image.asset("assets/images/button/${widget.index}_default.png", width: 75, height: 75, fit: BoxFit.fill,)
    );
  }
}
