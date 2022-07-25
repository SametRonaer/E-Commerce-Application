import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/notification_cubit/cubit/notification_cubit.dart';
import 'package:alfa_application/widgets/app_bottom_navigation_bar.dart';
import 'package:alfa_application/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class WebNotificationsScreen extends StatelessWidget {
  WebNotificationsScreen({Key? key}) : super(key: key);

  late NotificationCubit _notificationCubit;

  @override
  Widget build(BuildContext context) {
    _notificationCubit = context.read<NotificationCubit>();
    _notificationCubit.setUserNotifications(context);
    return SafeArea(
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                width: 880,
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _notificationCubit.userNotifications.length == 0
                        ? Text(
                            "There is no notification message\nfor you.",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          )
                        : SizedBox(
                            height: context.screenHeight / 1.4,
                            child: ListView.builder(
                              itemBuilder: (_, i) => NotificationTile(
                                  notificationModel:
                                      _notificationCubit.userNotifications[i]),
                              itemCount:
                                  _notificationCubit.userNotifications.length,
                            ),
                          ),
                  ],
                ),
                height: context.screenHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ))),
          );
        },
      ),
    );
  }
}
