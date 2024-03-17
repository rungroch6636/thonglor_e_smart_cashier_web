// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FinancialGroupModel {
  String tlfinancial_group_id;
  String tlfinancial_type_id;
  String tlfinancial_type_name;
  String tlfinancial_type_group;
  String tlfinancial_type_number;
  String tlfinancial_group_sum;
  String tlfinancial_id;
  String tldeposit_id;
  FinancialGroupModel({
    required this.tlfinancial_group_id,
    required this.tlfinancial_type_id,
    required this.tlfinancial_type_name,
    required this.tlfinancial_type_group,
    required this.tlfinancial_type_number,
    required this.tlfinancial_group_sum,
    required this.tlfinancial_id,
    required this.tldeposit_id,
  });

  FinancialGroupModel copyWith({
    String? tlfinancial_group_id,
    String? tlfinancial_type_id,
    String? tlfinancial_type_name,
    String? tlfinancial_type_group,
    String? tlfinancial_type_number,
    String? tlfinancial_group_sum,
    String? tlfinancial_id,
    String? tldeposit_id,
  }) {
    return FinancialGroupModel(
      tlfinancial_group_id: tlfinancial_group_id ?? this.tlfinancial_group_id,
      tlfinancial_type_id: tlfinancial_type_id ?? this.tlfinancial_type_id,
      tlfinancial_type_name: tlfinancial_type_name ?? this.tlfinancial_type_name,
      tlfinancial_type_group: tlfinancial_type_group ?? this.tlfinancial_type_group,
      tlfinancial_type_number: tlfinancial_type_number ?? this.tlfinancial_type_number,
      tlfinancial_group_sum: tlfinancial_group_sum ?? this.tlfinancial_group_sum,
      tlfinancial_id: tlfinancial_id ?? this.tlfinancial_id,
      tldeposit_id: tldeposit_id ?? this.tldeposit_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlfinancial_group_id': tlfinancial_group_id,
      'tlfinancial_type_id': tlfinancial_type_id,
      'tlfinancial_type_name': tlfinancial_type_name,
      'tlfinancial_type_group': tlfinancial_type_group,
      'tlfinancial_type_number': tlfinancial_type_number,
      'tlfinancial_group_sum': tlfinancial_group_sum,
      'tlfinancial_id': tlfinancial_id,
      'tldeposit_id': tldeposit_id,
    };
  }

  factory FinancialGroupModel.fromMap(Map<String, dynamic> map) {
    return FinancialGroupModel(
      tlfinancial_group_id: map['tlfinancial_group_id'] as String,
      tlfinancial_type_id: map['tlfinancial_type_id'] as String,
      tlfinancial_type_name: map['tlfinancial_type_name'] as String,
      tlfinancial_type_group: map['tlfinancial_type_group'] as String,
      tlfinancial_type_number: map['tlfinancial_type_number'] as String,
      tlfinancial_group_sum: map['tlfinancial_group_sum'] as String,
      tlfinancial_id: map['tlfinancial_id'] as String,
      tldeposit_id: map['tldeposit_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialGroupModel.fromJson(String source) => FinancialGroupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinancialGroupModel(tlfinancial_group_id: $tlfinancial_group_id, tlfinancial_type_id: $tlfinancial_type_id, tlfinancial_type_name: $tlfinancial_type_name, tlfinancial_type_group: $tlfinancial_type_group, tlfinancial_type_number: $tlfinancial_type_number, tlfinancial_group_sum: $tlfinancial_group_sum, tlfinancial_id: $tlfinancial_id, tldeposit_id: $tldeposit_id)';
  }

  @override
  bool operator ==(covariant FinancialGroupModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlfinancial_group_id == tlfinancial_group_id &&
      other.tlfinancial_type_id == tlfinancial_type_id &&
      other.tlfinancial_type_name == tlfinancial_type_name &&
      other.tlfinancial_type_group == tlfinancial_type_group &&
      other.tlfinancial_type_number == tlfinancial_type_number &&
      other.tlfinancial_group_sum == tlfinancial_group_sum &&
      other.tlfinancial_id == tlfinancial_id &&
      other.tldeposit_id == tldeposit_id;
  }

  @override
  int get hashCode {
    return tlfinancial_group_id.hashCode ^
      tlfinancial_type_id.hashCode ^
      tlfinancial_type_name.hashCode ^
      tlfinancial_type_group.hashCode ^
      tlfinancial_type_number.hashCode ^
      tlfinancial_group_sum.hashCode ^
      tlfinancial_id.hashCode ^
      tldeposit_id.hashCode;
  }
}
