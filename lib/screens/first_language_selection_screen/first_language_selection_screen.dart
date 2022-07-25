import 'package:alfa_application/constants/image_paths.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/auth_screens/sign_in_screen/ui/sign_in_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/cubit/bottom_bar_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/ui/bottom_bar_ui.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/enums.dart';
import '../notifications_screen/ui/notifications_screen_ui.dart';

class FirstLanguageSelectionScreen extends StatelessWidget {
  FirstLanguageSelectionScreen({Key? key}) : super(key: key);
  static const routeName = "/first-language-selection-screen";
  GetStorage _box = GetStorage();
  String? _currentLanguage;
  @override
  Widget build(BuildContext context) {
    _currentLanguage = _box.read("languagePreference");
    return SafeArea(
      child: Scaffold(
        appBar: _currentLanguage == null
            ? AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                title: SizedBox(
                    width: context.screenWidth / 2.4,
                    child: Image.asset(kAlfaTextLogo)),
                centerTitle: true,
              )
            : _getAppBar(context),
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getLanguageButton(context, "Türkçe", "tr", "TR"),
              SizedBox(height: 30),
              _getLanguageButton(context, "English", "en", "US"),
              SizedBox(height: 30),
              _getLanguageButton(context, "عربي", "ar", "SA"),
            ],
          ),
        ),
      ),
    );
  }

  _getLanguageButton(BuildContext context, String label, String l1, String l2) {
    if (_currentLanguage == l1) {
      return CustomAppButton.black(
          buttonName: label,
          buttonFunction: () {
            Get.updateLocale(Locale(l1, l2));
            GetStorage box = GetStorage();
            box.write("languagePreference", l1);
            _currentLanguage == null
                ? Navigator.pushReplacementNamed(
                    context, BottomBarScreen.routeName)
                : Navigator.of(context).pop();
          });
    } else {
      return CustomAppButton(
          buttonName: label,
          buttonFunction: () {
            Get.updateLocale(Locale(l1, l2));
            GetStorage box = GetStorage();
            box.write("languagePreference", l1);
            _currentLanguage == null
                ? Navigator.pushReplacementNamed(
                    context, BottomBarScreen.routeName)
                : Navigator.of(context).pop();
          });
    }
  }

  AppBar _getAppBar(BuildContext context) {
    ProfileCubit _profileCubit = context.read<ProfileCubit>();
    return AppBar(
        leadingWidth: 100,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => context
                  .read<BottomBarCubit>()
                  .switchScreen(BottomBarScreens.ProfileScreen, context),
              child: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                backgroundColor: Colors.grey.shade300,
                radius: 20,
              ),
            ),
            if (_profileCubit.userProfile != null)
              Text(
                "${'Hi'.tr} \n${_profileCubit.userProfile!.name}\n${_profileCubit.userProfile!.surName.toUpperCase()}",
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.left,
              )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NotificationsScreen.routeName);
              },
              icon: Icon(Icons.notifications_outlined))
        ],
        title: SizedBox(
            width: context.screenWidth / 2.7,
            child: Image.asset(kAlfaTextLogo)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black);
  }
}
