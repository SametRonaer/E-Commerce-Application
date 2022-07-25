import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/widgets/add_image_cell.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/fake_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/model/customer_model.dart';
import '../../../../../general_cubits/customers_cubit/cubit/customers_cubit.dart';
import '../../../../../widgets/web_page_title_field.dart';
import '../../../../web_screens/cubit/web_home_cubit.dart';
import '../../web_customers_edit_list_screen.dart';
import '../cubit/customer_add_edit_cubit.dart';

class WebCustomerEditScreen extends StatelessWidget {
  WebCustomerEditScreen({Key? key}) : super(key: key);
  late CustomerAddEditCubit _customerAddEditCubit;
  TextStyle _titleStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  double _textAreaWidth = 300.0;
  double _gapBetweenInputAreas = 30.0;

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
                          redButtonTitle: "CANCEL",
                          redButtonFunction: () {
                            context.read<WebHomeCubit>().switchCurrentScreen(
                                WebCustomersEditListScreen());
                          },
                          blackButtonFunction: () {
                            setCustomerData();
                            _customerAddEditCubit.updateCustomer(
                                context, _customerModel);
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
                                              controller:
                                                  _customerCodeController,
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
                                                    _customerModel
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
                                                controller: _nameController,
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
                                                controller: _surnameController,
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
                                                controller:
                                                    _customerEmailController,
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
                                              "WebSite",
                                              style: _titleStyle,
                                            ),
                                            CustomTextField(
                                              controller:
                                                  _customerWebsiteController,
                                              haveGap: false,
                                              onChangeFunction:
                                                  _customerAddEditCubit
                                                      .setCustomerCompanyWebsite,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: AddImageCell(
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
                                      controller:
                                          _customerMembershipDateController,
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
                                      controller:
                                          _customerMobilePhoneController,
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
                                      controller:
                                          _customerCompanyNameController,
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
                                      controller: _customerCityController,
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
                                      controller: _customerTeamController,
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
                                      controller: _customerPostCodeController,
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
                                      controller: _customerPhoneController,
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
                                      controller:
                                          _customerCompanyEmailController,
                                      haveGap: false,
                                      onChangeFunction: _customerAddEditCubit
                                          .setCustomerCompanyEmail,
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
                                      controller: _customerAddressController,
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
                                      controller: _customerNoteController,
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
                      //       buttonName: "Update Customer",
                      //       buttonFunction: () {
                      //         setCustomerData();
                      //         _customerAddEditCubit.updateCustomer(
                      //             context, _customerModel);
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
}
