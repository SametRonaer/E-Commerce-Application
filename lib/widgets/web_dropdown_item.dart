// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WebDropdownItem extends StatelessWidget {
  Function dropDownFunction;
  String dropDownLabel;
  WebDropdownItem({
    Key? key,
    required this.dropDownFunction,
    required this.dropDownLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dropDownFunction();
      },
      child: Text(
        dropDownLabel,
        textAlign: TextAlign.start,
      ),
    );
  }
}
