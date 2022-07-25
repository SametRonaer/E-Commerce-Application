import 'package:flutter/material.dart';

class AppToggleButton extends StatefulWidget {
  AppToggleButton(
      {Key? key,
      required this.toggleItem})
      : super(key: key);
  String toggleItem;
  @override
  State<AppToggleButton> createState() => _AppToggleButtonState();
}

class _AppToggleButtonState extends State<AppToggleButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
     
      },
     
    );
  }
}
