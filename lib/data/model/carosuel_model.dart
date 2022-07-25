// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CarosuelModel {
  String carosuelId;
  String carosuelImageUrl;
  int carosuelType;
  CarosuelModel({
    required this.carosuelId,
    required this.carosuelImageUrl,
    required this.carosuelType,
  });

  CarosuelModel copyWith({
    String? carosuelId,
    String? carosuelImageUrl,
    int? carosuelType,
  }) {
    return CarosuelModel(
      carosuelId: carosuelId ?? this.carosuelId,
      carosuelImageUrl: carosuelImageUrl ?? this.carosuelImageUrl,
      carosuelType: carosuelType ?? this.carosuelType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'carosuelId': carosuelId,
      'carosuelImageUrl': carosuelImageUrl,
      'carosuelType': carosuelType,
    };
  }

  factory CarosuelModel.fromMap(Map<String, dynamic> map) {
    return CarosuelModel(
      carosuelId: map['carosuelId'] as String,
      carosuelImageUrl: map['carosuelImageUrl'] as String,
      carosuelType: map['carosuelType'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarosuelModel.fromJson(String source) =>
      CarosuelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CarosuelModel(carosuelId: $carosuelId, carosuelImageUrl: $carosuelImageUrl, carosuelType: $carosuelType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarosuelModel &&
        other.carosuelId == carosuelId &&
        other.carosuelImageUrl == carosuelImageUrl &&
        other.carosuelType == carosuelType;
  }

  @override
  int get hashCode =>
      carosuelId.hashCode ^ carosuelImageUrl.hashCode ^ carosuelType.hashCode;
}
