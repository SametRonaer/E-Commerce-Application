import 'package:alfa_application/data/model/category_model.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_add_edit_screens/cubit/category_add_edit_screens_cubit.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_edit_list_web.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../widgets/web_page_title_field.dart';

class WebCategoryEditScreen extends StatefulWidget {
  WebCategoryEditScreen({Key? key}) : super(key: key);

  @override
  State<WebCategoryEditScreen> createState() => _WebCategoryEditScreenState();
}

class _WebCategoryEditScreenState extends State<WebCategoryEditScreen> {
  late CategoryAddEditScreensCubit _categoryAddEditScreensCubit;
  late CategoryModel _selectedCategory;
  TextEditingController _turkishTitleController = TextEditingController();
  TextEditingController _englishTitleController = TextEditingController();
  TextEditingController _arabicTitleController = TextEditingController();
  TextEditingController _categoryCodeController = TextEditingController();
  TextStyle _titleStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 17, color: Colors.grey.shade700);

  @override
  Widget build(BuildContext context) {
    _categoryAddEditScreensCubit = context.read<CategoryAddEditScreensCubit>();
    _selectedCategory = _categoryAddEditScreensCubit.getCategory;
    _setControllers();
    return BlocBuilder<CategoryAddEditScreensCubit,
        CategoryAddEditScreensState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    WebPageTitleField(
                        redButtonTitle: "CANCEL",
                        redButtonFunction: () {
                          _categoryAddEditScreensCubit.deleteSelectedImage();
                          context
                              .read<WebHomeCubit>()
                              .switchCurrentScreen(WebCategoryEditListScreen());
                        },
                        blackButtonFunction: () {
                          _categoryAddEditScreensCubit.updateCategory(context);
                        },
                        pageTitle: "CATEGORIES > EDIT CATEGORY",
                        subTitle: "Please edit category information."),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 400),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: double.infinity, height: 40),
                                  _getImageArea(context),
                                  SizedBox(height: 20),
                                  _getCategoryNameArea(),
                                  SizedBox(height: 10),
                                  Text("Category Code", style: _titleStyle),
                                  CustomTextField(
                                    controller: _categoryCodeController,
                                    haveGap: false,
                                    onChangeFunction:
                                        _categoryAddEditScreensCubit
                                            .setCategoryCode,
                                  ),
                                ],
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       bottom: 10.0, top: 20),
                              //   child: CustomAppButton.black(
                              //     buttonName: "Update Category",
                              //     buttonFunction: () {
                              //       _categoryAddEditScreensCubit
                              //           .updateCategory(context);
                              //     },
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            //if (state is CategoryAddEditScreensLoading)
            // Container(
            //   alignment: Alignment.center,
            //   color: Colors.black54,
            //   child: SpinKitSpinningLines(
            //     color: Colors.white,
            //     size: 100,
            //   ),
            // ),
          ],
        );
      },
    );
  }

  GestureDetector _getImageArea(BuildContext context) {
    return GestureDetector(
      onTap: () => _categoryAddEditScreensCubit.setWebPickedImage(),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15)),
        height: 400,
        width: 400,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.add_a_photo, size: 40),
            if (_categoryAddEditScreensCubit.getCategory.categoryImageUrl !=
                    "" &&
                _categoryAddEditScreensCubit.webPickedImage == null)
              Image.network(
                  _categoryAddEditScreensCubit.getCategory.categoryImageUrl),
            if (_categoryAddEditScreensCubit.webPickedImage != null)
              Image.memory(
                _categoryAddEditScreensCubit.webPickedImage!,
                fit: BoxFit.fitHeight,
              ),
            if (_categoryAddEditScreensCubit.webPickedImage != null)
              GestureDetector(
                onTap: () => _categoryAddEditScreensCubit.deleteSelectedImage(),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.delete,
                    size: 40,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _getCategoryNameArea() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Category Name:", style: _titleStyle),
          SizedBox(height: 10),
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
                  controller: _englishTitleController,
                  onChangeFunction:
                      _categoryAddEditScreensCubit.setCategoryTitle,
                  haveGap: false,
                  hintText: "Category name...",
                ),
                CustomTextField(
                  controller: _turkishTitleController,
                  onChangeFunction:
                      _categoryAddEditScreensCubit.setCategoryTitleTurkish,
                  hintText: "Kategori ismi...",
                  haveGap: false,
                ),
                CustomTextField(
                  controller: _arabicTitleController,
                  onChangeFunction:
                      _categoryAddEditScreensCubit.setCategoryTitleArabic,
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

  void _setControllers() {
    _englishTitleController.text = _selectedCategory.categoryTitle ?? "";
    _turkishTitleController.text = _selectedCategory.categoryTitleTurkish ?? "";
    _arabicTitleController.text = _selectedCategory.categoryTitleArabic ?? "";
    _categoryCodeController.text = _selectedCategory.categoryCode ?? "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _categoryAddEditScreensCubit.deleteSelectedImage();
  }
}
