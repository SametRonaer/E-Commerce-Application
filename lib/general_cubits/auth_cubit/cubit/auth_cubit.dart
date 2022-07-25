import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/constants/firebase_error_codes.dart';
import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/data/model/employee_model.dart';
import 'package:alfa_application/data/model/profile_abstract_model.dart';
import 'package:alfa_application/general_cubits/customers_cubit/cubit/customers_cubit.dart';
import 'package:alfa_application/general_cubits/employee_cubit/cubit/employee_cubit.dart';
import 'package:alfa_application/general_cubits/notification_cubit/cubit/notification_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/cubit/bottom_bar_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/ui/bottom_bar_ui.dart';
import 'package:alfa_application/screens/web_screens/web_home_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> addNewUser(Profile userProfile) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userProfile.email, password: userProfile.password);

      if (userProfile is CustomerModel) {
        await CustomersCubit().addNewCustomer(userProfile);
        Get.snackbar("İşlem Başarılı", "Kullanıcı kaydı oluşturuldu",
            backgroundColor: Colors.white54);
      } else if (userProfile is EmployeeModel) {
        await EmployeeCubit().addNewEmployee(userProfile);
        Get.snackbar("İşlem Başarılı", "Kullanıcı kaydı oluşturuldu",
            backgroundColor: Colors.white54);
      }
      emit(AuthLoaded());
    } catch (e) {
      FirebaseAuthException exception = e as FirebaseAuthException;
      if (exception.code == kUsedEmailError) {
        print("Bu isimde bir kullanıcı zaten kayıtlı");
        Get.snackbar("Hata Oluştu", "Bu email ismi zaten sistemde kayıtlı",
            backgroundColor: Colors.white54);
      } else if (exception.code == kWeakPasswordError) {
        Get.snackbar("Hata Oluştu",
            "Parola en az bir küçük harf, büyük harf ve rakam içermelidir",
            backgroundColor: Colors.white54);
      } else if (exception.code == kInvalidEmailError) {
        Get.snackbar(
            "Hata Oluştu", "Lütfen girdiğiniz email adresini kontrol ediniz.",
            backgroundColor: Colors.white54);
      }

      emit(AuthError());
      throw e;
    }
  }

  Future<void> signInUser(
      String email, String password, BuildContext context) async {
    emit(AuthLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await BlocProvider.of<ProfileCubit>(context)
          .detectAndSetUserProfile(email);

      if (kIsWeb) {
        Get.snackbar("İşlem Başarılı", "Kullanıcı Girişi Yapıldı",
            backgroundColor: Colors.white54);
        if (!context.read<ProfileCubit>().isCustomer!) {
          Navigator.of(context).pushReplacementNamed(WebHomeScreen.routeName);
        } else {
          print("Customers cant ");
        }
      } else {
        String token = await FirebaseMessaging.instance.getToken() as String;

        if (context.read<ProfileCubit>().isCustomer!) {
          String userId =
              (context.read<ProfileCubit>().userProfile as CustomerModel)
                  .userId;
          await context
              .read<CustomersCubit>()
              .updateCustomer(newData: {"fcm": token}, userId: userId);
          context
              .read<BottomBarCubit>()
              .switchScreen(BottomBarScreens.HomeScreen, context);
        } else {
          String userId =
              (context.read<ProfileCubit>().userProfile as EmployeeModel)
                  .employeeId;
          await context
              .read<EmployeeCubit>()
              .updateEmployee(newData: {"fcm": token}, employeeId: userId);
          context
              .read<BottomBarCubit>()
              .switchScreen(BottomBarScreens.EmployeeHomeScreen, context);
        }
        Get.snackbar("İşlem Başarılı", "Kullanıcı Girişi Yapıldı",
            backgroundColor: Colors.white54);

        Navigator.of(context).pushReplacementNamed(BottomBarScreen.routeName);
      }
      emit(AuthLoaded());
    } catch (e) {
      print(e);
      print(e.runtimeType);
      if (e is FirebaseException) {
        FirebaseException exception = e;
        print(exception.code);
        if (exception.code == kWrongPasswordError) {
          Get.snackbar("Hata Oluştu", "Lütfen şifrenizi kontrol ediniz",
              backgroundColor: Colors.white54);
        } else if (exception.code == kWrongEmailError) {
          Get.snackbar("Hata Oluştu", "Lütfen email adresinizi kontrol ediniz",
              backgroundColor: Colors.white54);
        }
      }
      emit(AuthError());
    }
  }
}
