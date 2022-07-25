import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/data/model/employee_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/employee_cubit/cubit/employee_cubit.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/employee_add_edit_screens/cubit/employee_add_edit_cubit.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/fake_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/enums.dart';
import '../../../../../general_cubits/profile_cubit/cubit/profile_cubit.dart';
import '../../../../../widgets/app_bottom_navigation_bar.dart';

class EmployeeEditScreen extends StatelessWidget {
  EmployeeEditScreen({Key? key}) : super(key: key);
  static const routeName = "/employee-edit-screen";
  late EmployeeAddEditCubit _employeeAddEditCubit;
  late EmployeeModel _employeeModel;
  late String _employeeStatus;

  TextStyle _titleStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  TextEditingController _employeeCodeController = TextEditingController();
  TextEditingController _employeePhoneController = TextEditingController();
  TextEditingController _employeeNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _employeeAddEditCubit = context.read<EmployeeAddEditCubit>();
    _employeeModel = context.read<EmployeeCubit>().selectedEmployee!;
    _setControllers();
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
                        SizedBox(height: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Employee Code",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              controller: _employeeCodeController,
                              haveGap: false,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Employee Status",
                              style: _titleStyle,
                            ),
                            FakeDropDownButton(
                                hintText: kGetEmployeeStatusLabel(
                                    _employeeModel.employeeStatus),
                                dropDownFunction: () =>
                                    _getEmployeeTypesBottomSheet(context)),
                            SizedBox(height: 8),
                            Text(
                              "Mobile Phone",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              controller: _employeePhoneController,
                              haveGap: false,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Note",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              controller: _employeeNoteController,
                              haveGap: false,
                              isLargeFied: true,
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                        CustomAppButton.black(
                          buttonName: "Update Employee",
                          buttonFunction: () {
                            _setEmployeeData();
                            _employeeAddEditCubit.updateEmployee(
                                context, _employeeModel);
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

  _setControllers() {
    _employeeCodeController.text = _employeeModel.employeeCode;
    _employeePhoneController.text = _employeeModel.employeePhone;
    _employeeNoteController.text = _employeeModel.employeeNote ?? "";
    _employeeStatus = _employeeModel.employeeStatus;
  }

  _setEmployeeData() {
    _employeeModel.employeeNote = _employeeNoteController.text;
    _employeeModel.employeePhone = _employeePhoneController.text;
    _employeeModel.employeeCode = _employeeCodeController.text;
    _employeeModel.employeeStatus = _employeeStatus;
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
                          _employeeStatus =
                              EmployeeStatus.Administor.toString();
                          _employeeModel.employeeStatus = _employeeStatus;
                          _employeeAddEditCubit.refreshPage();
                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Standart"),
                        onTap: () {
                          _employeeStatus = EmployeeStatus.Standart.toString();
                          _employeeModel.employeeStatus = _employeeStatus;
                          _employeeAddEditCubit.refreshPage();
                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Limited"),
                        onTap: () {
                          _employeeStatus = EmployeeStatus.Limited.toString();
                          _employeeModel.employeeStatus = _employeeStatus;
                          _employeeAddEditCubit.refreshPage();
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
