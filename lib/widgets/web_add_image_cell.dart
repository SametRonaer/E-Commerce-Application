import 'dart:typed_data';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:flutter/material.dart';

class WebAddImageCell extends StatefulWidget {
  bool? isMainImage;
  bool? isAvatar;
  dynamic cubit;
  double? size;
  int? index;
  WebAddImageCell(
      {Key? key,
      this.size,
      this.isMainImage = false,
      this.index,
      required this.cubit,
      this.isAvatar = false})
      : super(key: key);

  @override
  State<WebAddImageCell> createState() => _WebAddImageCellState();
}

class _WebAddImageCellState extends State<WebAddImageCell> {
  Uint8List? imageFile;

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
                  print("Helloo");
                  imageFile =
                      await widget.cubit.setWebPickedImage(isMainImage: true);
                  setState(() {});
                },
                child: Container(
                  child: imageFile != null
                      ? Stack(
                          alignment: Alignment.topRight,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.memory(
                                imageFile!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            IconButton(
                                padding: EdgeInsets.all(4),
                                alignment: Alignment.topRight,
                                onPressed: () {
                                  setState(() {
                                    imageFile = null;
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
                  imageFile = await widget.cubit.setWebPickedImage();
                  setState(() {});
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: widget.size ?? 80,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: imageFile != null
                          ? Image.memory(imageFile!).image
                          : null,
                    ),
                    imageFile == null
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
                                    imageFile = null;
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
                  imageFile = await widget.cubit.setWebPickedImage();
                  setState(() {});
                },
                child: Stack(
                  children: [
                    Container(
                      child: imageFile != null
                          ? Stack(
                              alignment: Alignment.topRight,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.memory(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                IconButton(
                                    padding: EdgeInsets.all(4),
                                    alignment: Alignment.topRight,
                                    onPressed: () {
                                      setState(() {
                                        imageFile = null;
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
