// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  String categoryId;
  String? categoryTitle;
  String? categoryTitleTurkish;
  String? categoryTitleArabic;
  String? categoryCode;
  String categoryImageUrl;
  CategoryModel({
    required this.categoryId,
    this.categoryTitle,
    this.categoryTitleTurkish,
    this.categoryTitleArabic,
    this.categoryCode,
    required this.categoryImageUrl,
  });

  CategoryModel copyWith({
    String? categoryId,
    String? categoryTitle,
    String? categoryTitleTurkish,
    String? categoryTitleArabic,
    String? categoryCode,
    String? categoryImageUrl,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      categoryTitleTurkish: categoryTitleTurkish ?? this.categoryTitleTurkish,
      categoryTitleArabic: categoryTitleArabic ?? this.categoryTitleArabic,
      categoryCode: categoryCode ?? this.categoryCode,
      categoryImageUrl: categoryImageUrl ?? this.categoryImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'categoryTitle': categoryTitle,
      'categoryTitleTurkish': categoryTitleTurkish,
      'categoryTitleArabic': categoryTitleArabic,
      'categoryCode': categoryCode,
      'categoryImageUrl': categoryImageUrl,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'] as String,
      categoryTitle:
          map['categoryTitle'] != null ? map['categoryTitle'] as String : null,
      categoryTitleTurkish: map['categoryTitleTurkish'] != null
          ? map['categoryTitleTurkish'] as String
          : null,
      categoryTitleArabic: map['categoryTitleArabic'] != null
          ? map['categoryTitleArabic'] as String
          : null,
      categoryCode:
          map['categoryCode'] != null ? map['categoryCode'] as String : null,
      categoryImageUrl: map['categoryImageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryModel(categoryId: $categoryId, categoryTitle: $categoryTitle, categoryTitleTurkish: $categoryTitleTurkish, categoryTitleArabic: $categoryTitleArabic, categoryCode: $categoryCode, categoryImageUrl: $categoryImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel &&
        other.categoryId == categoryId &&
        other.categoryTitle == categoryTitle &&
        other.categoryTitleTurkish == categoryTitleTurkish &&
        other.categoryTitleArabic == categoryTitleArabic &&
        other.categoryCode == categoryCode &&
        other.categoryImageUrl == categoryImageUrl;
  }

  @override
  int get hashCode {
    return categoryId.hashCode ^
        categoryTitle.hashCode ^
        categoryTitleTurkish.hashCode ^
        categoryTitleArabic.hashCode ^
        categoryCode.hashCode ^
        categoryImageUrl.hashCode;
  }
}
