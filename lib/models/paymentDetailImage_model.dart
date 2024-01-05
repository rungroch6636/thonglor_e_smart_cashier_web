// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentDetailImageModel {
  String tlpayment_detail_image_id;
  String tlpayment_detail_id;
  String tlpayment_image_path;
  String tlpayment_image_description;
  String tlpayment_id;
  PaymentDetailImageModel({
    required this.tlpayment_detail_image_id,
    required this.tlpayment_detail_id,
    required this.tlpayment_image_path,
    required this.tlpayment_image_description,
    required this.tlpayment_id,
  });

  PaymentDetailImageModel copyWith({
    String? tlpayment_detail_image_id,
    String? tlpayment_detail_id,
    String? tlpayment_image_path,
    String? tlpayment_image_description,
    String? tlpayment_id,
  }) {
    return PaymentDetailImageModel(
      tlpayment_detail_image_id: tlpayment_detail_image_id ?? this.tlpayment_detail_image_id,
      tlpayment_detail_id: tlpayment_detail_id ?? this.tlpayment_detail_id,
      tlpayment_image_path: tlpayment_image_path ?? this.tlpayment_image_path,
      tlpayment_image_description: tlpayment_image_description ?? this.tlpayment_image_description,
      tlpayment_id: tlpayment_id ?? this.tlpayment_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlpayment_detail_image_id': tlpayment_detail_image_id,
      'tlpayment_detail_id': tlpayment_detail_id,
      'tlpayment_image_path': tlpayment_image_path,
      'tlpayment_image_description': tlpayment_image_description,
      'tlpayment_id': tlpayment_id,
    };
  }

  factory PaymentDetailImageModel.fromMap(Map<String, dynamic> map) {
    return PaymentDetailImageModel(
      tlpayment_detail_image_id: map['tlpayment_detail_image_id'] as String,
      tlpayment_detail_id: map['tlpayment_detail_id'] as String,
      tlpayment_image_path: map['tlpayment_image_path'] as String,
      tlpayment_image_description: map['tlpayment_image_description'] as String,
      tlpayment_id: map['tlpayment_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentDetailImageModel.fromJson(String source) => PaymentDetailImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentDetailImageModel(tlpayment_detail_image_id: $tlpayment_detail_image_id, tlpayment_detail_id: $tlpayment_detail_id, tlpayment_image_path: $tlpayment_image_path, tlpayment_image_description: $tlpayment_image_description, tlpayment_id: $tlpayment_id)';
  }

  @override
  bool operator ==(covariant PaymentDetailImageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlpayment_detail_image_id == tlpayment_detail_image_id &&
      other.tlpayment_detail_id == tlpayment_detail_id &&
      other.tlpayment_image_path == tlpayment_image_path &&
      other.tlpayment_image_description == tlpayment_image_description &&
      other.tlpayment_id == tlpayment_id;
  }

  @override
  int get hashCode {
    return tlpayment_detail_image_id.hashCode ^
      tlpayment_detail_id.hashCode ^
      tlpayment_image_path.hashCode ^
      tlpayment_image_description.hashCode ^
      tlpayment_id.hashCode;
  }
}
