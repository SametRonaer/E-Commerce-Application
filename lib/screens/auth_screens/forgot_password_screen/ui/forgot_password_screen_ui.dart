import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/auth_screens/forgot_password_screen/cubit/forgot_password_cubit.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_app_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  static const routeName = "/forgot-password-screen";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.black,
                title: Text(
                  "Reset Password".tr,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            backgroundColor: Colors.black,
            body: Container(
              height: context.screenHeight,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_getInputField(), _getButtonField(context)],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getInputField() {
    return Container(
      margin: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: double.infinity, height: 150),
            Text(
              "Reset Password".tr,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Text(
              "Write your email".tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _emailController,
                    hintText: "Enter your email address",
                    title: "email".tr,
                  ),
                  SizedBox(width: double.infinity, height: 150),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getButtonField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 14, left: 14, bottom: 14),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 25,
          ),
          CustomAppButton.black(
            buttonName: "Send Email".tr,
            buttonFunction: () {
              context
                  .read<ForgotPasswordCubit>()
                  .sendEmailAddress(_emailController.text, context);
            },
          ),
          SizedBox(height: 25)
        ],
      ),
    );
  }
}
