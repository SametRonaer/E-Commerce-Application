import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_add_edit_screens/ui/category_add_screen.dart';
import 'package:alfa_application/screens/edit_screens/category_edit_screen/category_add_edit_screens/ui/web_category_add_screen.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/web_category_edit_list_tile.dart';

class WebCategoryEditListScreen extends StatelessWidget {
  WebCategoryEditListScreen({Key? key}) : super(key: key);

  static const routeName = "/category-edit-list-screen";
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
                          "CATEGORIES",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 27),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<WebHomeCubit>()
                                .switchCurrentScreen(WebCategoryAddScreen());
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
                            itemBuilder: (_, i) => WebCategoryEditListTile(
                                categoryModel: context
                                    .read<ProductsCubit>()
                                    .allCategories[i]),
                            itemCount: context
                                .read<ProductsCubit>()
                                .allCategories
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
