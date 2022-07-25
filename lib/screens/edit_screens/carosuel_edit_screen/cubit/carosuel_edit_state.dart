part of 'carosuel_edit_cubit.dart';

@immutable
abstract class CarosuelEditState {}

class CarosuelEditInitial extends CarosuelEditState {}

class CarosuelEditLoading extends CarosuelEditState {}

class CarosuelEditLoaded extends CarosuelEditState {}
