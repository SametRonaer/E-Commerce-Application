// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:alfa_application/data/model/notification_model.dart';
import 'package:alfa_application/data/model/profile_abstract_model.dart';

class CustomerModel extends Profile {
  String? customerId;
  String? customeCode;
  String? customeGroup;
  String? fcm;
  int? unreadMessages;
  String? customerMobilePhoneNumber;
  String? customerPhoneNumber;
  String? customerCompanyName;
  String? customerCompanyTitle;
  String? customerCountry;
  String? customerCity;
  String? customerAdress;
  String? customerCompanyPhoneNumber;
  String? customerCompanyMobilePhoneNumber;
  String? customerCompanyMailAdress;
  String? customerCompanyWebsite;
  String? customerPrivateNote;
  String userId;
  String userType;
  String userName;
  String userSurName;
  String userEmail;
  String userPassword;
  String customerImageUrl;
  List<dynamic> customerFavoriteProductIds;
  List<dynamic> customerTransactions;
  List<dynamic> customerCartProducts;
  List<NotificationModel>? notifications;
  String? customerMembershipDate;
  String? customerTeam;
  String? postCode;
  CustomerModel({
    this.customerMembershipDate,
    this.customerTeam,
    this.postCode,
    this.customerId,
    this.customeCode,
    this.customeGroup,
    this.fcm,
    this.unreadMessages,
    this.customerMobilePhoneNumber,
    this.customerPhoneNumber,
    this.customerCompanyName,
    this.customerCompanyTitle,
    this.customerCountry,
    this.customerCity,
    this.customerAdress,
    this.customerCompanyPhoneNumber,
    this.customerCompanyMobilePhoneNumber,
    this.customerCompanyMailAdress,
    this.customerCompanyWebsite,
    this.customerPrivateNote,
    required this.userId,
    required this.userType,
    required this.userName,
    required this.userSurName,
    required this.userEmail,
    required this.userPassword,
    required this.customerImageUrl,
    required this.customerFavoriteProductIds,
    required this.customerTransactions,
    required this.customerCartProducts,
    this.notifications,
  }) : super(
            name: userName,
            surName: userSurName,
            userType: userType,
            email: userEmail,
            password: userPassword);

  CustomerModel copyWith({
    String? customerId,
    String? customeCode,
    String? customeGroup,
    String? fcm,
    int? unreadMessages,
    String? customerMobilePhoneNumber,
    String? customerPhoneNumber,
    String? customerCompanyName,
    String? customerCompanyTitle,
    String? customerCountry,
    String? customerCity,
    String? customerAdress,
    String? customerCompanyPhoneNumber,
    String? customerCompanyMobilePhoneNumber,
    String? customerCompanyMailAdress,
    String? customerCompanyWebsite,
    String? customerPrivateNote,
    String? userId,
    String? userType,
    String? userName,
    String? userSurName,
    String? userEmail,
    String? userPassword,
    String? customerImageUrl,
    List<dynamic>? customerFavoriteProductIds,
    List<dynamic>? customerTransactions,
    List<dynamic>? customerCartProducts,
    List<NotificationModel>? notifications,
  }) {
    return CustomerModel(
      customerId: customerId ?? this.customerId,
      customeCode: customeCode ?? this.customeCode,
      customeGroup: customeGroup ?? this.customeGroup,
      fcm: fcm ?? this.fcm,
      unreadMessages: unreadMessages ?? this.unreadMessages,
      customerMobilePhoneNumber:
          customerMobilePhoneNumber ?? this.customerMobilePhoneNumber,
      customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
      customerCompanyName: customerCompanyName ?? this.customerCompanyName,
      customerCompanyTitle: customerCompanyTitle ?? this.customerCompanyTitle,
      customerCountry: customerCountry ?? this.customerCountry,
      customerCity: customerCity ?? this.customerCity,
      customerAdress: customerAdress ?? this.customerAdress,
      customerCompanyPhoneNumber:
          customerCompanyPhoneNumber ?? this.customerCompanyPhoneNumber,
      customerCompanyMobilePhoneNumber: customerCompanyMobilePhoneNumber ??
          this.customerCompanyMobilePhoneNumber,
      customerCompanyMailAdress:
          customerCompanyMailAdress ?? this.customerCompanyMailAdress,
      customerCompanyWebsite:
          customerCompanyWebsite ?? this.customerCompanyWebsite,
      customerPrivateNote: customerPrivateNote ?? this.customerPrivateNote,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      userName: userName ?? this.userName,
      userSurName: userSurName ?? this.userSurName,
      userEmail: userEmail ?? this.userEmail,
      userPassword: userPassword ?? this.userPassword,
      customerImageUrl: customerImageUrl ?? this.customerImageUrl,
      customerFavoriteProductIds:
          customerFavoriteProductIds ?? this.customerFavoriteProductIds,
      customerTransactions: customerTransactions ?? this.customerTransactions,
      customerCartProducts: customerCartProducts ?? this.customerCartProducts,
      notifications: notifications ?? this.notifications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerId': customerId,
      'customeCode': customeCode,
      'customeGroup': customeGroup,
      'customerMembershipDate': customerMembershipDate,
      'postCode': postCode,
      'customerTeam': customerTeam,
      'fcm': fcm,
      'unreadMessages': unreadMessages,
      'customerMobilePhoneNumber': customerMobilePhoneNumber,
      'customerPhoneNumber': customerPhoneNumber,
      'customerCompanyName': customerCompanyName,
      'customerCompanyTitle': customerCompanyTitle,
      'customerCountry': customerCountry,
      'customerCity': customerCity,
      'customerAdress': customerAdress,
      'customerCompanyPhoneNumber': customerCompanyPhoneNumber,
      'customerCompanyMobilePhoneNumber': customerCompanyMobilePhoneNumber,
      'customerCompanyMailAdress': customerCompanyMailAdress,
      'customerCompanyWebsite': customerCompanyWebsite,
      'customerPrivateNote': customerPrivateNote,
      'userId': userId,
      'userType': userType,
      'userName': userName,
      'userSurName': userSurName,
      'userEmail': userEmail,
      'userPassword': userPassword,
      'customerImageUrl': customerImageUrl,
      'customerFavoriteProductIds': customerFavoriteProductIds,
      'customerTransactions': customerTransactions,
      'customerCartProducts': customerCartProducts,
      'notifications': notifications != null
          ? notifications!.map((x) => x.toMap()).toList()
          : [],
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      customerId:
          map['customerId'] != null ? map['customerId'] as String : null,
      customeCode:
          map['customeCode'] != null ? map['customeCode'] as String : null,
      customeGroup:
          map['customeGroup'] != null ? map['customeGroup'] as String : null,
      fcm: map['fcm'] != null ? map['fcm'] as String : null,
      unreadMessages:
          map['unreadMessages'] != null ? map['unreadMessages'] as int : null,
      customerMobilePhoneNumber: map['customerMobilePhoneNumber'] != null
          ? map['customerMobilePhoneNumber'] as String
          : null,
      customerPhoneNumber:
          map['postCode'] != null ? map['postCode'] as String : null,
      customerMembershipDate: map['customerMembershipDate'] != null
          ? map['customerMembershipDate'] as String
          : null,
      customerTeam:
          map['customerTeam'] != null ? map['customerTeam'] as String : null,
      postCode: map['customerPhoneNumber'] != null
          ? map['customerPhoneNumber'] as String
          : null,
      customerCompanyName: map['customerCompanyName'] != null
          ? map['customerCompanyName'] as String
          : null,
      customerCompanyTitle: map['customerCompanyTitle'] != null
          ? map['customerCompanyTitle'] as String
          : null,
      customerCountry: map['customerCountry'] != null
          ? map['customerCountry'] as String
          : null,
      customerCity:
          map['customerCity'] != null ? map['customerCity'] as String : null,
      customerAdress: map['customerAdress'] != null
          ? map['customerAdress'] as String
          : null,
      customerCompanyPhoneNumber: map['customerCompanyPhoneNumber'] != null
          ? map['customerCompanyPhoneNumber'] as String
          : null,
      customerCompanyMobilePhoneNumber:
          map['customerCompanyMobilePhoneNumber'] != null
              ? map['customerCompanyMobilePhoneNumber'] as String
              : null,
      customerCompanyMailAdress: map['customerCompanyMailAdress'] != null
          ? map['customerCompanyMailAdress'] as String
          : null,
      customerCompanyWebsite: map['customerCompanyWebsite'] != null
          ? map['customerCompanyWebsite'] as String
          : null,
      customerPrivateNote: map['customerPrivateNote'] != null
          ? map['customerPrivateNote'] as String
          : null,
      userId: map['userId'] as String,
      userType: map['userType'] as String,
      userName: map['userName'] as String,
      userSurName: map['userSurName'] as String,
      userEmail: map['userEmail'] as String,
      userPassword: map['userPassword'] as String,
      customerImageUrl: map['customerImageUrl'] as String,
      customerFavoriteProductIds: List<dynamic>.from(
          (map['customerFavoriteProductIds'] as List<dynamic>)),
      customerTransactions:
          List<dynamic>.from((map['customerTransactions'] as List<dynamic>)),
      customerCartProducts:
          List<dynamic>.from((map['customerCartProducts'] as List<dynamic>)),
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

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerModel(customerId: $customerId, customeCode: $customeCode, customeGroup: $customeGroup, fcm: $fcm, unreadMessages: $unreadMessages, customerMobilePhoneNumber: $customerMobilePhoneNumber, customerPhoneNumber: $customerPhoneNumber, customerCompanyName: $customerCompanyName, customerCompanyTitle: $customerCompanyTitle, customerCountry: $customerCountry, customerCity: $customerCity, customerAdress: $customerAdress, customerCompanyPhoneNumber: $customerCompanyPhoneNumber, customerCompanyMobilePhoneNumber: $customerCompanyMobilePhoneNumber, customerCompanyMailAdress: $customerCompanyMailAdress, customerCompanyWebsite: $customerCompanyWebsite, customerPrivateNote: $customerPrivateNote, userId: $userId, userType: $userType, userName: $userName, userSurName: $userSurName, userEmail: $userEmail, userPassword: $userPassword, customerImageUrl: $customerImageUrl, customerFavoriteProductIds: $customerFavoriteProductIds, customerTransactions: $customerTransactions, customerCartProducts: $customerCartProducts, notifications: $notifications)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerModel &&
        other.customerId == customerId &&
        other.customeCode == customeCode &&
        other.customeGroup == customeGroup &&
        other.fcm == fcm &&
        other.unreadMessages == unreadMessages &&
        other.customerMobilePhoneNumber == customerMobilePhoneNumber &&
        other.customerPhoneNumber == customerPhoneNumber &&
        other.customerCompanyName == customerCompanyName &&
        other.customerCompanyTitle == customerCompanyTitle &&
        other.customerCountry == customerCountry &&
        other.customerCity == customerCity &&
        other.customerAdress == customerAdress &&
        other.customerCompanyPhoneNumber == customerCompanyPhoneNumber &&
        other.customerCompanyMobilePhoneNumber ==
            customerCompanyMobilePhoneNumber &&
        other.customerCompanyMailAdress == customerCompanyMailAdress &&
        other.customerCompanyWebsite == customerCompanyWebsite &&
        other.customerPrivateNote == customerPrivateNote &&
        other.userId == userId &&
        other.userType == userType &&
        other.userName == userName &&
        other.userSurName == userSurName &&
        other.userEmail == userEmail &&
        other.userPassword == userPassword &&
        other.customerImageUrl == customerImageUrl &&
        listEquals(
            other.customerFavoriteProductIds, customerFavoriteProductIds) &&
        listEquals(other.customerTransactions, customerTransactions) &&
        listEquals(other.customerCartProducts, customerCartProducts) &&
        listEquals(other.notifications, notifications);
  }

  @override
  int get hashCode {
    return customerId.hashCode ^
        customeCode.hashCode ^
        customeGroup.hashCode ^
        fcm.hashCode ^
        unreadMessages.hashCode ^
        customerMobilePhoneNumber.hashCode ^
        customerPhoneNumber.hashCode ^
        customerCompanyName.hashCode ^
        customerCompanyTitle.hashCode ^
        customerCountry.hashCode ^
        customerCity.hashCode ^
        customerAdress.hashCode ^
        customerCompanyPhoneNumber.hashCode ^
        customerCompanyMobilePhoneNumber.hashCode ^
        customerCompanyMailAdress.hashCode ^
        customerCompanyWebsite.hashCode ^
        customerPrivateNote.hashCode ^
        userId.hashCode ^
        userType.hashCode ^
        userName.hashCode ^
        userSurName.hashCode ^
        userEmail.hashCode ^
        userPassword.hashCode ^
        customerImageUrl.hashCode ^
        customerFavoriteProductIds.hashCode ^
        customerTransactions.hashCode ^
        customerCartProducts.hashCode ^
        notifications.hashCode;
  }
}
