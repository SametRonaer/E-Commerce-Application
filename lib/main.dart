import 'package:alfa_application/constants/languages.dart';
import 'package:alfa_application/general_cubits/auth_cubit/cubit/auth_cubit.dart';
import 'package:alfa_application/general_cubits/carosuel_cubit/cubit/carosuels_cubit.dart';
import 'package:alfa_application/general_cubits/customers_cubit/cubit/customers_cubit.dart';
import 'package:alfa_application/general_cubits/notification_cubit/cubit/notification_cubit.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/general_cubits/transactions_cubit/cubit/transactions_cubit.dart';
import 'package:alfa_application/routing/app_router.dart';
import 'package:alfa_application/screens/auth_screens/change_password_screen/cubit/change_password_cubit.dart';
import 'package:alfa_application/screens/auth_screens/forgot_password_screen/cubit/forgot_password_cubit.dart';
import 'package:alfa_application/screens/auth_screens/sign_in_screen/ui/sign_in_screen_ui.dart';
import 'package:alfa_application/screens/auth_screens/sign_in_screen/ui/web_sign_in_screen_ui.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/cart_screen/cubit/cart_screen_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/employee_home_screen/cubit/employee_home_screen_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/ui/bottom_bar_ui.dart';
import 'package:alfa_application/screens/edit_screens/carosuel_edit_screen/cubit/carosuel_edit_cubit.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_add_edit_screens/cubit/category_add_edit_screens_cubit.dart';
import 'package:alfa_application/screens/edit_screens/customers_edit_screen/customer_add_edit_screens/cubit/customer_add_edit_cubit.dart';
import 'package:alfa_application/screens/edit_screens/employee_edit_screen/employee_add_edit_screens/cubit/employee_add_edit_cubit.dart';
import 'package:alfa_application/screens/edit_screens/models_edit_screen/model_add_edit_screens/cubit/model_add_edit_cubit.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/cubit/product_add_screen_cubit.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_add_edit_screens/cubit/second_category_add_edit_cubit.dart';
import 'package:alfa_application/screens/first_language_selection_screen/first_language_selection_screen.dart';
import 'package:alfa_application/screens/order_progress_screen/cubit/order_progress_cubit.dart';
import 'package:alfa_application/screens/search_screen/cubit/search_screen_cubit.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/screens/web_screens/web_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'general_cubits/employee_cubit/cubit/employee_cubit.dart';
import 'general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'general_cubits/second_category_cubit/cubit/second_category_cubit.dart';
import 'screens/auth_screens/sign_in_screen/cubit/sign_in_cubit.dart';
import 'screens/bottom_bar_screens/cubit/bottom_bar_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  await GetStorage.init();

  if (kIsWeb) {
    await _setFirebaseConfigurationForWeb();
  } else {
    await _setFirebaseConfigurationForMobile();
  }
  runApp(MyApp());
}

_setFirebaseConfigurationForMobile() async {
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission(provisional: true);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

_setFirebaseConfigurationForWeb() async {
  await Firebase.initializeApp(
      // ignore: prefer_const_constructors
    //************************ */
    //************************ */
    //************************ */
    //************************ */
    //************************ */
    //************************ */
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final _box = GetStorage();
  String? _languagePreference;
  Locale? _deviceLocale;

  @override
  Widget build(BuildContext context) {
    String initialRoute = _getInitialRouteAndDetectLanguagePreferences();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsCubit()),
        BlocProvider(create: (context) => CustomersCubit()),
        BlocProvider(create: (context) => EmployeeCubit()),
        BlocProvider(create: (context) => TransactionsCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProfileCubit(context)),
        BlocProvider(create: (context) => CartScreenCubit()),
        BlocProvider(create: (context) => SignInCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => ForgotPasswordCubit()),
        BlocProvider(create: (context) => ChangePasswordCubit()),
        BlocProvider(create: (context) => EmployeeHomeScreenCubit()),
        BlocProvider(create: (context) => ProductAddScreenCubit()),
        BlocProvider(create: (context) => CustomerAddEditCubit()),
        BlocProvider(create: (context) => SearchScreenCubit()),
        BlocProvider(create: (context) => CategoryAddEditScreensCubit()),
        BlocProvider(create: (context) => EmployeeAddEditCubit()),
        BlocProvider(create: (context) => SecondCategoryAddEditCubit()),
        BlocProvider(lazy: false, create: (context) => SecondCategoryCubit()),
        BlocProvider(create: (context) => ModelAddEditCubit()),
        BlocProvider(create: (context) => CarosuelEditCubit()),
        BlocProvider(lazy: false, create: (context) => CarosuelsCubit()),
        BlocProvider(create: (context) => BottomBarCubit()),
        BlocProvider(lazy: false, create: (context) => WebHomeCubit()),
        BlocProvider(
          create: (context) => OrderProgressCubit(),
        ),
      ],
      child: GetMaterialApp(
        scrollBehavior:
            ScrollConfiguration.of(context).copyWith(scrollbars: false),
        translations: Languages(),
        fallbackLocale: _deviceLocale ?? const Locale('en', 'US'),
        locale: kIsWeb ? const Locale('en', 'US') : _deviceLocale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
        )),

        initialRoute: kIsWeb ? WebSignInScreen.routeName : initialRoute,
        //initialRoute: kIsWeb ? WebHomeScreen.routeName : initialRoute,
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }

  String _getInitialRouteAndDetectLanguagePreferences() {
    _languagePreference = _box.read("languagePreference");
    if (_languagePreference == null) {
      return FirstLanguageSelectionScreen.routeName;
    } else {
      _setDeviceLanguage(_languagePreference!);
      return BottomBarScreen.routeName;
    }
  }

  _setDeviceLanguage(String language) {
    if (language == "tr") {
      _deviceLocale = Locale("tr", "TR");
    } else if (language == "ar") {
      _deviceLocale = Locale("ar", "SA");
    } else {
      _deviceLocale = Locale("en", "US");
    }
  }
}
