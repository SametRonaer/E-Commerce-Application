import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/product_screen/ui/product_screen_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListTile extends StatelessWidget {
  CartListTile({Key? key, required this.productModel}) : super(key: key);
  ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ProductsCubit>(context)
            .setSelectedProduct(productModel);
        Navigator.of(context).pushNamed(ProductScreen.routeName);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: productModel.productImageList!.first ?? "",
                height: 89,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(productModel.productTitle!),
                        Text(productModel.productWeight.toString()),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<ProfileCubit>(context)
                            .deleteProductFromCart(productModel.productId!);
                      },
                      icon: Icon(Icons.delete_outline))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
