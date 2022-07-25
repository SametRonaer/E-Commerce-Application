// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:alfa_application/extensions/screen_size_context.dart';

class ManagementMenuCell extends StatelessWidget {
  IconData iconData;
  String label;
  String? route;
  bool? isLarge;
  Function? buttonFunction;
  ManagementMenuCell({
    Key? key,
    required this.iconData,
    required this.label,
    this.route,
    this.buttonFunction,
    this.isLarge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (route != null) {
          Navigator.of(context).pushNamed(route!);
        } else {
          buttonFunction!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 0.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconData,
                    color: Colors.grey.shade500,
                    size: isLarge! ? 50 : 32,
                  ),
                  SizedBox(height: 2),
                  FittedBox(
                    child: Text(
                      label,
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              height: isLarge!
                  ? context.screenHeight / 6
                  : context.screenHeight / 11,
              width: isLarge!
                  ? context.screenHeight / 7
                  : context.screenHeight / 11,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6)),
            ),
            Container(
              padding: EdgeInsets.all(2),
              child: FittedBox(
                child: Text(
                  "+ Add/ Edit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              margin: EdgeInsets.only(top: 4),
              height: isLarge! ? 20 : 16,
              width: isLarge!
                  ? context.screenHeight / 7
                  : context.screenHeight / 11,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(4)),
            ),
          ],
        ),
      ),
    );
  }
}
