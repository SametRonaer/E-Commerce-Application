import 'dart:io';
import 'dart:typed_data';

import 'package:alfa_application/general_cubits/second_category_cubit/cubit/second_category_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/ui/bottom_bar_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../data/model/second_category_model.dart';

part 'second_category_add_edit_state.dart';

class SecondCategoryAddEditCubit extends Cubit<SecondCategoryAddEditState> {
  SecondCategoryAddEditCubit() : super(SecondCategoryAddEditInitial()) {
    _secondCategoryModel = emptySecondCategoryModel;
  }

  File? pickedImage;
  Uint8List? webPickedImage;

  SecondCategoryModel emptySecondCategoryModel = SecondCategoryModel(
      secondCategoryId: "",
      secondCategoryTitle: "",
      secondCategoryImageUrl: "",
      secondCategoryCode: "");

  late SecondCategoryModel _secondCategoryModel;
  SecondCategoryModel get getSecondCategory => _secondCategoryModel;

  Future<void> setPickedImage() async {
    final pickedImageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (pickedImageFile != null) {
      pickedImage = File(pickedImageFile.path);
    }
    emit(SecondCategoryAddEditLoaded());
  }

  Future<void> setWebPickedImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    webPickedImage = result!.files.first.bytes;
    emit(SecondCategoryAddEditLoaded());
  }

  Future<String?> _uploadPickedImagesToWeb(Uint8List image) async {
    String? url;
    final ref = FirebaseStorage.instance
        .ref()
        .child('second_category_images')
        .child(DateTime.now().toString());
    await ref.putData(image).then((snaphot) async {
      url = await snaphot.ref.getDownloadURL();
      print("Url is");
      print(url);
    });
    return url;
  }

  deleteSelectedImage() {
    pickedImage = null;
    webPickedImage = null;
    emit(SecondCategoryAddEditLoaded());
  }

  Future<String?> _uploadPickedImages() async {
    String imageName = pickedImage!.path.split("/").last;
    String? url;
    final ref = FirebaseStorage.instance
        .ref()
        .child('second_category_images')
        .child(imageName);
    await ref.putFile(pickedImage!).then((snaphot) async {
      url = await snaphot.ref.getDownloadURL();
      print("Url is");
      print(url);
    });
    return url;
  }

  setSecondCategoryTitle(String? title) {
    _secondCategoryModel.secondCategoryTitle = title ?? "";
  }

  setSecondCategoryTitleTurkish(String? title) {
    _secondCategoryModel.secondCategoryTitleTurkish = title ?? "";
  }

  setSecondCategoryTitleArabic(String? title) {
    _secondCategoryModel.secondCategoryTitleArabic = title ?? "";
  }

  setSecondCategoryCode(String? code) {
    _secondCategoryModel.secondCategoryCode = code ?? "";
  }

  Future<void> addNewSecondCategory(BuildContext context) async {
    emit(SecondCategoryAddEditLoading());
    try {
      if (kIsWeb && webPickedImage != null) {
        _secondCategoryModel.secondCategoryImageUrl =
            await _uploadPickedImagesToWeb(webPickedImage!) ?? "";
      } else if (pickedImage != null) {
        _secondCategoryModel.secondCategoryImageUrl =
            await _uploadPickedImages() ?? "";
      }
      await context
          .read<SecondCategoryCubit>()
          .addNewSecondCategory(_secondCategoryModel);
      await context.read<SecondCategoryCubit>().getAllSecondCategories();
      Get.snackbar("İşlem Başarılı", "Yeni Koleksiyon Eklendi",
          backgroundColor: Colors.white54);
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _clearSecondCategoryModel();
    } catch (e) {
      print(e);
    }
    emit(SecondCategoryAddEditLoaded());
  }

  Future<void> updateSecondCategory(BuildContext context) async {
    emit(SecondCategoryAddEditLoading());
    try {
      if (kIsWeb && webPickedImage != null) {
        _secondCategoryModel.secondCategoryImageUrl =
            await _uploadPickedImagesToWeb(webPickedImage!) ?? "";
      } else if (pickedImage != null) {
        _secondCategoryModel.secondCategoryImageUrl =
            await _uploadPickedImages() ?? "";
      }
      await context.read<SecondCategoryCubit>().updateSecondCategory(
          secondCategoryId: _secondCategoryModel.secondCategoryId,
          newData: _secondCategoryModel.toMap());
      await context.read<SecondCategoryCubit>().getAllSecondCategories();
      Get.snackbar("İşlem Başarılı", "Koleksiyon Güncellendi",
          backgroundColor: Colors.white54);
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _clearSecondCategoryModel();
    } catch (e) {
      print(e);
    }
    emit(SecondCategoryAddEditLoaded());
  }

  _clearSecondCategoryModel() {
    pickedImage = null;
    _secondCategoryModel = emptySecondCategoryModel;
  }

  setSelectedSecondCategory(SecondCategoryModel secondCategoryModel) {
    _secondCategoryModel = secondCategoryModel;
  }
}
