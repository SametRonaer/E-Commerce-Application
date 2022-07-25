// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductModel {
  List<dynamic>? productImageList;

  String? goldPercent;
  String? productColorType;

  double? productHeight;
  double? productWidth;
  double? productRadius;
  double? productWeight;
  String? categoryId;
  String? productId;
  String? productCode;
  String? productTitle;
  String? productTitleTurkish;
  String? productTitleArabic;
  String? productDescriptionEnglish;
  String? productDescriptionTurkish;
  String? productDescriptionArabic;
  String? collectionId;
  String? secondCategoryId;
  String? modelId;
  String? sortStatus;
  String? productVisibility;
  ProductModel({
    this.productImageList,
    this.goldPercent,
    this.productColorType,
    this.productHeight,
    this.productWidth,
    this.productRadius,
    this.productWeight,
    this.categoryId,
    this.productId,
    this.productCode,
    this.productTitle,
    this.productTitleTurkish,
    this.productTitleArabic,
    this.productDescriptionEnglish,
    this.productDescriptionTurkish,
    this.productDescriptionArabic,
    this.collectionId,
    this.secondCategoryId,
    this.modelId,
    this.sortStatus,
    this.productVisibility,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productImageList': productImageList,
      'goldPercent': goldPercent,
      'productColorType': productColorType,
      'productHeight': productHeight,
      'productWidth': productWidth,
      'productRadius': productRadius,
      'productWeight': productWeight,
      'categoryId': categoryId,
      'productId': productId,
      'productCode': productCode,
      'productTitle': productTitle,
      'productTitleTurkish': productTitleTurkish,
      'productTitleArabic': productTitleArabic,
      'productDescriptionEnglish': productDescriptionEnglish,
      'productDescriptionTurkish': productDescriptionTurkish,
      'productDescriptionArabic': productDescriptionArabic,
      'collectionId': collectionId,
      'secondCategoryId': secondCategoryId,
      'modelId': modelId,
      'productVisibility': productVisibility,
      'sortStatus': sortStatus,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productImageList: map['productImageList'] != null
          ? List<dynamic>.from((map['productImageList'] as List<dynamic>))
          : null,
      goldPercent:
          map['goldPercent'] != null ? map['goldPercent'] as String : null,
      productColorType: map['productColorType'] != null
          ? map['productColorType'] as String
          : null,
      productHeight:
          map['productHeight'] != null ? map['productHeight'] as double : null,
      productWidth:
          map['productWidth'] != null ? map['productWidth'] as double : null,
      productRadius:
          map['productRadius'] != null ? map['productRadius'] as double : null,
      productWeight:
          map['productWeight'] != null ? map['productWeight'] as double : null,
      categoryId:
          map['categoryId'] != null ? map['categoryId'] as String : null,
      productId: map['productId'] != null ? map['productId'] as String : null,
      productCode:
          map['productCode'] != null ? map['productCode'] as String : null,
      productTitle:
          map['productTitle'] != null ? map['productTitle'] as String : null,
      productTitleTurkish: map['productTitleTurkish'] != null
          ? map['productTitleTurkish'] as String
          : null,
      productTitleArabic: map['productTitleArabic'] != null
          ? map['productTitleArabic'] as String
          : null,
      productDescriptionEnglish: map['productDescriptionEnglish'] != null
          ? map['productDescriptionEnglish'] as String
          : null,
      productDescriptionTurkish: map['productDescriptionTurkish'] != null
          ? map['productDescriptionTurkish'] as String
          : null,
      productDescriptionArabic: map['productDescriptionArabic'] != null
          ? map['productDescriptionArabic'] as String
          : null,
      sortStatus:
          map['sortStatus'] != null ? map['sortStatus'] as String : null,
      collectionId:
          map['collectionId'] != null ? map['collectionId'] as String : null,
      secondCategoryId: map['secondCategoryId'] != null
          ? map['secondCategoryId'] as String
          : null,
      modelId: map['modelId'] != null ? map['modelId'] as String : null,
      productVisibility: map['productVisibility'] != null
          ? map['productVisibility'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(productImageList: $productImageList, goldPercent: $goldPercent, productColorType: $productColorType, productHeight: $productHeight, productWidth: $productWidth, productRadius: $productRadius, productWeight: $productWeight, categoryId: $categoryId, productId: $productId, productCode: $productCode, productTitle: $productTitle, productTitleTurkish: $productTitleTurkish, productTitleArabic: $productTitleArabic, productDescriptionEnglish: $productDescriptionEnglish, productDescriptionTurkish: $productDescriptionTurkish, productDescriptionArabic: $productDescriptionArabic, collectionId: $collectionId, secondCategoryId: $secondCategoryId, modelId: $modelId, productVisibility: $productVisibility)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        listEquals(other.productImageList, productImageList) &&
        other.goldPercent == goldPercent &&
        other.productColorType == productColorType &&
        other.productHeight == productHeight &&
        other.productWidth == productWidth &&
        other.productRadius == productRadius &&
        other.productWeight == productWeight &&
        other.categoryId == categoryId &&
        other.productId == productId &&
        other.productCode == productCode &&
        other.productTitle == productTitle &&
        other.productTitleTurkish == productTitleTurkish &&
        other.productTitleArabic == productTitleArabic &&
        other.productDescriptionEnglish == productDescriptionEnglish &&
        other.productDescriptionTurkish == productDescriptionTurkish &&
        other.productDescriptionArabic == productDescriptionArabic &&
        other.collectionId == collectionId &&
        other.secondCategoryId == secondCategoryId &&
        other.modelId == modelId &&
        other.productVisibility == productVisibility;
  }

  @override
  int get hashCode {
    return productImageList.hashCode ^
        goldPercent.hashCode ^
        productColorType.hashCode ^
        productHeight.hashCode ^
        productWidth.hashCode ^
        productRadius.hashCode ^
        productWeight.hashCode ^
        categoryId.hashCode ^
        productId.hashCode ^
        productCode.hashCode ^
        productTitle.hashCode ^
        productTitleTurkish.hashCode ^
        productTitleArabic.hashCode ^
        productDescriptionEnglish.hashCode ^
        productDescriptionTurkish.hashCode ^
        productDescriptionArabic.hashCode ^
        collectionId.hashCode ^
        secondCategoryId.hashCode ^
        modelId.hashCode ^
        productVisibility.hashCode;
  }
}
