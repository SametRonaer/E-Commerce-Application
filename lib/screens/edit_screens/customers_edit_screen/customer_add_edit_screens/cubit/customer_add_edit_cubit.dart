import 'dart:io';
import 'dart:typed_data';

import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/constants/firebase_error_codes.dart';
import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/general_cubits/auth_cubit/cubit/auth_cubit.dart';
import 'package:alfa_application/general_cubits/customers_cubit/cubit/customers_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/ui/bottom_bar_ui.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'customer_add_edit_state.dart';

class CustomerAddEditCubit extends Cubit<CustomerAddEditState> {
  CustomerAddEditCubit() : super(CustomerAddEditInitial()) {
    _cleanCustomer();
  }
  File? _pickedImage;
  Uint8List? webPickedImage;
  late CustomerModel _customerModel;
  CustomerModel get customerModel => _customerModel;

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
        .child('customer_images')
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
        .child('customer_images')
        .child(DateTime.now().toString());
    await ref.putData(image).then((snaphot) async {
      url = await snaphot.ref.getDownloadURL();
      print("Url is");
      print(url);
    });
    return url;
  }

  setCustomerName(String? name) {
    _customerModel.name = name ?? "";
    _customerModel.userName = name ?? "";
  }

  setCustomerSurName(String? surname) {
    _customerModel.surName = surname ?? "";
    _customerModel.userSurName = surname ?? "";
  }

  setCustomerCode(String? customerCode) {
    _customerModel.customeCode = customerCode;
  }

  setCustomerEmail(String? customerEmail) {
    _customerModel.userEmail = customerEmail ?? "";
    _customerModel.email = customerEmail ?? "";
  }

  setCustomerMobilePhoneNumber(String? phoneNo) {
    _customerModel.customerMobilePhoneNumber = phoneNo;
  }

  setCustomerCompany(String? company) {
    _customerModel.customerCompanyName = company;
  }

  setCustomerTeam(String? team) {
    _customerModel.customerTeam = team;
  }

  setCustomerMEmbershipDate(String? date) {
    _customerModel.customerMembershipDate = date;
  }

  setCustomerAuthority(String? authority) {}

  setCustomerPassword(String? password) {
    _customerModel.password = password ?? "";
    _customerModel.userPassword = password ?? "";
    print(_customerModel.password);
  }

  setCustomerCountry(String? country) {
    _customerModel.customerCountry = country;
  }

  setCustomerCity(String? city) {
    _customerModel.customerCity = city;
  }

  setCustomerTown(String? town) {}

  setCustomerPostCode(String? postCode) {
    _customerModel.postCode = postCode;
  }

  setCustomerAddress(String? address) {
    _customerModel.customerAdress = address;
  }

  setCustomerCompanyEmail(String? email) {
    _customerModel.customerCompanyMailAdress = email;
  }

  setCustomerPhoneNo(String? phoneNo) {
    _customerModel.customerPhoneNumber = phoneNo;
  }

  setCustomerCompanyMobilPhone(String? mobileNo) {
    _customerModel.customerCompanyMobilePhoneNumber;
  }

  setCustomerCompanyWebsite(String? website) {
    _customerModel.customerCompanyWebsite = website;
  }

  setCustomerGroup(CustomerTypes customerTypes) {
    _customerModel.customeGroup = customerTypes.toString();
    emit(CustomerAddEditLoaded());
  }

  Future<void> setCustomerImage() async {
    if (kIsWeb && webPickedImage != null) {
      _customerModel.customerImageUrl =
          await _uploadPickedImagesToWeb(webPickedImage!) ?? "";
    } else if (_pickedImage != null) {
      _customerModel.customerImageUrl = await _uploadPickedImages() ?? "";
    }
  }

  _cleanCustomer() {
    _customerModel = CustomerModel(
      unreadMessages: 0,
      notifications: [],
      customeGroup: CustomerTypes.Standart.toString(),
      userId: "",
      userType: UserTypes.Customer.toString(),
      userName: "",
      userSurName: "",
      userEmail: "",
      userPassword: "",
      customerImageUrl: "",
      customerFavoriteProductIds: [],
      customerTransactions: [],
      customerCartProducts: [],
    );
    _pickedImage = null;
    webPickedImage = null;
  }

  Future<void> addNewCustomer(BuildContext context) async {
    emit(CustomerAddEditLoding());
    await setCustomerImage();
    try {
      await context.read<AuthCubit>().addNewUser(_customerModel);
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _cleanCustomer();
    } catch (e) {
      print(e);
    }
    emit(CustomerAddEditLoaded());
  }

  Future<void> updateCustomer(
      BuildContext context, CustomerModel customerModel) async {
    try {
      await setCustomerImage();
      await context.read<CustomersCubit>().updateCustomer(
          newData: customerModel.toMap(), userId: customerModel.userId);
      Get.snackbar("İşlem Başarılı", "Müşteri Bilgileri Güncellendi !",
          backgroundColor: Colors.white54);
      if (!kIsWeb) {
        Get.offAllNamed(BottomBarScreen.routeName);
      }
      _cleanCustomer();
    } catch (e) {
      print(e);
    }
  }
}
