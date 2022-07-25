import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/widgets/app_toggle_button.dart';
import 'package:flutter/material.dart';

class AppFilter extends StatefulWidget {
  AppFilter({Key? key, required this.items}) : super(key: key);
  List<dynamic> items;
  @override
  State<AppFilter> createState() => _AppFilterState();
}

class _AppFilterState extends State<AppFilter> {
  dynamic selecteItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selecteItem = widget.items.first;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _getToggleList(),
    );
  }

  _getToggleList() {
    List<Widget> toggleList = [];
    widget.items.forEach((element) {
    
    });
    return toggleList;
  }
}
