import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_add_edit_screens/cubit/second_category_add_edit_cubit.dart';
import 'package:alfa_application/widgets/app_bottom_navigation_bar.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../constants/app_general_methods.dart';
import '../../../../../widgets/custom_text_field.dart';

class SecondCategoryAddScreen extends StatelessWidget {
  SecondCategoryAddScreen({Key? key}) : super(key: key);
  static const routeName = "/second-category-add-screen";
  late SecondCategoryAddEditCubit _secondCategoryAddEditScreensCubit;
  TextEditingController _turkishTitleController = TextEditingController();
  TextEditingController _englishTitleController = TextEditingController();
  TextEditingController _arabicTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _secondCategoryAddEditScreensCubit =
        context.read<SecondCategoryAddEditCubit>();
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
                              Text("Collection Code",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.grey.shade700)),
                              CustomTextField(
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
                              buttonName: "Add New Collection",
                              buttonFunction: () {
                                _secondCategoryAddEditScreensCubit
                                    .addNewSecondCategory(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
            if (state is SecondCategoryAddEditLoading)
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
