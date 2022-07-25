// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';

import 'package:alfa_application/data/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppFavoriteButton extends StatelessWidget {
  double? iconSize = 20;
  AppFavoriteButton({Key? key, required this.product, this.iconSize})
      : super(key: key);

  ProductModel product;

  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        ProfileCubit profileCubit = context.read<ProfileCubit>();
        if (profileCubit.userProfile is CustomerModel &&
            (profileCubit.userProfile! as CustomerModel)
                .customerFavoriteProductIds
                .contains(product.productId)) {
          isFavorite = true;
        } else {
          isFavorite = false;
        }
        return GestureDetector(
          onTap: () {
            print(product.productId);
            if (isFavorite) {
              profileCubit.deleteProductFromFavorites(
                  product.productId!, context);
            } else {
              profileCubit.addProductToFavorites(product.productId!);
            }
          },
          child: Icon(
            Icons.favorite,
            color: isFavorite ? Colors.red : Colors.grey.shade300,
            size: iconSize,
          ),
        );
      },
    );
  }
}
