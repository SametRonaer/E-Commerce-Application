import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/employee_cubit/cubit/employee_cubit.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/employee_add_edit_screens/ui/employee_add_screen.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/employee_add_edit_screens/ui/web_employee_add_screen.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/web_employee_edit_list_tile.dart';

class WebEmployeesEditListScreen extends StatelessWidget {
  WebEmployeesEditListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EmployeeCubit>().getAllEmployees();
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "EMPLOYEES",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<WebHomeCubit>()
                            .switchCurrentScreen(WebEmployeeAddScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.add_circle_outline,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Divider(thickness: 0.7, color: Colors.grey.shade700),
                SizedBox(
                    height: context.screenHeight / 1.45,
                    width: double.infinity,
                    child: ListView.builder(
                        itemBuilder: (_, i) => WebEmployeeEditListTile(
                            employeeModel:
                                context.read<EmployeeCubit>().allEmployees[i]),
                        itemCount:
                            context.read<EmployeeCubit>().allEmployees.length)),
              ],
            ),
          ),
        );
      },
    );
  }
}
