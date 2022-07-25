import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BannerCell extends StatelessWidget {
  BannerCell({Key? key, required this.bannerImageUrl}) : super(key: key);
  String bannerImageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CachedNetworkImage(
      imageUrl: bannerImageUrl,
      fit: BoxFit.fitWidth,
      // placeholder: (context, url) =>
      //     Center(child: SpinKitSpinningLines(color: Colors.black)),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ));
  }
}
