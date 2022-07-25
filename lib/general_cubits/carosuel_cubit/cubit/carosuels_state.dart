part of 'carosuels_cubit.dart';

@immutable
abstract class CarosuelsState {}

class CarosuelsInitial extends CarosuelsState {}

class CarosuelsLoading extends CarosuelsState {}

class CarosuelsLoaded extends CarosuelsState {}
