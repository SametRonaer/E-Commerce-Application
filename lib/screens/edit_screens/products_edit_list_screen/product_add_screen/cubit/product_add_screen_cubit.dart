import 'dart:io';
import 'dart:typed_data';

import 'package:alfa_application/data/model/second_category_model.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/ui/bottom_bar_ui.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../constants/enums.dart';
import '../../../../../data/model/category_model.dart';
import '../../../../../data/model/collection_model.dart';
import '../../../../../data/model/product_model.dart';

part 'product_add_screen_state.dart';

class ProductAddScreenCubit extends Cubit<ProductAddScreenState> {
  ProductAddScreenCubit() : super(ProductAddScreenInitial());

  List<File> _pickedImagesList = [];
  List<Uint8List> _webPickedImagesList = [];
  List<String> _imageUrls = [];
  late ProductsCubit _productsCubit;
  late ProductModel _productModel = ProductModel();
  ProductModel get productModel => _productModel;

  File? _pickedImage;
  File? _mainImage;
  Uint8List? _webMainImage;
  String? _selectedProductVisiblity;
  String? _selectedProductGoldPercent;
  String? _selectedProductColour;
  String? _selectedProductCategoryId;
  String? _selectedProductCollectionId;
  String? _selectedProductModelId;
  String? _selectedProductCategoryLabel;
  String? _selectedProductSecondCategoryLabel;
  String? _selectedProductModelLabel;
  String? get selectedProductSecondCategoryLabel =>
      _selectedProductSecondCategoryLabel;
  String? get selectedProductCategoryLabel => _selectedProductCategoryLabel;
  String? get selectedProductCollectionLabel => _selectedProductModelLabel;
  String? get selectedProductModelId => _selectedProductModelId;
  String? get selectedProductCategoryId => _selectedProductCategoryId;
  String? get selectedProductModel => _selectedProductCategoryId;
  String? get selectedProductVisibility => _selectedProductVisiblity;
  String? get selectedProductGoldPercent => _selectedProductGoldPercent;
  String? get selectedProductColour => _selectedProductColour;

  File? get pickedImage => _pickedImage;
  Future<String?> setPickedImage({bool? isMainImage = false}) async {
    final pickedImageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      if (isMainImage!) {
        _mainImage = pickedImage;
      } else {
        _pickedImagesList.add(_pickedImage!);
      }
      return pickedImageFile.path;
    }
  }

  Future<Uint8List?> setWebPickedImage({bool? isMainImage = false}) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    Uint8List? webPickedImage = result!.files.first.bytes;
    if (webPickedImage != null) {
      if (isMainImage!) {
        _webMainImage = webPickedImage;
      } else {
        _webPickedImagesList.add(webPickedImage);
      }
    }
    return webPickedImage;
  }

  Future<void> uploadPickedImages() async {
    _imageUrls.clear();
    if (_mainImage != null) {
      _pickedImagesList.add(_mainImage!);
      _pickedImagesList = _pickedImagesList.reversed.toList();
    }
    await Future.forEach(_pickedImagesList, (element) async {
      element as File;
      String imageName = element.path.split("/").last;
      final ref = FirebaseStorage.instance
          .ref()
          .child('product_images')
          .child(imageName);
      await ref.putFile(element).then((snaphot) async {
        String url = await snaphot.ref.getDownloadURL();
        print("Url is");
        print(url);
        _imageUrls.add(url);
      });
    });
    _pickedImagesList.clear();
    _mainImage = null;
    if (!kIsWeb) {
      Get.offAllNamed(BottomBarScreen.routeName);
    }
  }

  Future<void> uploadWebPickedImages() async {
    _imageUrls.clear();
    if (_webMainImage != null) {
      _webPickedImagesList.add(_webMainImage!);
      _webPickedImagesList = _webPickedImagesList.reversed.toList();
    }
    await Future.forEach(_webPickedImagesList, (element) async {
      element as Uint8List;
      String imageName = DateTime.now().toString();
      final ref = FirebaseStorage.instance
          .ref()
          .child('product_images')
          .child(imageName);
      await ref.putData(element).then((snaphot) async {
        String url = await snaphot.ref.getDownloadURL();
        print("Url is");
        print(url);
        _imageUrls.add(url);
      });
    });
    _webPickedImagesList.clear();
    _mainImage = null;
  }

  Future<void> uploadProduct(BuildContext context) async {
    emit(ProductAddScreenLoading());
    if (_checkValues(_productModel)) {
      if (kIsWeb) {
        await uploadWebPickedImages();
      } else {
        await uploadPickedImages();
      }
      _productModel.productImageList = _imageUrls;
      _productsCubit = context.read<ProductsCubit>();
      await _productsCubit.addNewProduct(product: _productModel);
      Get.snackbar("Success", "Product Uploaded",
          backgroundColor: Colors.white54);
    }

    print(_productModel);
    emit(ProductAddScreenLoaded());
  }

  _checkNumberValues(String value) {
    if (value.contains(".")) {
      print("Contains");
    } else {
      print("not Contains");
      value = "$value.01";
      print(value);
    }
    return value;
  }

  _checkValues(ProductModel product) {
    if (product.categoryId == null) {
      Get.snackbar("Error appear", "Please fill category id field",
          backgroundColor: Colors.white54);
      return false;
    } else if (product.productCode == "") {
      Get.snackbar("Error appear", "Please fill product  code field",
          backgroundColor: Colors.white54);
      return false;
    } else if (product.productColorType == null) {
      Get.snackbar("Error appear", "Please fill product colour  field",
          backgroundColor: Colors.white54);
      return false;
    } else if (product.productTitle == "") {
      Get.snackbar("Error appear", "Please fill product  title field",
          backgroundColor: Colors.white54);
      return false;
    } else if (product.categoryId == null) {
      Get.snackbar("Error appear", "Please fill product  category field",
          backgroundColor: Colors.white54);
      return false;
    } else if (product.productVisibility == null) {
      Get.snackbar("Error appear", "Please fill product visibility field",
          backgroundColor: Colors.white54);
      return false;
    } else if (product.productHeight == null) {
      Get.snackbar("Error appear", "Please fill product height field",
          backgroundColor: Colors.white54);
      return false;
    } else if (product.productWidth == null) {
      Get.snackbar("Error appear", "Please fill product width field",
          backgroundColor: Colors.white54);
      return false;
    } else if (product.productWeight == null) {
      Get.snackbar("Error appear", "Please fill product weight field",
          backgroundColor: Colors.white54);
      return false;
    }
    return true;
  }

  setProductName(String? name) {
    _productModel.productTitle = name;
    emit(ProductAddScreenLoaded());
  }

  setProductTurkishName(String? name) {
    _productModel.productTitleTurkish = name;
    emit(ProductAddScreenLoaded());
  }

  setProductSortStatus(String? statusName) {
    _productModel.sortStatus = statusName ?? SortStatuses.Standart.toString();
    emit(ProductAddScreenLoaded());
  }

  setProductArabicName(String? name) {
    _productModel.productTitleArabic = name;
    emit(ProductAddScreenLoaded());
  }

  setProductCode(String? code) {
    _productModel.productCode = code;
    emit(ProductAddScreenLoaded());
  }

  setProductHeight(String? height) {
    height = _checkNumberValues(height ?? "0");
    _productModel.productHeight = double.parse(height!);
    emit(ProductAddScreenLoaded());
  }

  setProductWidth(String? width) {
    width = _checkNumberValues(width ?? "0");
    _productModel.productWidth = double.parse(width!);
    emit(ProductAddScreenLoaded());
  }

  setProductRadius(String? radius) {
    radius = _checkNumberValues(radius ?? "0");
    _productModel.productRadius = double.parse(radius!);
    emit(ProductAddScreenLoaded());
  }

  setProductWeight(String? weight) {
    weight = _checkNumberValues(weight ?? "0");
    _productModel.productWeight = double.parse(weight ?? "0");
    emit(ProductAddScreenLoaded());
  }

  setProductColour(ProductColours productColours) {
    _productModel.productColorType = productColours.toString();
    _selectedProductColour = productColours.toString();
    emit(ProductAddScreenLoaded());
  }

  setProductVisibility(ProductVisibility productVisibility) {
    _productModel.productVisibility = productVisibility.toString();
    _selectedProductVisiblity = productVisibility.toString();
    emit(ProductAddScreenLoaded());
  }

  setProductGoldPercent(ProductGoldPercents productGoldPercent) {
    _productModel.goldPercent = productGoldPercent.toString();
    _selectedProductGoldPercent = productGoldPercent.toString();
    emit(ProductAddScreenLoaded());
  }

  setProductCategory(CategoryModel category) {
    productModel.categoryId = category.categoryId;
    _selectedProductCategoryLabel = category.categoryTitle;
    emit(ProductAddScreenLoaded());
  }

  setProductSecondCategory(SecondCategoryModel category) {
    productModel.secondCategoryId = category.secondCategoryId;
    _selectedProductSecondCategoryLabel = category.secondCategoryTitle;
    emit(ProductAddScreenLoaded());
  }

  setProductModel(CollectionModel collection) {
    productModel.collectionId = collection.collectionId;
    _selectedProductModelLabel = collection.collectionTitle;
    emit(ProductAddScreenLoaded());
  }

  setSelectedProduct(ProductModel productModel) {
    _productModel = productModel;
    emit(ProductAddScreenLoaded());
  }

  setProductColorLabel(String label) {
    _selectedProductColour = label;
    emit(ProductAddScreenLoaded());
  }

  setProductGoldPercentLabel(String label) {
    _selectedProductGoldPercent = label;
    emit(ProductAddScreenLoaded());
  }

  setProductVisibilityLabel(String label) {
    _selectedProductVisiblity = label;
    emit(ProductAddScreenLoaded());
  }

  setProductEnglishDescription(String? description) {
    _productModel.productDescriptionEnglish = description;
    emit(ProductAddScreenLoaded());
  }

  setProductTurkisnhDescription(String? description) {
    _productModel.productDescriptionTurkish = description;
    emit(ProductAddScreenLoaded());
  }

  setProductArabicDescription(String? description) {
    _productModel.productDescriptionArabic = description;
    emit(ProductAddScreenLoaded());
  }

  clearProductData() {
    _productModel = ProductModel();
    _productModel.sortStatus = SortStatuses.Standart.toString();
    _selectedProductModelLabel = null;
    _selectedProductCategoryLabel = null;
    _selectedProductSecondCategoryLabel = null;
    _selectedProductColour = "";
    _selectedProductGoldPercent = "";
    _selectedProductVisiblity = "";
  }

  Future<void> updateProduct(BuildContext context) async {
    await uploadPickedImages();

    _productModel.goldPercent = _selectedProductGoldPercent;
    _productModel.productVisibility = _selectedProductVisiblity;
    _productModel.productColorType = _selectedProductColour;
    _productsCubit = context.read<ProductsCubit>();
    await _productsCubit.updateProduct(
        productId: _productModel.productId!, newData: _productModel.toMap());
    Get.snackbar("Success", "Product Uploaded",
        backgroundColor: Colors.white54);
  }
}
