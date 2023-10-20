import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  final List<String> messages;
  final int currentMessageIndex;
  final VoidCallback onTap;

  ChatBox({required this.messages, required this.onTap, required this.currentMessageIndex});

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {

  void _handleTap() {
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child:
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Text(
          widget.messages[widget.currentMessageIndex],
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}