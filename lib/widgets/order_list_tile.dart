// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alfa_application/data/model/transaction_model.dart';
import 'package:alfa_application/general_cubits/transactions_cubit/cubit/transactions_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/cart_screen/cubit/cart_screen_cubit.dart';
import 'package:alfa_application/screens/order_progress_screen/ui/order_progress_screen_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import '../constants/enums.dart';

class OrderListTile extends StatelessWidget {
  TransactionModel transactionModel;
  bool? isEmployee;
  OrderListTile(
      {Key? key, required this.transactionModel, this.isEmployee = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isEmployee!)
              Flexible(
                flex: 3,
                child: Text(
                  transactionModel.transactionId,
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 9,
                  ),
                ),
              ),
            if (isEmployee!)
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      transactionModel.customerId,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      transactionModel.customerId,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  if (isEmployee!)
                    Text(
                      transactionModel.transactionId,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500),
                    ),
                  _getProductsDataField(),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: _getTransactionDateArea(),
            ),
            Flexible(
              flex: 3,
              child: _getStatusArea(),
            ),
            Flexible(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  context
                      .read<TransactionsCubit>()
                      .setSelectedTransaction(transactionModel);
                  Navigator.of(context)
                      .pushNamed(OrderProgressScreen.routeName);
                },
                child: FittedBox(
                  child: Container(
                      color: Colors.black,
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "View".tr,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 6, left: 6, top: 18),
          child: Divider(
            thickness: 0.7,
          ),
        )
      ],
    );
  }

  FittedBox _getStatusArea() {
    String status = "";
    if (transactionModel.transactionStatus == 0.0) {
      status = TransactionStatuses.WaitToConfirm.toString().tr;
    } else if (transactionModel.transactionStatus == 1.0) {
      status = TransactionStatuses.Confirmed.toString().tr;
    } else if (transactionModel.transactionStatus == 2.0) {
      status = TransactionStatuses.WaitForPurchase.toString().tr;
    } else if (transactionModel.transactionStatus == 3.0) {
      status = TransactionStatuses.StartToPrepare.toString().tr;
    } else if (transactionModel.transactionStatus == 4.0) {
      status = TransactionStatuses.Send.toString().tr;
    } else if (transactionModel.transactionStatus == 5.0) {
      status = TransactionStatuses.Completed.toString().tr;
    } else if (transactionModel.transactionStatus == 6.0) {
      status = TransactionStatuses.Cancelled.toString().tr;
    } else if (transactionModel.transactionStatus == 7.0) {
      status = TransactionStatuses.NotConfirmed.toString().tr;
    } else {
      status = "Sipariş\nTamamlandı";
    }
    return FittedBox(
      child: Text(
        status,
        style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
      ),
    );
  }

  Column _getTransactionDateArea() {
    // print(transactionDate);
    DateTime transactionDate = DateTime.parse(transactionModel.transactionDate);
    //print(formattedDate);

    final formattedDate =
        "${transactionDate.day.toString()}.${transactionDate.month}.${transactionDate.year.toString()}";
    print(formattedDate);
    final formattedHour =
        "${transactionDate.hour.toString()}:${transactionDate.minute.toString()}";
    print(formattedHour);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            formattedDate,
            style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500),
          ),
        ),
        FittedBox(
          child: Text(
            formattedHour,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
          ),
        ),
      ],
    );
  }

  Column _getProductsDataField() {
    List<Widget> productDataList = [];
    transactionModel.productsInfo.forEach(
      (element) => productDataList.add(
        FittedBox(
          child: Text(
            element,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
          ),
        ),
      ),
    );
    return Column(children: productDataList);
  }
}
