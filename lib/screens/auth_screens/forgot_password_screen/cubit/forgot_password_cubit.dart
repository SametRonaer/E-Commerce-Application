import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  Future<void> sendEmailAddress(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      Get.snackbar("Success", "Email sent to your email adress",
          backgroundColor: Colors.white54);
    } catch (e) {
      print(e);
      Get.snackbar("Error appear", "Something went wrong",
          backgroundColor: Colors.white54);
    }
    Navigator.of(context).pop();
  }
}
