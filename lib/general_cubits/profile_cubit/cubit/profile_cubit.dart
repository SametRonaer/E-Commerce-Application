import 'dart:io';

import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/data/model/employee_model.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../data/model/profile_abstract_model.dart';
import '../../customers_cubit/cubit/customers_cubit.dart';
import '../../employee_cubit/cubit/employee_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.context) : super(ProfileInitial()) {}
  Profile? _userProfile;
  bool? isCustomer;
  Profile? get userProfile => _userProfile;
  List<ProductModel> _customerFavoriteProducts = [];
  List<ProductModel> _customerCartProducts = [];
  List<ProductModel> get customerFavoriteProducts => _customerFavoriteProducts;
  List<ProductModel> get customerCartProducts => _customerCartProducts;
  bool _loaded = false;
  BuildContext context;

  Future<void> detectAndSetUserProfile(String email) async {
    emit(ProfileLoading());
    CustomersCubit customersCubit = CustomersCubit();
    await customersCubit.getCustomersByEmail(email: email);
    if (customersCubit.filteredCustomers.isNotEmpty) {
      print("Find it customer");
      _userProfile = customersCubit.filteredCustomers.first;
      isCustomer = true;
      if (!_loaded) {
        await _getCartProducts();
        await _getFavoriteProducts();
        _loaded = true;
      }
      emit(ProfileLoaded());
      return;
    }
    EmployeeCubit employeeCubit = EmployeeCubit();
    await employeeCubit.getEmployeesByEmail(email: email);
    if (employeeCubit.filteredEmployees.isNotEmpty) {
      _userProfile = employeeCubit.filteredEmployees.first;
      print("Find it employee");
      isCustomer = false;
      emit(ProfileLoaded());
      return;
    }
    isCustomer = false;

    print("Find it admin");
    emit(ProfileLoaded());
  }

  Future<void> _getFavoriteProducts() async {
    emit(ProfileLoading());
    _customerFavoriteProducts.clear();
    ProductsCubit productsCubit = context.read<ProductsCubit>();

    await Future.forEach(
        (userProfile as CustomerModel).customerFavoriteProductIds,
        (element) async {
      await productsCubit.getProductWithId(productId: element as String);
      _customerFavoriteProducts.add(productsCubit.selectedProduct!);
    });

    emit(ProfileLoaded());
  }

  Future<void> _getCartProducts() async {
    emit(ProfileLoading());
    _customerCartProducts.clear();
    ProductsCubit productsCubit = BlocProvider.of<ProductsCubit>(context);
    await Future.forEach((userProfile as CustomerModel).customerCartProducts,
        (element) async {
      await productsCubit.getProductWithId(productId: element as String);
      _customerCartProducts.add(productsCubit.selectedProduct!);
    });
    // (userProfile as CustomerModel)
    //     .customerCartProducts
    //     .forEach((element) async {
    //   await productsCubit.getProductWithId(productId: element);
    //   _customerCartProducts.add(productsCubit.selectedProduct!);
    // });
    emit(ProfileLoaded());
  }

  Future<void> addProductToFavorites(String id) async {
    emit(ProfileLoading());
    List<dynamic> favoriteProducts =
        (_userProfile as CustomerModel).customerFavoriteProductIds;
    favoriteProducts.add(id);
    await BlocProvider.of<CustomersCubit>(context).updateCustomer(
        newData: {"customerFavoriteProductIds": favoriteProducts},
        userId: (_userProfile as CustomerModel).userId);
    favoriteProducts.forEach((element) {
      print(element.toString());
    });
    await detectAndSetUserProfile(userProfile!.email);
    await _getFavoriteProducts();
    emit(ProfileLoaded());
  }

  Future<void> addProductToCart(String id) async {
    emit(ProfileLoading());
    List<dynamic> cartProducts =
        (_userProfile as CustomerModel).customerCartProducts;
    cartProducts.add(id);
    await BlocProvider.of<CustomersCubit>(context).updateCustomer(
        newData: {"customerCartProducts": cartProducts},
        userId: (_userProfile as CustomerModel).userId);
    cartProducts.forEach((element) {
      print(element.toString());
    });
    await detectAndSetUserProfile(userProfile!.email);
    await _getCartProducts();

    emit(ProfileLoaded());
  }

  Future<void> deleteProductFromCart(String id) async {
    emit(ProfileLoading());
    List<dynamic> cartProducts =
        (_userProfile as CustomerModel).customerCartProducts;
    cartProducts.remove(id);
    await BlocProvider.of<CustomersCubit>(context).updateCustomer(
        newData: {"customerCartProducts": cartProducts},
        userId: (_userProfile as CustomerModel).userId);
    cartProducts.forEach((element) {
      print(element.toString());
    });
    await detectAndSetUserProfile(userProfile!.email);
    await _getCartProducts();

    emit(ProfileLoaded());
  }

  Future<void> clearCartProducts() async {
    emit(ProfileLoading());
    _customerCartProducts.clear();
    await BlocProvider.of<CustomersCubit>(context).updateCustomer(
        newData: {"customerCartProducts": []},
        userId: (_userProfile as CustomerModel).userId);

    await detectAndSetUserProfile(userProfile!.email);
    await _getCartProducts();

    emit(ProfileLoaded());
  }

  Future<void> deleteProductFromFavorites(
      String id, BuildContext context) async {
    emit(ProfileLoading());
    List<dynamic> favoriteProducts =
        (_userProfile as CustomerModel).customerFavoriteProductIds;
    favoriteProducts.remove(id);
    await BlocProvider.of<CustomersCubit>(context).updateCustomer(
        newData: {"customerFavoriteProductIds": favoriteProducts},
        userId: (_userProfile as CustomerModel).userId);
    favoriteProducts.forEach((element) {
      print(element.toString());
    });
    await detectAndSetUserProfile(userProfile!.email);
    await _getFavoriteProducts();
    emit(ProfileLoaded());
  }

  changeProfileImage(BuildContext context) async {
    emit(ProfileLoading());
    String? imageUrl = await _uploadPickedImages();
    if (isCustomer!) {
      await context.read<CustomersCubit>().updateCustomer(newData: {
        "customerImageUrl": imageUrl,
      }, userId: (userProfile as CustomerModel).userId);
      await detectAndSetUserProfile(userProfile!.email);
    } else {
      await context.read<EmployeeCubit>().updateEmployee(newData: {
        "employeeImageUrl": imageUrl,
      }, employeeId: (userProfile as EmployeeModel).employeeId);
      await detectAndSetUserProfile(userProfile!.email);
    }
  }

  Future<String?> _setPickedImage() async {
    final pickedImageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (pickedImageFile != null) {
      return pickedImageFile.path;
    }
  }

  cleanUser() {
    _userProfile = null;
    emit(ProfileLoaded());
  }

  Future<String?> _uploadPickedImages() async {
    String? imagePath = await _setPickedImage();
    if (imagePath != null) {
      String imageName = imagePath.split("/").last;
      String? url;
      final ref = FirebaseStorage.instance
          .ref()
          .child('customer_images')
          .child(imageName);
      File pickedImage = File(imagePath);
      await ref.putFile(pickedImage).then((snaphot) async {
        url = await snaphot.ref.getDownloadURL();
        print("Url is");
        print(url);
      });
      return url;
    }
  }
}
