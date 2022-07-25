import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/collection_model.dart';
import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/widgets/product_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../../general_cubits/products_cubit/cubit/products_cubit.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({Key? key}) : super(key: key);
  static const routeName = "/products-list-screen";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                title: Text(
                  _getTitle(context.read<ProductsCubit>().selectedCollection!),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            body: _getProductsGrid(context));
      },
    );
  }

  Widget _getProductsGrid(BuildContext context) {
    CustomerModel? customer;
    List<ProductModel> currentProducts =
        context.read<ProductsCubit>().selectedCollectionProducts;
    if (context.read<ProfileCubit>().isCustomer ?? false) {
      customer = context.read<ProfileCubit>().userProfile as CustomerModel;
      if (customer.customeGroup == CustomerTypes.Standart.toString()) {
        currentProducts = currentProducts
            .where((element) =>
                element.productVisibility !=
                ProductVisibility.Premiums.toString())
            .toList();
      } else if (customer.customeGroup == CustomerTypes.Other.toString()) {
        currentProducts = currentProducts
            .where((element) =>
                element.productVisibility == ProductVisibility.All.toString())
            .toList();
      }
    }
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 14,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1),
              itemCount: currentProducts.length,
              itemBuilder: (_, i) {
                return ProductCell(productModel: currentProducts[i]);
              })),
    );
  }

  String _getTitle(CollectionModel collectionModel) {
    String currentLanguage = GetStorage().read("languagePreference");
    if (currentLanguage == "ar") {
      return collectionModel.collectionTitleArabic ??
          collectionModel.collectionTitle ??
          collectionModel.collectionTitleTurkish ??
          "";
    } else if (currentLanguage == "tr") {
      return collectionModel.collectionTitleTurkish ??
          collectionModel.collectionTitle ??
          collectionModel.collectionTitleArabic ??
          "";
    } else {
      return collectionModel.collectionTitle ??
          collectionModel.collectionTitleArabic ??
          collectionModel.collectionTitleTurkish ??
          "";
    }
  }
}
