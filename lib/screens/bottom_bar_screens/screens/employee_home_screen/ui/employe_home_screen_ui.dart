import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/employee_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/general_cubits/transactions_cubit/cubit/transactions_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/cubit/bottom_bar_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/employee_home_screen/cubit/employee_home_screen_cubit.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_edit_list_screen.dart';
import 'package:alfa_application/screens/edit_screens/customers_edit_screen/customers_edit_list_screen.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/employee_edit_list_screen.dart';
import 'package:alfa_application/screens/edit_screens/models_edit_screen/model_edit_list_scrren_ui.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/ui/products_edit_list_screen_ui.dart';
import 'package:alfa_application/screens/search_screen/cubit/search_screen_cubit.dart';
import 'package:alfa_application/screens/search_screen/ui/search_screen_ui.dart';
import 'package:alfa_application/widgets/employye_home_transactions_field.dart';
import 'package:alfa_application/widgets/management_menu_cell.dart';
import 'package:alfa_application/widgets/search_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../edit_screens/second_category_edit_screen/second_category_edit_list_screen_ui.dart';

class EmployeeHomeScreen extends StatelessWidget {
  static const routeName = "/employee-home-screen";
  EmployeeHomeScreen({Key? key}) : super(key: key);
  late ProfileCubit _profileCubit;

  @override
  Widget build(BuildContext context) {
    _profileCubit = context.read<ProfileCubit>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: kGetAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchArea(searchAreaTypes: SearchAreaTypes.EmployeeProducts),
            BlocBuilder<SearchScreenCubit, SearchScreenState>(
              builder: (context, state) {
                return state is SearchScreenEmployeeProductList
                    ? SearchScreen()
                    : Column(
                        children: [
                          EmployeeHomeTransactionsField(
                            employeeHomeScreenCubit:
                                context.read<EmployeeHomeScreenCubit>(),
                          ),
                          Container(
                              color: Colors.grey.shade300,
                              child: _getManagementArea(context)),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getManagementArea(BuildContext context) {
    EmployeeModel employee = _profileCubit.userProfile as EmployeeModel;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      height: context.screenHeight / 4,
      width: context.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              "MANAGEMENT",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1.5,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ManagementMenuCell(
                    iconData: Icons.category_outlined,
                    label: "CATEGORIES",
                    route: CategoryEditListScreen.routeName),
                ManagementMenuCell(
                    iconData: Icons.sell_outlined,
                    label: "PRODUCTS",
                    route: ProductsEditListScreen.routeName),
                employee.employeeStatus == EmployeeStatus.Administor.toString()
                    ? ManagementMenuCell(
                        iconData: Icons.person_outline,
                        label: "CUSTOMERS",
                        route: CustomersEditListScreen.routeName)
                    : ManagementMenuCell(
                        iconData: Icons.burst_mode_outlined,
                        label: "MODELS",
                        route: ModelsEditListScreen.routeName),
                employee.employeeStatus != EmployeeStatus.Limited.toString()
                    ? ManagementMenuCell(
                        iconData: Icons.people_outline,
                        label: "EMPLOYEES",
                        route: EmployeesEditListScreen.routeName)
                    : ManagementMenuCell(
                        iconData: Icons.collections,
                        label: "COLLECTIONS",
                        route: SecondCategoryEditListScreen.routeName),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
