// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentDetailModel {
  String tlpayment_detail_id;
  String tlpayment_id;
  String tlpayment_detail_type_name;
  String imed_receip_paid;
  String tlpayment_detail_actual_paid;
  String tlpayment_detail_diff_paid;
  String tlpayment_detail_site_id;
  String tlpayment_detail_type_id;
  PaymentDetailModel({
    required this.tlpayment_detail_id,
    required this.tlpayment_id,
    required this.tlpayment_detail_type_name,
    required this.imed_receip_paid,
    required this.tlpayment_detail_actual_paid,
    required this.tlpayment_detail_diff_paid,
    required this.tlpayment_detail_site_id,
    required this.tlpayment_detail_type_id,
  });

  PaymentDetailModel copyWith({
    String? tlpayment_detail_id,
    String? tlpayment_id,
    String? tlpayment_detail_type_name,
    String? imed_receip_paid,
    String? tlpayment_detail_actual_paid,
    String? tlpayment_detail_diff_paid,
    String? tlpayment_detail_site_id,
    String? tlpayment_detail_type_id,
  }) {
    return PaymentDetailModel(
      tlpayment_detail_id: tlpayment_detail_id ?? this.tlpayment_detail_id,
      tlpayment_id: tlpayment_id ?? this.tlpayment_id,
      tlpayment_detail_type_name: tlpayment_detail_type_name ?? this.tlpayment_detail_type_name,
      imed_receip_paid: imed_receip_paid ?? this.imed_receip_paid,
      tlpayment_detail_actual_paid: tlpayment_detail_actual_paid ?? this.tlpayment_detail_actual_paid,
      tlpayment_detail_diff_paid: tlpayment_detail_diff_paid ?? this.tlpayment_detail_diff_paid,
      tlpayment_detail_site_id: tlpayment_detail_site_id ?? this.tlpayment_detail_site_id,
      tlpayment_detail_type_id: tlpayment_detail_type_id ?? this.tlpayment_detail_type_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlpayment_detail_id': tlpayment_detail_id,
      'tlpayment_id': tlpayment_id,
      'tlpayment_detail_type_name': tlpayment_detail_type_name,
      'imed_receip_paid': imed_receip_paid,
      'tlpayment_detail_actual_paid': tlpayment_detail_actual_paid,
      'tlpayment_detail_diff_paid': tlpayment_detail_diff_paid,
      'tlpayment_detail_site_id': tlpayment_detail_site_id,
      'tlpayment_detail_type_id': tlpayment_detail_type_id,
    };
  }

  factory PaymentDetailModel.fromMap(Map<String, dynamic> map) {
    return PaymentDetailModel(
      tlpayment_detail_id: map['tlpayment_detail_id'] as String,
      tlpayment_id: map['tlpayment_id'] as String,
      tlpayment_detail_type_name: map['tlpayment_detail_type_name'] as String,
      imed_receip_paid: map['imed_receip_paid'] as String,
      tlpayment_detail_actual_paid: map['tlpayment_detail_actual_paid'] as String,
      tlpayment_detail_diff_paid: map['tlpayment_detail_diff_paid'] as String,
      tlpayment_detail_site_id: map['tlpayment_detail_site_id'] as String,
      tlpayment_detail_type_id: map['tlpayment_detail_type_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentDetailModel.fromJson(String source) => PaymentDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentDetailModel(tlpayment_detail_id: $tlpayment_detail_id, tlpayment_id: $tlpayment_id, tlpayment_detail_type_name: $tlpayment_detail_type_name, imed_receip_paid: $imed_receip_paid, tlpayment_detail_actual_paid: $tlpayment_detail_actual_paid, tlpayment_detail_diff_paid: $tlpayment_detail_diff_paid, tlpayment_detail_site_id: $tlpayment_detail_site_id, tlpayment_detail_type_id: $tlpayment_detail_type_id)';
  }

  @override
  bool operator ==(covariant PaymentDetailModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlpayment_detail_id == tlpayment_detail_id &&
      other.tlpayment_id == tlpayment_id &&
      other.tlpayment_detail_type_name == tlpayment_detail_type_name &&
      other.imed_receip_paid == imed_receip_paid &&
      other.tlpayment_detail_actual_paid == tlpayment_detail_actual_paid &&
      other.tlpayment_detail_diff_paid == tlpayment_detail_diff_paid &&
      other.tlpayment_detail_site_id == tlpayment_detail_site_id &&
      other.tlpayment_detail_type_id == tlpayment_detail_type_id;
  }

  @override
  int get hashCode {
    return tlpayment_detail_id.hashCode ^
      tlpayment_id.hashCode ^
      tlpayment_detail_type_name.hashCode ^
      imed_receip_paid.hashCode ^
      tlpayment_detail_actual_paid.hashCode ^
      tlpayment_detail_diff_paid.hashCode ^
      tlpayment_detail_site_id.hashCode ^
      tlpayment_detail_type_id.hashCode;
  }
}
