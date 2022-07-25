import 'dart:io';
import 'dart:typed_data';

import 'package:alfa_application/data/model/carosuel_model.dart';
import 'package:alfa_application/general_cubits/carosuel_cubit/cubit/carosuels_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../bottom_bar_screens/ui/bottom_bar_ui.dart';

part 'carosuel_edit_state.dart';

class CarosuelEditCubit extends Cubit<CarosuelEditState> {
  CarosuelEditCubit() : super(CarosuelEditInitial());
  File? firstPickedImage;
  File? secondPickedImage;
  Uint8List? webFirstPickedImage;
  Uint8List? webSecondPickedImage;
  String? imagePath;
  CarosuelModel _carosuelModel =
      CarosuelModel(carosuelId: "", carosuelImageUrl: "", carosuelType: 0);

  Future<void> setFirstPickedImage() async {
    emit(CarosuelEditLoading());
    if (!kIsWeb) {
      final pickedImageFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 30);
      if (pickedImageFile != null) {
        firstPickedImage = File(pickedImageFile.path);
      }
    } else {
      await _setFirstPickedImageForWeb();
    }
    emit(CarosuelEditLoaded());
  }

  Future<void> setSecondPickedImage() async {
    emit(CarosuelEditLoading());

    if (!kIsWeb) {
      final pickedImageFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 30);
      if (pickedImageFile != null) {
        secondPickedImage = File(pickedImageFile.path);
      }
    } else {
      await _setSecondPickedImageForWeb();
    }
    emit(CarosuelEditLoaded());
  }

  _setFirstPickedImageForWeb() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    webFirstPickedImage = result!.files.first.bytes;
  }

  _setSecondPickedImageForWeb() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    webSecondPickedImage = result!.files.first.bytes;
  }

  Future<String?> _uploadPickedImagesToWeb(Uint8List image) async {
    String? url;

    emit(CarosuelEditLoaded());
    final ref = FirebaseStorage.instance
        .ref()
        .child('carosuel_images')
        .child(DateTime.now().toString());
    await ref.putData(image).then((snaphot) async {
      url = await snaphot.ref.getDownloadURL();
      print("Url is");
      print(url);
    });
    return url;

    // final pickedImageFile = await ImagePicker()
    //     .pickImage(source: ImageSource.gallery, imageQuality: 30);
    // Uint8List? fileBytes = await pickedImageFile!.readAsBytes();
    // File image = File.fromRawPath(fileBytes);
    // await _uploadPickedImages(image);

    emit(CarosuelEditLoaded());
  }

  deleteSelectedImage() {
    firstPickedImage = null;
    emit(CarosuelEditLoaded());
  }

  Future<String?> _uploadPickedImages(File imageFile) async {
    if (firstPickedImage != null) {}
    String imageName = imageFile.path.split("/").last;
    String? url;
    final ref = FirebaseStorage.instance
        .ref()
        .child('carosuel_images')
        .child(imageName);
    await ref.putFile(imageFile).then((snaphot) async {
      url = await snaphot.ref.getDownloadURL();
      print("Url is");
      print(url);
    });
    return url;
  }

  Future<void> addNewCarosuel(BuildContext context) async {
    emit(CarosuelEditLoading());
    try {
      if (firstPickedImage != null) {
        _carosuelModel.carosuelImageUrl =
            await _uploadPickedImages(firstPickedImage!) ?? "";
        _carosuelModel.carosuelType = 0;
        await context.read<CarosuelsCubit>().addNewCarosuel(_carosuelModel);
      }
      if (secondPickedImage != null) {
        _carosuelModel.carosuelImageUrl =
            await _uploadPickedImages(secondPickedImage!) ?? "";
        _carosuelModel.carosuelType = 1;
        await context.read<CarosuelsCubit>().addNewCarosuel(_carosuelModel);
      }

      await context.read<CarosuelsCubit>().getAllCarosuels();
      Get.snackbar("İşlem Başarılı", "Yeni Banner Eklendi",
          backgroundColor: Colors.white54);
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _clearCarosuelModel();
    } catch (e) {
      print(e);
    }
    emit(CarosuelEditLoaded());
  }

  Future<void> addNewCarosuelsToWeb(BuildContext context) async {
    emit(CarosuelEditLoading());
    try {
      if (webFirstPickedImage != null) {
        _carosuelModel.carosuelImageUrl =
            await _uploadPickedImagesToWeb(webFirstPickedImage!) ?? "";
        _carosuelModel.carosuelType = 0;
        await context.read<CarosuelsCubit>().addNewCarosuel(_carosuelModel);
      }
      if (webSecondPickedImage != null) {
        _carosuelModel.carosuelImageUrl =
            await _uploadPickedImagesToWeb(webSecondPickedImage!) ?? "";
        _carosuelModel.carosuelType = 1;
        await context.read<CarosuelsCubit>().addNewCarosuel(_carosuelModel);
      }

      await context.read<CarosuelsCubit>().getAllCarosuels();
      Get.snackbar("İşlem Başarılı", "Yeni Banner Eklendi",
          backgroundColor: Colors.white54);
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _clearCarosuelModel();
    } catch (e) {
      print(e);
    }
    emit(CarosuelEditLoaded());
  }

  _clearCarosuelModel() {
    secondPickedImage = null;
    firstPickedImage = null;
    _carosuelModel =
        CarosuelModel(carosuelId: "", carosuelImageUrl: "", carosuelType: 0);
  }
}
