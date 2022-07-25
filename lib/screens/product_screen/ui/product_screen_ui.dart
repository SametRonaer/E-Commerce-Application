import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/dummy_data.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/cubit/bottom_bar_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/ui/bottom_bar_ui.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/cubit/product_add_screen_cubit.dart';
import 'package:alfa_application/widgets/app_favorite_button.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../general_cubits/profile_cubit/cubit/profile_cubit.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../edit_screens/products_edit_list_screen/product_add_screen/ui/product_edit_screen.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);
  static const routeName = "/product-screen";
  ProductModel? _selectedProduct;
  late String productAmountInCart;
  late String _productName;
  late String _productDescription;

  @override
  Widget build(BuildContext context) {
    _selectedProduct = BlocProvider.of<ProductsCubit>(context).selectedProduct;
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => !(current is ProfileLoading),
      builder: (context, state) {
        productAmountInCart =
            context.read<ProfileCubit>().customerCartProducts.length.toString();
        _detectLanguage(context);
        return Scaffold(
            backgroundColor: Colors.black,
            bottomNavigationBar: AppBottomNavigationBar(Colors.grey.shade300),
            appBar: AppBar(
                automaticallyImplyLeading: false,
                actions: [
                  context.read<ProfileCubit>().isCustomer ?? false
                      ? GestureDetector(
                          onTap: () {
                            context.read<BottomBarCubit>().switchScreen(
                                BottomBarScreens.CartScreen, context);
                            Get.offAllNamed(BottomBarScreen.routeName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Badge(
                                position: BadgePosition.topEnd(top: 0),
                                badgeContent: Text(
                                  productAmountInCart,
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: Icon(Icons.shopping_bag)),
                          ),
                        )
                      : SizedBox(height: 2),
                ],
                title: Text(
                  "Product Detail".tr,
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.black),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 14,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                  ),
                  Container(
                    color: Colors.grey.shade300,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(8),
                          child: Stack(
                            children: [
                              _getImagesField(context),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (context
                                                .read<ProfileCubit>()
                                                .isCustomer !=
                                            null &&
                                        context
                                            .read<ProfileCubit>()
                                            .isCustomer!)
                                      AppFavoriteButton(
                                        product: _selectedProduct!,
                                        iconSize: 30,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        _getProductInfoField(context),
                        _getProductDetailsField(context)
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  Container _getProductInfoField(BuildContext context) {
    TextStyle parametersTextStyle = TextStyle(color: Colors.grey.shade400);
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 14),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      height: context.screenHeight / 3.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                _productName,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${kGetGoldPercentLabelOfProduct(_selectedProduct!.goldPercent ?? "")} / ${kGetWeightLabelOfProduct(_selectedProduct!.productWeight!)}",
                style: TextStyle(color: Colors.grey.shade400),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${'height'.tr}: ${kGetHeightLabelOfProduct(_selectedProduct!.productHeight!)}",
                    style: parametersTextStyle,
                  ),
                  Text(
                    "${'width'.tr}: ${kGetWidthLabelOfProduct(_selectedProduct!.productWidth!)}",
                    style: parametersTextStyle,
                  ),
                  Text(
                    "${'radius'.tr}: ${kGetRadiusLabelOfProduct(_selectedProduct!.productRadius!)}",
                    style: parametersTextStyle,
                  ),
                ],
              )
            ],
          ),
          if (context.read<ProfileCubit>().isCustomer != null &&
              context.read<ProfileCubit>().isCustomer!)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton.icon(
                label: Text("Add to cart"),
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  context
                      .read<ProfileCubit>()
                      .addProductToCart(_selectedProduct!.productId!);
                },
                icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
              ),
            ),
          if (context.read<ProfileCubit>().isCustomer != null &&
              !context.read<ProfileCubit>().isCustomer!)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ElevatedButton(
                    child: Text("Edit Product"),
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      context
                          .read<ProductAddScreenCubit>()
                          .setSelectedProduct(_selectedProduct!);
                      context
                          .read<ProductAddScreenCubit>()
                          .setProductColorLabel(
                              _selectedProduct!.productColorType.toString());
                      context
                          .read<ProductAddScreenCubit>()
                          .setProductGoldPercentLabel(
                              _selectedProduct!.goldPercent.toString());
                      context
                          .read<ProductAddScreenCubit>()
                          .setProductVisibilityLabel(
                              _selectedProduct!.productVisibility.toString());

                      Navigator.of(context)
                          .pushNamed(ProductEditScreen.routeName);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ElevatedButton(
                    child: Text("Delete Product"),
                    style:
                        ElevatedButton.styleFrom(primary: Colors.red.shade400),
                    onPressed: () {
                      showRemoveDialogBar(context);
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
    );
  }

  Widget _getImagesField(BuildContext context) {
    List<Widget> productImages = [];
    if (_selectedProduct!.productImageList! == null) {
      return SizedBox();
    }
    _selectedProduct!.productImageList!.forEach(
      (element) {
        productImages.add(
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: element ?? "",
                fit: BoxFit.fitHeight,
              )),
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CarouselSlider(
        items: productImages,
        options: CarouselOptions(
            viewportFraction: 1,
            enableInfiniteScroll: false,
            height: context.screenHeight / 1.6),
      ),
    );
  }

  Container _getProductDetailsField(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          children: [
            Text(
              "Product Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 4),
            Text(_productDescription)
          ],
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: double.infinity,
      //height: context.screenHeight / 3,
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
              .deleteProduct(productId: _selectedProduct!.productId!);
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

  _detectLanguage(BuildContext context) {
    String currentLanguage = GetStorage().read("languagePreference");
    if (currentLanguage == "ar") {
      _productName = _selectedProduct!.productTitleArabic ??
          _selectedProduct!.productTitle ??
          _selectedProduct!.productTitleTurkish ??
          "";
      _productDescription = _selectedProduct!.productDescriptionArabic ??
          _selectedProduct!.productDescriptionEnglish ??
          _selectedProduct!.productDescriptionTurkish ??
          "";
    } else if (currentLanguage == "tr") {
      _productDescription = _selectedProduct!.productDescriptionTurkish ??
          _selectedProduct!.productDescriptionEnglish ??
          "";
      _productName = _selectedProduct!.productTitleTurkish ??
          _selectedProduct!.productTitle ??
          "";
    } else {
      _productDescription = _selectedProduct!.productDescriptionEnglish ??
          _selectedProduct!.productDescriptionTurkish ??
          "";
      _productName = _selectedProduct!.productTitle ??
          _selectedProduct!.productTitleTurkish ??
          "";
    }
  }
}
