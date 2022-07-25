import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/ui/bottom_bar_ui.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';
import '../screens/bottom_bar_screens/cubit/bottom_bar_cubit.dart';

class AppBottomNavigationBar extends StatefulWidget {
  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
  Color? bottomColor;
  AppBottomNavigationBar([this.bottomColor = Colors.white]);
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  late ProfileCubit profileCubit;
  TextStyle labelStyle = TextStyle(fontSize: 11, color: Colors.white);
  Widget build(BuildContext context) {
    profileCubit = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return BlocBuilder<BottomBarCubit, BottomBarState>(
          builder: (context, state) {
            BottomBarCubit bottomBarCubit = context.read<BottomBarCubit>();
            return _getBottomBar(context, bottomBarCubit, state);
          },
        );
      },
    );
  }

  Widget _getBottomBar(BuildContext context, BottomBarCubit bottomBarCubit,
      BottomBarState state) {
    bool isEmployee;
    String? cartProductAmount;
    if (profileCubit.userProfile != null &&
        profileCubit.userProfile!.userType.toString() ==
            UserTypes.Employee.toString()) {
      isEmployee = true;
    } else {
      isEmployee = false;
      cartProductAmount = profileCubit.customerCartProducts.length.toString();
    }
    return Container(
      color: Colors.amber,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white, width: 0)),
            height: context.screenHeight / 9,
            alignment: Alignment.topCenter,
            child: Container(
              height: context.screenHeight / 28,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 0),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: widget.bottomColor),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            width: double.infinity,
            height: context.screenHeight / 14,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (ModalRoute.of(context)!.canPop) {
                        Get.offAllNamed(BottomBarScreen.routeName);
                      }

                      bottomBarCubit.switchScreen(
                          isEmployee
                              ? BottomBarScreens.EmployeeHomeScreen
                              : BottomBarScreens.HomeScreen,
                          context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: (state is BottomBarHome ||
                                  state is BottomBarEmployeeHome)
                              ? Colors.white
                              : Colors.grey,
                        ),
                        FittedBox(
                          child: Text(
                            "Home".tr,
                            style: TextStyle(
                                fontSize: 11,
                                color: (state is BottomBarHome ||
                                        state is BottomBarEmployeeHome)
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (ModalRoute.of(context)!.canPop) {
                        Get.offAllNamed(BottomBarScreen.routeName);
                      }
                      bottomBarCubit.switchScreen(
                          BottomBarScreens.CategoryScreen, context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.category_outlined,
                          color: (state is BottomBarCategories)
                              ? Colors.white
                              : Colors.grey,
                        ),
                        FittedBox(
                          child: Text(
                            "Categories".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                color: (state is BottomBarCategories)
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.home, color: Colors.black),
                        FittedBox(
                          child: Text(
                            "Cart".tr,
                            style: const TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (ModalRoute.of(context)!.canPop) {
                        Get.offAllNamed(BottomBarScreen.routeName);
                      }

                      bottomBarCubit.switchScreen(
                          isEmployee
                              ? BottomBarScreens.SystemScreen
                              : BottomBarScreens.FavoritesScreen,
                          context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isEmployee ? Icons.settings : Icons.favorite_outline,
                          color: (state is BottomBarFavorites ||
                                  state is BottomBarSystem)
                              ? Colors.white
                              : Colors.grey,
                        ),
                        FittedBox(
                          child: Text(isEmployee ? "System".tr : "Favorites".tr,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: (state is BottomBarFavorites ||
                                          state is BottomBarSystem)
                                      ? Colors.white
                                      : Colors.grey)),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (ModalRoute.of(context)!.canPop) {
                        Get.offAllNamed(BottomBarScreen.routeName);
                      }
                      bottomBarCubit.switchScreen(
                          BottomBarScreens.ProfileScreen, context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: (state is BottomBarProfile)
                              ? Colors.white
                              : Colors.grey,
                        ),
                        FittedBox(
                          child: Text(
                            "Profile".tr,
                            style: TextStyle(
                                fontSize: 11,
                                color: (state is BottomBarProfile)
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: context.screenWidth / 7,
            alignment: Alignment.topCenter,
            height: context.screenHeight / 10,
            //width: double.infinity,
            color: Colors.transparent,

            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (ModalRoute.of(context)!.canPop) {
                  Get.offAllNamed(BottomBarScreen.routeName);
                }
                bottomBarCubit.switchScreen(
                    isEmployee
                        ? BottomBarScreens.OrdersScreen
                        : BottomBarScreens.CartScreen,
                    context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: context.screenWidth / 13,
                      child: cartProductAmount != null
                          ? Badge(
                              position: BadgePosition.topEnd(top: 0),
                              badgeContent: Text(cartProductAmount,
                                  style: TextStyle(color: Colors.white)),
                              child: Icon(
                                Icons.shopping_bag,
                                color: ((state is BottomBarCart) ||
                                        (state is BottomBarOrders))
                                    ? Colors.white
                                    : Colors.grey,
                                size: context.screenWidth / 11,
                              ),
                            )
                          : Icon(
                              Icons.shopping_bag,
                              color: ((state is BottomBarCart) ||
                                      (state is BottomBarOrders))
                                  ? Colors.white
                                  : Colors.grey,
                              size: context.screenWidth / 11,
                            ),
                    ),
                  ),
                  Flexible(
                      child: Text(isEmployee ? "Orders".tr : "Cart".tr,
                          style: TextStyle(
                              fontSize: 11,
                              color: ((state is BottomBarCart) ||
                                      (state is BottomBarOrders))
                                  ? Colors.white
                                  : Colors.grey)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
