import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/data/model/employee_model.dart';
import 'package:alfa_application/data/model/notification_model.dart';
import 'package:alfa_application/data/model/profile_abstract_model.dart';
import 'package:alfa_application/general_cubits/customers_cubit/cubit/customers_cubit.dart';
import 'package:alfa_application/general_cubits/employee_cubit/cubit/employee_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import "package:dio/dio.dart";
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  List<NotificationModel> _userNotifications = [];
  List<NotificationModel> get userNotifications => _userNotifications;

  Future<void> _sendFakeNotification() async {
    try {
      var response = await Dio().get(
          "*********************************",
          queryParameters: {
            "userFcm": 123,
            "message": "sas",
            "title": "dsd",
            "token": "d",
          });
      log(response.data.toString());
    } catch (e) {}
  }

  Future<void> sendNotificationToUser(
      {required String? userFcm,
      required String message,
      required String title}) async {
    if (userFcm != null) {
      try {
        await _sendFakeNotification();
      } catch (e) {}

      var response = await Dio().get(
          "*********************************",
          queryParameters: {
            "userFcm": userFcm,
            "message": message,
            "title": title,
            "token": "*************",
          });
      log(response.data.toString());
    }
  }

  Future<void> sendNotificationToEmployees(
      {required String customerName,
      required BuildContext context,
      String? title,
      String? message,
      bool isCancel = false}) async {
    await context.read<EmployeeCubit>().getAllEmployees();
    List<EmployeeModel> employees = context.read<EmployeeCubit>().allEmployees;

// !isCancel situation only works here. It should fixed
    if (!isCancel) {
      await Future.forEach(employees, (element) async {
        if ((element as EmployeeModel).fcm != null) {
          var response = await Dio().get(
              "https://us-central1-alfaapplication-4b601.cloudfunctions.net/senNotification",
              queryParameters: {
                "userFcm": element.fcm,
                "message":
                    message ?? "$customerName isimli kullanıcı sipariş verdi.",
                "title": title ?? "Yeni sipariş geldi!",
                "token": "AlfaNotification.123",
              });
          NotificationModel notification = NotificationModel(
              content: message ?? "$customerName sipariş verdi.",
              date: DateTime.now());
          int unreadMessages = element.unreadMessages ?? 0;
          List<dynamic> notifications = element.notifications ?? [];
          notifications = [
            notification.toMap(),
            ...notifications.map((e) => e.toMap())
          ];
          await context
              .read<EmployeeCubit>()
              .updateEmployee(employeeId: element.employeeId, newData: {
            "unreadMessages": ++unreadMessages,
            "notifications": notifications,
          });
          log(response.data.toString());
        }
      });
    }
  }

  Future<void> resetUnreadNotificationAmount(BuildContext context) async {
    Profile userProfile = context.read<ProfileCubit>().userProfile!;
    if (userProfile is CustomerModel) {
      context.read<CustomersCubit>().updateCustomer(
          newData: {"unreadMessages": 0}, userId: userProfile.userId);
    } else if (userProfile is EmployeeModel) {
      context.read<EmployeeCubit>().updateEmployee(
          newData: {"unreadMessages": 0}, employeeId: userProfile.employeeId);
    }
    await context
        .read<ProfileCubit>()
        .detectAndSetUserProfile(userProfile.email);
  }

  Future<void> setUserNotifications(BuildContext context) async {
    bool isCustomer = context.read<ProfileCubit>().isCustomer!;
    if (isCustomer) {
      _userNotifications =
          (context.read<ProfileCubit>().userProfile as CustomerModel)
              .notifications!;
    } else {
      _userNotifications =
          (context.read<ProfileCubit>().userProfile as EmployeeModel)
              .notifications!;
    }
    emit(NotificationLoaded());
  }
}
