import 'package:alfa_application/data/model/collection_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/auth_screens/sign_in_screen/ui/sign_in_screen_ui.dart';
import 'package:alfa_application/screens/collection_screen/ui/collection_screen_ui.dart';
import 'package:alfa_application/screens/product_screen/ui/product_screen_ui.dart';
import 'package:alfa_application/screens/products_list_screen/ui/products_list_screen_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';

class CollectionCell extends StatelessWidget {
  CollectionModel collectionModel;
  bool? isHaveTitle;
  CollectionCell({
    Key? key,
    required this.collectionModel,
  }) : super(key: key);
  CollectionCell.WithTitle({
    Key? key,
    required this.collectionModel,
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
                await context.read<ProductsCubit>().getCollectionByCollectionId(
                    collectionId: collectionModel.collectionId);
                context.read<ProductsCubit>().getSelectedCollectionProducts();
                Navigator.of(context).pushNamed(CollectionScreen.routeName);
              }
            },
            child: Container(
              child: CachedNetworkImage(
                imageUrl: collectionModel.collectionImageUrl,
                fit: BoxFit.fitWidth,
                // placeholder: (context, url) => Center(
                //     child: SpinKitSpinningLines(color: Colors.black)),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
                await context.read<ProductsCubit>().getCollectionByCollectionId(
                    collectionId: collectionModel.collectionId);
                context.read<ProductsCubit>().getSelectedCollectionProducts();
                Navigator.of(context).pushNamed(ProductsListScreen.routeName);
              }
            },
            child: Column(
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: collectionModel.collectionImageUrl,
                          fit: BoxFit.fitWidth,
                          // placeholder: (context, url) => Center(
                          //     child: SpinKitSpinningLines(color: Colors.black)),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
