import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/customers_cubit/cubit/customers_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/widgets/app_bottom_navigation_bar.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CustomerInfoScreen extends StatelessWidget {
  static const routeName = "/customer-info-screen";
  CustomerInfoScreen({Key? key}) : super(key: key);
  bool _isLoaded = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyEmailController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyCountryController =
      TextEditingController();
  final TextEditingController _companyCityController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _mobilePhoneNumberController =
      TextEditingController();
  late CustomerModel customer;

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
              "AccountInfo".tr,
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
                  controller: _companyEmailController,
                  hintText: "Enter your company email address",
                  title: "Company Email".tr,
                ),
                CustomTextField(
                  controller: _companyNameController,
                  hintText: "Enter your company name",
                  title: "Company Name".tr,
                ),
                CustomTextField(
                  controller: _companyCountryController,
                  hintText: "Enter your company country",
                  title: "Company Country".tr,
                ),
                CustomTextField(
                  controller: _companyCityController,
                  hintText: "Enter your company city",
                  title: "Company City".tr,
                ),
                CustomTextField(
                  isLargeFied: true,
                  controller: _companyAddressController,
                  hintText: "Enter your company address",
                  title: "Company Address".tr,
                ),
                CustomTextField(
                  textInputType: TextInputType.phone,
                  controller: _phoneNumberController,
                  hintText: "Enter your phone number",
                  title: "Phone Number".tr,
                ),
                CustomTextField(
                  controller: _mobilePhoneNumberController,
                  hintText: "Enter your mobile phone number",
                  title: "Mobile Phone Number".tr,
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
            buttonName: "Save changes".tr,
            buttonFunction: () async {
              customer.customerAdress = _companyAddressController.text;
              customer.customerCity = _companyCityController.text;
              customer.customerCountry = _companyCountryController.text;
              customer.customerMobilePhoneNumber =
                  _mobilePhoneNumberController.text;
              customer.customerPhoneNumber = _phoneNumberController.text;
              customer.customerCompanyName = _companyNameController.text;
              customer.customerCompanyMailAdress = _companyEmailController.text;

              try {
                await context.read<CustomersCubit>().updateCustomer(
                    newData: customer.toMap(), userId: customer.userId);
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
    customer = context.read<ProfileCubit>().userProfile as CustomerModel;

    _companyEmailController.text = customer.customerCompanyMailAdress ?? "";
    _companyNameController.text = customer.customerCompanyName ?? "";
    _companyCityController.text = customer.customerCity ?? "";
    _companyAddressController.text = customer.customerAdress ?? "";
    _phoneNumberController.text = customer.customerPhoneNumber ?? "";
    _mobilePhoneNumberController.text =
        customer.customerCompanyMobilePhoneNumber ?? "";
    _companyCountryController.text = customer.customerCountry ?? "";
  }
}
