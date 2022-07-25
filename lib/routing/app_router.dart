import 'package:alfa_application/screens/auth_screens/forgot_password_screen/ui/forgot_password_screen_ui.dart';
import 'package:alfa_application/screens/auth_screens/sign_in_screen/ui/web_sign_in_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/all_orders/ui/all_orders.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/employee_home_screen/ui/employe_home_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/employee_info_screen/ui/employee_info_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/ui/bottom_bar_ui.dart';
import 'package:alfa_application/screens/collection_screen/ui/collection_screen_ui.dart';
import 'package:alfa_application/screens/customer_info_screen/ui/customer_info_screen_ui.dart';
import 'package:alfa_application/screens/customer_transactions_screen/ui/customer_transactions_screen_ui.dart';
import 'package:alfa_application/screens/dummy_screen.dart';
import 'package:alfa_application/screens/edit_screens/carosuel_edit_screen/ui/carosuel_edit_screen.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_add_edit_screens/ui/category_add_screen.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_add_edit_screens/ui/category_edit_screen.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_edit_list_screen.dart';
import 'package:alfa_application/screens/edit_screens/customers_edit_screen/customer_add_edit_screens/ui/customer_add_screen_ui.dart';
import 'package:alfa_application/screens/edit_screens/customers_edit_screen/customer_add_edit_screens/ui/cutomer_edit_screen_ui.dart';
import 'package:alfa_application/screens/edit_screens/customers_edit_screen/customers_edit_list_screen.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/employee_add_edit_screens/ui/employee_add_screen.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/employee_add_edit_screens/ui/employee_edit_screen.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/employee_edit_list_screen.dart';
import 'package:alfa_application/screens/edit_screens/models_edit_screen/model_add_edit_screens/ui/model_add_screen.dart';
import 'package:alfa_application/screens/edit_screens/models_edit_screen/model_add_edit_screens/ui/model_edit_screen.dart';
import 'package:alfa_application/screens/edit_screens/models_edit_screen/model_edit_list_scrren_ui.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/ui/product_add_screen.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/ui/product_edit_screen.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/ui/products_edit_list_screen_ui.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_add_edit_screens/ui/second_category_add_screen.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_add_edit_screens/ui/second_category_edit_screen.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_edit_list_screen_ui.dart';
import 'package:alfa_application/screens/first_language_selection_screen/first_language_selection_screen.dart';
import 'package:alfa_application/screens/notifications_screen/ui/notifications_screen_ui.dart';
import 'package:alfa_application/screens/order_progress_screen/ui/order_progress_screen_ui.dart';
import 'package:alfa_application/screens/product_screen/ui/product_screen_ui.dart';
import 'package:alfa_application/screens/products_list_screen/ui/products_list_screen_ui.dart';
import 'package:alfa_application/screens/second_category_screen/ui/second_category_screen.dart';
import 'package:alfa_application/screens/web_screens/web_home_screen.dart';
import 'package:flutter/material.dart';
import '../screens/auth_screens/sign_in_screen/ui/sign_in_screen_ui.dart';
import '../screens/collection_screen/ui/collection_screen_ui.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case BottomBarScreen.routeName:
        return MaterialPageRoute(builder: (_) => BottomBarScreen());
      case ProductScreen.routeName:
        return MaterialPageRoute(builder: (_) => ProductScreen());
      case CollectionScreen.routeName:
        return MaterialPageRoute(builder: (_) => CollectionScreen());
      case DummyScreen.routeName:
        return MaterialPageRoute(builder: (_) => DummyScreen());
      case SignInScreen.routeName:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case ProductAddScreen.routeName:
        return MaterialPageRoute(builder: (_) => ProductAddScreen());
      case ProductsListScreen.routeName:
        return MaterialPageRoute(builder: (_) => ProductsListScreen());
      case CustomerTransactionsScreen.routeName:
        return MaterialPageRoute(builder: (_) => CustomerTransactionsScreen());
      case OrderProgressScreen.routeName:
        return MaterialPageRoute(builder: (_) => OrderProgressScreen());
      case NotificationsScreen.routeName:
        return MaterialPageRoute(builder: (_) => NotificationsScreen());
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case CustomerInfoScreen.routeName:
        return MaterialPageRoute(builder: (_) => CustomerInfoScreen());
      case EmployeeHomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => EmployeeHomeScreen());
      case ProductsEditListScreen.routeName:
        return MaterialPageRoute(builder: (_) => ProductsEditListScreen());
      case ProductAddScreen.routeName:
        return MaterialPageRoute(builder: (_) => ProductAddScreen());
      case CategoryEditListScreen.routeName:
        return MaterialPageRoute(builder: (_) => CategoryEditListScreen());
      case CustomersEditListScreen.routeName:
        return MaterialPageRoute(builder: (_) => CustomersEditListScreen());
      case EmployeesEditListScreen.routeName:
        return MaterialPageRoute(builder: (_) => EmployeesEditListScreen());
      case CustomerAddScreen.routeName:
        return MaterialPageRoute(builder: (_) => CustomerAddScreen());
      case CustomerEditScreen.routeName:
        return MaterialPageRoute(builder: (_) => CustomerEditScreen());
      case CategoryAddScreen.routeName:
        return MaterialPageRoute(builder: (_) => CategoryAddScreen());
      case CategoryEditScreen.routeName:
        return MaterialPageRoute(builder: (_) => CategoryEditScreen());
      case EmployeeAddScreen.routeName:
        return MaterialPageRoute(builder: (_) => EmployeeAddScreen());
      case EmployeeEditScreen.routeName:
        return MaterialPageRoute(builder: (_) => EmployeeEditScreen());
      case SecondCategoryAddScreen.routeName:
        return MaterialPageRoute(builder: (_) => SecondCategoryAddScreen());
      case SecondCategoryEditScreen.routeName:
        return MaterialPageRoute(builder: (_) => SecondCategoryEditScreen());
      case ModelsEditListScreen.routeName:
        return MaterialPageRoute(builder: (_) => ModelsEditListScreen());
      case ModelAddScreen.routeName:
        return MaterialPageRoute(builder: (_) => ModelAddScreen());
      case ModelEditScreen.routeName:
        return MaterialPageRoute(builder: (_) => ModelEditScreen());
      case AllOrdersScreen.routeName:
        return MaterialPageRoute(builder: (_) => AllOrdersScreen());
      case ProductEditScreen.routeName:
        return MaterialPageRoute(builder: (_) => ProductEditScreen());
      case SecondCategoryEditListScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => SecondCategoryEditListScreen());
      case WebHomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => WebHomeScreen());
      case SecondCategoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => SecondCategoryScreen());
      case CarosuelEditScreen.routeName:
        return MaterialPageRoute(builder: (_) => CarosuelEditScreen());
      case FirstLanguageSelectionScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => FirstLanguageSelectionScreen());
      case EmployeeInfoScreen.routeName:
        return MaterialPageRoute(builder: (_) => EmployeeInfoScreen());
      case WebSignInScreen.routeName:
        return MaterialPageRoute(builder: (_) => WebSignInScreen());
      default:
        return MaterialPageRoute(builder: (_) => BottomBarScreen());
    }
  }
}
