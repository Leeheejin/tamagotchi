import 'package:flutter/material.dart';
import 'package:tamahaem/controller/ui/menu/ActionButton.dart';

class ActionDialog extends StatefulWidget {
  const ActionDialog({Key? key}) : super(key: key);

  @override
  _ActionDialogState createState() => _ActionDialogState();
}

class _ActionDialogState extends State<ActionDialog> {
  @override
  Widget build(BuildContext context) {
    return _dialog(context);
  }

  Widget _background(BuildContext context) {
    return const Image(
      image: AssetImage("assets/images/background/dialogBackground.png"),
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
    );
  }

  Widget _dialog(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: MediaQuery.of(context).size.height * 0.5,
        left: 0,
        right: 0,
        bottom: 0,
        child: _background(context),
      ),
      SimpleDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.35,
                child: dialogAnimation(context))
          ])
    ]);
  }

  Widget dialogAnimation(BuildContext context) {
    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, i) => GridView.builder(
        padding: const EdgeInsets.all(25),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 0,
          childAspectRatio: 1,
        ),
        itemCount: 4,
        primary: false,
        itemBuilder: (context, index) => Row(
          children: [
            ActionButton(index: index),
          ],
        ),
      ),
    );
  }
}
