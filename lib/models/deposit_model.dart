// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DepositModel {
  String tldeposit_id;
  String site_id;
  String tldeposit_create_date;
  String tldeposit_create_time;
  String tldeposit_bank;
  String tldeposit_bank_account;
  String tldeposit_date;
  String tldeposit_total;
  String tldeposit_total_actual;
  String tldeposit_total_balance;
  String tldeposit_comment;
  String tldeposit_status;
  String tldeposit_create_by;
  String tlpayment_rec_date;
  DepositModel({
    required this.tldeposit_id,
    required this.site_id,
    required this.tldeposit_create_date,
    required this.tldeposit_create_time,
    required this.tldeposit_bank,
    required this.tldeposit_bank_account,
    required this.tldeposit_date,
    required this.tldeposit_total,
    required this.tldeposit_total_actual,
    required this.tldeposit_total_balance,
    required this.tldeposit_comment,
    required this.tldeposit_status,
    required this.tldeposit_create_by,
    required this.tlpayment_rec_date,
  });

  DepositModel copyWith({
    String? tldeposit_id,
    String? site_id,
    String? tldeposit_create_date,
    String? tldeposit_create_time,
    String? tldeposit_bank,
    String? tldeposit_bank_account,
    String? tldeposit_date,
    String? tldeposit_total,
    String? tldeposit_total_actual,
    String? tldeposit_total_balance,
    String? tldeposit_comment,
    String? tldeposit_status,
    String? tldeposit_create_by,
    String? tlpayment_rec_date,
  }) {
    return DepositModel(
      tldeposit_id: tldeposit_id ?? this.tldeposit_id,
      site_id: site_id ?? this.site_id,
      tldeposit_create_date: tldeposit_create_date ?? this.tldeposit_create_date,
      tldeposit_create_time: tldeposit_create_time ?? this.tldeposit_create_time,
      tldeposit_bank: tldeposit_bank ?? this.tldeposit_bank,
      tldeposit_bank_account: tldeposit_bank_account ?? this.tldeposit_bank_account,
      tldeposit_date: tldeposit_date ?? this.tldeposit_date,
      tldeposit_total: tldeposit_total ?? this.tldeposit_total,
      tldeposit_total_actual: tldeposit_total_actual ?? this.tldeposit_total_actual,
      tldeposit_total_balance: tldeposit_total_balance ?? this.tldeposit_total_balance,
      tldeposit_comment: tldeposit_comment ?? this.tldeposit_comment,
      tldeposit_status: tldeposit_status ?? this.tldeposit_status,
      tldeposit_create_by: tldeposit_create_by ?? this.tldeposit_create_by,
      tlpayment_rec_date: tlpayment_rec_date ?? this.tlpayment_rec_date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tldeposit_id': tldeposit_id,
      'site_id': site_id,
      'tldeposit_create_date': tldeposit_create_date,
      'tldeposit_create_time': tldeposit_create_time,
      'tldeposit_bank': tldeposit_bank,
      'tldeposit_bank_account': tldeposit_bank_account,
      'tldeposit_date': tldeposit_date,
      'tldeposit_total': tldeposit_total,
      'tldeposit_total_actual': tldeposit_total_actual,
      'tldeposit_total_balance': tldeposit_total_balance,
      'tldeposit_comment': tldeposit_comment,
      'tldeposit_status': tldeposit_status,
      'tldeposit_create_by': tldeposit_create_by,
      'tlpayment_rec_date': tlpayment_rec_date,
    };
  }

  factory DepositModel.fromMap(Map<String, dynamic> map) {
    return DepositModel(
      tldeposit_id: map['tldeposit_id'] as String,
      site_id: map['site_id'] as String,
      tldeposit_create_date: map['tldeposit_create_date'] as String,
      tldeposit_create_time: map['tldeposit_create_time'] as String,
      tldeposit_bank: map['tldeposit_bank'] as String,
      tldeposit_bank_account: map['tldeposit_bank_account'] as String,
      tldeposit_date: map['tldeposit_date'] as String,
      tldeposit_total: map['tldeposit_total'] as String,
      tldeposit_total_actual: map['tldeposit_total_actual'] as String,
      tldeposit_total_balance: map['tldeposit_total_balance'] as String,
      tldeposit_comment: map['tldeposit_comment'] as String,
      tldeposit_status: map['tldeposit_status'] as String,
      tldeposit_create_by: map['tldeposit_create_by'] as String,
      tlpayment_rec_date: map['tlpayment_rec_date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DepositModel.fromJson(String source) => DepositModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DepositModel(tldeposit_id: $tldeposit_id, site_id: $site_id, tldeposit_create_date: $tldeposit_create_date, tldeposit_create_time: $tldeposit_create_time, tldeposit_bank: $tldeposit_bank, tldeposit_bank_account: $tldeposit_bank_account, tldeposit_date: $tldeposit_date, tldeposit_total: $tldeposit_total, tldeposit_total_actual: $tldeposit_total_actual, tldeposit_total_balance: $tldeposit_total_balance, tldeposit_comment: $tldeposit_comment, tldeposit_status: $tldeposit_status, tldeposit_create_by: $tldeposit_create_by, tlpayment_rec_date: $tlpayment_rec_date)';
  }

  @override
  bool operator ==(covariant DepositModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tldeposit_id == tldeposit_id &&
      other.site_id == site_id &&
      other.tldeposit_create_date == tldeposit_create_date &&
      other.tldeposit_create_time == tldeposit_create_time &&
      other.tldeposit_bank == tldeposit_bank &&
      other.tldeposit_bank_account == tldeposit_bank_account &&
      other.tldeposit_date == tldeposit_date &&
      other.tldeposit_total == tldeposit_total &&
      other.tldeposit_total_actual == tldeposit_total_actual &&
      other.tldeposit_total_balance == tldeposit_total_balance &&
      other.tldeposit_comment == tldeposit_comment &&
      other.tldeposit_status == tldeposit_status &&
      other.tldeposit_create_by == tldeposit_create_by &&
      other.tlpayment_rec_date == tlpayment_rec_date;
  }

  @override
  int get hashCode {
    return tldeposit_id.hashCode ^
      site_id.hashCode ^
      tldeposit_create_date.hashCode ^
      tldeposit_create_time.hashCode ^
      tldeposit_bank.hashCode ^
      tldeposit_bank_account.hashCode ^
      tldeposit_date.hashCode ^
      tldeposit_total.hashCode ^
      tldeposit_total_actual.hashCode ^
      tldeposit_total_balance.hashCode ^
      tldeposit_comment.hashCode ^
      tldeposit_status.hashCode ^
      tldeposit_create_by.hashCode ^
      tlpayment_rec_date.hashCode;
  }
}
