// import 'dart:io';

// import 'package:alfa_application/data/model/product_model.dart';
// import 'package:alfa_application/extensions/screen_size_context.dart';
// import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/cubit/product_add_screen_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'add_image_cell.dart';

// class ProductEditImagesField extends StatefulWidget {
//   ProductEditImagesField({Key? key, required this.selectedProduct})
//       : super(key: key);
//   ProductModel selectedProduct;

//   @override
//   State<ProductEditImagesField> createState() => _ProductEditImagesFieldState();
// }

// class _ProductEditImagesFieldState extends State<ProductEditImagesField> {
//   late ProductAddScreenCubit _productAddCubit;
//   double littImagesSize = 4.9;
//   @override
//   Widget build(BuildContext context) {
//     _productAddCubit = context.read<ProductAddScreenCubit>();
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _getMaimImageCell(context),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Other Images", style: TextStyle(fontWeight: FontWeight.w500)),
//             SizedBox(height: 3),
//             Row(
//               children: [
//                 AddImageCell(index: 1),
//                 SizedBox(width: 4),
//                 AddImageCell(index: 2)
//               ],
//             ),
//             SizedBox(height: 5),
//             Row(
//               children: [
//                 AddImageCell(index: 3),
//                 SizedBox(width: 4),
//                 AddImageCell(index: 4),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Column _getMaimImageCell(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Main Image",
//           style: TextStyle(fontWeight: FontWeight.w500),
//         ),
//         SizedBox(height: 3),
//         GestureDetector(
//           onTap: () {
//             _productAddCubit.setPickedImage();
//           },
//           child: Container(
//               height: context.screenWidth / 2.4,
//               width: context.screenWidth / 2.4,
//               color: Colors.grey.shade300,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Icon(
//                     Icons.add_a_photo,
//                     size: 30,
//                   ),
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Image.network(_productAddCubit.imageUrls.first),
//                       Align(
//                           alignment: Alignment.topRight,
//                           child: IconButton(
//                               alignment: Alignment.topRight,
//                               onPressed: () {
//                                 _removeImageFromList(
//                                     _productAddCubit.imageUrls.first);
//                               },
//                               icon: Icon(
//                                 Icons.close,
//                                 color: Colors.grey.shade50,
//                               ))),
//                     ],
//                   ),
//                 ],
//               )),
//         ),
//       ],
//     );
//   }

//   _removeImageFromList(dynamic image) {
//     List<dynamic> newList = _productAddCubit.imageUrls;
//     newList = newList.where((element) {
//       print("Element is $element image is $image");
//       return element.toString() != image.toString();
//     }).toList();
//     _productAddCubit.setImageUrls(newList);
//     print(newList.first);
//   }
// }
