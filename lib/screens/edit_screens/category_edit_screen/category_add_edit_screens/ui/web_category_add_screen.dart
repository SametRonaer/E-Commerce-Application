import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_add_edit_screens/cubit/category_add_edit_screens_cubit.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_edit_list_web.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/widgets/app_bottom_navigation_bar.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/web_page_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WebCategoryAddScreen extends StatefulWidget {
  WebCategoryAddScreen({Key? key}) : super(key: key);

  @override
  State<WebCategoryAddScreen> createState() => _WebCategoryAddScreenState();
}

class _WebCategoryAddScreenState extends State<WebCategoryAddScreen> {
  late CategoryAddEditScreensCubit _categoryAddEditScreensCubit;
  TextEditingController _turkishTitleController = TextEditingController();
  TextEditingController _englishTitleController = TextEditingController();
  TextEditingController _arabicTitleController = TextEditingController();
  TextStyle _titleStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 17, color: Colors.grey.shade700);

  @override
  Widget build(BuildContext context) {
    _categoryAddEditScreensCubit = context.read<CategoryAddEditScreensCubit>();
    return BlocBuilder<CategoryAddEditScreensCubit,
        CategoryAddEditScreensState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
                body: Column(
              children: [
                WebPageTitleField(
                    pageTitle: "CATEGORIES > ADD CATEGORY",
                    blackButtonFunction: () {
                      _categoryAddEditScreensCubit.addNewCategory(context);
                    },
                    redButtonFunction: () {
                      _categoryAddEditScreensCubit.deleteSelectedImage();
                      context
                          .read<WebHomeCubit>()
                          .switchCurrentScreen(WebCategoryEditListScreen());
                    },
                    subTitle: "Please confirm category information."),
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
                                haveGap: false,
                                onChangeFunction: _categoryAddEditScreensCubit
                                    .setCategoryCode,
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(bottom: 10.0, top: 20),
                          //   child: CustomAppButton.black(
                          //     buttonName: "Add Category",
                          //     buttonFunction: () {
                          //       _categoryAddEditScreensCubit
                          //           .addNewCategory(context);
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _categoryAddEditScreensCubit.deleteSelectedImage();
  }
}
