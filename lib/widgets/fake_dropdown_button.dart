// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FakeDropDownButton extends StatelessWidget {
  String? title;
  String hintText;
  String? initialText;
  String? selectedItem;
  TextStyle? textStyle;
  Function() dropDownFunction;
  FakeDropDownButton({
    Key? key,
    this.textStyle,
    this.title,
    this.initialText,
    required this.hintText,
    this.selectedItem,
    required this.dropDownFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: textStyle ??
                TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
        GestureDetector(
          onTap: dropDownFunction,
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        selectedItem ?? (initialText ?? hintText),
                        style: TextStyle(color: Colors.grey.shade700),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down)
                ],
              )),
        ),
      ],
    );
  }
}
