import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  final List<String> messages;
  final VoidCallback onFinished;

  ChatBox({required this.messages, required this.onFinished});

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  int currentMessageIndex = 0;

  void _handleTap() {
    setState(() {
      if (currentMessageIndex < widget.messages.length - 1) {
        currentMessageIndex++;
      } else {
        widget.onFinished();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Text(
          widget.messages[currentMessageIndex],
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}