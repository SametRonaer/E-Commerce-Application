import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/screens/edit_screens/models_edit_screen/model_add_edit_screens/cubit/model_add_edit_cubit.dart';
import 'package:alfa_application/widgets/app_bottom_navigation_bar.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../../data/model/collection_model.dart';
import '../../../../../constants/app_general_methods.dart';

class ModelEditScreen extends StatelessWidget {
  ModelEditScreen({Key? key}) : super(key: key);
  static const routeName = "/model-edit-screen";
  late ModelAddEditCubit _modelAddEditScreensCubit;
  late CollectionModel _selectedCollection;
  TextEditingController _turkishTitleController = TextEditingController();
  TextEditingController _englishTitleController = TextEditingController();
  TextEditingController _arabicTitleController = TextEditingController();
  TextEditingController _collectionCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _modelAddEditScreensCubit = context.read<ModelAddEditCubit>();
    _selectedCollection = _modelAddEditScreensCubit.getCollection;
    _setControllers();
    return BlocBuilder<ModelAddEditCubit, ModelAddEditState>(
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
                              _getModelNameArea(),
                              SizedBox(height: 10),
                              Text(
                                "Category Code",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              CustomTextField(
                                controller: _collectionCodeController,
                                haveGap: false,
                                onChangeFunction:
                                    _modelAddEditScreensCubit.setCollectionCode,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10.0, top: 20),
                            child: CustomAppButton.black(
                              buttonName: "Update Model",
                              buttonFunction: () {
                                _modelAddEditScreensCubit
                                    .updateCollection(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
            if (state is ModelAddEditLoading)
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
      onTap: () => _modelAddEditScreensCubit.setPickedImage(),
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
            if (_modelAddEditScreensCubit.getCollection.collectionImageUrl !=
                    "" &&
                _modelAddEditScreensCubit.pickedImage == null)
              Image.network(
                  _modelAddEditScreensCubit.getCollection.collectionImageUrl),
            if (_modelAddEditScreensCubit.pickedImage != null)
              Image.file(_modelAddEditScreensCubit.pickedImage!),
            if (_modelAddEditScreensCubit.pickedImage != null)
              GestureDetector(
                onTap: () => _modelAddEditScreensCubit.deleteSelectedImage(),
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

  DefaultTabController _getModelNameArea() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Model Name:",
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
                      _modelAddEditScreensCubit.setCollectionTitle,
                  haveGap: false,
                  hintText: "Model name...",
                ),
                CustomTextField(
                  controller: _turkishTitleController,
                  onChangeFunction:
                      _modelAddEditScreensCubit.setCollectionTitleTurkish,
                  hintText: "Model ismi...",
                  haveGap: false,
                ),
                CustomTextField(
                  controller: _arabicTitleController,
                  onChangeFunction:
                      _modelAddEditScreensCubit.setCollectionTitleArabic,
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
    _englishTitleController.text = _selectedCollection.collectionTitle ?? "";
    _turkishTitleController.text =
        _selectedCollection.collectionTitleTurkish ?? "";
    _arabicTitleController.text =
        _selectedCollection.collectionTitleArabic ?? "";
    _collectionCodeController.text = _selectedCollection.collectionCode ?? "";
  }
}
