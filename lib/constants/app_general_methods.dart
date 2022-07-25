import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/constants/image_paths.dart';
import 'package:alfa_application/data/model/category_model.dart';
import 'package:alfa_application/data/model/collection_model.dart';
import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/data/model/employee_model.dart';
import 'package:alfa_application/data/model/second_category_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/notification_cubit/cubit/notification_cubit.dart';
import 'package:alfa_application/screens/notifications_screen/ui/notifications_screen_ui.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../general_cubits/profile_cubit/cubit/profile_cubit.dart';
import '../screens/bottom_bar_screens/cubit/bottom_bar_cubit.dart';

String kGetFormattedPrice(double productPrice) {
  return productPrice.toString();
}

String kGetColorLabelOfProduct(String color) {
  if (color == ProductColours.Gold.toString()) {
    return "Gold";
  } else if (color == ProductColours.Rose.toString()) {
    return "Rose";
  } else {
    return "Bronze";
  }
}

String kGetGoldPercentLabelOfProduct(String productTypes) {
  if (productTypes == ProductGoldPercents.Eighteen.toString()) {
    return "18 K";
  } else if (productTypes == ProductGoldPercents.TwentyTwo.toString()) {
    return "22 K";
  } else {
    return "24 K";
  }
}

kGetSortStausLabel(String? status) {
  if (status == SortStatuses.Secondary.toString()) {
    return "Secondary";
  } else if (status == SortStatuses.Primary.toString()) {
    return "Primary";
  } else {
    return "Standart";
  }
}

String kGetCategoryScreenTitle(CategoryModel categoryModel) {
  String currentLanguage = GetStorage().read("languagePreference");

  if (currentLanguage == "ar") {
    return categoryModel.categoryTitleArabic ??
        categoryModel.categoryTitle ??
        categoryModel.categoryTitleTurkish ??
        "";
  } else if (currentLanguage == "tr") {
    return categoryModel.categoryTitleTurkish ??
        categoryModel.categoryTitle ??
        categoryModel.categoryTitleArabic ??
        "";
  } else {
    return categoryModel.categoryTitle ??
        categoryModel.categoryTitleTurkish ??
        categoryModel.categoryTitleArabic ??
        "";
  }
}

String kGetCollectionScreenName(CollectionModel collectionModel) {
  String currentLanguage = GetStorage().read("languagePreference");
  if (currentLanguage == "ar") {
    return collectionModel.collectionTitleArabic ??
        collectionModel.collectionTitle ??
        collectionModel.collectionTitleTurkish ??
        "";
  } else if (currentLanguage == "tr") {
    return collectionModel.collectionTitleTurkish ??
        collectionModel.collectionTitle ??
        collectionModel.collectionTitleArabic ??
        "";
  } else {
    return collectionModel.collectionTitle ??
        collectionModel.collectionTitleArabic ??
        collectionModel.collectionTitleTurkish ??
        "";
  }
}

String kGetSecondCategoryScreenName(SecondCategoryModel secondCategoryModel) {
  String currentLanguage = GetStorage().read("languagePreference");
  if (currentLanguage == "ar") {
    return secondCategoryModel.secondCategoryTitleArabic ??
        secondCategoryModel.secondCategoryTitle ??
        secondCategoryModel.secondCategoryTitleTurkish ??
        "";
  } else if (currentLanguage == "tr") {
    return secondCategoryModel.secondCategoryTitleTurkish ??
        secondCategoryModel.secondCategoryTitle ??
        secondCategoryModel.secondCategoryTitleArabic ??
        "";
  } else {
    return secondCategoryModel.secondCategoryTitle ??
        secondCategoryModel.secondCategoryTitleTurkish ??
        secondCategoryModel.secondCategoryTitleArabic ??
        "";
  }
}

String kGetWeightLabelOfProduct(double weight) {
  return weight.toString() + " gr";
}

String kGetHeightLabelOfProduct(double height) {
  return height.toString() + " cm";
}

String kGetWidthLabelOfProduct(double width) {
  return width.toString() + " cm";
}

String kGetRadiusLabelOfProduct(double radius) {
  return radius.toString() + " cm";
}

Widget kGetLoadingScreen() {
  return Container(
    alignment: Alignment.center,
    color: Colors.black54,
    child: SpinKitSpinningLines(
      color: Colors.white,
      size: 100,
    ),
  );
}

AppBar kGetAppBar(BuildContext context) {
  ProfileCubit _profileCubit = context.read<ProfileCubit>();
  String? imageUrl;
  if (_profileCubit.userProfile == null) {
  } else {
    if (_profileCubit.isCustomer!) {
      imageUrl = (_profileCubit.userProfile as CustomerModel).customerImageUrl;
    } else {
      imageUrl = (_profileCubit.userProfile as EmployeeModel).employeeImageUrl;
    }
  }
  int? notificationsLength = _profileCubit.userProfile != null
      ? _getNotificationsLength(context)
      : null;
  return AppBar(
      leadingWidth: 100,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => context
                .read<BottomBarCubit>()
                .switchScreen(BottomBarScreens.ProfileScreen, context),
            child: CircleAvatar(
              backgroundImage: (imageUrl != "" && imageUrl != null)
                  ? Image.network(imageUrl).image
                  : null,
              child: (imageUrl == "" || imageUrl == null)
                  ? Icon(
                      Icons.person,
                      color: Colors.grey,
                    )
                  : null,
              backgroundColor: Colors.grey.shade300,
              radius: 20,
            ),
          ),
          if (_profileCubit.userProfile != null)
            FittedBox(
              child: Text(
                "${'Hi'.tr},\n${_profileCubit.userProfile!.name}\n${_profileCubit.userProfile!.surName.toUpperCase()}",
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.left,
              ),
            )
        ],
      ),
      actions: [
        if (_profileCubit.userProfile != null)
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(NotificationsScreen.routeName);
              context
                  .read<NotificationCubit>()
                  .resetUnreadNotificationAmount(context);
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, right: 12),
                  child: Icon(Icons.notifications_outlined),
                ),
                if (notificationsLength != 0)
                  Padding(
                    padding: EdgeInsets.only(right: 6, top: 9),
                    child: CircleAvatar(
                      backgroundColor: Colors.red.shade400,
                      child: FittedBox(
                        child: Text(
                          notificationsLength.toString(),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      radius: 8,
                    ),
                  ),
              ],
            ),
          )
      ],
      title: SizedBox(
          width: context.screenWidth / 2.7, child: Image.asset(kAlfaTextLogo)),
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.black);
}

int _getNotificationsLength(BuildContext context) {
  return context.read<ProfileCubit>().isCustomer!
      ? ((context.read<ProfileCubit>().userProfile as CustomerModel)
              .unreadMessages ??
          0)
      : ((context.read<ProfileCubit>().userProfile as EmployeeModel)
              .unreadMessages ??
          0);
}

String kGetFormattedDate(DateTime date, [bool withHour = false]) {
  String day = date.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }
  String month = date.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }

  String hour = date.hour.toString();
  if (hour.length == 1) {
    hour = "0$hour";
  }
  String minutes = date.minute.toString();
  if (minutes.length == 1) {
    minutes = "0$minutes";
  }

  String year = date.year.toString();
  String formattedDate = "$day/$month/$year";

  if (withHour) {
    formattedDate = "$formattedDate $hour:$minutes";
  }

  return formattedDate;
}

String kGetEmployeeStatusLabel(String employeeType) {
  if (employeeType == EmployeeStatus.Standart.toString()) {
    return "Standart";
  } else if (employeeType == EmployeeStatus.Administor.toString()) {
    return "Administor";
  } else {
    return "Limited";
  }
}

String kGetCustomerTypeLabel(String customerType) {
  if (customerType == CustomerTypes.Standart.toString()) {
    return "Standart";
  } else if (customerType == CustomerTypes.Premium.toString()) {
    return "Premium";
  } else {
    return "Other";
  }
}

String kRemoveTurkishCharacters(String text) {
  text = text.replaceAll("ı", "i");
  text = text.replaceAll("İ", "I");
  text = text.replaceAll("ü", "u");
  text = text.replaceAll("Ü", "U");
  text = text.replaceAll("ö", "o");
  text = text.replaceAll("Ö", "O");
  text = text.replaceAll("ğ", "g");
  text = text.replaceAll("Ğ", "G");
  text = text.replaceAll("ş", "s");
  text = text.replaceAll("Ş", "S");
  text = text.replaceAll("ç", "c");
  text = text.replaceAll("Ç", "C");
  return text;
}

List<String> kTransactionProgressStepLabels = [
  TransactionStatuses.WaitToConfirm.toString().tr,
  TransactionStatuses.Confirmed.toString().tr,
  TransactionStatuses.WaitForPurchase.toString().tr,
  TransactionStatuses.StartToPrepare.toString().tr,
  TransactionStatuses.Send.toString().tr,
  TransactionStatuses.Completed.toString().tr,
  TransactionStatuses.Cancelled.toString().tr,
  TransactionStatuses.NotConfirmed.toString().tr,
];
