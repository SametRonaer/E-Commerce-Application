import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/screens/search_screen/cubit/search_screen_cubit.dart';
import 'package:alfa_application/widgets/customer_search_list_tile.dart';
import 'package:alfa_application/widgets/product_edit_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchScreenCubit, SearchScreenState>(
      builder: (context, state) {
        return _getCurrentSearchField(state, context);
      },
    );
  }

  _getCurrentSearchField(SearchScreenState state, BuildContext context) {
    if (state is SearchScreenCustomerProductList) {
      return _getCustomerProductList(context);
    } else if (state is SearchScreenEmployeeProductList) {
      return _getEmployeeProductList(context);
    } else {
      return _getEmployeeProductList(context);
    }
  }

  _getEmployeeProductList(BuildContext context) {
    return Container(
      height: context.screenHeight / 1.4,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: (_, i) {
          return ProductEditListTile(
              productModel:
                  context.read<SearchScreenCubit>().filteredProducts[i]);
        },
        itemCount: context.read<SearchScreenCubit>().filteredProducts.length,
      ),
    );
  }

  _getCustomerProductList(BuildContext context) {
    return Container(
      height: context.screenHeight / 1.4,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: (_, i) {
          return CustomerSearchListTile(
              productModel:
                  context.read<SearchScreenCubit>().filteredProducts[i]);
        },
        itemCount: context.read<SearchScreenCubit>().filteredProducts.length,
      ),
    );
  }
}
