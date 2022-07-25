import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/employee_home_screen/cubit/employee_home_screen_cubit.dart';
import 'package:alfa_application/widgets/order_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/transaction_model.dart';
import '../general_cubits/transactions_cubit/cubit/transactions_cubit.dart';

class EmployeeHomeTransactionsField extends StatelessWidget {
  EmployeeHomeScreenCubit employeeHomeScreenCubit;
  bool? isFullScreen;
  late List<TransactionModel> currentList;
  TransacationTabs currentTab = TransacationTabs.New;
  EmployeeHomeTransactionsField(
      {Key? key,
      required this.employeeHomeScreenCubit,
      this.isFullScreen = false})
      : super(key: key) {
    currentTab = employeeHomeScreenCubit.currentTab;
  }

  @override
  Widget build(BuildContext context) {
    employeeHomeScreenCubit.switchTab(currentTab, context);
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        return BlocBuilder<EmployeeHomeScreenCubit, EmployeeHomeScreenState>(
          builder: (context, state) {
            currentList = employeeHomeScreenCubit.transacationsList;
            currentTab = employeeHomeScreenCubit.currentTab;
            return Container(
              height: !isFullScreen! ? context.screenHeight / 2.2 : null,
              width: context.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
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
                        "ORDERS",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    employeeHomeScreenCubit.switchTab(
                                        TransacationTabs.New, context);
                                  },
                                  child: Text("New",
                                      style: TextStyle(
                                          color:
                                              currentTab == TransacationTabs.New
                                                  ? Colors.black
                                                  : Colors.grey.shade400,
                                          fontSize: 12))),
                              Text(
                                " | ",
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                              GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    employeeHomeScreenCubit.switchTab(
                                        TransacationTabs.Processing, context);
                                  },
                                  child: Text("Processing",
                                      style: TextStyle(
                                          color: currentTab ==
                                                  TransacationTabs.Processing
                                              ? Colors.black
                                              : Colors.grey.shade400,
                                          fontSize: 12))),
                              Text(
                                " | ",
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                              GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    employeeHomeScreenCubit.switchTab(
                                        TransacationTabs.Finished, context);
                                  },
                                  child: Text("Finished",
                                      style: TextStyle(
                                          color: currentTab ==
                                                  TransacationTabs.Finished
                                              ? Colors.black
                                              : Colors.grey.shade400,
                                          fontSize: 12))),
                            ],
                          ),
                          GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                employeeHomeScreenCubit.switchTab(
                                    TransacationTabs.All, context);
                              },
                              child: Text("See All",
                                  style: TextStyle(
                                      color: currentTab == TransacationTabs.All
                                          ? Colors.black
                                          : Colors.grey.shade400,
                                      fontSize: 12))),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    if (currentList.length != 0)
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: currentList.length,
                            itemBuilder: ((context, index) {
                              TransactionModel transaction = currentList[index];
                              return OrderListTile(
                                transactionModel: transaction,
                                isEmployee: true,
                              );
                            }),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
