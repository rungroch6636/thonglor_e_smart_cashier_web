// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BankModel {
  String tlpayment_bank_id;
String tlpayment_bank_code;
String tlpayment_bank_name;
String tlpayment_bank_number;
String tlpayment_bank_site;
  BankModel({
    required this.tlpayment_bank_id,
    required this.tlpayment_bank_code,
    required this.tlpayment_bank_name,
    required this.tlpayment_bank_number,
    required this.tlpayment_bank_site,
  });


  BankModel copyWith({
    String? tlpayment_bank_id,
    String? tlpayment_bank_code,
    String? tlpayment_bank_name,
    String? tlpayment_bank_number,
    String? tlpayment_bank_site,
  }) {
    return BankModel(
      tlpayment_bank_id: tlpayment_bank_id ?? this.tlpayment_bank_id,
      tlpayment_bank_code: tlpayment_bank_code ?? this.tlpayment_bank_code,
      tlpayment_bank_name: tlpayment_bank_name ?? this.tlpayment_bank_name,
      tlpayment_bank_number: tlpayment_bank_number ?? this.tlpayment_bank_number,
      tlpayment_bank_site: tlpayment_bank_site ?? this.tlpayment_bank_site,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlpayment_bank_id': tlpayment_bank_id,
      'tlpayment_bank_code': tlpayment_bank_code,
      'tlpayment_bank_name': tlpayment_bank_name,
      'tlpayment_bank_number': tlpayment_bank_number,
      'tlpayment_bank_site': tlpayment_bank_site,
    };
  }

  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
      tlpayment_bank_id: map['tlpayment_bank_id'] as String,
      tlpayment_bank_code: map['tlpayment_bank_code'] as String,
      tlpayment_bank_name: map['tlpayment_bank_name'] as String,
      tlpayment_bank_number: map['tlpayment_bank_number'] as String,
      tlpayment_bank_site: map['tlpayment_bank_site'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankModel.fromJson(String source) => BankModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BankModel(tlpayment_bank_id: $tlpayment_bank_id, tlpayment_bank_code: $tlpayment_bank_code, tlpayment_bank_name: $tlpayment_bank_name, tlpayment_bank_number: $tlpayment_bank_number, tlpayment_bank_site: $tlpayment_bank_site)';
  }

  @override
  bool operator ==(covariant BankModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlpayment_bank_id == tlpayment_bank_id &&
      other.tlpayment_bank_code == tlpayment_bank_code &&
      other.tlpayment_bank_name == tlpayment_bank_name &&
      other.tlpayment_bank_number == tlpayment_bank_number &&
      other.tlpayment_bank_site == tlpayment_bank_site;
  }

  @override
  int get hashCode {
    return tlpayment_bank_id.hashCode ^
      tlpayment_bank_code.hashCode ^
      tlpayment_bank_name.hashCode ^
      tlpayment_bank_number.hashCode ^
      tlpayment_bank_site.hashCode;
  }
}
