// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DepositImageTempModel {
  String tldeposit_image_id;
  String tldeposit_image_base64;
  String tldeposit_image_lastName;
  String tldeposit_image_description;
  String tldeposit_id;
  DepositImageTempModel({
    required this.tldeposit_image_id,
    required this.tldeposit_image_base64,
    required this.tldeposit_image_lastName,
    required this.tldeposit_image_description,
    required this.tldeposit_id,
  });

  DepositImageTempModel copyWith({
    String? tldeposit_image_id,
    String? tldeposit_image_base64,
    String? tldeposit_image_lastName,
    String? tldeposit_image_description,
    String? tldeposit_id,
  }) {
    return DepositImageTempModel(
      tldeposit_image_id: tldeposit_image_id ?? this.tldeposit_image_id,
      tldeposit_image_base64: tldeposit_image_base64 ?? this.tldeposit_image_base64,
      tldeposit_image_lastName: tldeposit_image_lastName ?? this.tldeposit_image_lastName,
      tldeposit_image_description: tldeposit_image_description ?? this.tldeposit_image_description,
      tldeposit_id: tldeposit_id ?? this.tldeposit_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tldeposit_image_id': tldeposit_image_id,
      'tldeposit_image_base64': tldeposit_image_base64,
      'tldeposit_image_lastName': tldeposit_image_lastName,
      'tldeposit_image_description': tldeposit_image_description,
      'tldeposit_id': tldeposit_id,
    };
  }

  factory DepositImageTempModel.fromMap(Map<String, dynamic> map) {
    return DepositImageTempModel(
      tldeposit_image_id: map['tldeposit_image_id'] as String,
      tldeposit_image_base64: map['tldeposit_image_base64'] as String,
      tldeposit_image_lastName: map['tldeposit_image_lastName'] as String,
      tldeposit_image_description: map['tldeposit_image_description'] as String,
      tldeposit_id: map['tldeposit_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DepositImageTempModel.fromJson(String source) => DepositImageTempModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DepositImageTempModel(tldeposit_image_id: $tldeposit_image_id, tldeposit_image_base64: $tldeposit_image_base64, tldeposit_image_lastName: $tldeposit_image_lastName, tldeposit_image_description: $tldeposit_image_description, tldeposit_id: $tldeposit_id)';
  }

  @override
  bool operator ==(covariant DepositImageTempModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tldeposit_image_id == tldeposit_image_id &&
      other.tldeposit_image_base64 == tldeposit_image_base64 &&
      other.tldeposit_image_lastName == tldeposit_image_lastName &&
      other.tldeposit_image_description == tldeposit_image_description &&
      other.tldeposit_id == tldeposit_id;
  }

  @override
  int get hashCode {
    return tldeposit_image_id.hashCode ^
      tldeposit_image_base64.hashCode ^
      tldeposit_image_lastName.hashCode ^
      tldeposit_image_description.hashCode ^
      tldeposit_id.hashCode;
  }
}
