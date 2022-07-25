part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoaded extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {}
