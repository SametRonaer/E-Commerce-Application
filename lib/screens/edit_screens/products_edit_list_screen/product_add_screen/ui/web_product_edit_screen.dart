import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/category_model.dart';
import 'package:alfa_application/data/model/collection_model.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/data/model/second_category_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/general_cubits/second_category_cubit/cubit/second_category_cubit.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/product_add_screen/cubit/product_add_screen_cubit.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/ui/web_products_edit_list_screen_ui.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/widgets/add_image_cell.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/fake_dropdown_button.dart';
import 'package:alfa_application/widgets/web_page_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../filters/product_colour_filter.dart';
import '../filters/product_gold_percent_filter.dart';
import '../filters/product_visibility_filter.dart';

class WebProductEditScreen extends StatefulWidget {
  WebProductEditScreen({Key? key}) : super(key: key);

  @override
  State<WebProductEditScreen> createState() => _WebProductEditScreenState();
}

class _WebProductEditScreenState extends State<WebProductEditScreen> {
  late ProductsCubit _productsCubit;
  late ProductModel _selectedProduct;
  late ProductAddScreenCubit _productsAddCubit;
  TextEditingController _englishProductDescriptionController =
      TextEditingController();
  TextEditingController _turkishProductDescriptionController =
      TextEditingController();
  TextEditingController _arabicProductDescriptionController =
      TextEditingController();
  TextEditingController _englishProductNameController = TextEditingController();
  TextEditingController _turkishProductNameController = TextEditingController();
  TextEditingController _arabicProductNameController = TextEditingController();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productCodeController = TextEditingController();
  TextEditingController _productWeightController = TextEditingController();
  TextEditingController _productHeightController = TextEditingController();
  TextEditingController _productWidthController = TextEditingController();
  TextEditingController _productRadiusController = TextEditingController();
  TextStyle _subTitleTextstyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  TextStyle _titleTextstyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    _setControllersText();
    _productsAddCubit = context.read<ProductAddScreenCubit>();
    _productsCubit = context.read<ProductsCubit>();
    return BlocBuilder<ProductAddScreenCubit, ProductAddScreenState>(
      builder: (context, state) {
        print(state.runtimeType);
        return Stack(
          children: [
            Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      WebPageTitleField(
                        pageTitle: "PRODUCT > PRODUCT EDIT",
                        subTitle: "Please edit product information.",
                        redButtonTitle: "CANCEL",
                        blackButtonFunction: () async {
                          await _productsAddCubit.updateProduct(context);
                        },
                        redButtonFunction: () {
                          _productsAddCubit.clearProductData();
                          context
                              .read<WebHomeCubit>()
                              .switchCurrentScreen(WebProductsEditListScreen());
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 780,
                            child: Column(
                              children: [
                                _getProductNameArea(),
                                //First three lines
                                CustomTextField(
                                  controller: _productCodeController,
                                  hintText: "Product code..",
                                  onChangeFunction:
                                      _productsAddCubit.setProductCode,
                                  title: "Product Code",
                                  textStyle: _titleTextstyle,
                                ),
                                SizedBox(height: 20),
                                _getFirstArea(),

                                _getProductSizeArea(),
                              ],
                            ),
                          ),
                          SizedBox(width: 45),
                          _getImagesField(context),
                        ],
                      ),
                      _getSecondArea(),
                      // SizedBox(height: 20),
                      // SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     SizedBox(
                      //       width: 400,
                      //       child: CustomAppButton.black(
                      //           buttonName: "Update Product",
                      //           buttonFunction: () async {
                      //             await _productsAddCubit
                      //                 .updateProduct(context);
                      //           }),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 20),
                    ],
                  ),
                )),
            if (state is ProductAddScreenLoading) kGetLoadingScreen()
          ],
        );
      },
    );
  }

  _getSecondArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              FakeDropDownButton(
                hintText: _getSecondCategoryTitle() ??
                    "No(if yes, select collection.)",
                dropDownFunction: () =>
                    _getSecondCategoriesBottomSheet(context),
                title: "Is It a Collection?",
                textStyle: _titleTextstyle,
              ),
              FakeDropDownButton(
                textStyle: _titleTextstyle,
                hintText: kGetSortStausLabel(
                    _productsAddCubit.productModel.sortStatus),
                dropDownFunction: () => _getSortStatusesBottomSheet(context),
                title: "Product Sort Status",
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: _getProductDescriptionArea(),
        )
      ],
    );
  }

  _getFirstArea() {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Column(
              children: [
                FakeDropDownButton(
                  textStyle: _titleTextstyle,
                  hintText: _getCategoryTitle() ?? "Select Category",
                  dropDownFunction: () => _getCategoriesBottomSheet(context),
                  title: "Category",
                ),
                SizedBox(width: 10),
                FakeDropDownButton(
                  textStyle: _titleTextstyle,
                  hintText: _getModelTitle() ?? "Select Model",
                  title: "Model",
                  dropDownFunction: () => _getCollectionsBottomSheet(context),
                ),
              ],
            )),
        SizedBox(width: 25),
        Expanded(
          flex: 3,
          child: Column(children: [
            SizedBox(height: 15),
            ProductGoldPercentFilter(textStyle: _titleTextstyle),
            SizedBox(height: 20),
            ProductColourFilter(textStyle: _titleTextstyle),
            SizedBox(height: 20),
            ProductVisibilityFilter(textStyle: _titleTextstyle),
          ]),
        ),
      ],
    );
  }

  DefaultTabController _getProductDescriptionArea() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Description:", style: _titleTextstyle),
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
                  controller: _englishProductDescriptionController,
                  onChangeFunction:
                      _productsAddCubit.setProductEnglishDescription,
                  isLargeFied: true,
                  haveGap: false,
                  hintText: "Product Description...",
                ),
                CustomTextField(
                  controller: _turkishProductDescriptionController,
                  onChangeFunction:
                      _productsAddCubit.setProductTurkisnhDescription,
                  hintText: "Ürün açıklaması...",
                  isLargeFied: true,
                  haveGap: false,
                ),
                CustomTextField(
                  controller: _arabicProductDescriptionController,
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
          Text("Product Name:", style: _titleTextstyle),
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

  Widget _getImagesField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddImageCell(
          size: 330,
          isMainImage: true,
          cubit: _productsAddCubit,
        ),
        SizedBox(height: 10),
        Text("Other Images"),
        SizedBox(height: 3),
        Row(
          children: [
            AddImageCell(
              cubit: _productsAddCubit,
              size: 165,
            ),
            SizedBox(width: 3),
            AddImageCell(
              cubit: _productsAddCubit,
              size: 165,
            ),
          ],
        ),
        SizedBox(height: 3),
        Row(
          children: [
            AddImageCell(
              cubit: _productsAddCubit,
              size: 165,
            ),
            SizedBox(width: 3),
            AddImageCell(
              cubit: _productsAddCubit,
              size: 165,
            ),
          ],
        )
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

  Widget _getProductSizeArea() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Dimensions", style: _titleTextstyle),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Weight: ",
                              style: _subTitleTextstyle,
                            ),
                            CustomTextField(
                                controller: _productWeightController,
                                haveGap: false,
                                hintText: "Weight",
                                onChangeFunction:
                                    _productsAddCubit.setProductWeight,
                                textInputType: TextInputType.number),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Height: ",
                              style: _subTitleTextstyle,
                            ),
                            CustomTextField(
                                controller: _productHeightController,
                                haveGap: false,
                                onChangeFunction:
                                    _productsAddCubit.setProductHeight,
                                hintText: "Height",
                                textInputType: TextInputType.number),
                          ],
                        ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Radius: ",
                    style: _subTitleTextstyle,
                  ),
                  CustomTextField(
                      controller: _productRadiusController,
                      haveGap: false,
                      onChangeFunction: _productsAddCubit.setProductRadius,
                      hintText: "Radius",
                      textInputType: TextInputType.number),
                ],
              ),
            ),
            SizedBox(width: 5),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Width: ",
                    style: _subTitleTextstyle,
                  ),
                  CustomTextField(
                      controller: _productWidthController,
                      haveGap: false,
                      onChangeFunction: _productsAddCubit.setProductWidth,
                      hintText: "Width",
                      textInputType: TextInputType.number),
                ],
              ),
            ),
          ],
        ),
      ],
    );
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
                  category.secondCategoryTitleTurkish ??
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
    _englishProductDescriptionController.text =
        _selectedProduct.productDescriptionEnglish ?? "";
    _arabicProductDescriptionController.text =
        _selectedProduct.productDescriptionArabic ?? "";
    _turkishProductDescriptionController.text =
        _selectedProduct.productDescriptionTurkish ?? "";
    _englishProductNameController.text = _selectedProduct.productTitle ?? "";
    _turkishProductNameController.text =
        _selectedProduct.productTitleTurkish ?? "";
    _arabicProductNameController.text =
        _selectedProduct.productTitleArabic ?? "";
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productsAddCubit.clearProductData();
  }
}
