import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/app_general_methods.dart';
import '../../../../../constants/enums.dart';
import '../../../../../data/model/transaction_model.dart';
import '../../../../../widgets/employye_home_transactions_field.dart';
import '../../employee_home_screen/cubit/employee_home_screen_cubit.dart';

class AllOrdersScreen extends StatelessWidget {
  AllOrdersScreen({Key? key}) : super(key: key);
  static const routeName = "/all-orders-screen";
  late List<TransactionModel> currentList;
  late ProfileCubit _profileCubit;
  TransacationTabs currentTab = TransacationTabs.New;

  @override
  Widget build(BuildContext context) {
    _profileCubit = context.read<ProfileCubit>();
    return Scaffold(
        appBar: kGetAppBar(context),
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: EmployeeHomeTransactionsField(
              isFullScreen: true,
              employeeHomeScreenCubit: context.read<EmployeeHomeScreenCubit>(),
            ),
          ),
        ));
  }
}
