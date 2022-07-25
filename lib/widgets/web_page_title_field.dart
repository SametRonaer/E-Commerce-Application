import 'package:alfa_application/widgets/web_app_button.dart';
import 'package:flutter/material.dart';

class WebPageTitleField extends StatelessWidget {
  WebPageTitleField(
      {Key? key,
      required this.pageTitle,
      required this.subTitle,
      this.blackButtonFunction,
      this.redButtonFunction,
      this.blackButtonTitle,
      this.redButtonTitle})
      : super(key: key);
  String pageTitle;
  String subTitle;
  Function? redButtonFunction;
  Function? blackButtonFunction;
  String? redButtonTitle;
  String? blackButtonTitle;
  double gapValue = 25;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: double.infinity),
        Text(pageTitle,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
        Divider(thickness: 3, color: Colors.grey.shade300),
        SizedBox(height: gapValue),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subTitle,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade400),
            ),
            Row(
              children: [
                if (redButtonFunction != null)
                  WebAppButton(
                      isRed: true,
                      buttonTitle: redButtonTitle ?? "REMOVE",
                      buttonFunction: () {
                        if (redButtonFunction != null) {
                          redButtonFunction!();
                        }
                      }),
                SizedBox(width: 15),
                if (blackButtonFunction != null)
                  WebAppButton(
                      isRed: false,
                      buttonTitle: blackButtonTitle ?? "SAVE",
                      buttonFunction: () {
                        if (blackButtonFunction != null) {
                          blackButtonFunction!();
                        }
                      }),
              ],
            )
          ],
        ),
        SizedBox(height: gapValue),
        Divider(thickness: 2, color: Colors.grey.shade300),
        SizedBox(height: gapValue),
      ],
    );
  }
}
