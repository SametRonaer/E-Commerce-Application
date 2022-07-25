import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/profile_abstract_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/search_screen/cubit/search_screen_cubit.dart';

class SearchArea extends StatelessWidget {
  SearchArea({Key? key, required this.searchAreaTypes}) : super(key: key);
  SearchAreaTypes searchAreaTypes;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: context.screenHeight / 13,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 12, top: 5),
      child: Container(
          padding: EdgeInsets.only(bottom: 8, left: 8),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                  child: Icon(
                Icons.search,
                color: Colors.grey.shade400,
              )),
              Flexible(
                  child: Focus(
                onFocusChange: (value) {
                  if (value == false) {
                    context.read<SearchScreenCubit>().disabelArea();
                  }
                },
                child: TextFormField(
                  onChanged: (value) {
                    print(value);
                    if (context.read<ProfileCubit>().userProfile != null) {
                      context
                          .read<SearchScreenCubit>()
                          .search(value, context, searchAreaTypes);
                    }
                  },
                  decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "Search",
                      hintStyle:
                          TextStyle(fontSize: 12, color: Colors.grey.shade300)),
                ),
              )),
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white)),
      color: Colors.black,
      width: double.infinity,
    );
  }
}
