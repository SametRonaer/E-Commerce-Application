import 'dart:developer';

import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/cubit/bottom_bar_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/all_orders/ui/all_orders.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/cart_screen/ui/cart_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/categories_screen/ui/categories_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/customers_screen/ui/customers_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/employee_home_screen/ui/employe_home_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/system_screen/ui/system_screen_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../widgets/app_bottom_navigation_bar.dart';

import '../screens/favorites_screen/ui/favorites_screen_ui.dart';
import '../screens/home_screen/ui/home_screen_ui.dart';
import '../screens/profile_screen/ui/profile_screen_ui.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({Key? key}) : super(key: key);

  static const routeName = "/bottom_bar";
  late Color _bottomBarColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
      builder: (context, state) {
        _detecBottomBarColor(state);
        return SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              bool close = await _showCloseDialogBar(context);
              return close;
            },
            child: Scaffold(
                bottomNavigationBar: AppBottomNavigationBar(_bottomBarColor),
                body: _getCurrentScreen(state)),
          ),
          //    body: CategoriesScreen()),
        );
      },
    );
  }

  Widget _getCurrentScreen(BottomBarState state) {
    if (state is BottomBarHome) {
      return HomeScreen();
    } else if (state is BottomBarFavorites) {
      return FavoritesScreen();
    } else if (state is BottomBarProfile) {
      return ProfileScreen();
    } else if (state is BottomBarCart) {
      return CartScreen();
    } else if (state is BottomBarCategories) {
      return CategoriesScreen();
    } else if (state is BottomBarCustomers) {
      return CustomersScreen();
    } else if (state is BottomBarEmployeeHome) {
      return EmployeeHomeScreen();
    } else if (state is BottomBarSystem) {
      return SystemScreen();
    } else if (state is BottomBarOrders) {
      return AllOrdersScreen();
    } else {
      return HomeScreen();
    }
  }

  void _detecBottomBarColor(BottomBarState state) {
    if ((state is BottomBarEmployeeHome) ||
        (state is BottomBarOrders) ||
        (state is BottomBarFavorites) ||
        (state is BottomBarSystem)) {
      _bottomBarColor = Colors.grey.shade300;
    } else {
      _bottomBarColor = Colors.white;
    }
  }

  _showCloseDialogBar(BuildContext context) async {
    bool close = false;
    await Get.defaultDialog(
      title: "Uyarı",
      middleText: "Çıkmak istediğinize emin misiniz?",
      confirm: GestureDetector(
        onTap: () {
          close = false;
          Navigator.of(context).pop();
        },
        child: Container(
          alignment: Alignment.center,
          height: 28,
          width: context.screenWidth / 6,
          color: Colors.black,
          child: Text(
            "İptal",
            style: TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      cancel: GestureDetector(
        onTap: () {
          close = true;
          Navigator.of(context).pop();
        },
        child: Container(
            alignment: Alignment.center,
            height: 28,
            width: context.screenWidth / 6,
            color: Colors.red.shade400,
            child: Text(
              "Çık",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
      ),
    );
    print("Close is $close");
    return close;
  }
}
