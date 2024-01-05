// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DepositImageModel {
  String tldeposit_image_id;
  String tldeposit_id;
  String tldeposit_image_path;
  String tldeposit_image_description;
  DepositImageModel({
    required this.tldeposit_image_id,
    required this.tldeposit_id,
    required this.tldeposit_image_path,
    required this.tldeposit_image_description,
  });

  DepositImageModel copyWith({
    String? tldeposit_image_id,
    String? tldeposit_id,
    String? tldeposit_image_path,
    String? tldeposit_image_description,
  }) {
    return DepositImageModel(
      tldeposit_image_id: tldeposit_image_id ?? this.tldeposit_image_id,
      tldeposit_id: tldeposit_id ?? this.tldeposit_id,
      tldeposit_image_path: tldeposit_image_path ?? this.tldeposit_image_path,
      tldeposit_image_description: tldeposit_image_description ?? this.tldeposit_image_description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tldeposit_image_id': tldeposit_image_id,
      'tldeposit_id': tldeposit_id,
      'tldeposit_image_path': tldeposit_image_path,
      'tldeposit_image_description': tldeposit_image_description,
    };
  }

  factory DepositImageModel.fromMap(Map<String, dynamic> map) {
    return DepositImageModel(
      tldeposit_image_id: map['tldeposit_image_id'] as String,
      tldeposit_id: map['tldeposit_id'] as String,
      tldeposit_image_path: map['tldeposit_image_path'] as String,
      tldeposit_image_description: map['tldeposit_image_description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DepositImageModel.fromJson(String source) => DepositImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DepositImageModel(tldeposit_image_id: $tldeposit_image_id, tldeposit_id: $tldeposit_id, tldeposit_image_path: $tldeposit_image_path, tldeposit_image_description: $tldeposit_image_description)';
  }

  @override
  bool operator ==(covariant DepositImageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tldeposit_image_id == tldeposit_image_id &&
      other.tldeposit_id == tldeposit_id &&
      other.tldeposit_image_path == tldeposit_image_path &&
      other.tldeposit_image_description == tldeposit_image_description;
  }

  @override
  int get hashCode {
    return tldeposit_image_id.hashCode ^
      tldeposit_id.hashCode ^
      tldeposit_image_path.hashCode ^
      tldeposit_image_description.hashCode;
  }
}
