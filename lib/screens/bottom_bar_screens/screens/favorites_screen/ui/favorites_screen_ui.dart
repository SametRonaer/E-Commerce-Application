import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/widgets/product_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../../general_cubits/products_cubit/cubit/products_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // context.read<ProfileCubit>().getFavoriteProducts(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.black,
                title: Text(
                  "Favorites".tr,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            body: state is ProfileLoading
                ? SpinKitSpinningLines(color: Colors.black)
                : _getProductsGrid(context));
      },
    );
  }

  Widget _getProductsGrid(BuildContext context) {
    return Container(
      key: UniqueKey(),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade300),
          margin: EdgeInsets.only(top: 5, right: 5, left: 5),
          child: GridView.builder(
              key: UniqueKey(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 14,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1),
              itemCount:
                  context.read<ProfileCubit>().customerFavoriteProducts.length,
              itemBuilder: (_, i) {
                return ProductCell(
                    key: UniqueKey(),
                    productModel: context
                        .read<ProfileCubit>()
                        .customerFavoriteProducts[i]);
              })),
    );
  }
}
