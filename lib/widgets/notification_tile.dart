import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/data/model/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  NotificationTile({Key? key, required this.notificationModel})
      : super(key: key);
  NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.notifications),
            Text(
              notificationModel.content,
              maxLines: 4,
              softWrap: true,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            kGetFormattedDate(notificationModel.date, true),
            style: TextStyle(fontSize: 12),
          ),
        ),
        Divider(
          thickness: 0.7,
          color: Colors.grey.shade500,
          height: 25,
        ),
      ],
    );
  }
}
