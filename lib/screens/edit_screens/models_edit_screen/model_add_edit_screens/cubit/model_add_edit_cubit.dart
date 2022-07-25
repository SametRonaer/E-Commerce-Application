import 'dart:io';
import 'dart:typed_data';

import 'package:alfa_application/data/model/collection_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../general_cubits/products_cubit/cubit/products_cubit.dart';
import '../../../../bottom_bar_screens/ui/bottom_bar_ui.dart';

part 'model_add_edit_state.dart';

class ModelAddEditCubit extends Cubit<ModelAddEditState> {
  ModelAddEditCubit() : super(ModelAddEditInitial()) {
    _collectionModel = emptyCollectionModel;
  }
  File? pickedImage;
  Uint8List? webPickedImage;
  CollectionModel emptyCollectionModel = CollectionModel(
      collectionDescription: "",
      collectionId: "",
      collectionTitle: "",
      collectionImageUrl: "",
      collectionCode: "");

  late CollectionModel _collectionModel;
  CollectionModel get getCollection => _collectionModel;

  Future<void> setPickedImage() async {
    final pickedImageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (pickedImageFile != null) {
      pickedImage = File(pickedImageFile.path);
    }
    emit(ModelAddEditLoaded());
  }

  Future<void> setWebPickedImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    webPickedImage = result!.files.first.bytes;

    emit(ModelAddEditLoaded());
  }

  deleteSelectedImage() {
    pickedImage = null;
    webPickedImage = null;
    emit(ModelAddEditLoaded());
  }

  Future<String?> _uploadPickedImages() async {
    String imageName = pickedImage!.path.split("/").last;
    String? url;
    final ref = FirebaseStorage.instance
        .ref()
        .child('collection_images')
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
        .child('collection_images')
        .child(DateTime.now().toString());
    await ref.putData(image).then((snaphot) async {
      url = await snaphot.ref.getDownloadURL();
      print("Url is");
      print(url);
    });
    return url;
  }

  setCollectionTitle(String? title) {
    _collectionModel.collectionTitle = title ?? "";
  }

  setCollectionTitleTurkish(String? title) {
    _collectionModel.collectionTitleTurkish = title ?? "";
  }

  setCollectionTitleArabic(String? title) {
    _collectionModel.collectionTitleArabic = title ?? "";
  }

  setCollectionCode(String? code) {
    _collectionModel.collectionCode = code;
  }

  Future<void> addNewCollection(BuildContext context) async {
    emit(ModelAddEditLoading());
    try {
      if (kIsWeb && webPickedImage != null) {
        _collectionModel.collectionImageUrl =
            await _uploadPickedImagesToWeb(webPickedImage!) ?? "";
      } else if (pickedImage != null) {
        _collectionModel.collectionImageUrl = await _uploadPickedImages() ?? "";
      }
      await context
          .read<ProductsCubit>()
          .addNewCollection(collection: _collectionModel);
      await context.read<ProductsCubit>().getAllCollections();
      Get.snackbar("İşlem Başarılı", "Yeni Model Eklendi",
          backgroundColor: Colors.white54);
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _clearCollectionModel();
    } catch (e) {
      print(e);
    }
    emit(ModelAddEditLoaded());
  }

  Future<void> updateCollection(BuildContext context) async {
    emit(ModelAddEditLoading());
    try {
      if (kIsWeb && webPickedImage != null) {
        _collectionModel.collectionImageUrl =
            await _uploadPickedImagesToWeb(webPickedImage!) ?? "";
      } else if (pickedImage != null) {
        _collectionModel.collectionImageUrl = await _uploadPickedImages() ?? "";
      }
      await context.read<ProductsCubit>().updateCollection(
          collectionId: _collectionModel.collectionId,
          newData: _collectionModel.toMap());
      await context.read<ProductsCubit>().getAllCollections();
      Get.snackbar("İşlem Başarılı", "Model Güncellendi",
          backgroundColor: Colors.white54);
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _clearCollectionModel();
    } catch (e) {
      print(e);
    }
    emit(ModelAddEditLoaded());
  }

  _clearCollectionModel() {
    pickedImage = null;
    _collectionModel = emptyCollectionModel;
  }

  setSelectedCollectionModel(CollectionModel collectionModel) {
    _collectionModel = collectionModel;
  }
}
