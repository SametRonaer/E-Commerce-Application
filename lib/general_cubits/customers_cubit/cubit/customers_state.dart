part of 'customers_cubit.dart';

@immutable
abstract class CustomersState {}

class CustomersInitial extends CustomersState {}

class CustomersLoading extends CustomersState {}

class CustomersLoaded extends CustomersState {}

class CustomersError extends CustomersState {}
