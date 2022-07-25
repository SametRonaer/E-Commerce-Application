import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/employee_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/cubit/bottom_bar_cubit.dart';
import 'package:alfa_application/screens/edit_screens/carosuel_edit_screen/ui/carosuel_edit_screen.dart';
import 'package:alfa_application/screens/edit_screens/models_edit_screen/model_edit_list_scrren_ui.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_edit_list_screen_ui.dart';
import 'package:alfa_application/screens/search_screen/cubit/search_screen_cubit.dart';
import 'package:alfa_application/screens/search_screen/ui/search_screen_ui.dart';
import 'package:alfa_application/widgets/search_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/app_general_methods.dart';
import '../../../../../widgets/management_menu_cell.dart';
import '../../../../edit_screens/category_edit_screen/category_edit_list_screen.dart';
import '../../../../edit_screens/customers_edit_screen/customers_edit_list_screen.dart';
import '../../../../edit_screens/employee_edit_screen/employee_edit_list_screen.dart';
import '../../../../edit_screens/products_edit_list_screen/ui/products_edit_list_screen_ui.dart';

class SystemScreen extends StatelessWidget {
  SystemScreen({Key? key}) : super(key: key);
  late ProfileCubit _profileCubit;
  late EmployeeModel _employeeModel;

  @override
  Widget build(BuildContext context) {
    _profileCubit = context.read<ProfileCubit>();
    _employeeModel = _profileCubit.userProfile as EmployeeModel;
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
                    : Container(
                        padding: EdgeInsets.only(
                            top: 18, right: 12, left: 12, bottom: 18),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                "SYSTEM",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                              ),
                              Divider(
                                  thickness: 0.7, color: Colors.grey.shade700),
                              SizedBox(height: 10),
                              SizedBox(
                                height: context.screenHeight / 1.75,
                                width: double.infinity,
                                child: GridView(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  children: [
                                    ManagementMenuCell(
                                        isLarge: true,
                                        iconData: Icons.category_outlined,
                                        label: "CATEGORIES",
                                        route:
                                            CategoryEditListScreen.routeName),
                                    ManagementMenuCell(
                                        isLarge: true,
                                        iconData: Icons.sell_outlined,
                                        label: "PRODUCTS",
                                        route:
                                            ProductsEditListScreen.routeName),
                                    if (_employeeModel.employeeStatus ==
                                        EmployeeStatus.Administor.toString())
                                      ManagementMenuCell(
                                          isLarge: true,
                                          iconData: Icons.person_outline,
                                          label: "CUSTOMERS",
                                          route: CustomersEditListScreen
                                              .routeName),
                                    if (_employeeModel.employeeStatus !=
                                        EmployeeStatus.Limited.toString())
                                      ManagementMenuCell(
                                          isLarge: true,
                                          iconData: Icons.people_outline,
                                          label: "EMPLOYEES",
                                          route: EmployeesEditListScreen
                                              .routeName),
                                    ManagementMenuCell(
                                        isLarge: true,
                                        iconData: Icons.burst_mode_outlined,
                                        label: "MODELS",
                                        route: ModelsEditListScreen.routeName),
                                    ManagementMenuCell(
                                      buttonFunction: () => context
                                          .read<BottomBarCubit>()
                                          .switchScreen(
                                              BottomBarScreens.OrdersScreen,
                                              context),
                                      isLarge: true,
                                      iconData: Icons.shopping_bag_outlined,
                                      label: "ORDERS",
                                    ),
                                    ManagementMenuCell(
                                        isLarge: true,
                                        iconData: Icons.collections,
                                        label: "COLLECTIONS",
                                        route: SecondCategoryEditListScreen
                                            .routeName),
                                    ManagementMenuCell(
                                        isLarge: true,
                                        iconData: Icons.collections_bookmark,
                                        label: "BANNERS",
                                        route: CarosuelEditScreen.routeName),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
