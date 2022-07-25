import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/employee_add_edit_screens/cubit/employee_add_edit_cubit.dart';
import 'package:alfa_application/widgets/add_image_cell.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/fake_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../constants/enums.dart';
import '../../../../../widgets/app_bottom_navigation_bar.dart';

class EmployeeAddScreen extends StatelessWidget {
  EmployeeAddScreen({Key? key}) : super(key: key);
  static const routeName = "/employee-add-screen";
  late EmployeeAddEditCubit _employeeAddEditCubit;

  TextStyle _titleStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    _employeeAddEditCubit = context.read<EmployeeAddEditCubit>();
    return BlocBuilder<EmployeeAddEditCubit, EmployeeAddEditState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: kGetAppBar(context),
              bottomNavigationBar: AppBottomNavigationBar(Colors.grey.shade300),
              backgroundColor: Colors.black,
              body: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  height: context.screenHeight,
                  width: context.screenWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AddImageCell(
                          cubit: _employeeAddEditCubit,
                          isAvatar: true,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Employee Code",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              haveGap: false,
                              onChangeFunction:
                                  _employeeAddEditCubit.setEmployeeCode,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Employee Status",
                              style: _titleStyle,
                            ),
                            FakeDropDownButton(
                                hintText: kGetEmployeeStatusLabel(
                                    _employeeAddEditCubit
                                        .employeeModel.employeeStatus),
                                dropDownFunction: () =>
                                    _getEmployeeTypesBottomSheet(context)),
                            SizedBox(height: 8),
                            Text(
                              "Name",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                                haveGap: false,
                                onChangeFunction:
                                    _employeeAddEditCubit.setEmployeeName),
                            SizedBox(height: 8),
                            Text(
                              "Surname",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                                haveGap: false,
                                onChangeFunction:
                                    _employeeAddEditCubit.setEmployeeSurName),
                            SizedBox(height: 8),
                            Text(
                              "E-Mail",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                                haveGap: false,
                                onChangeFunction:
                                    _employeeAddEditCubit.setEmployeeEmail),
                            SizedBox(height: 8),
                            Text(
                              "Password",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                                haveGap: false,
                                onChangeFunction: (value) {
                                  _employeeAddEditCubit
                                      .setEmployeePassword(value);
                                }),
                            SizedBox(height: 8),
                            Text(
                              "Mobile Phone",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              haveGap: false,
                              onChangeFunction: _employeeAddEditCubit
                                  .setEmployeeMobilePhoneNumber,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Note",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              haveGap: false,
                              isLargeFied: true,
                              onChangeFunction:
                                  _employeeAddEditCubit.setEmployeeNote,
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                        CustomAppButton.black(
                          buttonName: "Add Employee",
                          buttonFunction: () {
                            _employeeAddEditCubit.addNewEmployee(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state is EmployeeAddEditLoading) kGetLoadingScreen()
          ],
        );
      },
    );
  }

  _getEmployeeTypesBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        builder: (_) {
          return Container(
            height: context.screenHeight / 1.5,
            child: Column(
              children: [
                ListTile(
                  title: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Select")),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  height: context.screenHeight / 1.9,
                  width: double.infinity,
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text("Administor"),
                        onTap: () {
                          _employeeAddEditCubit
                              .setEmployeeStatus(EmployeeStatus.Administor);
                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Standart"),
                        onTap: () {
                          _employeeAddEditCubit
                              .setEmployeeStatus(EmployeeStatus.Standart);
                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Limited"),
                        onTap: () {
                          _employeeAddEditCubit
                              .setEmployeeStatus(EmployeeStatus.Standart);
                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
