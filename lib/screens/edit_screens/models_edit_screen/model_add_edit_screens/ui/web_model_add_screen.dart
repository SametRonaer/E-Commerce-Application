import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_add_edit_screens/cubit/category_add_edit_screens_cubit.dart';
import 'package:alfa_application/screens/edit_screens/models_edit_screen/model_add_edit_screens/cubit/model_add_edit_cubit.dart';
import 'package:alfa_application/screens/edit_screens/models_edit_screen/model_add_edit_screens/web_model_edit_list_screen.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/web_page_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WebModelAddScreen extends StatefulWidget {
  WebModelAddScreen({Key? key}) : super(key: key);

  @override
  State<WebModelAddScreen> createState() => _WebModelAddScreenState();
}

class _WebModelAddScreenState extends State<WebModelAddScreen> {
  late ModelAddEditCubit _modelAddEditCubit;
  TextEditingController _turkishTitleController = TextEditingController();
  TextEditingController _englishTitleController = TextEditingController();
  TextEditingController _arabicTitleController = TextEditingController();
  TextStyle _titleStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 17, color: Colors.grey.shade700);

  @override
  Widget build(BuildContext context) {
    _modelAddEditCubit = context.read<ModelAddEditCubit>();
    return BlocBuilder<ModelAddEditCubit, ModelAddEditState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    WebPageTitleField(
                        redButtonFunction: () {
                          _modelAddEditCubit.deleteSelectedImage();
                          context
                              .read<WebHomeCubit>()
                              .switchCurrentScreen(WebModelEditListScreen());
                        },
                        blackButtonFunction: () {
                          _modelAddEditCubit.addNewCollection(context);
                        },
                        pageTitle: "MODELS > ADD MODEL",
                        subTitle: "Please confirm the model information"),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 400),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: 500,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: double.infinity, height: 40),
                                    _getImageArea(context),
                                    SizedBox(height: 20),
                                    _getModelNameArea(),
                                    SizedBox(height: 10),
                                    Text("Model Code", style: _titleStyle),
                                    CustomTextField(
                                      haveGap: false,
                                      onChangeFunction:
                                          _modelAddEditCubit.setCollectionCode,
                                    ),
                                  ],
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       bottom: 10.0, top: 20),
                                //   child: CustomAppButton.black(
                                //     buttonName: "Add Model",
                                //     buttonFunction: () {
                                //       _modelAddEditCubit
                                //           .addNewCollection(context);
                                //     },
                                //   ),
                                // )
                              ],
                            ),
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
      onTap: () => _modelAddEditCubit.setWebPickedImage(),
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
            if (_modelAddEditCubit.webPickedImage != null)
              Image.memory(_modelAddEditCubit.webPickedImage!),
            if (_modelAddEditCubit.webPickedImage != null)
              GestureDetector(
                onTap: () => _modelAddEditCubit.deleteSelectedImage(),
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

  Widget _getModelNameArea() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Model Name:", style: _titleStyle),
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
                  onChangeFunction: _modelAddEditCubit.setCollectionTitle,
                  haveGap: false,
                  hintText: "Model name...",
                ),
                CustomTextField(
                  controller: _turkishTitleController,
                  onChangeFunction:
                      _modelAddEditCubit.setCollectionTitleTurkish,
                  hintText: "Model ismi...",
                  haveGap: false,
                ),
                CustomTextField(
                  controller: _arabicTitleController,
                  onChangeFunction: _modelAddEditCubit.setCollectionTitleArabic,
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
    _modelAddEditCubit.deleteSelectedImage();
  }
}
