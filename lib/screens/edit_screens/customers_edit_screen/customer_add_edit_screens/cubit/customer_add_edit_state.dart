part of 'customer_add_edit_cubit.dart';

@immutable
abstract class CustomerAddEditState {}

class CustomerAddEditInitial extends CustomerAddEditState {}

class CustomerAddEditLoding extends CustomerAddEditState {}

class CustomerAddEditLoaded extends CustomerAddEditState {}
