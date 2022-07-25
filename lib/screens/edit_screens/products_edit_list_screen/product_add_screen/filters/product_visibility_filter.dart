import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/cubit/products_edit_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product_add_screen_cubit.dart';

class ProductVisibilityFilter extends StatelessWidget {
  ProductVisibilityFilter({Key? key, this.textStyle}) : super(key: key);
  late ProductAddScreenCubit productsAddCubit;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    productsAddCubit = context.read<ProductAddScreenCubit>();
    return BlocBuilder<ProductAddScreenCubit, ProductAddScreenState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Visibility",
              style: textStyle ??
                  TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey.shade700),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: context.screenWidth / 1.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _getToggle(ProductVisibility.Premiums, "Premiums"),
                  _getToggle(ProductVisibility.PremiumAndStandarts,
                      "Premium&Standarts"),
                  _getToggle(ProductVisibility.All, "All"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getToggle(ProductVisibility productVisibility, String label) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        productsAddCubit.setProductVisibility(productVisibility);
      },
      child: SizedBox(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: productsAddCubit.selectedProductVisibility ==
                          productVisibility.toString()
                      ? Colors.grey.shade400
                      : Colors.white,
                  border: Border.all(color: Colors.grey.shade300)),
            ),
            SizedBox(width: 4),
            FittedBox(child: Text(label)),
          ],
        ),
      ),
    );
  }
}
