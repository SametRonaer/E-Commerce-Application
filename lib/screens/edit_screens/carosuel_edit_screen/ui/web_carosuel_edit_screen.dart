import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/carosuel_cubit/cubit/carosuels_cubit.dart';
import 'package:alfa_application/screens/edit_screens/carosuel_edit_screen/cubit/carosuel_edit_cubit.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/widgets/carosuel_slider.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/web_page_title_field.dart';
import 'package:alfa_application/widgets/web_transactions_list_area.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebCarosuelEditScreen extends StatelessWidget {
  WebCarosuelEditScreen({Key? key}) : super(key: key);
  double _carosuelHeight = 300;
  CarouselController _firstController = CarouselController();
  CarouselController _secondController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarosuelEditCubit, CarosuelEditState>(
      builder: (context, editState) {
        return BlocBuilder<CarosuelsCubit, CarosuelsState>(
          builder: (context, state) {
            return Stack(
              children: [
                Scaffold(
                    backgroundColor: Colors.white,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WebPageTitleField(
                          pageTitle: "BANNERS > ADD BANNER",
                          subTitle: "Please confirm the banner images.",
                          blackButtonFunction: () {
                            context
                                .read<CarosuelEditCubit>()
                                .addNewCarosuelsToWeb(context);
                          },
                          redButtonTitle: "CANCEL",
                          redButtonFunction: () {
                            context
                                .read<WebHomeCubit>()
                                .switchCurrentScreen(WebTransactionsListArea());
                          },
                        ),
                        SizedBox(height: 15),
                        Text(
                          "  First Banners:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _firstController.previousPage();
                                },
                                icon: Icon(
                                  Icons.arrow_left,
                                  color: Colors.black,
                                  size: 45,
                                )),
                            SizedBox(
                              width: 630,
                              child: CarouselSlider(
                                carouselController: _firstController,
                                items: _getFirstCarosuels(context),
                                options: CarouselOptions(
                                    viewportFraction: 2,
                                    height: _carosuelHeight),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  _firstController.nextPage();
                                },
                                icon: Icon(
                                  Icons.arrow_right,
                                  size: 45,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          "  Second Banners:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _secondController.previousPage();
                                },
                                icon: Icon(
                                  Icons.arrow_left,
                                  color: Colors.black,
                                  size: 45,
                                )),
                            SizedBox(
                              width: 630,
                              child: CarouselSlider(
                                carouselController: _secondController,
                                items: _getSecondCarosuels(context),
                                options: CarouselOptions(
                                    viewportFraction: 1,
                                    height: _carosuelHeight),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  _secondController.nextPage();
                                },
                                icon: Icon(
                                  Icons.arrow_right,
                                  size: 45,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                        // SizedBox(height: 20),
                        // SizedBox(
                        //   width: 630,
                        //   child: Align(
                        //     alignment: Alignment.center,
                        //     child: CustomAppButton.black(
                        //         buttonName: "Add Banner",
                        //         buttonFunction: () => context
                        //             .read<CarosuelEditCubit>()
                        //             .addNewCarosuelsToWeb(context)),
                        //   ),
                        // ),
                      ],
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
          height: _carosuelHeight,
          alignment: Alignment.center,
          width: 600,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.add_a_photo, size: 40),
              if (context.read<CarosuelEditCubit>().webFirstPickedImage != null)
                Image.memory(
                  context.read<CarosuelEditCubit>().webFirstPickedImage!,
                  fit: BoxFit.fitHeight,
                )
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
          height: _carosuelHeight,
          alignment: Alignment.center,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.add_a_photo, size: 40),
              if (context.read<CarosuelEditCubit>().webSecondPickedImage !=
                  null)
                Image.memory(
                  context.read<CarosuelEditCubit>().webSecondPickedImage!,
                  fit: BoxFit.fitHeight,
                )
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
