import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/data/model/second_category_model.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/general_cubits/second_category_cubit/cubit/second_category_cubit.dart';
import 'package:alfa_application/screens/auth_screens/sign_in_screen/ui/sign_in_screen_ui.dart';
import 'package:alfa_application/screens/collection_screen/ui/collection_screen_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class SecondCategoryCell extends StatelessWidget {
  SecondCategoryModel secondCategoryModel;
  bool? isHaveTitle;
  SecondCategoryCell({
    Key? key,
    required this.secondCategoryModel,
  }) : super(key: key);
  SecondCategoryCell.WithTitle({
    Key? key,
    required this.secondCategoryModel,
  }) : super(key: key) {
    this.isHaveTitle = true;
  }

  @override
  Widget build(BuildContext context) {
    return isHaveTitle == null
        ? GestureDetector(
            onTap: () async {
              if (context.read<ProfileCubit>().userProfile == null) {
                Navigator.of(context).pushNamed(SignInScreen.routeName);
              } else {
                await context.read<SecondCategoryCubit>().getSecondCategoryById(
                    secondCategoryId: secondCategoryModel.secondCategoryId);
                Navigator.of(context).pushNamed(CollectionScreen.routeName);
                await context
                    .read<ProductsCubit>()
                    .getProductsWithSecondCategoryId(
                        secondCategoryModel: secondCategoryModel);
              }
            },
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: secondCategoryModel.secondCategoryImageUrl,
                  fit: BoxFit.fitWidth,
                  // placeholder: (context, url) => Center(
                  //     child: SpinKitSpinningLines(color: Colors.black)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
            ))
        : GestureDetector(
            onTap: () async {
              if (context.read<ProfileCubit>().userProfile == null) {
                Navigator.of(context).pushNamed(SignInScreen.routeName);
              } else {
                await context.read<SecondCategoryCubit>().getSecondCategoryById(
                    secondCategoryId: secondCategoryModel.secondCategoryId);
                Navigator.of(context).pushNamed(CollectionScreen.routeName);
                await context
                    .read<ProductsCubit>()
                    .getProductsWithSecondCategoryId(
                        secondCategoryModel: secondCategoryModel);
              }
            },
            child: Column(
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl:
                                secondCategoryModel.secondCategoryImageUrl,
                            fit: BoxFit.fitWidth,
                            // placeholder: (context, url) => Center(
                            //     child: SpinKitSpinningLines(color: Colors.black)),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )),
                    height: context.screenWidth / 4,
                    width: context.screenWidth / 4,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Flexible(child: Text(_getTitle()))
              ],
            ));
  }

  String _getTitle() {
    String currentLanguage = GetStorage().read("languagePreference");
    if (currentLanguage == "ar") {
      return secondCategoryModel.secondCategoryTitleArabic ??
          secondCategoryModel.secondCategoryTitle ??
          secondCategoryModel.secondCategoryTitleTurkish ??
          "";
    } else if (currentLanguage == "tr") {
      return secondCategoryModel.secondCategoryTitleTurkish ??
          secondCategoryModel.secondCategoryTitle ??
          secondCategoryModel.secondCategoryTitleArabic ??
          "";
    } else {
      return secondCategoryModel.secondCategoryTitle ??
          secondCategoryModel.secondCategoryTitleTurkish ??
          secondCategoryModel.secondCategoryTitleArabic ??
          "";
    }
  }
}
