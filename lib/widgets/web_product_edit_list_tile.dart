import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/cubit/product_add_screen_cubit.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/ui/product_edit_screen.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/ui/web_products_edit_list_screen_ui.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../screens/edit_screens/products_edit_list_screen/product_add_screen/ui/web_product_edit_screen.dart';

class WebProductEditListTile extends StatelessWidget {
  WebProductEditListTile({Key? key, required this.productModel})
      : super(key: key);
  ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
                    Container(
                      color: Colors.white,
                      height: 70,
                      width: 60,
                      child: (productModel.productImageList!.length > 0)
                          ? CachedNetworkImage(
                              fit: BoxFit.fitHeight,
                              imageUrl: productModel.productImageList!.first ??
                                  "https://son-haberler.com/wp-content/uploads/2020/12/stack-of-golden-bars-in-the-bank-vault-60756080_16x9.jpg")
                          : null,
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
                                        ProductGoldPercents.TwentyFour
                                            .toString()),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            context
                                .read<ProductAddScreenCubit>()
                                .setSelectedProduct(productModel);
                            context
                                .read<ProductAddScreenCubit>()
                                .setProductColorLabel(
                                    productModel.productColorType.toString());
                            context
                                .read<ProductAddScreenCubit>()
                                .setProductGoldPercentLabel(
                                    productModel.goldPercent.toString());
                            context
                                .read<ProductAddScreenCubit>()
                                .setProductVisibilityLabel(
                                    productModel.productVisibility.toString());

                            context
                                .read<WebHomeCubit>()
                                .switchCurrentScreen(WebProductEditScreen());
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 130,
                              color: Colors.black,
                              child: Text(
                                "EDIT",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ))),
                      GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showRemoveDialogBar(context);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 130,
                              color: Colors.red.shade400,
                              child: Text(
                                "REMOVE",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ))),
                    ],
                  ),
                ),
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

  showRemoveDialogBar(BuildContext context) {
    Get.defaultDialog(
      title: "Remove Product!",
      middleText: "Are you sure to remove this product?",
      confirm: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          alignment: Alignment.center,
          height: 28,
          width: context.screenWidth / 6,
          color: Colors.black,
          child: Text(
            "Cancel",
            style: TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      cancel: GestureDetector(
        onTap: () async {
          context
              .read<ProductsCubit>()
              .deleteProduct(productId: productModel.productId!);
          Navigator.of(context).pop();
        },
        child: Container(
            alignment: Alignment.center,
            height: 28,
            width: context.screenWidth / 6,
            color: Colors.red.shade400,
            child: Text(
              "Remove",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
      ),
    );
  }
}
