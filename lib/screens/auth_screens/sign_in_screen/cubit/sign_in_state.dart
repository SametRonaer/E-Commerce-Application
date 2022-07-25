part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInAccountNotFoundError extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInLoading extends SignInState {}