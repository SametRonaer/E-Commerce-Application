part of 'employee_add_edit_cubit.dart';

@immutable
abstract class EmployeeAddEditState {}

class EmployeeAddEditInitial extends EmployeeAddEditState {}

class EmployeeAddEditLoading extends EmployeeAddEditState {}

class EmployeeAddEditLoaded extends EmployeeAddEditState {}
