import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/employee_add_edit_screens/cubit/employee_add_edit_cubit.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/web_employee_edit_list_screen.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/widgets/add_image_cell.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/fake_dropdown_button.dart';
import 'package:alfa_application/widgets/web_page_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../constants/enums.dart';
import '../../../../../widgets/app_bottom_navigation_bar.dart';
import '../../../../../widgets/web_add_image_cell.dart';

class WebEmployeeAddScreen extends StatelessWidget {
  WebEmployeeAddScreen({Key? key}) : super(key: key);
  late EmployeeAddEditCubit _employeeAddEditCubit;

  TextStyle _titleStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  double _textAreaWidth = 300.0;
  double _gapBetweenInputAreas = 30.0;

  @override
  Widget build(BuildContext context) {
    _employeeAddEditCubit = context.read<EmployeeAddEditCubit>();
    return BlocBuilder<EmployeeAddEditCubit, EmployeeAddEditState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                height: context.screenHeight,
                width: context.screenWidth,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WebPageTitleField(
                              blackButtonFunction: () {
                                _employeeAddEditCubit.addNewEmployee(context);
                              },
                              redButtonFunction: () {
                                context
                                    .read<WebHomeCubit>()
                                    .switchCurrentScreen(
                                        WebEmployeesEditListScreen());
                              },
                              pageTitle: "EMPLOYEES > ADD EMPLOYEE",
                              subTitle:
                                  "Please confirm the employee informations."),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: _textAreaWidth,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Employee Code",
                                              style: _titleStyle,
                                            ),
                                            CustomTextField(
                                              haveGap: false,
                                              onChangeFunction:
                                                  _employeeAddEditCubit
                                                      .setEmployeeCode,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: _gapBetweenInputAreas),
                                      SizedBox(
                                        width: _textAreaWidth,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Employee Status",
                                              style: _titleStyle,
                                            ),
                                            FakeDropDownButton(
                                                hintText:
                                                    kGetEmployeeStatusLabel(
                                                        _employeeAddEditCubit
                                                            .employeeModel
                                                            .employeeStatus),
                                                dropDownFunction: () =>
                                                    _getEmployeeTypesBottomSheet(
                                                        context)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: _textAreaWidth,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name",
                                              style: _titleStyle,
                                            ),
                                            CustomTextField(
                                                haveGap: false,
                                                onChangeFunction:
                                                    _employeeAddEditCubit
                                                        .setEmployeeName),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: _gapBetweenInputAreas),
                                      SizedBox(
                                        width: _textAreaWidth,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Surname",
                                              style: _titleStyle,
                                            ),
                                            CustomTextField(
                                                haveGap: false,
                                                onChangeFunction:
                                                    _employeeAddEditCubit
                                                        .setEmployeeSurName),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: WebAddImageCell(
                                  size: 100,
                                  cubit: _employeeAddEditCubit,
                                  isAvatar: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              SizedBox(
                                width: _textAreaWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "E-Mail",
                                      style: _titleStyle,
                                    ),
                                    CustomTextField(
                                        haveGap: false,
                                        onChangeFunction: _employeeAddEditCubit
                                            .setEmployeeEmail),
                                  ],
                                ),
                              ),
                              SizedBox(width: _gapBetweenInputAreas),
                              SizedBox(
                                width: _textAreaWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                  ],
                                ),
                              ),
                              SizedBox(width: _gapBetweenInputAreas),
                              SizedBox(
                                width: _textAreaWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mobile Phone",
                                      style: _titleStyle,
                                    ),
                                    CustomTextField(
                                      haveGap: false,
                                      onChangeFunction: _employeeAddEditCubit
                                          .setEmployeeMobilePhoneNumber,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: _textAreaWidth * 1.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                              ],
                            ),
                          ),
                          SizedBox(height: 18),
                        ],
                      ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: SizedBox(
                      //     height: 48,
                      //     width: _textAreaWidth,
                      //     child: CustomAppButton.black(
                      //       buttonName: "Add Employee",
                      //       buttonFunction: () {
                      //         _employeeAddEditCubit.addNewEmployee(context);
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ],
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
