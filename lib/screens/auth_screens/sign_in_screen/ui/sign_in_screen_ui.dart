import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/auth_screens/forgot_password_screen/ui/forgot_password_screen_ui.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/remember_me_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../general_cubits/auth_cubit/cubit/auth_cubit.dart';
import '../cubit/sign_in_cubit.dart';

final _firestore = FirebaseFirestore.instance;

class SignInScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Map<String, String> userInfo;
  late RememberMeButton rememberMeButton;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfo = context.read<SignInCubit>().getUserData();
    _emailController.text = userInfo["email"]!;
    _passwordController.text = userInfo["password"]!;
    rememberMeButton = RememberMeButton(
        email: _emailController, password: _passwordController);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.black,
                title: Text(
                  "signIn".tr,
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
            SizedBox(width: double.infinity, height: 100),
            Text(
              "signIn".tr,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Text(
              "signSentence".tr,
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
                  CustomTextField.password(
                    controller: _passwordController,
                    hintText: "Enter your password",
                    title: "password".tr,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rememberMeButton,
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(ForgotPasswordScreen.routeName);
                          },
                          child: Text(
                            "forgotPassword".tr,
                            style: TextStyle(
                                color: Colors.red.shade300, fontSize: 12),
                          )),
                    ],
                  ),
                  SizedBox(width: double.infinity, height: 100),
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
            buttonName: "signIn".tr,
            buttonFunction: () {
              rememberMeButton.saveData(context);
              context.read<AuthCubit>().signInUser(
                  _emailController.text, _passwordController.text, context);
            },
          ),
          SizedBox(height: 25)
        ],
      ),
    );
  }
}
