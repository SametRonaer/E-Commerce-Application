import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/employee_home_screen/cubit/employee_home_screen_cubit.dart';
import 'package:alfa_application/widgets/order_list_tile.dart';
import 'package:alfa_application/widgets/web_order_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/transaction_model.dart';
import '../general_cubits/transactions_cubit/cubit/transactions_cubit.dart';

class WebTransactionsListArea extends StatelessWidget {
  late EmployeeHomeScreenCubit _employeeHomeScreenCubit;

  late List<TransactionModel> currentList;
  TransacationTabs currentTab = TransacationTabs.New;
  WebTransactionsListArea({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _employeeHomeScreenCubit = context.read<EmployeeHomeScreenCubit>();
    currentTab = _employeeHomeScreenCubit.currentTab;
    _employeeHomeScreenCubit.switchTab(currentTab, context);
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        return BlocBuilder<EmployeeHomeScreenCubit, EmployeeHomeScreenState>(
          builder: (context, state) {
            currentList = _employeeHomeScreenCubit.transacationsList;
            currentTab = _employeeHomeScreenCubit.currentTab;
            return Container(
              padding: EdgeInsets.only(top: 8, left: 4),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 1.5,
                  ),
                  SizedBox(height: 15),
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
                                  _employeeHomeScreenCubit.switchTab(
                                      TransacationTabs.New, context);
                                },
                                child: Text("New",
                                    style: TextStyle(
                                        color:
                                            currentTab == TransacationTabs.New
                                                ? Colors.black
                                                : Colors.grey.shade400,
                                        fontSize: 18))),
                            Text(
                              " | ",
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                            GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  _employeeHomeScreenCubit.switchTab(
                                      TransacationTabs.Processing, context);
                                },
                                child: Text("Processing",
                                    style: TextStyle(
                                        color: currentTab ==
                                                TransacationTabs.Processing
                                            ? Colors.black
                                            : Colors.grey.shade400,
                                        fontSize: 18))),
                            Text(
                              " | ",
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                            GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  _employeeHomeScreenCubit.switchTab(
                                      TransacationTabs.Finished, context);
                                },
                                child: Text("Finished",
                                    style: TextStyle(
                                        color: currentTab ==
                                                TransacationTabs.Finished
                                            ? Colors.black
                                            : Colors.grey.shade400,
                                        fontSize: 18))),
                          ],
                        ),
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              _employeeHomeScreenCubit.switchTab(
                                  TransacationTabs.All, context);
                            },
                            child: Text("See All",
                                style: TextStyle(
                                    color: currentTab == TransacationTabs.All
                                        ? Colors.black
                                        : Colors.grey.shade400,
                                    fontSize: 18))),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                  SizedBox(height: 8),
                  if (currentList.length != 0)
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: currentList.length,
                          itemBuilder: ((context, index) {
                            TransactionModel transaction = currentList[index];
                            return WebOrderListTile(
                              transactionModel: transaction,
                              isEmployee: true,
                            );
                          }),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
