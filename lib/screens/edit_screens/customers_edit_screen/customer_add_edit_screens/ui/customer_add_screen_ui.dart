import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/widgets/add_image_cell.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/fake_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../widgets/app_bottom_navigation_bar.dart';
import '../cubit/customer_add_edit_cubit.dart';

class CustomerAddScreen extends StatelessWidget {
  CustomerAddScreen({Key? key}) : super(key: key);
  static const routeName = "/customer-add-screen";
  late CustomerAddEditCubit _customerAddEditCubit;
  TextStyle _titleStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    _customerAddEditCubit = context.read<CustomerAddEditCubit>();
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
                        AddImageCell(
                          cubit: _customerAddEditCubit,
                          isAvatar: true,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Customer Code",
                              style: _titleStyle,
                            ),
                            CustomTextField(
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
                                    _customerAddEditCubit
                                            .customerModel.customeGroup ??
                                        ""),
                                dropDownFunction: () =>
                                    _getCustomerTypesBottomSheet(context)),
                            SizedBox(height: 8),
                            Text(
                              "Name",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                                haveGap: false,
                                onChangeFunction:
                                    _customerAddEditCubit.setCustomerName),
                            SizedBox(height: 8),
                            Text(
                              "Surname",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                                haveGap: false,
                                onChangeFunction:
                                    _customerAddEditCubit.setCustomerSurName),
                            SizedBox(height: 8),
                            Text(
                              "E-Mail",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                                haveGap: false,
                                onChangeFunction:
                                    _customerAddEditCubit.setCustomerEmail),
                            SizedBox(height: 8),
                            Text(
                              "Password",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                                haveGap: false,
                                onChangeFunction: (value) {
                                  _customerAddEditCubit
                                      .setCustomerPassword(value);
                                }),
                            SizedBox(height: 8),
                            Text(
                              "Membership Date",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              textInputType: TextInputType.number,
                              haveGap: false,
                              onChangeFunction: _customerAddEditCubit
                                  .setCustomerMEmbershipDate,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Mobile Phone",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              textInputType: TextInputType.number,
                              haveGap: false,
                              onChangeFunction: _customerAddEditCubit
                                  .setCustomerMobilePhoneNumber,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Company",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              haveGap: false,
                              onChangeFunction:
                                  _customerAddEditCubit.setCustomerCompany,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "City",
                              style: _titleStyle,
                            ),
                            CustomTextField(
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
                              haveGap: false,
                              onChangeFunction:
                                  _customerAddEditCubit.setCustomerTeam,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Post Code",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              textInputType: TextInputType.number,
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
                              haveGap: false,
                              onChangeFunction:
                                  _customerAddEditCubit.setCustomerPhoneNo,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Company E-Mail",
                              style: _titleStyle,
                            ),
                            CustomTextField(
                              haveGap: false,
                              onChangeFunction:
                                  _customerAddEditCubit.setCustomerCompanyEmail,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "WebSite",
                              style: _titleStyle,
                            ),
                            CustomTextField(
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
                              haveGap: false,
                              isLargeFied: true,
                              onChangeFunction: (_) {},
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                        CustomAppButton.black(
                          buttonName: "Add Customer",
                          buttonFunction: () {
                            _customerAddEditCubit.addNewCustomer(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state is CustomerAddEditLoding) kGetLoadingScreen(),
          ],
        );
      },
    );
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
                          _customerAddEditCubit
                              .setCustomerGroup(CustomerTypes.Premium);
                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Standart"),
                        onTap: () {
                          _customerAddEditCubit
                              .setCustomerGroup(CustomerTypes.Standart);
                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Other"),
                        onTap: () {
                          _customerAddEditCubit
                              .setCustomerGroup(CustomerTypes.Other);
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
