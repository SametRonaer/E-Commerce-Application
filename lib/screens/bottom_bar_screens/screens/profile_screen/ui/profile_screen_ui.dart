import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/general_cubits/transactions_cubit/cubit/transactions_cubit.dart';
import 'package:alfa_application/screens/auth_screens/sign_in_screen/ui/sign_in_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/cubit/bottom_bar_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/employee_home_screen/ui/employe_home_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/employee_info_screen/ui/employee_info_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/ui/bottom_bar_ui.dart';
import 'package:alfa_application/screens/customer_info_screen/ui/customer_info_screen_ui.dart';
import 'package:alfa_application/screens/customer_transactions_screen/ui/customer_transactions_screen_ui.dart';
import 'package:alfa_application/screens/first_language_selection_screen/first_language_selection_screen.dart';
import 'package:alfa_application/widgets/collection_cell.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../constants/enums.dart';
import '../../../../../data/model/employee_model.dart';
import '../../../../../general_cubits/profile_cubit/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  late ProfileCubit _profileCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        _profileCubit = context.read<ProfileCubit>();
        return Stack(
          children: [
            Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  backgroundColor: Colors.black,
                  title: Text(
                    "Profile".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _getTopField(context),
                        _getMenuOptionsField(context),
                        _getLogoutField(context)
                      ],
                    ),
                  ),
                  height: context.screenHeight,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                )),
            if (state is ProfileLoading) kGetLoadingScreen()
          ],
        );
      },
    );
  }

  Column _getMenuOptionsField(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 4),
          width: double.infinity,
          height: context.screenHeight / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getMenuOptionButton(
                    buttonFunction: () async {
                      Navigator.of(context).pushNamed(
                          (_profileCubit.isCustomer ?? false)
                              ? CustomerInfoScreen.routeName
                              : EmployeeInfoScreen.routeName);
                    },
                    context: context,
                    menuTitle: 'AccountInfo'.tr,
                    iconData: Icons.person_outline,
                    routeName: CustomerTransactionsScreen.routeName),
                if (_profileCubit.isCustomer ?? false)
                  _getMenuOptionButton(
                      buttonFunction: () async {
                        await context
                            .read<TransactionsCubit>()
                            .getTransactionsByCustomerId(
                                customerId:
                                    (_profileCubit.userProfile as CustomerModel)
                                        .userId);
                        Navigator.of(context)
                            .pushNamed(CustomerTransactionsScreen.routeName);
                      },
                      context: context,
                      menuTitle: "My Orders".tr,
                      iconData: Icons.shopping_cart_outlined,
                      routeName: CustomerTransactionsScreen.routeName),
                _getMenuOptionButton(
                    buttonFunction: () {
                      Navigator.of(context)
                          .pushNamed(FirstLanguageSelectionScreen.routeName);
                    },
                    context: context,
                    menuTitle: "Language Preferences".tr,
                    iconData: Icons.language_outlined,
                    routeName: CustomerTransactionsScreen.routeName),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getLogoutField(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 4),
          width: double.infinity,
          height: context.screenHeight / 9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomAppButton.black(
                buttonName: "Log out".tr,
                buttonFunction: () {
                  context.read<ProfileCubit>().cleanUser();
                  context
                      .read<BottomBarCubit>()
                      .switchScreen(BottomBarScreens.HomeScreen, context);
                  if (!kIsWeb) {
                    Get.offAllNamed(BottomBarScreen.routeName);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector _getMenuOptionButton(
      {required IconData iconData,
      required String menuTitle,
      required Function() buttonFunction,
      required String routeName,
      required BuildContext context}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: buttonFunction,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Row(
          children: [
            Icon(iconData),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                menuTitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _getTopField(BuildContext context) {
    ProfileCubit _profileCubit = context.read<ProfileCubit>();
    String? imageUrl;
    if (_profileCubit.isCustomer!) {
      imageUrl = (_profileCubit.userProfile as CustomerModel).customerImageUrl;
    } else {
      imageUrl = (_profileCubit.userProfile as EmployeeModel).employeeImageUrl;
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _profileCubit.changeProfileImage(context),
                child: CircleAvatar(
                  backgroundImage: Image.network(imageUrl).image,
                  radius: 35,
                  child: imageUrl == ""
                      ? Icon(
                          Icons.person_outline,
                          size: 30,
                          color: Colors.white,
                        )
                      : null,
                  backgroundColor: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${_profileCubit.userProfile!.name} ${_profileCubit.userProfile!.surName}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          width: double.infinity,
          height: context.screenHeight / 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300),
        ),
      ],
    );
  }
}
