import 'package:alfa_application/screens/auth_screens/sign_in_screen/cubit/sign_in_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RememberMeButton extends StatefulWidget {
  RememberMeButton({Key? key, required this.email, required this.password})
      : super(key: key);
  TextEditingController email;
  TextEditingController password;
  bool isSelected = true;
  saveData(BuildContext context) {
    if (isSelected) {
      context.read<SignInCubit>().saveUserData(email.text, password.text);
    } else {
      context.read<SignInCubit>().deleteUserData();
    }
  }

  @override
  State<RememberMeButton> createState() => _RememberMeButtonState();
}

class _RememberMeButtonState extends State<RememberMeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
      },
      child: Row(
        children: [
          Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: widget.isSelected ? Colors.grey.shade400 : Colors.white,
                border: Border.all(color: Colors.grey.shade300)),
          ),
          SizedBox(width: 7),
          Text(
            kIsWeb ? "Beni hatırla" : "rememberMe".tr,
            style: TextStyle(
                color: Colors.grey.shade300, fontSize: kIsWeb ? 16 : 12),
          ),
        ],
      ),
    );
  }
}
