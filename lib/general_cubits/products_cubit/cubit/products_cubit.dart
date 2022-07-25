import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/data/model/category_model.dart';
import 'package:alfa_application/data/model/collection_model.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/data/model/second_category_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  late CollectionReference _productsCollection;
  late CollectionReference _collectionsCollection;
  late CollectionReference _categoriesCollection;
  final _firestore = FirebaseFirestore.instance;
  final List<ProductModel> _allProducts = [];
  final List<ProductModel> _collectionProducts = [];
  final List<ProductModel> _categoryProducts = [];
  final List<ProductModel> _secondCategoryProducts = [];
  ProductModel? _selectedProduct;
  ProductModel? get selectedProduct => _selectedProduct;
  List<ProductModel> get allProducts => _allProducts;
  List<ProductModel> get collectionProducts => _collectionProducts;
  List<ProductModel> get categoryProducts => _categoryProducts;
  List<ProductModel> get secondCategoryProducts => _secondCategoryProducts;

  String _collectionScreenTitle = "";
  String get collectionScreenTitle => _collectionScreenTitle;

  List<CollectionModel> _filteredCollections = [];
  List<CollectionModel> get filteredCollections => _filteredCollections;

  List<ProductModel> _filteredProducts = [];
  List<ProductModel> get filteredProducts => _filteredProducts;

  List<ProductModel> _selectedCollectionProducts = [];
  List<ProductModel> get selectedCollectionProducts =>
      _selectedCollectionProducts;

  final List<CategoryModel> _allCategories = [];
  CategoryModel? _selectedCategory;

  CategoryModel? get selectedCategory => _selectedCategory;
  List<CategoryModel> get allCategories => _allCategories;

  final List<CollectionModel> _allCollections = [];
  CollectionModel? _selectedCollection;

  CollectionModel? get selectedCollection => _selectedCollection;
  List<CollectionModel> get allCollections => _allCollections;

  ProductsCubit() : super(ProductsInitial()) {
    _productsCollection = _firestore.collection("Products");
    _collectionsCollection = _firestore.collection("Collections");
    _categoriesCollection = _firestore.collection("Categories");
    getAllCategories();
    getAllCollections();
    getAllProducts();
  }
//-----------------------------Product Methods Start Here--------------------------------------------//

  Future<void> getAllProducts() async {
    emit(ProductsLoading());
    _allProducts.clear();
    QuerySnapshot querySnapshot = await _productsCollection.get();
    final allProductsData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    allProductsData.forEach((productData) {
      ProductModel product =
          ProductModel.fromMap(productData as Map<String, dynamic>);
      _allProducts.add(product);
    });
    emit(ProductsLoaded());
  }

  Future<void> getProductWithId({required String productId}) async {
    emit(ProductsLoading());
    DocumentSnapshot productData =
        await _productsCollection.doc(productId).get();
    if (productData.data() != null) {
      ProductModel product =
          ProductModel.fromMap(productData.data() as Map<String, dynamic>);
      _selectedProduct = product;
    }
    emit(ProductsLoaded());
  }

  Future<void> getProductsWithCategoryId(
      {required CategoryModel category}) async {
    _collectionScreenTitle = kGetCategoryScreenTitle(category);
    emit(ProductsLoading());
    _filteredProducts.clear();
    _filteredCollections.clear();

    QuerySnapshot querySnapshot = await _productsCollection
        .where("categoryId", isEqualTo: category.categoryId)
        .get();
    final filteredProductsData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    filteredProductsData.forEach((productData) {
      ProductModel product =
          ProductModel.fromMap(productData as Map<String, dynamic>);
      _filteredProducts.add(product);
    });

    await Future.forEach(_filteredProducts, (element) async {
      await getCollectionByCollectionId(
          collectionId: (element as ProductModel).collectionId!);
      _filteredCollections.add(_selectedCollection!);
    });

    _filteredCollections = _filteredCollections.toSet().toList();
    emit(ProductsLoaded());
  }

  Future<void> getProductsWithSecondCategoryId(
      {required SecondCategoryModel secondCategoryModel}) async {
    String currentLanguage = GetStorage().read("languagePreference");
    _collectionScreenTitle = kGetSecondCategoryScreenName(secondCategoryModel);
    emit(ProductsLoading());
    _filteredProducts.clear();
    _filteredCollections.clear();
    QuerySnapshot querySnapshot = await _productsCollection
        .where("secondCategoryId",
            isEqualTo: secondCategoryModel.secondCategoryId)
        .get();
    final filteredProductsData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    filteredProductsData.forEach((productData) {
      ProductModel product =
          ProductModel.fromMap(productData as Map<String, dynamic>);
      _filteredProducts.add(product);
    });

    await Future.forEach(_filteredProducts, (element) async {
      await getCollectionByCollectionId(
          collectionId: (element as ProductModel).collectionId!);
      _filteredCollections.add(_selectedCollection!);
    });

    _filteredCollections = _filteredCollections.toSet().toList();
    emit(ProductsLoaded());
  }

  Future<void> getProductsWithCollectionId(
      {required String collectionId}) async {
    emit(ProductsLoading());
    _collectionProducts.clear();
    QuerySnapshot querySnapshot = await _productsCollection
        .where("modelId", isEqualTo: collectionId)
        .get();
    final filteredProductsData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    filteredProductsData.forEach((productData) {
      ProductModel product =
          ProductModel.fromMap(productData as Map<String, dynamic>);
      _collectionProducts.add(product);
    });
    emit(ProductsLoaded());
  }

  getSelectedCollectionProducts() {
    _selectedCollectionProducts = _filteredProducts
        .where((element) =>
            element.collectionId == _selectedCollection!.collectionId)
        .toList();
    print(_selectedCollectionProducts.toString());
    print(_filteredProducts.length);
    emit(ProductsLoaded());
  }

  Future<void> addNewProduct({required ProductModel product}) async {
    emit(ProductsLoading());
    String productId = DateTime.now().millisecondsSinceEpoch.toString();
    product.productId = productId;
    await _productsCollection.doc(product.productId).set(product.toMap());
    await getAllProducts();
    emit(ProductsLoaded());
  }

  Future<void> updateProduct(
      {required Map<String, dynamic> newData,
      required String productId}) async {
    emit(ProductsLoading());
    await _productsCollection.doc(productId).update(newData);
    emit(ProductsLoaded());
  }

  Future<void> deleteProduct({required String productId}) async {
    emit(ProductsLoading());
    await _productsCollection.doc(productId).delete();
    await getAllProducts();
    emit(ProductsLoaded());
  }

  setSelectedProduct(ProductModel productModel) {
    emit(ProductsLoading());
    _selectedProduct = productModel;
    emit(ProductsLoaded());
  }

//-----------------------------Product Methods End Here--------------------------------------------//

//-----------------------------Category Methods Start Here--------------------------------------------//

  Future<void> getAllCategories() async {
    emit(ProductsLoading());
    _allCategories.clear();
    QuerySnapshot querySnapshot = await _categoriesCollection.get();
    final allCategoriessData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    allCategoriessData.forEach((categoryData) {
      CategoryModel category =
          CategoryModel.fromMap(categoryData as Map<String, dynamic>);
      _allCategories.add(category);
    });
    _allCategories.forEach((element) => print(element.categoryTitle));
    emit(ProductsLoaded());
  }

  Future<void> getCategoryByCategoryTitle(
      {required String categoryTitle}) async {
    emit(ProductsLoading());
    QuerySnapshot querySnapshot = await _categoriesCollection
        .where("categoryTitle", isEqualTo: categoryTitle)
        .get();
    final filteredCategoriesData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    _selectedCategory = CategoryModel.fromMap(
        filteredCategoriesData.first as Map<String, dynamic>);
    emit(ProductsLoaded());
  }

  Future<void> getCategoryByCategoryId({required String categoryId}) async {
    emit(ProductsLoading());
    DocumentSnapshot categoryData =
        await _categoriesCollection.doc(categoryId).get();
    CategoryModel category =
        CategoryModel.fromMap(categoryData.data() as Map<String, dynamic>);
    _selectedCategory = category;
    emit(ProductsLoaded());
  }

  Future<void> addNewCategory({required CategoryModel category}) async {
    emit(ProductsLoading());
    String categoryId = DateTime.now().millisecondsSinceEpoch.toString();
    category.categoryId = categoryId;
    await _categoriesCollection.doc(categoryId).set(category.toMap());
    emit(ProductsLoaded());
  }

  Future<void> deleteCategory({required String categoryId}) async {
    emit(ProductsLoading());
    await _categoriesCollection.doc(categoryId).delete();
    await getAllCategories();
    emit(ProductsLoaded());
  }

  Future<void> updateCategory(
      {required Map<String, dynamic> newData,
      required String categoryId}) async {
    emit(ProductsLoading());
    await _categoriesCollection.doc(categoryId).update(newData);
    emit(ProductsLoaded());
  }

  setSelectedCategory(CategoryModel categoryModel) {
    _selectedCategory = categoryModel;
  }

  //-----------------------------Category Methods End Here--------------------------------------------//

  //-----------------------------Collection Methods Start Here--------------------------------------------//
  Future<void> getAllCollections() async {
    emit(ProductsLoading());
    _allCollections.clear();
    QuerySnapshot querySnapshot = await _collectionsCollection.get();
    final allCollectionsData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    allCollectionsData.forEach((collectionData) {
      CollectionModel collection =
          CollectionModel.fromMap(collectionData as Map<String, dynamic>);
      _allCollections.add(collection);
    });
    emit(ProductsLoaded());
  }

  Future<void> getCollectionByCollectionId(
      {required String collectionId}) async {
    emit(ProductsLoading());
    DocumentSnapshot collectionData =
        await _collectionsCollection.doc(collectionId).get();
    CollectionModel collection =
        CollectionModel.fromMap(collectionData.data() as Map<String, dynamic>);
    _selectedCollection = collection;
    emit(ProductsLoaded());
  }

  Future<void> getCollectionByCollectionTitle(
      {required String collectionTitle}) async {
    emit(ProductsLoading());
    QuerySnapshot querySnapshot = await _collectionsCollection
        .where("collectionTitle", isEqualTo: collectionTitle)
        .get();
    final filteredCollectionsData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    _selectedCollection = CollectionModel.fromMap(
        filteredCollectionsData.first as Map<String, dynamic>);
    emit(ProductsLoaded());
  }

  Future<void> addNewCollection({required CollectionModel collection}) async {
    emit(ProductsLoading());
    String collectionId = DateTime.now().millisecondsSinceEpoch.toString();
    collection.collectionId = collectionId;
    await _collectionsCollection.doc(collectionId).set(collection.toMap());
    emit(ProductsLoaded());
  }

  Future<void> deleteCollection({required String collectionId}) async {
    emit(ProductsLoading());
    await _collectionsCollection.doc(collectionId).delete();
    await getAllCollections();
    emit(ProductsLoaded());
  }

  Future<void> updateCollection(
      {required Map<String, dynamic> newData,
      required String collectionId}) async {
    emit(ProductsLoading());
    await _collectionsCollection.doc(collectionId).update(newData);
    emit(ProductsLoaded());
  }
}
