// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FinancialTypeModel {
  String tlfinancial_type_id;
  String tlfinancial_type_name;
  String tlfinancial_type_group;
  String tlfinancial_type_number;
  FinancialTypeModel({
    required this.tlfinancial_type_id,
    required this.tlfinancial_type_name,
    required this.tlfinancial_type_group,
    required this.tlfinancial_type_number,
  });

  FinancialTypeModel copyWith({
    String? tlfinancial_type_id,
    String? tlfinancial_type_name,
    String? tlfinancial_type_group,
    String? tlfinancial_type_number,
  }) {
    return FinancialTypeModel(
      tlfinancial_type_id: tlfinancial_type_id ?? this.tlfinancial_type_id,
      tlfinancial_type_name: tlfinancial_type_name ?? this.tlfinancial_type_name,
      tlfinancial_type_group: tlfinancial_type_group ?? this.tlfinancial_type_group,
      tlfinancial_type_number: tlfinancial_type_number ?? this.tlfinancial_type_number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlfinancial_type_id': tlfinancial_type_id,
      'tlfinancial_type_name': tlfinancial_type_name,
      'tlfinancial_type_group': tlfinancial_type_group,
      'tlfinancial_type_number': tlfinancial_type_number,
    };
  }

  factory FinancialTypeModel.fromMap(Map<String, dynamic> map) {
    return FinancialTypeModel(
      tlfinancial_type_id: map['tlfinancial_type_id'] as String,
      tlfinancial_type_name: map['tlfinancial_type_name'] as String,
      tlfinancial_type_group: map['tlfinancial_type_group'] as String,
      tlfinancial_type_number: map['tlfinancial_type_number'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialTypeModel.fromJson(String source) => FinancialTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinancialTypeModel(tlfinancial_type_id: $tlfinancial_type_id, tlfinancial_type_name: $tlfinancial_type_name, tlfinancial_type_group: $tlfinancial_type_group, tlfinancial_type_number: $tlfinancial_type_number)';
  }

  @override
  bool operator ==(covariant FinancialTypeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlfinancial_type_id == tlfinancial_type_id &&
      other.tlfinancial_type_name == tlfinancial_type_name &&
      other.tlfinancial_type_group == tlfinancial_type_group &&
      other.tlfinancial_type_number == tlfinancial_type_number;
  }

  @override
  int get hashCode {
    return tlfinancial_type_id.hashCode ^
      tlfinancial_type_name.hashCode ^
      tlfinancial_type_group.hashCode ^
      tlfinancial_type_number.hashCode;
  }
}
