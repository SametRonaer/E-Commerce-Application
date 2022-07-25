import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/ui/product_add_screen.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/ui/web_product_add_screen.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/widgets/web_product_edit_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebProductsEditListScreen extends StatelessWidget {
  WebProductsEditListScreen({Key? key}) : super(key: key);

  late List<ProductModel> _sortedProductList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        _sortProducts(context);
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "PRODUCTS",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<WebHomeCubit>()
                            .switchCurrentScreen(WebProductAddScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.add_circle_outline, size: 35),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Divider(thickness: 0.7, color: Colors.grey.shade700),
                SizedBox(
                    height: context.screenHeight / 1.45,
                    width: double.infinity,
                    child: ListView.builder(
                        itemBuilder: (_, i) => WebProductEditListTile(
                            productModel: _sortedProductList[i]),
                        itemCount: _sortedProductList.length)),
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
