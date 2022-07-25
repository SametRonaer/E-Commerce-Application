part of 'model_add_edit_cubit.dart';

@immutable
abstract class ModelAddEditState {}

class ModelAddEditInitial extends ModelAddEditState {}

class ModelAddEditLoading extends ModelAddEditState {}

class ModelAddEditLoaded extends ModelAddEditState {}
