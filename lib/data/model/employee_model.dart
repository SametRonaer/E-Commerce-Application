// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:alfa_application/data/model/notification_model.dart';
import 'package:alfa_application/data/model/profile_abstract_model.dart';

class EmployeeModel extends Profile {
  String employeeName;
  String employeeSurName;
  String employeeId;
  String employeeCode;
  String employeeImageUrl;
  String employeeStatus;
  String employeeEmail;
  String employeePassword;
  String userType;
  String employeePhone;
  String? employeeNote;
  String? fcm;
  int? unreadMessages;
  List<NotificationModel>? notifications;
  EmployeeModel({
    required this.employeeName,
    required this.employeeSurName,
    required this.employeeId,
    required this.employeeCode,
    required this.employeeImageUrl,
    required this.employeeStatus,
    required this.employeeEmail,
    required this.employeePassword,
    required this.userType,
    required this.employeePhone,
    this.employeeNote,
    this.fcm,
    this.unreadMessages,
    this.notifications,
  }) : super(
            name: employeeName,
            surName: employeeSurName,
            password: employeePassword,
            email: employeeEmail,
            userType: userType);

  EmployeeModel copyWith({
    String? employeeName,
    String? employeeSurName,
    String? employeeId,
    String? employeeCode,
    String? employeeImageUrl,
    String? employeeStatus,
    String? employeeEmail,
    String? employeePassword,
    String? userType,
    String? employeePhone,
    String? employeeNote,
    String? fcm,
    int? unreadMessages,
    List<NotificationModel>? notifications,
  }) {
    return EmployeeModel(
      employeeName: employeeName ?? this.employeeName,
      employeeSurName: employeeSurName ?? this.employeeSurName,
      employeeId: employeeId ?? this.employeeId,
      employeeCode: employeeCode ?? this.employeeCode,
      employeeImageUrl: employeeImageUrl ?? this.employeeImageUrl,
      employeeStatus: employeeStatus ?? this.employeeStatus,
      employeeEmail: employeeEmail ?? this.employeeEmail,
      employeePassword: employeePassword ?? this.employeePassword,
      userType: userType ?? this.userType,
      employeePhone: employeePhone ?? this.employeePhone,
      employeeNote: employeeNote ?? this.employeeNote,
      fcm: fcm ?? this.fcm,
      unreadMessages: unreadMessages ?? this.unreadMessages,
      notifications: notifications ?? this.notifications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeName': employeeName,
      'employeeSurName': employeeSurName,
      'employeeId': employeeId,
      'employeeCode': employeeCode,
      'employeeImageUrl': employeeImageUrl,
      'employeeStatus': employeeStatus,
      'employeeEmail': employeeEmail,
      'employeePassword': employeePassword,
      'userType': userType,
      'employeePhone': employeePhone,
      'employeeNote': employeeNote,
      'fcm': fcm,
      'unreadMessages': unreadMessages,
      'notifications': notifications!.map((x) => x.toMap()).toList(),
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      employeeName: map['employeeName'] as String,
      employeeSurName: map['employeeSurName'] as String,
      employeeId: map['employeeId'] as String,
      employeeCode: map['employeeCode'] as String,
      employeeImageUrl: map['employeeImageUrl'] as String,
      employeeStatus: map['employeeStatus'] as String,
      employeeEmail: map['employeeEmail'] as String,
      employeePassword: map['employeePassword'] as String,
      userType: map['userType'] as String,
      employeePhone: map['employeePhone'] as String,
      employeeNote:
          map['employeeNote'] != null ? map['employeeNote'] as String : null,
      fcm: map['fcm'] != null ? map['fcm'] as String : null,
      unreadMessages:
          map['unreadMessages'] != null ? map['unreadMessages'] as int : null,
      notifications: map['notifications'] != null
          ? List<NotificationModel>.from(
              (map['notifications'] as List<dynamic>).map<NotificationModel?>(
                (x) => NotificationModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromJson(String source) =>
      EmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmployeeModel(employeeName: $employeeName, employeeSurName: $employeeSurName, employeeId: $employeeId, employeeCode: $employeeCode, employeeImageUrl: $employeeImageUrl, employeeStatus: $employeeStatus, employeeEmail: $employeeEmail, employeePassword: $employeePassword, userType: $userType, employeePhone: $employeePhone, employeeNote: $employeeNote, fcm: $fcm, unreadMessages: $unreadMessages, notifications: $notifications)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmployeeModel &&
        other.employeeName == employeeName &&
        other.employeeSurName == employeeSurName &&
        other.employeeId == employeeId &&
        other.employeeCode == employeeCode &&
        other.employeeImageUrl == employeeImageUrl &&
        other.employeeStatus == employeeStatus &&
        other.employeeEmail == employeeEmail &&
        other.employeePassword == employeePassword &&
        other.userType == userType &&
        other.employeePhone == employeePhone &&
        other.employeeNote == employeeNote &&
        other.fcm == fcm &&
        other.unreadMessages == unreadMessages &&
        listEquals(other.notifications, notifications);
  }

  @override
  int get hashCode {
    return employeeName.hashCode ^
        employeeSurName.hashCode ^
        employeeId.hashCode ^
        employeeCode.hashCode ^
        employeeImageUrl.hashCode ^
        employeeStatus.hashCode ^
        employeeEmail.hashCode ^
        employeePassword.hashCode ^
        userType.hashCode ^
        employeePhone.hashCode ^
        employeeNote.hashCode ^
        fcm.hashCode ^
        unreadMessages.hashCode ^
        notifications.hashCode;
  }
}
