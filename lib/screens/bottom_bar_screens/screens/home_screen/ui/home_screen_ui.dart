import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/dummy_data.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/constants/image_paths.dart';
import 'package:alfa_application/data/model/category_model.dart';
import 'package:alfa_application/data/model/collection_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/carosuel_cubit/cubit/carosuels_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/general_cubits/second_category_cubit/cubit/second_category_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/cubit/bottom_bar_cubit.dart';
import 'package:alfa_application/screens/notifications_screen/ui/notifications_screen_ui.dart';
import 'package:alfa_application/screens/search_screen/cubit/search_screen_cubit.dart';
import 'package:alfa_application/screens/search_screen/ui/search_screen_ui.dart';
import 'package:alfa_application/screens/second_category_screen/ui/second_category_screen.dart';
import 'package:alfa_application/widgets/banner_cell.dart';
import 'package:alfa_application/widgets/carosuel_slider.dart';
import 'package:alfa_application/widgets/category_cell.dart';
import 'package:alfa_application/widgets/search_area.dart';
import 'package:alfa_application/widgets/second_category_cell.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../general_cubits/products_cubit/cubit/products_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  late ProductsCubit productsCubit;
  late ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    profileCubit = context.read<ProfileCubit>();
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, productCubitState) {
        productsCubit = context.read<ProductsCubit>();
        return BlocBuilder<BottomBarCubit, BottomBarState>(
          builder: (context, bootomBarCubitState) {
            return BlocBuilder<SearchScreenCubit, SearchScreenState>(
              builder: (context, searchState) {
                return BlocBuilder<CarosuelsCubit, CarosuelsState>(
                  builder: (context, state) {
                    return Scaffold(
                      backgroundColor: Colors.black,
                      appBar: kGetAppBar(context),
                      body: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SearchArea(
                                searchAreaTypes:
                                    SearchAreaTypes.CustomerProducts),
                            (searchState is SearchScreenCustomerProductList)
                                ? SearchScreen()
                                : Column(
                                    children: [
                                      _getCarosuelField(context),
                                      _getCategoriesField(context),
                                      _getBannerBar(context),
                                      _getCollectionsField(context)
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Container _getCarosuelField(BuildContext context) {
    List<Widget> carosuels = context
        .read<CarosuelsCubit>()
        .allCarosuels
        .where((element) => element.carosuelType == 0)
        .map((e) => CarosuelCell(carosuelModel: e))
        .toList();
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: context.screenHeight / 3.2,
      width: double.infinity,
      child: CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1, height: context.screenHeight / 3.6),
          items: carosuels),
    );
  }

  Container _getCategoriesField(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(width: 0, color: Colors.white),
          color: Colors.white),
      height: context.screenHeight / 6,
      width: double.infinity,
      child: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories".tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => context
                        .read<BottomBarCubit>()
                        .switchScreen(BottomBarScreens.CategoryScreen, context),
                    child: Text(
                      "See All".tr,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(flex: 4, child: _getCategoriesBar(context))
        ],
      ),
    );
  }

  Widget _getCategoriesBar(BuildContext context) {
    return Container(
      color: Colors.white,
      height: context.screenHeight / 7,
      child: ListView.builder(
          itemExtent: context.screenHeight / 7,
          scrollDirection: Axis.horizontal,
          itemCount: productsCubit.allCategories.length,
          itemBuilder: (_, i) {
            return CategoryCell(categoryModel: productsCubit.allCategories[i]);
          }),
    );
  }

  Container _getCollectionsField(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(width: 0, color: Colors.white),
          color: Colors.white),
      height: context.screenHeight / 5,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Collections".tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(SecondCategoryScreen.routeName);
                  },
                  child: Text(
                    "See All".tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          _getCollectionsBar(context)
        ],
      ),
    );
  }

  Widget _getCollectionsBar(BuildContext context) {
    return Container(
        color: Colors.white,
        height: context.screenHeight / 7,
        child: ListView.builder(
            itemExtent: context.screenHeight / 7,
            scrollDirection: Axis.horizontal,
            itemCount:
                context.read<SecondCategoryCubit>().allSecondCategories.length,
            itemBuilder: (_, i) {
              return SecondCategoryCell(
                  secondCategoryModel: context
                      .read<SecondCategoryCubit>()
                      .allSecondCategories[i]);
            }));
  }

  Widget _getBannerBar(BuildContext context) {
    return Container(
      color: Colors.white,
      height: context.screenHeight / 4,
      child: ListView.builder(
          itemExtent: context.screenWidth,
          scrollDirection: Axis.horizontal,
          itemCount: context
              .read<CarosuelsCubit>()
              .allCarosuels
              .where((element) => element.carosuelType == 1)
              .length,
          itemBuilder: (_, i) => BannerCell(
              bannerImageUrl: context
                  .read<CarosuelsCubit>()
                  .allCarosuels
                  .where((element) => element.carosuelType == 1)
                  .toList()[i]
                  .carosuelImageUrl)),
      // child: ListView(
      //   itemExtent: context.screenWidth / 1,
      //   scrollDirection: Axis.horizontal,
      //   children: [
      //     BannerCell(
      //       bannerImageUrl:
      //           "https://n11-image.mncdn.com/a1/org/21/08/27/80/61/45/27/10/02/42/89/19/78387906578545461780.png",
      //     ),
      //     BannerCell(
      //       bannerImageUrl:
      //           "https://n11scdn.akamaized.net/a1/org/21/09/22/83/52/72/92/69/23/92/36/17/8890890948604573211.jpg",
      //     ),
      //   ],
      // )
    );
  }
}
