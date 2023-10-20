import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  final AnimatedText message;
  final VoidCallback onTap;

  ChatBox({required this.message, required this.onTap});

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {

  void _handleTap() {
    widget.onTap();
  }

  Widget _background(BuildContext context) {

    return const Image(
      image: AssetImage("assets/images/background/chatBoxBackground.png"),
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _handleTap,
        child: Stack(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: _background(context)
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.height * 0.05,
                  child: AnimatedTextKit(
                      key: ValueKey(widget.message),
                      animatedTexts: [widget.message],
                      isRepeatingAnimation: false,
                      displayFullTextOnTap: true
                  )
              )
            ],
        )
    );
  }
}