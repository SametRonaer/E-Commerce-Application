import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/ui/product_add_screen.dart';
import 'package:alfa_application/screens/search_screen/cubit/search_screen_cubit.dart';
import 'package:alfa_application/screens/search_screen/ui/search_screen_ui.dart';
import 'package:alfa_application/widgets/product_edit_list_tile.dart';
import 'package:alfa_application/widgets/search_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsEditListScreen extends StatelessWidget {
  ProductsEditListScreen({Key? key}) : super(key: key);
  late ProfileCubit _profileCubit;
  static const routeName = "/products-edit-list-screen";
  late List<ProductModel> _sortedProductList;

  @override
  Widget build(BuildContext context) {
    _profileCubit = context.read<ProfileCubit>();

    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        _sortProducts(context);
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: kGetAppBar(context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SearchArea(searchAreaTypes: SearchAreaTypes.EmployeeProducts),
                BlocBuilder<SearchScreenCubit, SearchScreenState>(
                  builder: (context, state) {
                    return state is SearchScreenEmployeeProductList
                        ? SearchScreen()
                        : Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 12),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "PRODUCTS",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(
                                                ProductAddScreen.routeName),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Icon(Icons.add_circle_outline),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(
                                      thickness: 0.7,
                                      color: Colors.grey.shade700),
                                  SizedBox(
                                      height: context.screenHeight / 1.45,
                                      width: double.infinity,
                                      child: ListView.builder(
                                          itemBuilder: (_, i) =>
                                              ProductEditListTile(
                                                  productModel:
                                                      _sortedProductList[i]),
                                          itemCount:
                                              _sortedProductList.length)),
                                ],
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _sortProducts(BuildContext context) {
    final primaryProducts = context
        .read<ProductsCubit>()
        .allProducts
        .where(
            (element) => element.sortStatus == SortStatuses.Primary.toString())
        .toList();
    final secondaryProducts = context.read<ProductsCubit>().allProducts.where(
        (element) => element.sortStatus == SortStatuses.Secondary.toString());
    final standartProducts = context.read<ProductsCubit>().allProducts.where(
        (element) => (element.sortStatus != SortStatuses.Secondary.toString() &&
            element.sortStatus != SortStatuses.Primary.toString()));
    _sortedProductList = [
      ...primaryProducts,
      ...secondaryProducts,
      ...standartProducts
    ];
  }
}
