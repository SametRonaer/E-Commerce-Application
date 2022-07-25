import 'package:alfa_application/data/model/category_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/auth_screens/sign_in_screen/ui/sign_in_screen_ui.dart';
import 'package:alfa_application/screens/collection_screen/ui/collection_screen_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';

class CategoryCell extends StatelessWidget {
  CategoryModel categoryModel;
  bool? isHaveTitle;
  CategoryCell({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);
  CategoryCell.WithTitle({
    Key? key,
    required this.categoryModel,
  }) : super(key: key) {
    this.isHaveTitle = true;
  }
  late ProfileCubit _profileCubit;

  @override
  Widget build(BuildContext context) {
    String currentLanguage = GetStorage().read("languagePreference");
    _profileCubit = context.read<ProfileCubit>();
    return isHaveTitle == null
        ? GestureDetector(
            onTap: () async {
              if (_profileCubit.userProfile == null) {
                Navigator.of(context).pushNamed(SignInScreen.routeName);
              } else {
                await context.read<ProductsCubit>().getCategoryByCategoryId(
                    categoryId: categoryModel.categoryId);
                Navigator.of(context).pushNamed(CollectionScreen.routeName);
                await context
                    .read<ProductsCubit>()
                    .getProductsWithCategoryId(category: categoryModel);
              }
            },
            child: Container(
              child: Container(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: categoryModel.categoryImageUrl,
                  fit: BoxFit.fitWidth,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
            ))
        : GestureDetector(
            onTap: () async {
              if (_profileCubit.userProfile == null) {
                Navigator.of(context).pushNamed(SignInScreen.routeName);
              } else {
                await context.read<ProductsCubit>().getCategoryByCategoryId(
                    categoryId: categoryModel.categoryId);
                Navigator.of(context).pushNamed(CollectionScreen.routeName);
                await context
                    .read<ProductsCubit>()
                    .getProductsWithCategoryId(category: categoryModel);
              }
            },
            child: Column(
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    height: context.screenWidth / 4,
                    width: context.screenWidth / 4,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: categoryModel.categoryImageUrl,
                        fit: BoxFit.fitWidth,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Flexible(child: Text(_getTitle()))
              ],
            ));
  }

  String _getTitle() {
    String currentLanguage = GetStorage().read("languagePreference");
    if (currentLanguage == "ar") {
      return categoryModel.categoryTitleArabic ??
          categoryModel.categoryTitle ??
          categoryModel.categoryTitleTurkish ??
          "";
    } else if (currentLanguage == "tr") {
      return categoryModel.categoryTitleTurkish ??
          categoryModel.categoryTitle ??
          categoryModel.categoryTitleArabic ??
          "";
    } else {
      return categoryModel.categoryTitle ??
          categoryModel.categoryTitleTurkish ??
          categoryModel.categoryTitleArabic ??
          "";
    }
  }
}
