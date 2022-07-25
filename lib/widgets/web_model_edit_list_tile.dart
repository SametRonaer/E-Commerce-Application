import 'package:alfa_application/data/model/collection_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/screens/edit_screens/models_edit_screen/model_add_edit_screens/ui/web_model_edit_screen.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../screens/edit_screens/models_edit_screen/model_add_edit_screens/cubit/model_add_edit_cubit.dart';

class WebModelEditListTile extends StatelessWidget {
  WebModelEditListTile({Key? key, required this.collectionModel})
      : super(key: key);
  CollectionModel collectionModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.white,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        color: Colors.white,
                        height: 70,
                        width: 60,
                        child:
                            Image.network(collectionModel.collectionImageUrl)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                collectionModel.collectionTitle ?? "",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                collectionModel.collectionId,
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            context
                                .read<ModelAddEditCubit>()
                                .setSelectedCollectionModel(collectionModel);
                            context
                                .read<WebHomeCubit>()
                                .switchCurrentScreen(WebModelEditScreen());
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 130,
                              color: Colors.black,
                              child: Text(
                                "EDIT",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ))),
                      GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showRemoveDialogBar(context);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 130,
                              color: Colors.red.shade400,
                              child: Text(
                                "REMOVE",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(
            height: 0,
            thickness: 0.7,
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }

  showRemoveDialogBar(BuildContext context) {
    Get.defaultDialog(
      title: "Remove Model!",
      middleText: "Are you sure to remove this model?",
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
              .deleteCollection(collectionId: collectionModel.collectionId);
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
}
