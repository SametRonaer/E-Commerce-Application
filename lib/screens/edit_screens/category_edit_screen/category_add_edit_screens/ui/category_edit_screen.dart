import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/data/model/category_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_add_edit_screens/cubit/category_add_edit_screens_cubit.dart';
import 'package:alfa_application/widgets/app_bottom_navigation_bar.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CategoryEditScreen extends StatelessWidget {
  CategoryEditScreen({Key? key}) : super(key: key);
  static const routeName = "/category-edit-screen";
  late CategoryAddEditScreensCubit _categoryAddEditScreensCubit;
  late CategoryModel _selectedCategory;
  TextEditingController _categoryCodeController = TextEditingController();
  TextEditingController _turkishTitleController = TextEditingController();
  TextEditingController _englishTitleController = TextEditingController();
  TextEditingController _arabicTitleController = TextEditingController();

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
                backgroundColor: Colors.black,
                appBar: kGetAppBar(context),
                bottomNavigationBar: AppBottomNavigationBar(),
                body: Container(
                  height: context.screenHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth / 14),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: double.infinity, height: 40),
                              _getImageArea(context),
                              SizedBox(height: 20),
                              _getCategoryNameArea(),
                              SizedBox(height: 10),
                              Text(
                                "Category Code",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              CustomTextField(
                                controller: _categoryCodeController,
                                haveGap: false,
                                onChangeFunction: _categoryAddEditScreensCubit
                                    .setCategoryCode,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10.0, top: 20),
                            child: CustomAppButton.black(
                              buttonName: "Update Category",
                              buttonFunction: () {
                                _categoryAddEditScreensCubit
                                    .updateCategory(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
            if (state is CategoryAddEditScreensLoading)
              Container(
                alignment: Alignment.center,
                color: Colors.black54,
                child: SpinKitSpinningLines(
                  color: Colors.white,
                  size: 100,
                ),
              ),
          ],
        );
      },
    );
  }

  DefaultTabController _getCategoryNameArea() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Category Name:",
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

  GestureDetector _getImageArea(BuildContext context) {
    return GestureDetector(
      onTap: () => _categoryAddEditScreensCubit.setPickedImage(),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15)),
        height: context.screenWidth / 1.2,
        width: context.screenWidth / 1.2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.add_a_photo, size: 40),
            if (_categoryAddEditScreensCubit.getCategory.categoryImageUrl !=
                    "" &&
                _categoryAddEditScreensCubit.pickedImage == null)
              Image.network(
                  _categoryAddEditScreensCubit.getCategory.categoryImageUrl),
            if (_categoryAddEditScreensCubit.pickedImage != null)
              Image.file(_categoryAddEditScreensCubit.pickedImage!),
            if (_categoryAddEditScreensCubit.pickedImage != null)
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

  void _setControllers() {
    _englishTitleController.text = _selectedCategory.categoryTitle ?? "";
    _turkishTitleController.text = _selectedCategory.categoryTitleTurkish ?? "";
    _arabicTitleController.text = _selectedCategory.categoryTitleArabic ?? "";
    _categoryCodeController.text = _selectedCategory.categoryCode ?? "";
  }
}
