// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:flutter/material.dart';

class OrderProgressCell extends StatelessWidget {
  String stepTitle;
  String? stepDescription;
  String? stepDate;
  bool? isLastStep;
  OrderProgressCell({
    Key? key,
    required this.stepTitle,
    this.stepDescription,
    this.stepDate,
    this.isLastStep = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Text(
              stepDate ?? "",
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
        Column(
          children: [
            CircleAvatar(
              backgroundColor:
                  stepDate == null ? Colors.grey.shade300 : Colors.black,
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
              radius: 20,
            ),
            if (!isLastStep!)
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                width: 2,
                height: 70,
                color: Colors.grey.shade300,
              )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 9),
                child: Text(
                  stepTitle,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                )),
            Container(
                width: context.screenWidth / 2,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  stepDescription ?? "",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                )),
          ],
        ),
      ],
    );
  }
}
