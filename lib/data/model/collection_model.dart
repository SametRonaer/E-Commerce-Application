// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CollectionModel {
  String collectionId;
  String? collectionTitle;
  String? collectionTitleArabic;
  String? collectionTitleTurkish;
  String collectionDescription;
  String collectionImageUrl;
  String? collectionCode;
  CollectionModel({
    required this.collectionId,
    this.collectionTitle,
    this.collectionTitleArabic,
    this.collectionTitleTurkish,
    required this.collectionDescription,
    required this.collectionImageUrl,
    this.collectionCode,
  });

  CollectionModel copyWith({
    String? collectionId,
    String? collectionTitle,
    String? collectionTitleArabic,
    String? collectionTitleTurkish,
    String? collectionDescription,
    String? collectionImageUrl,
    String? collectionCode,
  }) {
    return CollectionModel(
      collectionId: collectionId ?? this.collectionId,
      collectionTitle: collectionTitle ?? this.collectionTitle,
      collectionTitleArabic:
          collectionTitleArabic ?? this.collectionTitleArabic,
      collectionTitleTurkish:
          collectionTitleTurkish ?? this.collectionTitleTurkish,
      collectionDescription:
          collectionDescription ?? this.collectionDescription,
      collectionImageUrl: collectionImageUrl ?? this.collectionImageUrl,
      collectionCode: collectionCode ?? this.collectionCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'collectionId': collectionId,
      'collectionTitle': collectionTitle,
      'collectionTitleArabic': collectionTitleArabic,
      'collectionTitleTurkish': collectionTitleTurkish,
      'collectionDescription': collectionDescription,
      'collectionImageUrl': collectionImageUrl,
      'collectionCode': collectionCode,
    };
  }

  factory CollectionModel.fromMap(Map<String, dynamic> map) {
    return CollectionModel(
      collectionId: map['collectionId'] as String,
      collectionTitle: map['collectionTitle'] != null
          ? map['collectionTitle'] as String
          : null,
      collectionTitleArabic: map['collectionTitleArabic'] != null
          ? map['collectionTitleArabic'] as String
          : null,
      collectionTitleTurkish: map['collectionTitleTurkish'] != null
          ? map['collectionTitleTurkish'] as String
          : null,
      collectionDescription: map['collectionDescription'] as String,
      collectionImageUrl: map['collectionImageUrl'] as String,
      collectionCode: map['collectionCode'] != null
          ? map['collectionCode'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectionModel.fromJson(String source) =>
      CollectionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CollectionModel(collectionId: $collectionId, collectionTitle: $collectionTitle, collectionTitleArabic: $collectionTitleArabic, collectionTitleTurkish: $collectionTitleTurkish, collectionDescription: $collectionDescription, collectionImageUrl: $collectionImageUrl, collectionCode: $collectionCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CollectionModel &&
        other.collectionId == collectionId &&
        other.collectionTitle == collectionTitle &&
        other.collectionTitleArabic == collectionTitleArabic &&
        other.collectionTitleTurkish == collectionTitleTurkish &&
        other.collectionDescription == collectionDescription &&
        other.collectionImageUrl == collectionImageUrl &&
        other.collectionCode == collectionCode;
  }

  @override
  int get hashCode {
    return collectionId.hashCode ^
        collectionTitle.hashCode ^
        collectionTitleArabic.hashCode ^
        collectionTitleTurkish.hashCode ^
        collectionDescription.hashCode ^
        collectionImageUrl.hashCode ^
        collectionCode.hashCode;
  }
}
