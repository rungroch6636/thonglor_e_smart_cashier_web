// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentTypeDetailModel {
  String tlpayment_type_detail_id;
  String tlpayment_type_detail;
  String tlpayment_type_id;
  PaymentTypeDetailModel({
    required this.tlpayment_type_detail_id,
    required this.tlpayment_type_detail,
    required this.tlpayment_type_id,
  });

  PaymentTypeDetailModel copyWith({
    String? tlpayment_type_detail_id,
    String? tlpayment_type_detail,
    String? tlpayment_type_id,
  }) {
    return PaymentTypeDetailModel(
      tlpayment_type_detail_id: tlpayment_type_detail_id ?? this.tlpayment_type_detail_id,
      tlpayment_type_detail: tlpayment_type_detail ?? this.tlpayment_type_detail,
      tlpayment_type_id: tlpayment_type_id ?? this.tlpayment_type_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlpayment_type_detail_id': tlpayment_type_detail_id,
      'tlpayment_type_detail': tlpayment_type_detail,
      'tlpayment_type_id': tlpayment_type_id,
    };
  }

  factory PaymentTypeDetailModel.fromMap(Map<String, dynamic> map) {
    return PaymentTypeDetailModel(
      tlpayment_type_detail_id: map['tlpayment_type_detail_id'] as String,
      tlpayment_type_detail: map['tlpayment_type_detail'] as String,
      tlpayment_type_id: map['tlpayment_type_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentTypeDetailModel.fromJson(String source) => PaymentTypeDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PaymentTypeDetailModel(tlpayment_type_detail_id: $tlpayment_type_detail_id, tlpayment_type_detail: $tlpayment_type_detail, tlpayment_type_id: $tlpayment_type_id)';

  @override
  bool operator ==(covariant PaymentTypeDetailModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlpayment_type_detail_id == tlpayment_type_detail_id &&
      other.tlpayment_type_detail == tlpayment_type_detail &&
      other.tlpayment_type_id == tlpayment_type_id;
  }

  @override
  int get hashCode => tlpayment_type_detail_id.hashCode ^ tlpayment_type_detail.hashCode ^ tlpayment_type_id.hashCode;
}
