import 'package:alfa_application/screens/edit_screens/carosuel_edit_screen/ui/web_carosuel_edit_screen.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/ui/web_product_add_screen.dart';
import 'package:alfa_application/screens/order_progress_screen/ui/web_order_progress_screen_ui.dart';
import 'package:alfa_application/widgets/web_transactions_list_area.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
part 'web_home_state.dart';

class WebHomeCubit extends Cubit<WebHomeState> {
  WebHomeCubit() : super(WebHomeInitial());
  Widget _currentScreen = WebTransactionsListArea();
  //Widget _currentScreen = WebProductAddScreen();
  Widget get currentScreen => _currentScreen;

  switchCurrentScreen(Widget screen) {
    _currentScreen = screen;
    emit(WebHomeLoaded());
  }
}
