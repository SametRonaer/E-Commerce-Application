// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/screens/product_screen/ui/product_screen_ui.dart';
import 'package:alfa_application/widgets/app_favorite_button.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';

import '../data/model/product_model.dart';
import '../general_cubits/profile_cubit/cubit/profile_cubit.dart';

class ProductCell extends StatelessWidget {
  ProductModel productModel;
  ProductCell({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  Color iconColor = Colors.grey.shade400;
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 5,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<ProductsCubit>(context)
                    .setSelectedProduct(productModel);
                Navigator.of(context).pushNamed(ProductScreen.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: productModel.productImageList!.first ?? "",
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Center(
                        child: SpinKitSpinningLines(color: Colors.black)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<ProductsCubit>(context)
                    .setSelectedProduct(productModel);
                Navigator.of(context).pushNamed(ProductScreen.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                      child: Text(
                        _getTitle(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${kGetWeightLabelOfProduct(productModel.productWeight ?? 0)}/${kGetGoldPercentLabelOfProduct(productModel.goldPercent ?? '')}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.grey.shade400),
                          ),
                          if (context.read<ProfileCubit>().isCustomer != null &&
                              context.read<ProfileCubit>().isCustomer!)
                            AppFavoriteButton(product: productModel)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    String currentLanguage = GetStorage().read("languagePreference");
    if (currentLanguage == "ar") {
      return productModel.productTitleArabic ??
          productModel.productTitle ??
          productModel.productTitleTurkish ??
          "";
    } else if (currentLanguage == "tr") {
      return productModel.productTitleTurkish ??
          productModel.productTitle ??
          productModel.productTitleArabic ??
          "";
    } else {
      return productModel.productTitle ??
          productModel.productTitleArabic ??
          productModel.productTitleTurkish ??
          "";
    }
  }
}
