// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:alfa_application/constants/enums.dart';

abstract class Profile {
  String email;
  String password;
  String name;
  String surName;
  String userType;
  Profile({
    required this.email,
    required this.password,
    required this.name,
    required this.surName,
    required this.userType,
  });
}
