import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/transaction_model.dart';
import 'package:alfa_application/general_cubits/transactions_cubit/cubit/transactions_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_home_screen_state.dart';

class EmployeeHomeScreenCubit extends Cubit<EmployeeHomeScreenState> {
  EmployeeHomeScreenCubit() : super(EmployeeHomeScreenInitial());
  TransacationTabs currentTab = TransacationTabs.New;
  List<TransactionModel> transacationsList = [];
  bool _allOrdersLoaded = false;

  _changeTab(TransacationTabs newTab) {
    currentTab = newTab;
    emit(EmployeeHomeScreenLoaded());
  }

  Future<void> switchTab(TransacationTabs newTab, BuildContext context) async {
    _changeTab(newTab);
    if (!_allOrdersLoaded) {
      await context.read<TransactionsCubit>().getAllTransactions();
      _allOrdersLoaded = true;
    }

    double status;
    if (currentTab == TransacationTabs.New) {
      status = 0.0;
    } else if (currentTab == TransacationTabs.Processing) {
      status = 1.0;
    } else if (currentTab == TransacationTabs.Finished) {
      status = 5.0;
    } else if (currentTab == TransacationTabs.All) {
      status = 10.0;
    } else {
      status = 1.0;
    }
    if (status == 1.0) {
      transacationsList = context
          .read<TransactionsCubit>()
          .allTransactions
          .where((element) =>
              (element.transactionStatus != 0.0) &&
              (element.transactionStatus != 5.0) &&
              (element.transactionStatus != 6.0) &&
              (element.transactionStatus != 7.0))
          .toList();
    } else if (status == 10.0) {
      transacationsList = context.read<TransactionsCubit>().allTransactions;
    } else {
      await context
          .read<TransactionsCubit>()
          .getTransactionsByStatus(status: status);
      transacationsList =
          context.read<TransactionsCubit>().filteredTransactions;
    }
    emit(EmployeeHomeScreenLoaded());
  }

  Future<void> refreshOrders(BuildContext context) async {
    double status;
    if (currentTab == TransacationTabs.New) {
      status = 0.0;
    } else if (currentTab == TransacationTabs.Processing) {
      status = 1.0;
    } else if (currentTab == TransacationTabs.Finished) {
      status = 2.0;
    } else if (currentTab == TransacationTabs.All) {
      status = 10.0;
    } else {
      status = 1.0;
    }
    if (status == 1.0) {
      transacationsList = context
          .read<TransactionsCubit>()
          .allTransactions
          .where((element) =>
              (element.transactionStatus != 0.0) &&
              (element.transactionStatus != 2.0))
          .toList();
    } else if (status == 10.0) {
      await context.read<TransactionsCubit>().getAllTransactions();
      transacationsList = context.read<TransactionsCubit>().allTransactions;
    } else {
      await context
          .read<TransactionsCubit>()
          .getTransactionsByStatus(status: status);
      transacationsList =
          context.read<TransactionsCubit>().filteredTransactions;
    }
    emit(EmployeeHomeScreenLoaded());
  }
}
