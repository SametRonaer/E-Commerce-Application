import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/product_screen/ui/product_screen_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/product_model.dart';

class CustomerSearchListTile extends StatelessWidget {
  CustomerSearchListTile({Key? key, required this.productModel})
      : super(key: key);

  ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context
                            .read<ProductsCubit>()
                            .setSelectedProduct(productModel);
                        Navigator.of(context)
                            .pushNamed(ProductScreen.routeName);
                      },
                      child: Container(
                        color: Colors.white,
                        height: 70,
                        width: 60,
                        child: (productModel.productImageList!.length > 0)
                            ? CachedNetworkImage(
                                fit: BoxFit.fitHeight,
                                imageUrl: productModel
                                        .productImageList!.first ??
                                    "https://son-haberler.com/wp-content/uploads/2020/12/stack-of-golden-bars-in-the-bank-vault-60756080_16x9.jpg")
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productModel.productTitle!,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                productModel.productId!,
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    kGetGoldPercentLabelOfProduct(
                                        productModel.goldPercent.toString()),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    kGetWeightLabelOfProduct(
                                        productModel.productWeight!),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                productModel.productColorType ?? "Empty",
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 3),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: IconButton(
                      icon: Icon(Icons.shopping_bag),
                      onPressed: () {
                        context
                            .read<ProfileCubit>()
                            .addProductToCart(productModel.productId!);
                      },
                    )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(
            height: 0,
            thickness: 0.7,
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }
}
