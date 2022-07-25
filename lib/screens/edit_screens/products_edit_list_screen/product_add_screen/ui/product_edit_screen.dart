import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/category_model.dart';
import 'package:alfa_application/data/model/collection_model.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/data/model/second_category_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/general_cubits/second_category_cubit/cubit/second_category_cubit.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/cubit/product_add_screen_cubit.dart';
import 'package:alfa_application/widgets/add_image_cell.dart';
import 'package:alfa_application/widgets/app_bottom_navigation_bar.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/fake_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../filters/product_colour_filter.dart';
import '../filters/product_gold_percent_filter.dart';
import '../filters/product_visibility_filter.dart';

class ProductEditScreen extends StatefulWidget {
  ProductEditScreen({Key? key}) : super(key: key);
  static const routeName = "/edit-product-screen";

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  late ProductsCubit _productsCubit;
  late ProductAddScreenCubit _productsAddCubit;
  late ProductModel _selectedProduct;
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productCodeController = TextEditingController();
  TextEditingController _productWeightController = TextEditingController();
  TextEditingController _productHeightController = TextEditingController();
  TextEditingController _productWidthController = TextEditingController();
  TextEditingController _productRadiusController = TextEditingController();
  TextEditingController _productEnglishDescriptionController =
      TextEditingController();
  TextEditingController _productTurkishDescriptionController =
      TextEditingController();
  TextEditingController _productArabicDescriptionController =
      TextEditingController();

  TextEditingController _englishProductNameController = TextEditingController();
  TextEditingController _turkishProductNameController = TextEditingController();
  TextEditingController _arabicProductNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _setControllersText();
    _productsAddCubit = context.read<ProductAddScreenCubit>();

    _productsCubit = context.read<ProductsCubit>();
    return BlocBuilder<ProductAddScreenCubit, ProductAddScreenState>(
      builder: (context, state) {
        print(state.runtimeType);
        return Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(Colors.grey.shade300),
            backgroundColor: Colors.black,
            appBar: kGetAppBar(context),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    height: context.screenHeight,
                    width: context.screenWidth,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _getProductNameArea(),
                          CustomTextField(
                            onChangeFunction: _productsAddCubit.setProductCode,
                            controller: _productCodeController,
                            title: "Product Code",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Dimensions",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: CustomTextField(
                                              controller:
                                                  _productWeightController,
                                              hintText: "Weight",
                                              onChangeFunction:
                                                  _productsAddCubit
                                                      .setProductWeight,
                                              textInputType:
                                                  TextInputType.number),
                                        ),
                                        SizedBox(width: 5),
                                        Flexible(
                                          child: CustomTextField(
                                              onChangeFunction:
                                                  _productsAddCubit
                                                      .setProductHeight,
                                              controller:
                                                  _productHeightController,
                                              hintText: "Height",
                                              textInputType:
                                                  TextInputType.number),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CustomTextField(
                                    onChangeFunction:
                                        _productsAddCubit.setProductRadius,
                                    controller: _productRadiusController,
                                    hintText: "Radius",
                                    textInputType: TextInputType.number),
                              ),
                              SizedBox(width: 5),
                              Flexible(
                                child: CustomTextField(
                                    onChangeFunction:
                                        _productsAddCubit.setProductWidth,
                                    controller: _productWidthController,
                                    hintText: "Width",
                                    textInputType: TextInputType.number),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Flexible(
                                  child: FakeDropDownButton(
                                hintText:
                                    _getCategoryTitle() ?? "Select Category",
                                dropDownFunction: () =>
                                    _getCategoriesBottomSheet(context),
                                title: "Category",
                              )),
                              SizedBox(width: 10),
                              Flexible(
                                  child: FakeDropDownButton(
                                hintText: _getModelTitle() ?? "Select Model",
                                title: "Model",
                                dropDownFunction: () =>
                                    _getCollectionsBottomSheet(context),
                              )),
                            ],
                          ),
                          SizedBox(
                              width: context.screenWidth / 2,
                              child: FakeDropDownButton(
                                hintText: _getSecondCategoryTitle() ??
                                    "No(if yes, select collection.)",
                                dropDownFunction: () =>
                                    _getSecondCategoriesBottomSheet(context),
                                title: "Is It a Collection?",
                              )),
                          SizedBox(
                              width: context.screenWidth / 2,
                              child: FakeDropDownButton(
                                hintText: kGetSortStausLabel(
                                    _productsAddCubit.productModel.sortStatus),
                                dropDownFunction: () =>
                                    _getSortStatusesBottomSheet(context),
                                title: "Product Sort Status",
                              )),
                          SizedBox(height: 15),
                          ProductGoldPercentFilter(),
                          SizedBox(height: 20),
                          ProductColourFilter(),
                          SizedBox(height: 20),
                          ProductVisibilityFilter(),
                          SizedBox(height: 20),
                          _getProductDescriptionArea(),
                          SizedBox(height: 10),
                          _getImagesField(context),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomAppButton.black(
                                  buttonName: "Update Product",
                                  buttonFunction: () async {
                                    await _productsAddCubit
                                        .updateProduct(context);
                                  }),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is ProductAddScreenLoading)
                  Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: SpinKitSpinningLines(
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
              ],
            ));
      },
    );
  }

  String? _getCategoryTitle() {
    List<CategoryModel> categoryList = _productsCubit.allCategories
        .where((element) =>
            element.categoryId == _productsAddCubit.productModel.categoryId)
        .toList();
    if (categoryList.length != 0) {
      return categoryList.first.categoryTitle;
    }
  }

  String? _getSecondCategoryTitle() {
    List<SecondCategoryModel> secondCategoryModelList = context
        .read<SecondCategoryCubit>()
        .allSecondCategories
        .where((element) =>
            element.secondCategoryId ==
            _productsAddCubit.productModel.secondCategoryId)
        .toList();

    if (secondCategoryModelList.length != 0) {
      return secondCategoryModelList.first.secondCategoryTitle;
    }
  }

  String? _getModelTitle() {
    List<CollectionModel> collectionList = _productsCubit.allCollections
        .where((element) =>
            element.collectionId == _productsAddCubit.productModel.collectionId)
        .toList();
    if (collectionList.length != 0) {
      return collectionList.first.collectionTitle;
    }
  }

  Row _getImagesField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AddImageCell(
          index: 0,
          isMainImage: true,
          cubit: _productsAddCubit,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Other Images", style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 3),
            Row(
              children: [
                AddImageCell(
                  cubit: _productsAddCubit,
                  index: 1,
                ),
                SizedBox(width: 4),
                AddImageCell(cubit: _productsAddCubit, index: 2)
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                AddImageCell(cubit: _productsAddCubit, index: 3),
                SizedBox(width: 4),
                AddImageCell(cubit: _productsAddCubit, index: 4),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _getCategoriesBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        builder: (_) {
          return Container(
            height: context.screenHeight / 1.5,
            child: Column(
              children: [
                ListTile(
                  title: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Select")),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  height: context.screenHeight / 1.9,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (_, i) {
                      return _getCategoryTile(
                          _productsCubit.allCategories[i], context);
                    },
                    itemCount: _productsCubit.allCategories.length,
                  ),
                ),
              ],
            ),
          );
        });
  }

  _getSecondCategoriesBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        builder: (_) {
          return Container(
            height: context.screenHeight / 1.5,
            child: Column(
              children: [
                ListTile(
                  title: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Select")),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  height: context.screenHeight / 1.9,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (_, i) {
                      return _getSecondCategoryTile(
                          context
                              .read<SecondCategoryCubit>()
                              .allSecondCategories[i],
                          context);
                    },
                    itemCount: context
                        .read<SecondCategoryCubit>()
                        .allSecondCategories
                        .length,
                  ),
                ),
              ],
            ),
          );
        });
  }

  _getCollectionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        builder: (_) {
          return Container(
            height: context.screenHeight / 1.5,
            child: Column(
              children: [
                ListTile(
                  title: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Select")),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  height: context.screenHeight / 1.9,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (_, i) {
                      return _getModelTile(
                          _productsCubit.allCollections[i], context);
                    },
                    itemCount: _productsCubit.allCollections.length,
                  ),
                ),
              ],
            ),
          );
        });
  }

  _getCategoryTile(CategoryModel category, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _productsAddCubit.setProductCategory(category);
        Navigator.of(context).pop();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              category.categoryTitle ?? category.categoryTitleTurkish ?? "",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 0.7,
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  _getSecondCategoryTile(SecondCategoryModel category, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _productsAddCubit.setProductSecondCategory(category);
        Navigator.of(context).pop();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              category.secondCategoryTitle ??
                  category.secondCategoryTitle ??
                  "",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 0.7,
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  _getModelTile(CollectionModel collection, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _productsAddCubit.setProductModel(collection);
        Navigator.of(context).pop();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              collection.collectionTitle ?? "",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 0.7,
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  void _setControllersText() {
    _selectedProduct = context.read<ProductAddScreenCubit>().productModel;
    _productNameController.text = _selectedProduct.productTitle ?? "";
    _productCodeController.text = _selectedProduct.productCode ?? "";
    _productWeightController.text = _selectedProduct.productWeight.toString();
    _productHeightController.text = _selectedProduct.productHeight.toString();
    _productWidthController.text = _selectedProduct.productWidth.toString();
    _productRadiusController.text = _selectedProduct.productRadius.toString();
    _productEnglishDescriptionController.text =
        _selectedProduct.productDescriptionEnglish ?? "";
    _productArabicDescriptionController.text =
        _selectedProduct.productDescriptionArabic ?? "";
    _productTurkishDescriptionController.text =
        _selectedProduct.productDescriptionTurkish ?? "";
    _englishProductNameController.text = _selectedProduct.productTitle ?? "";
    _turkishProductNameController.text =
        _selectedProduct.productTitleTurkish ?? "";
    _arabicProductNameController.text =
        _selectedProduct.productTitleArabic ?? "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productsAddCubit.clearProductData();
  }

  _getSortStatusesBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        builder: (_) {
          return Container(
            height: context.screenHeight / 1.5,
            child: Column(
              children: [
                ListTile(
                  title: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Select")),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  height: context.screenHeight / 1.9,
                  width: double.infinity,
                  child: ListView(
                    children: [
                      ListTile(
                          title: Text("Standart"),
                          onTap: () {
                            _productsAddCubit.setProductSortStatus(
                                SortStatuses.Standart.toString());
                            Navigator.of(context).pop();
                          }),
                      ListTile(
                          title: Text("Primary"),
                          onTap: () {
                            _productsAddCubit.setProductSortStatus(
                                SortStatuses.Primary.toString());
                            Navigator.of(context).pop();
                          }),
                      ListTile(
                          title: Text("Secondary"),
                          onTap: () {
                            _productsAddCubit.setProductSortStatus(
                                SortStatuses.Secondary.toString());
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  DefaultTabController _getProductDescriptionArea() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Description:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey.shade700)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              indicatorColor: Colors.grey,
              tabs: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "English",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Türkçe",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Arabic",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 215,
            child: TabBarView(
              children: [
                CustomTextField(
                  controller: _productEnglishDescriptionController,
                  onChangeFunction:
                      _productsAddCubit.setProductEnglishDescription,
                  isLargeFied: true,
                  haveGap: false,
                  hintText: "Product Description...",
                ),
                CustomTextField(
                  controller: _productTurkishDescriptionController,
                  onChangeFunction:
                      _productsAddCubit.setProductTurkisnhDescription,
                  hintText: "Ürün açıklaması...",
                  isLargeFied: true,
                  haveGap: false,
                ),
                CustomTextField(
                  controller: _productArabicDescriptionController,
                  onChangeFunction:
                      _productsAddCubit.setProductArabicDescription,
                  hintText: "وصف المنتج...",
                  isLargeFied: true,
                  haveGap: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DefaultTabController _getProductNameArea() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Name:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey.shade700)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              indicatorColor: Colors.grey,
              tabs: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "English",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Türkçe",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Arabic",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 65,
            child: TabBarView(
              children: [
                CustomTextField(
                  controller: _englishProductNameController,
                  onChangeFunction: _productsAddCubit.setProductName,
                  haveGap: false,
                  hintText: "Product name...",
                ),
                CustomTextField(
                  controller: _turkishProductNameController,
                  onChangeFunction: _productsAddCubit.setProductTurkishName,
                  hintText: "Ürün ismi...",
                  haveGap: false,
                ),
                CustomTextField(
                  controller: _arabicProductNameController,
                  onChangeFunction: _productsAddCubit.setProductArabicName,
                  hintText: "وصف المنتج...",
                  haveGap: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
