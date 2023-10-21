
import 'package:flutter/material.dart';
import 'package:tamahaem/action/AbstractAction.dart';
import 'package:tamahaem/action/ActionHandler.dart';

class DefaultAction extends AbstractAction {

  @override
  _DefaultActionState createState() => _DefaultActionState();

  @override
  void action() {
    // Do nothing
  }
}

class _DefaultActionState extends State<DefaultAction> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}