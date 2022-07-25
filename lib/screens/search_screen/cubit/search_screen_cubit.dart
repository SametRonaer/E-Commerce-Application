import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/data/model/profile_abstract_model.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_screen_state.dart';

class SearchScreenCubit extends Cubit<SearchScreenState> {
  SearchScreenCubit() : super(SearchScreenInitial());
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> get filteredProducts => _filteredProducts;

  search(String value, BuildContext context, SearchAreaTypes searchAreaType) {
    if (value == "") {
      emit(SearchScreenDisabled());
    } else if (searchAreaType == SearchAreaTypes.EmployeeProducts) {
      _getFilteredProducts(context, value);
      emit(SearchScreenEmployeeProductList());
    } else if (searchAreaType == SearchAreaTypes.CustomerProducts) {
      _getFilteredProducts(context, value);
      emit(SearchScreenCustomerProductList());
    }
  }

  _getFilteredProducts(BuildContext context, String value) {
    _filteredProducts.clear();
    _filteredProducts = context
        .read<ProductsCubit>()
        .allProducts
        .where((element) =>
            element.productTitle!.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  disabelArea() {
    emit(SearchScreenDisabled());
  }
}
