import 'package:alfa_application/data/model/second_category_model.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_add_edit_screens/cubit/category_add_edit_screens_cubit.dart';
import 'package:alfa_application/screens/edit_screens/products_edit_list_screen/ui/web_products_edit_list_screen_ui.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_add_edit_screens/cubit/second_category_add_edit_cubit.dart';
import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/web_second_category_edit_list_screen.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/web_page_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WebSecondCategoryEditScreen extends StatefulWidget {
  WebSecondCategoryEditScreen({Key? key}) : super(key: key);

  @override
  State<WebSecondCategoryEditScreen> createState() =>
      _WebSecondCategoryEditScreenState();
}

class _WebSecondCategoryEditScreenState
    extends State<WebSecondCategoryEditScreen> {
  late SecondCategoryAddEditCubit _secondCategoryAddEditScreensCubit;
  late SecondCategoryModel _selectedSecondCategory;
  TextEditingController _turkishTitleController = TextEditingController();
  TextEditingController _englishTitleController = TextEditingController();
  TextEditingController _arabicTitleController = TextEditingController();
  TextEditingController _secondCategoryCodeController = TextEditingController();
  TextStyle _titleStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 17, color: Colors.grey.shade700);

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
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    WebPageTitleField(
                        redButtonTitle: "CANCEL",
                        blackButtonFunction: () {
                          _secondCategoryAddEditScreensCubit
                              .updateSecondCategory(context);
                        },
                        redButtonFunction: () {
                          _secondCategoryAddEditScreensCubit
                              .deleteSelectedImage();
                          context.read<WebHomeCubit>().switchCurrentScreen(
                              WebSecondCategoryEditListScreen());
                        },
                        pageTitle: "COLLECTIONS > EDIT COLLECTION",
                        subTitle: "Please edit collection fileds."),
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
                                  _getSecondCategoryNameArea(),
                                  SizedBox(height: 10),
                                  Text("Collection Code", style: _titleStyle),
                                  CustomTextField(
                                    controller: _secondCategoryCodeController,
                                    haveGap: false,
                                    onChangeFunction:
                                        _secondCategoryAddEditScreensCubit
                                            .setSecondCategoryCode,
                                  ),
                                ],
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       bottom: 10.0, top: 20),
                              //   child: CustomAppButton.black(
                              //     buttonName: "Update Collection",
                              //     buttonFunction: () {
                              //       _secondCategoryAddEditScreensCubit
                              //           .updateSecondCategory(context);
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
            // if (state is CategoryAddEditScreensLoading)
            //   Container(
            //     alignment: Alignment.center,
            //     color: Colors.black54,
            //     child: SpinKitSpinningLines(
            //       color: Colors.white,
            //       size: 100,
            //     ),
            //   ),
          ],
        );
      },
    );
  }

  GestureDetector _getImageArea(BuildContext context) {
    return GestureDetector(
      onTap: () => _secondCategoryAddEditScreensCubit.setWebPickedImage(),
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
            if (_secondCategoryAddEditScreensCubit
                        .getSecondCategory.secondCategoryImageUrl !=
                    "" &&
                _secondCategoryAddEditScreensCubit.webPickedImage == null)
              Image.network(_secondCategoryAddEditScreensCubit
                  .getSecondCategory.secondCategoryImageUrl),
            if (_secondCategoryAddEditScreensCubit.webPickedImage != null)
              Image.memory(
                _secondCategoryAddEditScreensCubit.webPickedImage!,
                fit: BoxFit.fitHeight,
              ),
            if (_secondCategoryAddEditScreensCubit.webPickedImage != null)
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

  Widget _getSecondCategoryNameArea() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Collection Name:", style: _titleStyle),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _secondCategoryAddEditScreensCubit.deleteSelectedImage();
  }
}
