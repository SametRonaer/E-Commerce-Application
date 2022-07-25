import 'package:alfa_application/screens/edit_screens/second_category_edit_screen/second_category_add_edit_screens/ui/web_second_category_add_screen.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/second_category_cubit/cubit/second_category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/web_second_category_edit_list_tile.dart';
import 'second_category_add_edit_screens/ui/second_category_add_screen.dart';

class WebSecondCategoryEditListScreen extends StatelessWidget {
  WebSecondCategoryEditListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondCategoryCubit, SecondCategoryState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
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
                    "COLLECTIONS",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<WebHomeCubit>()
                          .switchCurrentScreen(WebSecondCategoryAddScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.add_circle_outline, size: 35),
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
                      itemBuilder: (_, i) => WebSecondCategoryEditListTile(
                          secondCategoryModel: context
                              .read<SecondCategoryCubit>()
                              .allSecondCategories[i]),
                      itemCount: context
                          .read<SecondCategoryCubit>()
                          .allSecondCategories
                          .length)),
            ],
          ),
        );
      },
    );
  }
}
