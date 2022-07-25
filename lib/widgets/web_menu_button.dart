// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WebMenuButton extends StatelessWidget {
  Function buttonFunction;
  IconData buttonIcon;
  String buttonLabel;
  WebMenuButton({
    Key? key,
    required this.buttonFunction,
    required this.buttonIcon,
    required this.buttonLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        buttonFunction();
      },
      child: Row(
        children: [
          Row(children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300),
              width: 150,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    buttonIcon,
                    size: 30,
                  ),
                  Text(
                    buttonLabel,
                  )
                ],
              ),
            )
          ]),
          SizedBox(width: 5),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            child: Text(
              "ADD\n&\nEDIT",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 9),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
