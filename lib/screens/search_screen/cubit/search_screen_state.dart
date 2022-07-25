part of 'search_screen_cubit.dart';

@immutable
abstract class SearchScreenState {}

class SearchScreenInitial extends SearchScreenState {}

class SearchScreenEnabled extends SearchScreenState {}

class SearchScreenCustomerProductList extends SearchScreenState {}

class SearchScreenEmployeeProductList extends SearchScreenState {}

class SearchScreenCategory extends SearchScreenState {}

class SearchScreenDisabled extends SearchScreenState {}
