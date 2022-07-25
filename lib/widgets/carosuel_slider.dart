import 'package:alfa_application/data/model/carosuel_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/carosuel_cubit/cubit/carosuels_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CarosuelCell extends StatelessWidget {
  CarosuelModel carosuelModel;
  bool hasDeleteButton;
  CarosuelCell({
    Key? key,
    this.hasDeleteButton = false,
    required this.carosuelModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: carosuelModel.carosuelImageUrl,
                fit: BoxFit.fitWidth,
                // placeholder: (context, url) =>
                //     Center(child: SpinKitSpinningLines(color: Colors.white)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            )),
        if (hasDeleteButton)
          GestureDetector(
            onTap: () {
              _showRemoveDialogBar(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete_outline,
                size: 30,
                color: Colors.grey,
              ),
            ),
          )
      ],
    );
  }

  _showRemoveDialogBar(BuildContext context) {
    Get.defaultDialog(
      title: "Remove Banner!",
      middleText: "Are you sure to remove this banner?",
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
              .read<CarosuelsCubit>()
              .deleteCarosuel(carosuelModel.carosuelId);
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
