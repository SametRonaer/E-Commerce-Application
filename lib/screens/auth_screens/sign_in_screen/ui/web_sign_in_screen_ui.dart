import 'package:alfa_application/constants/image_paths.dart';
import 'package:alfa_application/general_cubits/auth_cubit/cubit/auth_cubit.dart';
import 'package:alfa_application/screens/auth_screens/sign_in_screen/cubit/sign_in_cubit.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/remember_me_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebSignInScreen extends StatelessWidget {
  WebSignInScreen({Key? key}) : super(key: key);
  static const routeName = "web-sign-in-screen";
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
              width: 180,
              child: Image.asset(
                kAlfaLogoPng,
                fit: BoxFit.fitWidth,
              )),
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Center(
          child: Container(
        height: 450,
        width: 450,
        padding: EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Admin Paneli",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            CustomTextField(
              controller: _emailController,
              hintText: "Email adresi..",
            ),
            CustomTextField.password(
              controller: _passwordController,
              hintText: "Şifre..",
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RememberMeButton(
                    email: _emailController, password: _passwordController),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Şifremi unuttum",
                      style:
                          TextStyle(fontSize: 16, color: Colors.red.shade700),
                    )),
              ],
            ),
            SizedBox(height: 38),
            CustomAppButton.black(
              buttonName: "Giriş",
              buttonFunction: () {
                context.read<AuthCubit>().signInUser(
                    _emailController.text, _passwordController.text, context);
              },
            )
          ],
        ),
      )),
    );
  }
}
