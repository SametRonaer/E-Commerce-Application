import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/customers_cubit/cubit/customers_cubit.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../constants/app_general_methods.dart';
import '../../../../../constants/enums.dart';
import '../../../../../widgets/app_bottom_navigation_bar.dart';
import '../../../../../widgets/fake_dropdown_button.dart';
import '../cubit/customer_add_edit_cubit.dart';

class CustomerEditScreen extends StatelessWidget {
  CustomerEditScreen({Key? key}) : super(key: key);
  static const routeName = "/customer-edit-screen";
  late CustomerAddEditCubit _customerAddEditCubit;

  TextStyle _titleStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  late CustomerModel _customerModel;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _customerCodeController = TextEditingController();
  TextEditingController _customerEmailController = TextEditingController();

  TextEditingController _customerMembershipDateController =
      TextEditingController();
  TextEditingController _customerCityController = TextEditingController();
  TextEditingController _customerTeamController = TextEditingController();
  TextEditingController _customerPostCodeController = TextEditingController();
  TextEditingController _customerWebsiteController = TextEditingController();
  TextEditingController _customerAddressController = TextEditingController();
  TextEditingController _customerNoteController = TextEditingController();
  TextEditingController _customerMobilePhoneController =
      TextEditingController();
  TextEditingController _customerPhoneController = TextEditingController();
  TextEditingController _customerCompanyNameController =
      TextEditingController();
  TextEditingController _customerCompanyEmailController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _customerAddEditCubit = context.read<CustomerAddEditCubit>();
    _customerModel = context.read<CustomersCubit>().selectedCustomer!;
    _getAndSetControllers();
    return BlocBuilder<CustomerAddEditCubit, CustomerAddEditState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: kGetAppBar(context),
              bottomNavigationBar: AppBottomNavigationBar(),
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
                        SizedBox(height: 80),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CustomerCode",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              controller: _customerCodeController,
                              haveGap: false,
                              onChangeFunction:
                                  _customerAddEditCubit.setCustomerCode,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Customer Group",
                              style: _titleStyle,
                            ),
                            FakeDropDownButton(
                                hintText: kGetCustomerTypeLabel(
                                    _customerModel.customeGroup ?? ""),
                                dropDownFunction: () =>
                                    _getCustomerTypesBottomSheet(context)),
                            SizedBox(height: 8),
                            Text(
                              "E-Mail",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                                controller: _customerEmailController,
                                haveGap: false,
                                onChangeFunction:
                                    _customerAddEditCubit.setCustomerEmail),
                            SizedBox(height: 8),
                            Text(
                              "Membership Date",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              textInputType: TextInputType.number,
                              controller: _customerMembershipDateController,
                              haveGap: false,
                              onChangeFunction: (_) {},
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Mobile Phone",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              textInputType: TextInputType.number,
                              controller: _customerMobilePhoneController,
                              haveGap: false,
                              onChangeFunction: _customerAddEditCubit
                                  .setCustomerMobilePhoneNumber,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "City",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              controller: _customerCityController,
                              haveGap: false,
                              onChangeFunction:
                                  _customerAddEditCubit.setCustomerCity,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Team",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              controller: _customerTeamController,
                              haveGap: false,
                              onChangeFunction: (_) {},
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Post Code",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              textInputType: TextInputType.number,
                              controller: _customerPostCodeController,
                              haveGap: false,
                              onChangeFunction:
                                  _customerAddEditCubit.setCustomerPostCode,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Phone",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              textInputType: TextInputType.number,
                              controller: _customerPhoneController,
                              haveGap: false,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Company E-Mail",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              controller: _customerCompanyEmailController,
                              haveGap: false,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Web-Site",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              controller: _customerWebsiteController,
                              haveGap: false,
                              onChangeFunction: _customerAddEditCubit
                                  .setCustomerCompanyWebsite,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Address",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              controller: _customerAddressController,
                              haveGap: false,
                              isLargeFied: true,
                              onChangeFunction:
                                  _customerAddEditCubit.setCustomerAddress,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Note",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              controller: _customerNoteController,
                              haveGap: false,
                              isLargeFied: true,
                              onChangeFunction: (_) {},
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                        CustomAppButton.black(
                          buttonName: "Update Customer",
                          buttonFunction: () {
                            setCustomerData();
                            _customerAddEditCubit.updateCustomer(
                                context, _customerModel);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state is CustomerAddEditLoding)
              Container(
                alignment: Alignment.center,
                color: Colors.black54,
                child: SpinKitSpinningLines(
                  color: Colors.white,
                  size: 100,
                ),
              ),
          ],
        );
      },
    );
  }

  _getAndSetControllers() {
    _nameController.text = _customerModel.name;
    _surnameController.text = _customerModel.surName;
    _customerCodeController.text = _customerModel.customeCode ?? "";
    _customerEmailController.text = _customerModel.userEmail;
    _customerMembershipDateController.text =
        _customerModel.customerMembershipDate ?? "";
    _customerCompanyNameController.text =
        _customerModel.customerCompanyName ?? "";
    _customerCityController.text = _customerModel.customerCity ?? "";
    _customerTeamController.text = _customerModel.customerTeam ?? "";
    _customerPostCodeController.text = _customerModel.postCode ?? "";
    _customerMobilePhoneController.text =
        _customerModel.customerMobilePhoneNumber ?? "";
    _customerPhoneController.text = _customerModel.customerPhoneNumber ?? "";
    _customerCompanyEmailController.text =
        _customerModel.customerCompanyMailAdress ?? "";
    _customerWebsiteController.text =
        _customerModel.customerCompanyMailAdress ?? "";
    _customerAddressController.text = _customerModel.customerAdress ?? "";
    _customerNoteController.text = _customerModel.customerPrivateNote ?? "";
  }

  void setCustomerData() {
    _customerModel.name = _nameController.text;
    _customerModel.userName = _nameController.text;
    _customerModel.userSurName = _surnameController.text;
    _customerModel.surName = _surnameController.text;
    _customerModel.customeCode = _customerCodeController.text;
    _customerModel.email = _customerEmailController.text;
    _customerModel.customerMobilePhoneNumber =
        _customerMobilePhoneController.text;
    _customerModel.customerCompanyMailAdress =
        _customerCompanyEmailController.text;
    _customerModel.customerPhoneNumber = _customerPhoneController.text;
    _customerModel.customerCompanyMailAdress =
        _customerCompanyEmailController.text;
    _customerModel.customerCompanyWebsite = _customerWebsiteController.text;
    _customerModel.customerAdress = _customerAddressController.text;
    _customerModel.customerPrivateNote = _customerNoteController.text;
    _customerModel.customerCity = _customerCityController.text;
    _customerModel.postCode = _customerPostCodeController.text;
    _customerModel.customerTeam = _customerTeamController.text;
    _customerModel.customerMembershipDate =
        _customerMembershipDateController.text;
  }

  _getCustomerTypesBottomSheet(BuildContext context) {
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
                        title: Text("Premium"),
                        onTap: () {
                          _customerModel.customeGroup =
                              CustomerTypes.Premium.toString();
                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Standart"),
                        onTap: () {
                          _customerModel.customeGroup =
                              CustomerTypes.Standart.toString();

                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Other"),
                        onTap: () {
                          _customerModel.customeGroup =
                              CustomerTypes.Other.toString();

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
