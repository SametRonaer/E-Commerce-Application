import 'package:alfa_application/data/model/employee_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/employee_cubit/cubit/employee_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../widgets/app_bottom_navigation_bar.dart';
import '../../../../../widgets/custom_app_button.dart';
import '../../../../../widgets/custom_text_field.dart';

class EmployeeInfoScreen extends StatelessWidget {
  static const routeName = "/employee-info-screen";
  EmployeeInfoScreen({Key? key}) : super(key: key);

  bool _isLoaded = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  late EmployeeModel _employee;

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      _setControllers(context);
      _isLoaded = true;
    }
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: AppBottomNavigationBar(Colors.grey.shade300),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text(
              "Account Information",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
        backgroundColor: Colors.black,
        body: Container(
          height: context.screenHeight,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_getInputField(context), _getButtonField(context)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getInputField(BuildContext context) {
    return Container(
      height: context.screenHeight / 1.7,
      margin: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  textInputType: TextInputType.phone,
                  controller: _phoneNumberController,
                  hintText: "Enter your phone number",
                  title: "Phone Number",
                ),
                SizedBox(width: double.infinity, height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getButtonField(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.screenHeight / 8,
      margin: EdgeInsets.only(right: 14, left: 14, bottom: 14),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAppButton.black(
            buttonName: "Save changes",
            buttonFunction: () async {
              try {
                _employee.employeePhone = _phoneNumberController.text;
                await context.read<EmployeeCubit>().updateEmployee(
                    newData: _employee.toMap(),
                    employeeId: _employee.employeeId);
                Get.snackbar(
                    "İşlem başarılı", "Bilgileriniz başarıyla güncellendi",
                    backgroundColor: Colors.white54);
              } catch (e) {
                Get.snackbar("Hata meydana geldi",
                    "İşleminiz yapılırken hata oluştu. Lütfen sonra tekrar deneyin",
                    backgroundColor: Colors.white54);
              }
            },
          ),
        ],
      ),
    );
  }

  void _setControllers(BuildContext context) {
    _employee = context.read<ProfileCubit>().userProfile as EmployeeModel;
    _phoneNumberController.text = _employee.employeePhone;
  }
}
