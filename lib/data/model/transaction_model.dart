// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class TransactionModel {
  String transactionId;
  String transactionDate;
  String transactionTotalAmount;
  String? transactionNote;
  String? customerName;

  List<dynamic> transactionProductIds;
  List<dynamic> productsInfo;
  List<TransactionDetailModel> transactionDetails;
  String customerId;
  dynamic transactionStatus;
  TransactionModel({
    required this.transactionId,
    required this.transactionDate,
    required this.transactionTotalAmount,
    this.transactionNote,
    this.customerName,
    required this.transactionProductIds,
    required this.productsInfo,
    required this.transactionDetails,
    required this.customerId,
    required this.transactionStatus,
  });

  TransactionModel copyWith({
    String? transactionId,
    String? transactionDate,
    String? transactionTotalAmount,
    String? transactionNote,
    String? customerName,
    List<dynamic>? transactionProductIds,
    List<dynamic>? productsInfo,
    List<TransactionDetailModel>? transactionDetails,
    String? customerId,
    dynamic? transactionStatus,
  }) {
    return TransactionModel(
      transactionId: transactionId ?? this.transactionId,
      transactionDate: transactionDate ?? this.transactionDate,
      transactionTotalAmount:
          transactionTotalAmount ?? this.transactionTotalAmount,
      transactionNote: transactionNote ?? this.transactionNote,
      customerName: customerName ?? this.customerName,
      transactionProductIds:
          transactionProductIds ?? this.transactionProductIds,
      productsInfo: productsInfo ?? this.productsInfo,
      transactionDetails: transactionDetails ?? this.transactionDetails,
      customerId: customerId ?? this.customerId,
      transactionStatus: transactionStatus ?? this.transactionStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionId': transactionId,
      'transactionDate': transactionDate,
      'transactionTotalAmount': transactionTotalAmount,
      'transactionNote': transactionNote,
      'customerName': customerName,
      'transactionProductIds': transactionProductIds,
      'productsInfo': productsInfo,
      'transactionDetails': transactionDetails.map((x) => x.toMap()).toList(),
      'customerId': customerId,
      'transactionStatus': transactionStatus,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      transactionId: map['transactionId'] as String,
      transactionDate: map['transactionDate'] as String,
      transactionTotalAmount: map['transactionTotalAmount'] as String,
      transactionNote: map['transactionNote'] != null
          ? map['transactionNote'] as String
          : null,
      customerName:
          map['customerName'] != null ? map['customerName'] as String : null,
      transactionProductIds:
          List<dynamic>.from((map['transactionProductIds'] as List<dynamic>)),
      productsInfo: List<dynamic>.from((map['productsInfo'] as List<dynamic>)),
      transactionDetails: List<TransactionDetailModel>.from(
        (map['transactionDetails'] as List<dynamic>)
            .map<TransactionDetailModel>(
          (x) => TransactionDetailModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      customerId: map['customerId'] as String,
      transactionStatus: map['transactionStatus'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(transactionId: $transactionId, transactionDate: $transactionDate, transactionTotalAmount: $transactionTotalAmount, transactionNote: $transactionNote, customerName: $customerName, transactionProductIds: $transactionProductIds, productsInfo: $productsInfo, transactionDetails: $transactionDetails, customerId: $customerId, transactionStatus: $transactionStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.transactionId == transactionId &&
        other.transactionDate == transactionDate &&
        other.transactionTotalAmount == transactionTotalAmount &&
        other.transactionNote == transactionNote &&
        other.customerName == customerName &&
        listEquals(other.transactionProductIds, transactionProductIds) &&
        listEquals(other.productsInfo, productsInfo) &&
        listEquals(other.transactionDetails, transactionDetails) &&
        other.customerId == customerId &&
        other.transactionStatus == transactionStatus;
  }

  @override
  int get hashCode {
    return transactionId.hashCode ^
        transactionDate.hashCode ^
        transactionTotalAmount.hashCode ^
        transactionNote.hashCode ^
        customerName.hashCode ^
        transactionProductIds.hashCode ^
        productsInfo.hashCode ^
        transactionDetails.hashCode ^
        customerId.hashCode ^
        transactionStatus.hashCode;
  }
}

class TransactionDetailModel {
  String employeeNameWhoEdit;
  String employeeIdWhoEdit;
  DateTime editDate;
  int? transactionType;
  TransactionDetailModel({
    required this.employeeNameWhoEdit,
    required this.employeeIdWhoEdit,
    required this.editDate,
    this.transactionType,
  });

  TransactionDetailModel copyWith({
    String? employeeNameWhoEdit,
    String? employeeIdWhoEdit,
    DateTime? editDate,
    int? transactionType,
  }) {
    return TransactionDetailModel(
      employeeNameWhoEdit: employeeNameWhoEdit ?? this.employeeNameWhoEdit,
      employeeIdWhoEdit: employeeIdWhoEdit ?? this.employeeIdWhoEdit,
      editDate: editDate ?? this.editDate,
      transactionType: transactionType ?? this.transactionType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeNameWhoEdit': employeeNameWhoEdit,
      'employeeIdWhoEdit': employeeIdWhoEdit,
      'editDate': editDate.millisecondsSinceEpoch,
      'transactionType': transactionType,
    };
  }

  factory TransactionDetailModel.fromMap(Map<String, dynamic> map) {
    return TransactionDetailModel(
      employeeNameWhoEdit: map['employeeNameWhoEdit'] as String,
      employeeIdWhoEdit: map['employeeIdWhoEdit'] as String,
      editDate: DateTime.fromMillisecondsSinceEpoch(map['editDate'] as int),
      transactionType:
          map['transactionType'] != null ? map['transactionType'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionDetailModel.fromJson(String source) =>
      TransactionDetailModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionDetailModel(employeeNameWhoEdit: $employeeNameWhoEdit, employeeIdWhoEdit: $employeeIdWhoEdit, editDate: $editDate, transactionType: $transactionType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionDetailModel &&
        other.employeeNameWhoEdit == employeeNameWhoEdit &&
        other.employeeIdWhoEdit == employeeIdWhoEdit &&
        other.editDate == editDate &&
        other.transactionType == transactionType;
  }

  @override
  int get hashCode {
    return employeeNameWhoEdit.hashCode ^
        employeeIdWhoEdit.hashCode ^
        editDate.hashCode ^
        transactionType.hashCode;
  }
}
