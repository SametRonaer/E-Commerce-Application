import 'dart:io';
import 'dart:typed_data';

import 'package:alfa_application/data/model/category_model.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/ui/bottom_bar_ui.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'category_add_edit_screens_state.dart';

class CategoryAddEditScreensCubit extends Cubit<CategoryAddEditScreensState> {
  CategoryAddEditScreensCubit() : super(CategoryAddEditScreensInitial()) {
    _categoryModel = emptyCategoryModel;
  }
  File? pickedImage;
  Uint8List? webPickedImage;
  CategoryModel emptyCategoryModel = CategoryModel(
      categoryId: "",
      categoryTitle: "",
      categoryImageUrl: "",
      categoryCode: "");

  late CategoryModel _categoryModel;
  CategoryModel get getCategory => _categoryModel;

  Future<void> setPickedImage() async {
    final pickedImageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (pickedImageFile != null) {
      pickedImage = File(pickedImageFile.path);
    }
    emit(CategoryAddEditScreensLoaded());
  }

  Future<void> setWebPickedImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    webPickedImage = result!.files.first.bytes;

    emit(CategoryAddEditScreensLoaded());
  }

  deleteSelectedImage() {
    pickedImage = null;
    webPickedImage = null;
    emit(CategoryAddEditScreensLoaded());
  }

  Future<String?> _uploadPickedImages() async {
    String imageName = pickedImage!.path.split("/").last;
    String? url;
    final ref = FirebaseStorage.instance
        .ref()
        .child('category_images')
        .child(imageName);
    await ref.putFile(pickedImage!).then((snaphot) async {
      url = await snaphot.ref.getDownloadURL();
      print("Url is");
      print(url);
    });
    return url;
  }

  Future<String?> _uploadPickedImagesToWeb(Uint8List image) async {
    String? url;
    final ref = FirebaseStorage.instance
        .ref()
        .child('category_images')
        .child(DateTime.now().toString());
    await ref.putData(image).then((snaphot) async {
      url = await snaphot.ref.getDownloadURL();
      print("Url is");
      print(url);
    });
    return url;
  }

  setCategoryTitle(String? title) {
    _categoryModel.categoryTitle = title ?? "";
  }

  setCategoryTitleTurkish(String? title) {
    _categoryModel.categoryTitleTurkish = title ?? "";
  }

  setCategoryTitleArabic(String? title) {
    _categoryModel.categoryTitleArabic = title ?? "";
  }

  setCategoryCode(String? code) {
    _categoryModel.categoryCode = code;
  }

  Future<void> addNewCategory(BuildContext context) async {
    emit(CategoryAddEditScreensLoading());
    try {
      if (kIsWeb && webPickedImage != null) {
        _categoryModel.categoryImageUrl =
            await _uploadPickedImagesToWeb(webPickedImage!) ?? "";
      } else if (pickedImage != null) {
        _categoryModel.categoryImageUrl = await _uploadPickedImages() ?? "";
      }

      await context
          .read<ProductsCubit>()
          .addNewCategory(category: _categoryModel);
      await context.read<ProductsCubit>().getAllCategories();
      Get.snackbar("İşlem Başarılı", "Yeni Kategori Eklendi");
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _clearCategoryModel();
    } catch (e) {
      print(e);
    }
    emit(CategoryAddEditScreensLoaded());
  }

  Future<void> updateCategory(BuildContext context) async {
    emit(CategoryAddEditScreensLoading());
    try {
      if (kIsWeb && webPickedImage != null) {
        _categoryModel.categoryImageUrl =
            await _uploadPickedImagesToWeb(webPickedImage!) ?? "";
      } else if (pickedImage != null) {
        _categoryModel.categoryImageUrl = await _uploadPickedImages() ?? "";
      }
      await context.read<ProductsCubit>().updateCategory(
          categoryId: _categoryModel.categoryId,
          newData: _categoryModel.toMap());
      await context.read<ProductsCubit>().getAllCategories();
      Get.snackbar("İşlem Başarılı", "Yeni Kategori Eklendi");
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _clearCategoryModel();
    } catch (e) {
      print(e);
    }
    emit(CategoryAddEditScreensLoaded());
  }

  _clearCategoryModel() {
    pickedImage = null;
    _categoryModel = emptyCategoryModel;
  }

  setSelectedCategoryModel(CategoryModel categoryModel) {
    _categoryModel = categoryModel;
  }
}
