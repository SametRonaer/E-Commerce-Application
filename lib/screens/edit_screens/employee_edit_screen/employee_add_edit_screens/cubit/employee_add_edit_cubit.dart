import 'dart:io';
import 'dart:typed_data';

import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/general_cubits/employee_cubit/cubit/employee_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../data/model/employee_model.dart';
import '../../../../../general_cubits/auth_cubit/cubit/auth_cubit.dart';
import '../../../../bottom_bar_screens/ui/bottom_bar_ui.dart';

part 'employee_add_edit_state.dart';

class EmployeeAddEditCubit extends Cubit<EmployeeAddEditState> {
  EmployeeAddEditCubit() : super(EmployeeAddEditInitial()) {
    _cleanEmployee();
  }

  File? _pickedImage;
  Uint8List? webPickedImage;
  late EmployeeModel _employeeModel;
  EmployeeModel get employeeModel => _employeeModel;

  Future<String?> setPickedImage() async {
    final pickedImageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      return pickedImageFile.path;
    }
  }

  Future<Uint8List?> setWebPickedImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    webPickedImage = result!.files.first.bytes;
    return webPickedImage;
  }

  Future<String?> _uploadPickedImages() async {
    String imageName = _pickedImage!.path.split("/").last;
    String? url;
    final ref = FirebaseStorage.instance
        .ref()
        .child('employee_images')
        .child(imageName);
    await ref.putFile(_pickedImage!).then((snaphot) async {
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
        .child('employee_images')
        .child(DateTime.now().toString());
    await ref.putData(image).then((snaphot) async {
      url = await snaphot.ref.getDownloadURL();
      print("Url is");
      print(url);
    });
    return url;
  }

  setEmployeeName(String? name) {
    _employeeModel.name = name ?? "";
    _employeeModel.employeeName = name ?? "";
  }

  setEmployeeSurName(String? surname) {
    _employeeModel.surName = surname ?? "";
    _employeeModel.employeeSurName = surname ?? "";
  }

  setEmployeeCode(String? employeeCode) {
    _employeeModel.employeeCode = employeeCode ?? "";
  }

  setEmployeeEmail(String? employeeEmail) {
    _employeeModel.employeeEmail = employeeEmail ?? "";
    _employeeModel.email = employeeEmail ?? "";
  }

  setEmployeeMobilePhoneNumber(String? phoneNo) {
    _employeeModel.employeePhone = phoneNo ?? "";
  }

  setEmployeePassword(String? password) {
    _employeeModel.password = password ?? "";
    _employeeModel.employeePassword = password ?? "";
    print(_employeeModel.password);
  }

  setEmployeeNote(String? note) {
    _employeeModel.employeeNote = note;
  }

  Future<void> setEmployeeImage() async {
    if (kIsWeb && webPickedImage != null) {
      _employeeModel.employeeImageUrl =
          await _uploadPickedImagesToWeb(webPickedImage!) ?? "";
    } else if (_pickedImage != null) {
      _employeeModel.employeeImageUrl = await _uploadPickedImages() ?? "";
    }
  }

  setEmployeeStatus(EmployeeStatus employeeType) {
    _employeeModel.employeeStatus = employeeType.toString();
    emit(EmployeeAddEditLoaded());
  }

  _cleanEmployee() {
    _employeeModel = EmployeeModel(
      unreadMessages: 0,
      notifications: [],
      employeeCode: "",
      employeeEmail: "",
      employeeId: "",
      employeeImageUrl: "",
      employeeName: "",
      employeePassword: "",
      employeePhone: "",
      employeeStatus: EmployeeStatus.Standart.toString(),
      employeeSurName: "",
      employeeNote: "",
      userType: UserTypes.Employee.toString(),
    );
    _pickedImage = null;
  }

  Future<void> addNewEmployee(BuildContext context) async {
    emit(EmployeeAddEditLoading());
    await setEmployeeImage();
    try {
      await context.read<AuthCubit>().addNewUser(_employeeModel);
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _cleanEmployee();
    } catch (e) {
      print(e);
    }
    emit(EmployeeAddEditLoaded());
  }

  Future<void> updateEmployee(
      BuildContext context, EmployeeModel employeeModel) async {
    emit(EmployeeAddEditLoading());
    try {
      await context.read<EmployeeCubit>().updateEmployee(
          newData: employeeModel.toMap(), employeeId: employeeModel.employeeId);
      Get.snackbar("İşlem Başarılı", "Çalışan Bilgileri Güncellendi !",
          backgroundColor: Colors.white54);
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _cleanEmployee();
    } catch (e) {
      print(e);
    }
    emit(EmployeeAddEditLoaded());
  }

  refreshPage() {
    emit(EmployeeAddEditLoaded());
  }
}
