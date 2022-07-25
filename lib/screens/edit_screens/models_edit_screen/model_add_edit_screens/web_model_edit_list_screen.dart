import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/screens/edit_screens/models_edit_screen/model_add_edit_screens/ui/web_model_add_screen.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:alfa_application/widgets/web_model_edit_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebModelEditListScreen extends StatelessWidget {
  WebModelEditListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MODELS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 27),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<WebHomeCubit>()
                                .switchCurrentScreen(WebModelAddScreen());
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.add_circle_outline,
                              size: 35,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 0.7, color: Colors.grey.shade700),
                    SizedBox(
                        height: context.screenHeight / 1.45,
                        width: double.infinity,
                        child: ListView.builder(
                            itemBuilder: (_, i) => WebModelEditListTile(
                                collectionModel: context
                                    .read<ProductsCubit>()
                                    .allCollections[i]),
                            itemCount: context
                                .read<ProductsCubit>()
                                .allCollections
                                .length)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
