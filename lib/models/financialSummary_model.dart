// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FinancialSummaryModel {
  String tlfinancial_summary_id;
  String tlfinancial_type_id;
  String tlfinancial_type_name;
  String tlfinancial_type_group;
  String tlfinancial_type_number;
  String tlfinancial_summary_total;
  String tlfinancial_id;
  String tldeposit_id;
  FinancialSummaryModel({
    required this.tlfinancial_summary_id,
    required this.tlfinancial_type_id,
    required this.tlfinancial_type_name,
    required this.tlfinancial_type_group,
    required this.tlfinancial_type_number,
    required this.tlfinancial_summary_total,
    required this.tlfinancial_id,
    required this.tldeposit_id,
  });

  FinancialSummaryModel copyWith({
    String? tlfinancial_summary_id,
    String? tlfinancial_type_id,
    String? tlfinancial_type_name,
    String? tlfinancial_type_group,
    String? tlfinancial_type_number,
    String? tlfinancial_summary_total,
    String? tlfinancial_id,
    String? tldeposit_id,
  }) {
    return FinancialSummaryModel(
      tlfinancial_summary_id: tlfinancial_summary_id ?? this.tlfinancial_summary_id,
      tlfinancial_type_id: tlfinancial_type_id ?? this.tlfinancial_type_id,
      tlfinancial_type_name: tlfinancial_type_name ?? this.tlfinancial_type_name,
      tlfinancial_type_group: tlfinancial_type_group ?? this.tlfinancial_type_group,
      tlfinancial_type_number: tlfinancial_type_number ?? this.tlfinancial_type_number,
      tlfinancial_summary_total: tlfinancial_summary_total ?? this.tlfinancial_summary_total,
      tlfinancial_id: tlfinancial_id ?? this.tlfinancial_id,
      tldeposit_id: tldeposit_id ?? this.tldeposit_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlfinancial_summary_id': tlfinancial_summary_id,
      'tlfinancial_type_id': tlfinancial_type_id,
      'tlfinancial_type_name': tlfinancial_type_name,
      'tlfinancial_type_group': tlfinancial_type_group,
      'tlfinancial_type_number': tlfinancial_type_number,
      'tlfinancial_summary_total': tlfinancial_summary_total,
      'tlfinancial_id': tlfinancial_id,
      'tldeposit_id': tldeposit_id,
    };
  }

  factory FinancialSummaryModel.fromMap(Map<String, dynamic> map) {
    return FinancialSummaryModel(
      tlfinancial_summary_id: map['tlfinancial_summary_id'] as String,
      tlfinancial_type_id: map['tlfinancial_type_id'] as String,
      tlfinancial_type_name: map['tlfinancial_type_name'] as String,
      tlfinancial_type_group: map['tlfinancial_type_group'] as String,
      tlfinancial_type_number: map['tlfinancial_type_number'] as String,
      tlfinancial_summary_total: map['tlfinancial_summary_total'] as String,
      tlfinancial_id: map['tlfinancial_id'] as String,
      tldeposit_id: map['tldeposit_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialSummaryModel.fromJson(String source) => FinancialSummaryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinancialSummaryModel(tlfinancial_summary_id: $tlfinancial_summary_id, tlfinancial_type_id: $tlfinancial_type_id, tlfinancial_type_name: $tlfinancial_type_name, tlfinancial_type_group: $tlfinancial_type_group, tlfinancial_type_number: $tlfinancial_type_number, tlfinancial_summary_total: $tlfinancial_summary_total, tlfinancial_id: $tlfinancial_id, tldeposit_id: $tldeposit_id)';
  }

  @override
  bool operator ==(covariant FinancialSummaryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlfinancial_summary_id == tlfinancial_summary_id &&
      other.tlfinancial_type_id == tlfinancial_type_id &&
      other.tlfinancial_type_name == tlfinancial_type_name &&
      other.tlfinancial_type_group == tlfinancial_type_group &&
      other.tlfinancial_type_number == tlfinancial_type_number &&
      other.tlfinancial_summary_total == tlfinancial_summary_total &&
      other.tlfinancial_id == tlfinancial_id &&
      other.tldeposit_id == tldeposit_id;
  }

  @override
  int get hashCode {
    return tlfinancial_summary_id.hashCode ^
      tlfinancial_type_id.hashCode ^
      tlfinancial_type_name.hashCode ^
      tlfinancial_type_group.hashCode ^
      tlfinancial_type_number.hashCode ^
      tlfinancial_summary_total.hashCode ^
      tlfinancial_id.hashCode ^
      tldeposit_id.hashCode;
  }
}
