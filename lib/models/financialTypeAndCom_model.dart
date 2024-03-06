// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FinancialTypeAndComModel {
String tlfinancial_type_id;
String tlfinancial_type_name;
String tlfinancial_type_group;
String tlfinancial_type_number;
String tlfinancial_type_compare_id;
String tlpayment_type_id;
String tlpayment_type;
String tlpayment_type_detail;
  FinancialTypeAndComModel({
    required this.tlfinancial_type_id,
    required this.tlfinancial_type_name,
    required this.tlfinancial_type_group,
    required this.tlfinancial_type_number,
    required this.tlfinancial_type_compare_id,
    required this.tlpayment_type_id,
    required this.tlpayment_type,
    required this.tlpayment_type_detail,
  });


  FinancialTypeAndComModel copyWith({
    String? tlfinancial_type_id,
    String? tlfinancial_type_name,
    String? tlfinancial_type_group,
    String? tlfinancial_type_number,
    String? tlfinancial_type_compare_id,
    String? tlpayment_type_id,
    String? tlpayment_type,
    String? tlpayment_type_detail,
  }) {
    return FinancialTypeAndComModel(
      tlfinancial_type_id: tlfinancial_type_id ?? this.tlfinancial_type_id,
      tlfinancial_type_name: tlfinancial_type_name ?? this.tlfinancial_type_name,
      tlfinancial_type_group: tlfinancial_type_group ?? this.tlfinancial_type_group,
      tlfinancial_type_number: tlfinancial_type_number ?? this.tlfinancial_type_number,
      tlfinancial_type_compare_id: tlfinancial_type_compare_id ?? this.tlfinancial_type_compare_id,
      tlpayment_type_id: tlpayment_type_id ?? this.tlpayment_type_id,
      tlpayment_type: tlpayment_type ?? this.tlpayment_type,
      tlpayment_type_detail: tlpayment_type_detail ?? this.tlpayment_type_detail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlfinancial_type_id': tlfinancial_type_id,
      'tlfinancial_type_name': tlfinancial_type_name,
      'tlfinancial_type_group': tlfinancial_type_group,
      'tlfinancial_type_number': tlfinancial_type_number,
      'tlfinancial_type_compare_id': tlfinancial_type_compare_id,
      'tlpayment_type_id': tlpayment_type_id,
      'tlpayment_type': tlpayment_type,
      'tlpayment_type_detail': tlpayment_type_detail,
    };
  }

  factory FinancialTypeAndComModel.fromMap(Map<String, dynamic> map) {
    return FinancialTypeAndComModel(
      tlfinancial_type_id: map['tlfinancial_type_id'] as String,
      tlfinancial_type_name: map['tlfinancial_type_name'] as String,
      tlfinancial_type_group: map['tlfinancial_type_group'] as String,
      tlfinancial_type_number: map['tlfinancial_type_number'] as String,
      tlfinancial_type_compare_id: map['tlfinancial_type_compare_id'] as String,
      tlpayment_type_id: map['tlpayment_type_id'] as String,
      tlpayment_type: map['tlpayment_type'] as String,
      tlpayment_type_detail: map['tlpayment_type_detail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialTypeAndComModel.fromJson(String source) => FinancialTypeAndComModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinancialTypeAndComModel(tlfinancial_type_id: $tlfinancial_type_id, tlfinancial_type_name: $tlfinancial_type_name, tlfinancial_type_group: $tlfinancial_type_group, tlfinancial_type_number: $tlfinancial_type_number, tlfinancial_type_compare_id: $tlfinancial_type_compare_id, tlpayment_type_id: $tlpayment_type_id, tlpayment_type: $tlpayment_type, tlpayment_type_detail: $tlpayment_type_detail)';
  }

  @override
  bool operator ==(covariant FinancialTypeAndComModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlfinancial_type_id == tlfinancial_type_id &&
      other.tlfinancial_type_name == tlfinancial_type_name &&
      other.tlfinancial_type_group == tlfinancial_type_group &&
      other.tlfinancial_type_number == tlfinancial_type_number &&
      other.tlfinancial_type_compare_id == tlfinancial_type_compare_id &&
      other.tlpayment_type_id == tlpayment_type_id &&
      other.tlpayment_type == tlpayment_type &&
      other.tlpayment_type_detail == tlpayment_type_detail;
  }

  @override
  int get hashCode {
    return tlfinancial_type_id.hashCode ^
      tlfinancial_type_name.hashCode ^
      tlfinancial_type_group.hashCode ^
      tlfinancial_type_number.hashCode ^
      tlfinancial_type_compare_id.hashCode ^
      tlpayment_type_id.hashCode ^
      tlpayment_type.hashCode ^
      tlpayment_type_detail.hashCode;
  }
}
