import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  void Function()? buttonFunction;
  String buttonName;
  late Color buttonColor;

  CustomAppButton({this.buttonFunction, required this.buttonName}) {
    buttonColor = Colors.grey.shade100;
  }

  CustomAppButton.white({this.buttonFunction, required this.buttonName}) {
    buttonColor = Colors.white;
  }
  CustomAppButton.black({this.buttonFunction, required this.buttonName}) {
    buttonColor = Colors.black;
  }

  double? screenWidth;
  double? screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: buttonFunction,
      child: FittedBox(
          child: Text(
        buttonName,
        style: TextStyle(
            fontFamily: 'Source Sans Pro',
            fontWeight: kIsWeb ? FontWeight.bold : FontWeight.w500,
            color: buttonColor == Colors.black ? Colors.white : Colors.black,
            fontSize: kIsWeb ? 18 : 16),
      )),
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.black,
        primary: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        fixedSize: Size(screenWidth! / 1.5, screenHeight! / 17.5),
      ),
    );
  }
}
