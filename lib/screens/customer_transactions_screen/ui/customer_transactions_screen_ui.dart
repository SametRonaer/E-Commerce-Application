import 'package:alfa_application/data/model/transaction_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/transactions_cubit/cubit/transactions_cubit.dart';
import 'package:alfa_application/widgets/app_bottom_navigation_bar.dart';
import 'package:alfa_application/widgets/order_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CustomerTransactionsScreen extends StatelessWidget {
  CustomerTransactionsScreen({Key? key}) : super(key: key);
  static const routeName = "/cutomer-transactions-screen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(Colors.grey.shade300),
            backgroundColor: Colors.black,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.black,
              title: Text(
                "Orders".tr,
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 12),
                      child: Text(
                        "Orders".tr.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1.5,
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: context
                              .read<TransactionsCubit>()
                              .filteredTransactions
                              .length,
                          itemBuilder: ((context, index) {
                            TransactionModel transaction = context
                                .read<TransactionsCubit>()
                                .filteredTransactions[index];
                            return OrderListTile(transactionModel: transaction);
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
