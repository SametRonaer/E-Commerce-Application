import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/carosuel_cubit/cubit/carosuels_cubit.dart';
import 'package:alfa_application/screens/edit_screens/carosuel_edit_screen/cubit/carosuel_edit_cubit.dart';
import 'package:alfa_application/widgets/carosuel_slider.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarosuelEditScreen extends StatelessWidget {
  const CarosuelEditScreen({Key? key}) : super(key: key);
  static const routeName = "/carosuel-edit-screen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarosuelEditCubit, CarosuelEditState>(
      builder: (context, editState) {
        return BlocBuilder<CarosuelsCubit, CarosuelsState>(
          builder: (context, state) {
            return Stack(
              children: [
                Scaffold(
                    backgroundColor: Colors.black,
                    appBar: kGetAppBar(context),
                    body: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Text(
                            "  First Banners:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          CarouselSlider(
                            items: _getFirstCarosuels(context),
                            options: CarouselOptions(
                                viewportFraction: 1,
                                height: context.screenHeight / 3.6),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "  Second Banners:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          CarouselSlider(
                            items: _getSecondCarosuels(context),
                            options: CarouselOptions(
                                viewportFraction: 1,
                                height: context.screenHeight / 3.6),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: CustomAppButton.black(
                                buttonName: "Add Banner",
                                buttonFunction: () => context
                                    .read<CarosuelEditCubit>()
                                    .addNewCarosuel(context)),
                          ),
                        ],
                      ),
                    )),
                if (editState is CarosuelEditLoading) kGetLoadingScreen()
              ],
            );
          },
        );
      },
    );
  }

  _getFirstCarosuels(BuildContext context) {
    List<Widget> carosuels = [
      GestureDetector(
        onTap: () {
          context.read<CarosuelEditCubit>().setFirstPickedImage();
        },
        child: Container(
          height: context.screenHeight / 3.6,
          alignment: Alignment.center,
          width: double.infinity,
          child: Stack(
            children: [
              Icon(Icons.add_a_photo, size: 40),
              if (context.read<CarosuelEditCubit>().firstPickedImage != null)
                Image.file(
                  context.read<CarosuelEditCubit>().firstPickedImage!,
                  fit: BoxFit.fitHeight,
                ),
            ],
          ),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15)),
        ),
      )
    ];

    context
        .read<CarosuelsCubit>()
        .allCarosuels
        .where((element) => element.carosuelType == 0)
        .forEach((element) => carosuels.add(CarosuelCell(
              hasDeleteButton: true,
              carosuelModel: element,
            )));

    return carosuels;
  }

  _getSecondCarosuels(BuildContext context) {
    List<Widget> carosuels = [
      GestureDetector(
        onTap: () {
          context.read<CarosuelEditCubit>().setSecondPickedImage();
        },
        child: Container(
          height: context.screenHeight / 3.6,
          alignment: Alignment.center,
          width: double.infinity,
          child: Stack(
            children: [
              Icon(Icons.add_a_photo, size: 40),
              // if (context.read<CarosuelEditCubit>().secondPickedImage != null)
              //   Image.file(
              //     context.read<CarosuelEditCubit>().secondPickedImage!,
              //     fit: BoxFit.fitHeight,
              //   ),
            ],
          ),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15)),
        ),
      )
    ];

    context
        .read<CarosuelsCubit>()
        .allCarosuels
        .where((element) => element.carosuelType == 1)
        .forEach((element) => carosuels.add(CarosuelCell(
              hasDeleteButton: true,
              carosuelModel: element,
            )));

    return carosuels;
  }
}
