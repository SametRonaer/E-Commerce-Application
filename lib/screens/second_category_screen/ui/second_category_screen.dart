import 'package:alfa_application/general_cubits/second_category_cubit/cubit/second_category_cubit.dart';
import 'package:alfa_application/widgets/second_category_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../general_cubits/products_cubit/cubit/products_cubit.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';

class SecondCategoryScreen extends StatelessWidget {
  static const routeName = "/second-category-screen";
  const SecondCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondCategoryCubit, SecondCategoryState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.grey.shade300,
            bottomNavigationBar: AppBottomNavigationBar(Colors.grey.shade300),
            appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                // leading: IconButton(
                //   icon: Icon(
                //     Icons.keyboard_arrow_left,
                //     color: Colors.white,
                //   ),
                //   onPressed: () => Navigator.of(context).pop(),
                // ),
                backgroundColor: Colors.black,
                title: Text(
                  "Collections".tr,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            body: _getSecondCategoryGrid(context));
      },
    );
  }

  Widget _getSecondCategoryGrid(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade300),
          margin: EdgeInsets.only(top: 5, right: 5, left: 5),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              itemCount: context
                  .read<SecondCategoryCubit>()
                  .allSecondCategories
                  .length,
              itemBuilder: (_, i) {
                return SecondCategoryCell.WithTitle(
                    secondCategoryModel: context
                        .read<SecondCategoryCubit>()
                        .allSecondCategories[i]);
              })),
    );
  }
}
