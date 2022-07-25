import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/data/model/transaction_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/general_cubits/transactions_cubit/cubit/transactions_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/cart_screen/cubit/cart_screen_cubit.dart';
import 'package:alfa_application/widgets/cart_list_tile.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/order_progress_cell.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        ProfileCubit profileCubit = context.read<ProfileCubit>();
        List<ProductModel> cartProducts = profileCubit.customerCartProducts;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text(
              "Cart".tr,
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, i) {
                      return CartListTile(
                        productModel: cartProducts[i],
                        key: Key(cartProducts[i].hashCode.toString()),
                      );
                    },
                    itemCount: cartProducts.length,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: CustomAppButton.black(
                          buttonName: "Complete Transaction".tr,
                          buttonFunction: () async {
                            context
                                .read<CartScreenCubit>()
                                .completeTransaction(context);
                          }),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15)),
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      width: double.infinity,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
