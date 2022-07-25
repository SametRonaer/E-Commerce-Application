part of 'order_progress_cubit.dart';

@immutable
abstract class OrderProgressState {}

class OrderProgressInitial extends OrderProgressState {}

class OrderProgressLoading extends OrderProgressState {}

class OrderProgressLoaded extends OrderProgressState {}
