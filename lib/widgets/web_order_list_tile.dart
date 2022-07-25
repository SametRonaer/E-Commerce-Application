// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alfa_application/data/model/transaction_model.dart';
import 'package:alfa_application/general_cubits/transactions_cubit/cubit/transactions_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/cart_screen/cubit/cart_screen_cubit.dart';
import 'package:alfa_application/screens/order_progress_screen/ui/order_progress_screen_ui.dart';
import 'package:alfa_application/screens/order_progress_screen/ui/web_order_progress_screen_ui.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import '../constants/enums.dart';

class WebOrderListTile extends StatelessWidget {
  TransactionModel transactionModel;
  bool? isEmployee;
  WebOrderListTile(
      {Key? key, required this.transactionModel, this.isEmployee = false})
      : super(key: key);

  TextStyle _transactionTextStyle = TextStyle(
      fontSize: 15, color: Colors.grey.shade700, fontWeight: FontWeight.w600);
  TextStyle _transactionSubtitleTextStyle = TextStyle(
      fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transactionModel.customerName ?? "Empty",
                          maxLines: 1,
                          softWrap: true,
                          style: _transactionTextStyle),
                      Text(
                        transactionModel.customerId,
                        maxLines: 1,
                        softWrap: true,
                        style: _transactionSubtitleTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactionModel.transactionId,
                        maxLines: 1,
                        softWrap: true,
                        style: _transactionTextStyle,
                      ),
                      _getProductsDataField(),
                    ],
                  ),
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
                    context
                        .read<WebHomeCubit>()
                        .switchCurrentScreen(WebOrderProgressScreen());
                  },
                  child: FittedBox(
                    child: Container(
                        color: Colors.black,
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "View".tr,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )),
                  ),
                ),
              )
            ],
          ),
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

  Widget _getStatusArea() {
    String status = "";
    if (transactionModel.transactionStatus == 0.0) {
      status = "Wait to confirm";
    } else if (transactionModel.transactionStatus == 1.0) {
      status = "Confirmed";
    } else if (transactionModel.transactionStatus == 2.0) {
      status = "Wait for purchase";
    } else if (transactionModel.transactionStatus == 3.0) {
      status = "Started to prepare";
    } else if (transactionModel.transactionStatus == 4.0) {
      status = "Send";
    } else if (transactionModel.transactionStatus == 5.0) {
      status = "Completed";
    } else if (transactionModel.transactionStatus == 6.0) {
      status = "Cancelled";
    } else if (transactionModel.transactionStatus == 7.0) {
      status = "Not Confirmed";
    } else {
      status = "Sipariş\nTamamlandı";
    }
    return SizedBox(
      width: 120,
      child: Text(
        status,
        style: _transactionTextStyle,
      ),
    );
  }

  Column _getTransactionDateArea() {
    DateTime transactionDate = DateTime.parse(transactionModel.transactionDate);

    final formattedDate =
        "${transactionDate.day.toString()}.${transactionDate.month}.${transactionDate.year.toString()}";

    final formattedHour =
        "${transactionDate.hour.toString()}:${transactionDate.minute.toString()}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(formattedDate, style: _transactionTextStyle),
        ),
        FittedBox(
          child: Text(
            formattedHour,
            style: _transactionSubtitleTextStyle,
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
            style: _transactionSubtitleTextStyle,
          ),
        ),
      ),
    );
    return Column(children: productDataList);
  }
}
