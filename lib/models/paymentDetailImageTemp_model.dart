// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentDetailImageTempModel {
  String tlpayment_detail_image_id;
  String tlpayment_detail_id;
  String tlpayment_image_base64;
  String tlpayment_image_last_Name;
  String tlpayment_image_description;
  String tlpayment_id;
  PaymentDetailImageTempModel({
    required this.tlpayment_detail_image_id,
    required this.tlpayment_detail_id,
    required this.tlpayment_image_base64,
    required this.tlpayment_image_last_Name,
    required this.tlpayment_image_description,
    required this.tlpayment_id,
  });

  PaymentDetailImageTempModel copyWith({
    String? tlpayment_detail_image_id,
    String? tlpayment_detail_id,
    String? tlpayment_image_base64,
    String? tlpayment_image_last_Name,
    String? tlpayment_image_description,
    String? tlpayment_id,
  }) {
    return PaymentDetailImageTempModel(
      tlpayment_detail_image_id: tlpayment_detail_image_id ?? this.tlpayment_detail_image_id,
      tlpayment_detail_id: tlpayment_detail_id ?? this.tlpayment_detail_id,
      tlpayment_image_base64: tlpayment_image_base64 ?? this.tlpayment_image_base64,
      tlpayment_image_last_Name: tlpayment_image_last_Name ?? this.tlpayment_image_last_Name,
      tlpayment_image_description: tlpayment_image_description ?? this.tlpayment_image_description,
      tlpayment_id: tlpayment_id ?? this.tlpayment_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlpayment_detail_image_id': tlpayment_detail_image_id,
      'tlpayment_detail_id': tlpayment_detail_id,
      'tlpayment_image_base64': tlpayment_image_base64,
      'tlpayment_image_last_Name': tlpayment_image_last_Name,
      'tlpayment_image_description': tlpayment_image_description,
      'tlpayment_id': tlpayment_id,
    };
  }

  factory PaymentDetailImageTempModel.fromMap(Map<String, dynamic> map) {
    return PaymentDetailImageTempModel(
      tlpayment_detail_image_id: map['tlpayment_detail_image_id'] as String,
      tlpayment_detail_id: map['tlpayment_detail_id'] as String,
      tlpayment_image_base64: map['tlpayment_image_base64'] as String,
      tlpayment_image_last_Name: map['tlpayment_image_last_Name'] as String,
      tlpayment_image_description: map['tlpayment_image_description'] as String,
      tlpayment_id: map['tlpayment_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentDetailImageTempModel.fromJson(String source) => PaymentDetailImageTempModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentDetailImageTempModel(tlpayment_detail_image_id: $tlpayment_detail_image_id, tlpayment_detail_id: $tlpayment_detail_id, tlpayment_image_base64: $tlpayment_image_base64, tlpayment_image_last_Name: $tlpayment_image_last_Name, tlpayment_image_description: $tlpayment_image_description, tlpayment_id: $tlpayment_id)';
  }

  @override
  bool operator ==(covariant PaymentDetailImageTempModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlpayment_detail_image_id == tlpayment_detail_image_id &&
      other.tlpayment_detail_id == tlpayment_detail_id &&
      other.tlpayment_image_base64 == tlpayment_image_base64 &&
      other.tlpayment_image_last_Name == tlpayment_image_last_Name &&
      other.tlpayment_image_description == tlpayment_image_description &&
      other.tlpayment_id == tlpayment_id;
  }

  @override
  int get hashCode {
    return tlpayment_detail_image_id.hashCode ^
      tlpayment_detail_id.hashCode ^
      tlpayment_image_base64.hashCode ^
      tlpayment_image_last_Name.hashCode ^
      tlpayment_image_description.hashCode ^
      tlpayment_id.hashCode;
  }
}
