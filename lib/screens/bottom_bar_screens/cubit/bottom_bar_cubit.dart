import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/auth_screens/sign_in_screen/ui/sign_in_screen_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(BottomBarHome());

  bool _cartProductsLoaded = false;

  void switchScreen(BottomBarScreens screen, BuildContext context) async {
    if (context.read<ProfileCubit>().userProfile == null) {
      print("Here");
      print(screen.toString());
      if (screen == BottomBarScreens.FavoritesScreen ||
          screen == BottomBarScreens.CartScreen ||
          screen == BottomBarScreens.ProfileScreen) {
        print("Here2");
        Navigator.of(context).pushNamed(SignInScreen.routeName);
        return;
      }
    }

    switch (screen) {
      case BottomBarScreens.CategoryScreen:
        emit(BottomBarCategories());
        break;
      case BottomBarScreens.EmployeeHomeScreen:
        emit(BottomBarEmployeeHome());
        break;
      case BottomBarScreens.FavoritesScreen:
        emit(BottomBarFavorites());
        break;
      case BottomBarScreens.CartScreen:
        emit(BottomBarCart());
        break;
      case BottomBarScreens.ProfileScreen:
        emit(BottomBarProfile());
        break;
      case BottomBarScreens.HomeScreen:
        emit(BottomBarHome());
        break;
      case BottomBarScreens.OrdersScreen:
        emit(BottomBarOrders());
        break;
      case BottomBarScreens.EmployeesScreen:
        emit(BottomBarEmployees());
        break;
      case BottomBarScreens.CustomersScreen:
        emit(BottomBarCustomers());
        break;
      case BottomBarScreens.ProductsScreen:
        emit(BottomBarProducts());
        break;
      case BottomBarScreens.SystemScreen:
        emit(BottomBarSystem());
        break;
    }
  }
}
