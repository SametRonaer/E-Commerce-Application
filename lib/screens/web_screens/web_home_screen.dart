import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/constants/image_paths.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/employee_home_screen/cubit/employee_home_screen_cubit.dart';
import 'package:alfa_application/screens/edit_screens/carosuel_edit_screen/ui/web_carosuel_edit_screen.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_edit_list_web.dart';
import 'package:alfa_application/screens/edit_screens/customers_edit_screen/web_customers_edit_list_screen.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/web_employee_edit_list_screen.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/ui/web_products_edit_list_screen_ui.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/web_second_category_edit_list_screen.dart';
import 'package:alfa_application/screens/notifications_screen/ui/web_notifications_screen_ui.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/widgets/web_menu_button.dart';
import 'package:alfa_application/widgets/web_transactions_list_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../edit_screens/models_edit_screen/model_add_edit_screens/web_model_edit_list_screen.dart';

class WebHomeScreen extends StatelessWidget {
  WebHomeScreen({Key? key}) : super(key: key);
  static const routeName = "/web-home-screen";
  TextStyle _titleStyle =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  TextStyle _subTitleStyle =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400);
  double _titleGap = 35;
  double _subtitleGap = 20;
  double _itemGap = 15;
  late WebHomeCubit _webHomeCubit;

  @override
  Widget build(BuildContext context) {
    _webHomeCubit = context.read<WebHomeCubit>();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getMenuBar(context),
                Column(
                  children: [
                    _getTopButtonsArea(),
                    SizedBox(height: 50),
                    BlocBuilder<WebHomeCubit, WebHomeState>(
                      builder: (context, state) {
                        return Container(
                            padding: EdgeInsets.only(left: 20),
                            height: 1000,
                            width: 1200,
                            child: _webHomeCubit.currentScreen);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Row _getTopButtonsArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 40),
            WebMenuButton(
                buttonFunction: () {
                  _webHomeCubit
                      .switchCurrentScreen(WebCategoryEditListScreen());
                },
                buttonIcon: Icons.category_outlined,
                buttonLabel: "CATEGORIES"),
            SizedBox(width: 20),
            WebMenuButton(
                buttonFunction: () {
                  _webHomeCubit
                      .switchCurrentScreen(WebProductsEditListScreen());
                },
                buttonIcon: Icons.category_outlined,
                buttonLabel: "PRODUCTS"),
            SizedBox(width: 20),
            WebMenuButton(
                buttonFunction: () {
                  _webHomeCubit
                      .switchCurrentScreen(WebCustomersEditListScreen());
                },
                buttonIcon: Icons.person_outline,
                buttonLabel: "CUSTOMERS"),
            SizedBox(width: 20),
            WebMenuButton(
                buttonFunction: () {
                  _webHomeCubit
                      .switchCurrentScreen(WebEmployeesEditListScreen());
                },
                buttonIcon: Icons.people_outlined,
                buttonLabel: "EMPLOYEES"),
          ],
        ),
        SizedBox(width: 200),
        Column(
          children: [
            Text("Merhaba"),
            GestureDetector(
                onTap: () =>
                    _webHomeCubit.switchCurrentScreen(WebNotificationsScreen()),
                child: Icon(Icons.notifications_outlined,
                    color: Colors.black, size: 35)),
          ],
        ),
      ],
    );
  }

  Widget _getMenuBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30),
      height: 1200,
      width: 270,
      color: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                _webHomeCubit.switchCurrentScreen(WebTransactionsListArea());
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    width: 220,
                    height: 20,
                    child: Image.asset(
                      kAlfaLogoPng,
                      fit: BoxFit.fitHeight,
                    )),
              ),
            ),
            SizedBox(height: 50),
            _getProductsField(),
            SizedBox(height: _titleGap),
            _getOrdersField(context),
            SizedBox(height: _titleGap),
            _getCustomersField(),
            SizedBox(height: _titleGap),
            _getEmployeesField(),
          ],
        ),
      ),
    );
  }

  _getProductsField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GestureDetector(
        onTap: () {
          _webHomeCubit.switchCurrentScreen(WebProductsEditListScreen());
        },
        child: FittedBox(
          child: Text(
            "PRODUCTS",
            style: _titleStyle,
          ),
        ),
      ),
      SizedBox(height: _subtitleGap),
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () =>
              _webHomeCubit.switchCurrentScreen(WebProductsEditListScreen()),
          child: Text("Products", style: _subTitleStyle)),
      SizedBox(height: _itemGap),
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () =>
              _webHomeCubit.switchCurrentScreen(WebCategoryEditListScreen()),
          child: Text("Categories", style: _subTitleStyle)),
      SizedBox(height: _itemGap),
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () =>
              _webHomeCubit.switchCurrentScreen(WebModelEditListScreen()),
          child: Text("Models", style: _subTitleStyle)),
      SizedBox(height: _itemGap),
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _webHomeCubit
              .switchCurrentScreen(WebSecondCategoryEditListScreen()),
          child: Text("Collections", style: _subTitleStyle)),
      SizedBox(height: _itemGap),
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () =>
              _webHomeCubit.switchCurrentScreen(WebCarosuelEditScreen()),
          child: Text("Banners", style: _subTitleStyle)),
    ]);
  }

  _getCustomersField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      FittedBox(
        child: GestureDetector(
          onTap: () =>
              _webHomeCubit.switchCurrentScreen(WebCustomersEditListScreen()),
          child: Text(
            "CUSTOMERS",
            style: _titleStyle,
          ),
        ),
      ),
      // SizedBox(height: _subtitleGap),
      // GestureDetector(
      //     behavior: HitTestBehavior.translucent,
      //     onTap: () {},
      //     child: Text("Premium", style: _subTitleStyle)),
      // SizedBox(height: _itemGap),
      // GestureDetector(
      //     behavior: HitTestBehavior.translucent,
      //     onTap: () {},
      //     child: Text("Standart", style: _subTitleStyle)),
      // SizedBox(height: _itemGap),
      // GestureDetector(
      //     behavior: HitTestBehavior.translucent,
      //     onTap: () {},
      //     child: Text("Other", style: _subTitleStyle)),
    ]);
  }

  _getOrdersField(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      FittedBox(
        child: GestureDetector(
          onTap: () =>
              _webHomeCubit.switchCurrentScreen(WebTransactionsListArea()),
          child: Text(
            "ORDERS",
            style: _titleStyle,
          ),
        ),
      ),
      SizedBox(height: _subtitleGap),
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            context
                .read<EmployeeHomeScreenCubit>()
                .switchTab(TransacationTabs.New, context);
            _webHomeCubit.switchCurrentScreen(WebTransactionsListArea());
          },
          child: Text("New", style: _subTitleStyle)),
      SizedBox(height: _itemGap),
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            context
                .read<EmployeeHomeScreenCubit>()
                .switchTab(TransacationTabs.Processing, context);
            _webHomeCubit.switchCurrentScreen(WebTransactionsListArea());
          },
          child: Text("Processing", style: _subTitleStyle)),
      SizedBox(height: _itemGap),
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            context
                .read<EmployeeHomeScreenCubit>()
                .switchTab(TransacationTabs.Finished, context);
            _webHomeCubit.switchCurrentScreen(WebTransactionsListArea());
          },
          child: Text("Finished", style: _subTitleStyle)),
    ]);
  }

  _getEmployeesField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      FittedBox(
        child: GestureDetector(
          onTap: () =>
              _webHomeCubit.switchCurrentScreen(WebEmployeesEditListScreen()),
          child: Text(
            "EMPLOYEES",
            style: _titleStyle,
          ),
        ),
      ),
      SizedBox(height: _subtitleGap),
      // GestureDetector(
      //     behavior: HitTestBehavior.translucent,
      //     onTap: () {},
      //     child: Text("Administor", style: _subTitleStyle)),
      // SizedBox(height: _itemGap),
      // GestureDetector(
      //     behavior: HitTestBehavior.translucent,
      //     onTap: () {},
      //     child: Text("Standart", style: _subTitleStyle)),
      // SizedBox(height: _itemGap),
      // GestureDetector(
      //     behavior: HitTestBehavior.translucent,
      //     onTap: () {},
      //     child: Text("Limited", style: _subTitleStyle)),
    ]);
  }
}
