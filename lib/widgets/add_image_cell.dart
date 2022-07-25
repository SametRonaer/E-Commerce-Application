import 'dart:io';

import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/cubit/products_edit_list_cubit.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/cubit/product_add_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddImageCell extends StatefulWidget {
  bool? isMainImage;
  bool? isAvatar;
  dynamic cubit;
  double? size;
  int? index;
  AddImageCell(
      {Key? key,
      this.size,
      this.isMainImage = false,
      this.index,
      required this.cubit,
      this.isAvatar = false})
      : super(key: key);

  @override
  State<AddImageCell> createState() => _AddImageCellState();
}

class _AddImageCellState extends State<AddImageCell> {
  String? imageFilePath;

  double littImagesSize = 4.9;
  @override
  Widget build(BuildContext context) {
    return widget.isMainImage!
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Main Image",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 3),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  imageFilePath =
                      await widget.cubit.setPickedImage(isMainImage: true);
                  setState(() {});
                },
                child: Container(
                  child: imageFilePath != null
                      ? Stack(
                          alignment: Alignment.topRight,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.file(
                                File(imageFilePath!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            IconButton(
                                padding: EdgeInsets.all(4),
                                alignment: Alignment.topRight,
                                onPressed: () {
                                  setState(() {
                                    imageFilePath = null;
                                  });
                                },
                                icon: Icon(Icons.close)),
                          ],
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 30,
                            ),
                            //  _getSavedImage(),
                          ],
                        ),
                  height: widget.size ?? context.screenWidth / 2.4,
                  width: widget.size ?? context.screenWidth / 2.4,
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          )
        : widget.isAvatar!
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  imageFilePath = await widget.cubit.setPickedImage();
                  setState(() {});
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: widget.size ?? 80,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: imageFilePath != null
                          ? Image.file(File(imageFilePath!)).image
                          : null,
                    ),
                    imageFilePath == null
                        ? Icon(Icons.add_a_photo)
                        : Container(
                            width: 180,
                            height: 150,
                            alignment: Alignment.topRight,
                            child: IconButton(
                                padding: EdgeInsets.all(4),
                                alignment: Alignment.topRight,
                                onPressed: () {
                                  setState(() {
                                    imageFilePath = null;
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 35,
                                  color: Colors.grey.shade500,
                                )),
                          ),
                  ],
                ))
            : (GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  imageFilePath = await widget.cubit.setPickedImage();
                  setState(() {});
                },
                child: Stack(
                  children: [
                    Container(
                      child: imageFilePath != null
                          ? Stack(
                              alignment: Alignment.topRight,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.file(
                                    File(imageFilePath!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                IconButton(
                                    padding: EdgeInsets.all(4),
                                    alignment: Alignment.topRight,
                                    onPressed: () {
                                      setState(() {
                                        imageFilePath = null;
                                      });
                                    },
                                    icon: Icon(Icons.close)),
                              ],
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 20,
                                ),
                                //  _getSavedImage(),
                              ],
                            ),
                      width:
                          widget.size ?? context.screenWidth / littImagesSize,
                      height:
                          widget.size ?? context.screenWidth / littImagesSize,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ));
  }

  _getSavedImage() {
    final imageList = widget.cubit.productModel.productImageList;
    if (imageList != null && imageList.length != 0) {
      if (imageList!.length >= widget.index!) {
        if (widget.index == 0) {
          return Container(
            width: widget.size ?? context.screenWidth / 2.4,
            height: widget.size ?? context.screenWidth / 2.4,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                imageList[widget.index!],
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          if (imageList[widget.index] != null &&
              imageList[widget.index] != "") {
            return Container(
              width: widget.size ?? context.screenWidth / littImagesSize,
              height: widget.size ?? context.screenWidth / littImagesSize,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  imageList[widget.index!],
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        }
      } else {
        return SizedBox();
      }
    } else {
      return SizedBox();
    }
  }
}
