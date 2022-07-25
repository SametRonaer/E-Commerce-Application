import 'package:alfa_application/constants/dummy_data.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/second_category_cubit/cubit/second_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../general_cubits/products_cubit/cubit/products_cubit.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/collection_cell.dart';
import '../../../widgets/product_cell.dart';

class CollectionScreen extends StatelessWidget {
  static const routeName = "/collection-screen";
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.grey.shade300,
            bottomNavigationBar: AppBottomNavigationBar(Colors.grey.shade300),
            appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.black,
                title: Text(
                  context.read<ProductsCubit>().collectionScreenTitle,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            body: _getCollectionsGrid(context));
      },
    );
  }

  Widget _getCollectionsGrid(BuildContext context) {
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
              itemCount:
                  context.read<ProductsCubit>().filteredCollections.length,
              itemBuilder: (_, i) {
                return CollectionCell.WithTitle(
                    collectionModel:
                        context.read<ProductsCubit>().filteredCollections[i]);
              })),
    );
  }
}
