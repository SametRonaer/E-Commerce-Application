// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SecondCategoryModel {
  String secondCategoryCode;
  String secondCategoryId;
  String secondCategoryImageUrl;
  String? secondCategoryTitle;
  String? secondCategoryTitleArabic;
  String? secondCategoryTitleTurkish;
  SecondCategoryModel({
    required this.secondCategoryCode,
    required this.secondCategoryId,
    required this.secondCategoryImageUrl,
    this.secondCategoryTitle,
    this.secondCategoryTitleArabic,
    this.secondCategoryTitleTurkish,
  });

  SecondCategoryModel copyWith({
    String? secondCategoryCode,
    String? secondCategoryId,
    String? secondCategoryImageUrl,
    String? secondCategoryTitle,
    String? secondCategoryTitleArabic,
    String? secondCategoryTitleTurkish,
  }) {
    return SecondCategoryModel(
      secondCategoryCode: secondCategoryCode ?? this.secondCategoryCode,
      secondCategoryId: secondCategoryId ?? this.secondCategoryId,
      secondCategoryImageUrl:
          secondCategoryImageUrl ?? this.secondCategoryImageUrl,
      secondCategoryTitle: secondCategoryTitle ?? this.secondCategoryTitle,
      secondCategoryTitleArabic:
          secondCategoryTitleArabic ?? this.secondCategoryTitleArabic,
      secondCategoryTitleTurkish:
          secondCategoryTitleTurkish ?? this.secondCategoryTitleTurkish,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'secondCategoryCode': secondCategoryCode,
      'secondCategoryId': secondCategoryId,
      'secondCategoryImageUrl': secondCategoryImageUrl,
      'secondCategoryTitle': secondCategoryTitle,
      'secondCategoryTitleArabic': secondCategoryTitleArabic,
      'secondCategoryTitleTurkish': secondCategoryTitleTurkish,
    };
  }

  factory SecondCategoryModel.fromMap(Map<String, dynamic> map) {
    return SecondCategoryModel(
      secondCategoryCode: map['secondCategoryCode'] as String,
      secondCategoryId: map['secondCategoryId'] as String,
      secondCategoryImageUrl: map['secondCategoryImageUrl'] as String,
      secondCategoryTitle: map['secondCategoryTitle'] != null
          ? map['secondCategoryTitle'] as String
          : null,
      secondCategoryTitleArabic: map['secondCategoryTitleArabic'] != null
          ? map['secondCategoryTitleArabic'] as String
          : null,
      secondCategoryTitleTurkish: map['secondCategoryTitleTurkish'] != null
          ? map['secondCategoryTitleTurkish'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SecondCategoryModel.fromJson(String source) =>
      SecondCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SecondCategoryModel(secondCategoryCode: $secondCategoryCode, secondCategoryId: $secondCategoryId, secondCategoryImageUrl: $secondCategoryImageUrl, secondCategoryTitle: $secondCategoryTitle, secondCategoryTitleArabic: $secondCategoryTitleArabic, secondCategoryTitleTurkish: $secondCategoryTitleTurkish)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SecondCategoryModel &&
        other.secondCategoryCode == secondCategoryCode &&
        other.secondCategoryId == secondCategoryId &&
        other.secondCategoryImageUrl == secondCategoryImageUrl &&
        other.secondCategoryTitle == secondCategoryTitle &&
        other.secondCategoryTitleArabic == secondCategoryTitleArabic &&
        other.secondCategoryTitleTurkish == secondCategoryTitleTurkish;
  }

  @override
  int get hashCode {
    return secondCategoryCode.hashCode ^
        secondCategoryId.hashCode ^
        secondCategoryImageUrl.hashCode ^
        secondCategoryTitle.hashCode ^
        secondCategoryTitleArabic.hashCode ^
        secondCategoryTitleTurkish.hashCode;
  }
}
