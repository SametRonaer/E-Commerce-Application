// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class WebDropdownButton extends StatefulWidget {
  String dropdownValue;
  String dropdownTitle;
  Widget dropdownWidget;
  WebDropdownButton({
    Key? key,
    required this.dropdownValue,
    required this.dropdownTitle,
    required this.dropdownWidget,
  }) : super(key: key);

  @override
  State<WebDropdownButton> createState() => _WebDropdownButtonState();
}

class _WebDropdownButtonState extends State<WebDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.dropdownTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 40,
              alignment: Alignment.center,
              color: Colors.grey.shade200,
            ),
            DropdownButtonFormField(
                alignment: AlignmentDirectional.topStart,
                iconSize: 50,
                // isExpanded: true,
                itemHeight: null,
                //menuMaxHeight: 40,

                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey.shade600,
                ),
                dropdownColor: Color.fromRGBO(245, 245, 245, 1),
                value: widget.dropdownValue,
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
                elevation: 0,
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: widget.dropdownWidget,
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  print(newValue);

                  setState(() {
                    widget.dropdownValue = newValue ?? widget.dropdownValue;
                  });
                }),
          ],
        ),
      ],
    );
  }
}
