import 'package:flutter/material.dart';

class DropDownButtonWithBorders extends StatefulWidget {
  const DropDownButtonWithBorders({ Key? key }) : super(key: key);

  @override
  _DropDownButtonWithBordersState createState() => _DropDownButtonWithBordersState();
}

class _DropDownButtonWithBordersState extends State<DropDownButtonWithBorders> {
  double? screenWidth;
  double? screenHeight;
  String _dropDownValue = "-Select-";

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
     return Stack(
     children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5), 
         height: screenHeight!/20,
         alignment: Alignment.center,
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade400)),
         padding: const EdgeInsets.symmetric(vertical: 5), ),
       DropdownButton(
          hint: _dropDownValue == null
              ? Text('Dropdown')
              : Text(
                  _dropDownValue,
                  style: TextStyle(color: Colors.black),
                ),
          isExpanded: true,
          iconSize: 30.0,
          icon: Icon(Icons.keyboard_arrow_down),
          style: TextStyle(color: Colors.black),
          items: ['One', 'Two', 'Three'].map(
            (val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            },
          ).toList(),
          onChanged: (val) {
            setState(
              () {
                _dropDownValue = val.toString();
              },
            );
          },
        ),
     ],
   );
  }
}