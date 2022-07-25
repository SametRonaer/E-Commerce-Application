import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/employee_cubit/cubit/employee_cubit.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/employee_add_edit_screens/ui/employee_add_screen.dart';
import 'package:alfa_application/screens/search_screen/cubit/search_screen_cubit.dart';
import 'package:alfa_application/widgets/employee_edit__list_tile.dart';
import 'package:alfa_application/widgets/search_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_general_methods.dart';
import '../../search_screen/ui/search_screen_ui.dart';
import '../../../constants/enums.dart';

class EmployeesEditListScreen extends StatelessWidget {
  EmployeesEditListScreen({Key? key}) : super(key: key);

  static const routeName = "/employees-edit-list-screen";
  @override
  Widget build(BuildContext context) {
    context.read<EmployeeCubit>().getAllEmployees();
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
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
                            padding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 12),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "EMPLOYEES",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              EmployeeAddScreen.routeName);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Icon(Icons.add_circle_outline),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(
                                      thickness: 0.7,
                                      color: Colors.grey.shade700),
                                  SizedBox(
                                      height: context.screenHeight / 1.45,
                                      width: double.infinity,
                                      child: ListView.builder(
                                          itemBuilder: (_, i) =>
                                              EmployeeEditListTile(
                                                  employeeModel: context
                                                      .read<EmployeeCubit>()
                                                      .allEmployees[i]),
                                          itemCount: context
                                              .read<EmployeeCubit>()
                                              .allEmployees
                                              .length)),
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
      },
    );
  }
}
