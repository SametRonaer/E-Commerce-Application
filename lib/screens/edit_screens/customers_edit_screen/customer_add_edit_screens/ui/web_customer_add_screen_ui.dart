import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/edit_screens/customers_edit_screen/web_customers_edit_list_screen.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/widgets/add_image_cell.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/fake_dropdown_button.dart';
import 'package:alfa_application/widgets/web_add_image_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../widgets/app_bottom_navigation_bar.dart';
import '../../../../../widgets/web_page_title_field.dart';
import '../cubit/customer_add_edit_cubit.dart';

class WebCustomerAddScreen extends StatelessWidget {
  WebCustomerAddScreen({Key? key}) : super(key: key);
  late CustomerAddEditCubit _customerAddEditCubit;
  TextStyle _titleStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  double _textAreaWidth = 300.0;
  double _gapBetweenInputAreas = 30.0;

  @override
  Widget build(BuildContext context) {
    _customerAddEditCubit = context.read<CustomerAddEditCubit>();
    return BlocBuilder<CustomerAddEditCubit, CustomerAddEditState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
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
                      WebPageTitleField(
                          redButtonFunction: () {
                            context.read<WebHomeCubit>().switchCurrentScreen(
                                WebCustomersEditListScreen());
                          },
                          blackButtonFunction: () {
                            _customerAddEditCubit.addNewCustomer(context);
                          },
                          pageTitle: "CUSTOMERS > ADD CUSTOMER",
                          subTitle:
                              "Please confirm the customer informations."),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Firts three lines
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
                                              "Customer Code",
                                              style: _titleStyle,
                                            ),
                                            CustomTextField(
                                              haveGap: false,
                                              onChangeFunction:
                                                  _customerAddEditCubit
                                                      .setCustomerCode,
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
                                            SizedBox(height: 2),
                                            Text(
                                              "Customer Group",
                                              style: _titleStyle,
                                            ),
                                            FakeDropDownButton(
                                                hintText: kGetCustomerTypeLabel(
                                                    _customerAddEditCubit
                                                            .customerModel
                                                            .customeGroup ??
                                                        ""),
                                                dropDownFunction: () =>
                                                    _getCustomerTypesBottomSheet(
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
                                                    _customerAddEditCubit
                                                        .setCustomerName),
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
                                                    _customerAddEditCubit
                                                        .setCustomerSurName),
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
                                              "E-mail",
                                              style: _titleStyle,
                                            ),
                                            CustomTextField(
                                                haveGap: false,
                                                onChangeFunction:
                                                    _customerAddEditCubit
                                                        .setCustomerEmail),
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
                                              "Password",
                                              style: _titleStyle,
                                            ),
                                            CustomTextField(
                                                haveGap: false,
                                                onChangeFunction: (value) {
                                                  _customerAddEditCubit
                                                      .setCustomerPassword(
                                                          value);
                                                }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: WebAddImageCell(
                                  size: 100,
                                  cubit: _customerAddEditCubit,
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
                                      "Membership Date",
                                      style: _titleStyle,
                                    ),
                                    CustomTextField(
                                      textInputType: TextInputType.number,
                                      haveGap: false,
                                      onChangeFunction: _customerAddEditCubit
                                          .setCustomerMEmbershipDate,
                                    ),
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
                                      textInputType: TextInputType.number,
                                      haveGap: false,
                                      onChangeFunction: _customerAddEditCubit
                                          .setCustomerMobilePhoneNumber,
                                    ),
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
                                      "Company",
                                      style: _titleStyle,
                                    ),
                                    CustomTextField(
                                      haveGap: false,
                                      onChangeFunction: _customerAddEditCubit
                                          .setCustomerCompany,
                                    ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "City",
                                      style: _titleStyle,
                                    ),
                                    CustomTextField(
                                      haveGap: false,
                                      onChangeFunction:
                                          _customerAddEditCubit.setCustomerCity,
                                    ),
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
                                      "Team",
                                      style: _titleStyle,
                                    ),
                                    CustomTextField(
                                      haveGap: false,
                                      onChangeFunction:
                                          _customerAddEditCubit.setCustomerTeam,
                                    ),
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
                                      "Post Code",
                                      style: _titleStyle,
                                    ),
                                    CustomTextField(
                                      textInputType: TextInputType.number,
                                      haveGap: false,
                                      onChangeFunction: _customerAddEditCubit
                                          .setCustomerPostCode,
                                    ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phone",
                                      style: _titleStyle,
                                    ),
                                    CustomTextField(
                                      textInputType: TextInputType.number,
                                      haveGap: false,
                                      onChangeFunction: _customerAddEditCubit
                                          .setCustomerPhoneNo,
                                    ),
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
                                      "Company e-mail",
                                      style: _titleStyle,
                                    ),
                                    CustomTextField(
                                      haveGap: false,
                                      onChangeFunction: _customerAddEditCubit
                                          .setCustomerCompanyEmail,
                                    ),
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
                                      "WebSite",
                                      style: _titleStyle,
                                    ),
                                    CustomTextField(
                                      haveGap: false,
                                      onChangeFunction: _customerAddEditCubit
                                          .setCustomerCompanyWebsite,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          Row(
                            children: [
                              SizedBox(
                                width: _textAreaWidth * 1.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Address",
                                      style: _titleStyle,
                                    ),
                                    CustomTextField(
                                      haveGap: false,
                                      isLargeFied: true,
                                      onChangeFunction: _customerAddEditCubit
                                          .setCustomerAddress,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: _gapBetweenInputAreas),
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
                                      onChangeFunction: (_) {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(height: 18),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: SizedBox(
                      //     width: _textAreaWidth,
                      //     height: 48,
                      //     child: CustomAppButton.black(
                      //       buttonName: "Add Customer",
                      //       buttonFunction: () {
                      //         _customerAddEditCubit.addNewCustomer(context);
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ],
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
