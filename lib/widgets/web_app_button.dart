// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WebAppButton extends StatelessWidget {
  bool isRed;
  String buttonTitle;
  Function buttonFunction;
  WebAppButton({
    Key? key,
    required this.isRed,
    required this.buttonTitle,
    required this.buttonFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          buttonFunction();
        },
        child: Container(
            alignment: Alignment.center,
            height: 43,
            width: 130,
            color: isRed ? Colors.red.shade400 : Colors.black,
            child: Text(
              buttonTitle,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            )));
  }
}
