import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_add_edit_screens/cubit/second_category_add_edit_cubit.dart';
import 'package:alfa_application/widgets/app_bottom_navigation_bar.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/model/second_category_model.dart';

class SecondCategoryEditScreen extends StatelessWidget {
  SecondCategoryEditScreen({Key? key}) : super(key: key);
  static const routeName = "/second-category-edit-screen";
  late SecondCategoryAddEditCubit _secondCategoryAddEditScreensCubit;
  late SecondCategoryModel _selectedSecondCategory;
  TextEditingController _englishTitleController = TextEditingController();
  TextEditingController _turkishTitleController = TextEditingController();
  TextEditingController _arabicTitleController = TextEditingController();
  TextEditingController _secondCategoryCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _secondCategoryAddEditScreensCubit =
        context.read<SecondCategoryAddEditCubit>();
    _selectedSecondCategory =
        _secondCategoryAddEditScreensCubit.getSecondCategory;
    _englishTitleController.text =
        _selectedSecondCategory.secondCategoryTitle ?? "";
    _turkishTitleController.text =
        _selectedSecondCategory.secondCategoryTitleTurkish ?? "";
    _arabicTitleController.text =
        _selectedSecondCategory.secondCategoryTitleArabic ?? "";
    _secondCategoryCodeController.text =
        _selectedSecondCategory.secondCategoryCode;
    return BlocBuilder<SecondCategoryAddEditCubit, SecondCategoryAddEditState>(
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
                              _getSecondCategoryNameArea(),
                              SizedBox(height: 10),
                              Text(
                                "Collection Code",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              CustomTextField(
                                controller: _secondCategoryCodeController,
                                haveGap: false,
                                onChangeFunction:
                                    _secondCategoryAddEditScreensCubit
                                        .setSecondCategoryCode,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10.0, top: 20),
                            child: CustomAppButton.black(
                              buttonName: "Update Collection",
                              buttonFunction: () {
                                _secondCategoryAddEditScreensCubit
                                    .updateSecondCategory(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
            if (state is SecondCategoryAddEditLoading) kGetLoadingScreen()
          ],
        );
      },
    );
  }

  GestureDetector _getImageArea(BuildContext context) {
    return GestureDetector(
      onTap: () => _secondCategoryAddEditScreensCubit.setPickedImage(),
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
            if (_secondCategoryAddEditScreensCubit
                        .getSecondCategory.secondCategoryImageUrl !=
                    "" &&
                _secondCategoryAddEditScreensCubit.pickedImage == null)
              Image.network(_secondCategoryAddEditScreensCubit
                  .getSecondCategory.secondCategoryImageUrl),
            if (_secondCategoryAddEditScreensCubit.pickedImage != null)
              Image.file(_secondCategoryAddEditScreensCubit.pickedImage!),
            if (_secondCategoryAddEditScreensCubit.pickedImage != null)
              GestureDetector(
                onTap: () =>
                    _secondCategoryAddEditScreensCubit.deleteSelectedImage(),
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

  DefaultTabController _getSecondCategoryNameArea() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Collection Name:",
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
                      _secondCategoryAddEditScreensCubit.setSecondCategoryTitle,
                  haveGap: false,
                  hintText: "Collection name...",
                ),
                CustomTextField(
                  controller: _turkishTitleController,
                  onChangeFunction: _secondCategoryAddEditScreensCubit
                      .setSecondCategoryTitleTurkish,
                  hintText: "Koleksiyon ismi...",
                  haveGap: false,
                ),
                CustomTextField(
                  controller: _arabicTitleController,
                  onChangeFunction: _secondCategoryAddEditScreensCubit
                      .setSecondCategoryTitleArabic,
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
