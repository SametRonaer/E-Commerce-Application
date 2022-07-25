import 'package:alfa_application/data/model/second_category_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/second_category_cubit/cubit/second_category_cubit.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_add_edit_screens/cubit/second_category_add_edit_cubit.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_add_edit_screens/ui/second_category_edit_screen.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_add_edit_screens/ui/web_second_category_edit_screen.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class WebSecondCategoryEditListTile extends StatelessWidget {
  WebSecondCategoryEditListTile({Key? key, required this.secondCategoryModel})
      : super(key: key);
  SecondCategoryModel secondCategoryModel;

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
                      child: CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          imageUrl: secondCategoryModel.secondCategoryImageUrl),
                    ),
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
                                secondCategoryModel.secondCategoryTitle ?? "",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                secondCategoryModel.secondCategoryId,
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
                                .read<SecondCategoryAddEditCubit>()
                                .setSelectedSecondCategory(secondCategoryModel);
                            context.read<WebHomeCubit>().switchCurrentScreen(
                                WebSecondCategoryEditScreen());
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
      title: "Remove Collection!",
      middleText: "Are you sure to remove this collection?",
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
              .read<SecondCategoryCubit>()
              .deleteSecondCategory(secondCategoryModel.secondCategoryId);
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
