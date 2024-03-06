// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FinancialDetailModel {
  String tlfinancial_detail_id;
  String tlpayment_detail_site_id;
  String tlpayment_rec_by;
  String tlpayment_rec_date;
  String tlpayment_type_id;
  String tlpayment_type;
  String tlpayment_type_detail;
  String tlpayment_detail_actual_paid;
  String tlpayment_detail_id;
  String tlpayment_id;
  String tlpayment_detail_paid;
  String tlpayment_detail_paid_go;
  String tlpayment_detail_diff_paid;
  String tlpayment_detail_comment;
  String tldeposit_id;
  String tldeposit_create_by;
  String deposit_fullname;
  String tldeposit_detail_id;
  String tldeposit_bank_account;
  String tldeposit_date;
  String tldeposit_total;
  String tldeposit_total_actual;
  String tldeposit_total_balance;
  String tldeposit_comment;
  String tlfinancial_type_id;
  String tlfinancial_type_name;
  String tlfinancial_type_group;
  String tlfinancial_type_number;
  String tlfinancial_detail_actual;
  String tlfinancial_detail_comment;
  String tlfinancial_detail_create_by;
  String tlfinancial_detail_create_date;
  String tlfinancial_detail_create_time;
  String tlfinancial_detail_modify_by;
  String tlfinancial_detail_modify_date;
  String tlfinancial_detail_modify_time;
  String tlfinancial_id;
  String tlfinancial_menu_id;
  FinancialDetailModel({
    required this.tlfinancial_detail_id,
    required this.tlpayment_detail_site_id,
    required this.tlpayment_rec_by,
    required this.tlpayment_rec_date,
    required this.tlpayment_type_id,
    required this.tlpayment_type,
    required this.tlpayment_type_detail,
    required this.tlpayment_detail_actual_paid,
    required this.tlpayment_detail_id,
    required this.tlpayment_id,
    required this.tlpayment_detail_paid,
    required this.tlpayment_detail_paid_go,
    required this.tlpayment_detail_diff_paid,
    required this.tlpayment_detail_comment,
    required this.tldeposit_id,
    required this.tldeposit_create_by,
    required this.deposit_fullname,
    required this.tldeposit_detail_id,
    required this.tldeposit_bank_account,
    required this.tldeposit_date,
    required this.tldeposit_total,
    required this.tldeposit_total_actual,
    required this.tldeposit_total_balance,
    required this.tldeposit_comment,
    required this.tlfinancial_type_id,
    required this.tlfinancial_type_name,
    required this.tlfinancial_type_group,
    required this.tlfinancial_type_number,
    required this.tlfinancial_detail_actual,
    required this.tlfinancial_detail_comment,
    required this.tlfinancial_detail_create_by,
    required this.tlfinancial_detail_create_date,
    required this.tlfinancial_detail_create_time,
    required this.tlfinancial_detail_modify_by,
    required this.tlfinancial_detail_modify_date,
    required this.tlfinancial_detail_modify_time,
    required this.tlfinancial_id,
    required this.tlfinancial_menu_id,
  });

  FinancialDetailModel copyWith({
    String? tlfinancial_detail_id,
    String? tlpayment_detail_site_id,
    String? tlpayment_rec_by,
    String? tlpayment_rec_date,
    String? tlpayment_type_id,
    String? tlpayment_type,
    String? tlpayment_type_detail,
    String? tlpayment_detail_actual_paid,
    String? tlpayment_detail_id,
    String? tlpayment_id,
    String? tlpayment_detail_paid,
    String? tlpayment_detail_paid_go,
    String? tlpayment_detail_diff_paid,
    String? tlpayment_detail_comment,
    String? tldeposit_id,
    String? tldeposit_create_by,
    String? deposit_fullname,
    String? tldeposit_detail_id,
    String? tldeposit_bank_account,
    String? tldeposit_date,
    String? tldeposit_total,
    String? tldeposit_total_actual,
    String? tldeposit_total_balance,
    String? tldeposit_comment,
    String? tlfinancial_type_id,
    String? tlfinancial_type_name,
    String? tlfinancial_type_group,
    String? tlfinancial_type_number,
    String? tlfinancial_detail_actual,
    String? tlfinancial_detail_comment,
    String? tlfinancial_detail_create_by,
    String? tlfinancial_detail_create_date,
    String? tlfinancial_detail_create_time,
    String? tlfinancial_detail_modify_by,
    String? tlfinancial_detail_modify_date,
    String? tlfinancial_detail_modify_time,
    String? tlfinancial_id,
    String? tlfinancial_menu_id,
  }) {
    return FinancialDetailModel(
      tlfinancial_detail_id: tlfinancial_detail_id ?? this.tlfinancial_detail_id,
      tlpayment_detail_site_id: tlpayment_detail_site_id ?? this.tlpayment_detail_site_id,
      tlpayment_rec_by: tlpayment_rec_by ?? this.tlpayment_rec_by,
      tlpayment_rec_date: tlpayment_rec_date ?? this.tlpayment_rec_date,
      tlpayment_type_id: tlpayment_type_id ?? this.tlpayment_type_id,
      tlpayment_type: tlpayment_type ?? this.tlpayment_type,
      tlpayment_type_detail: tlpayment_type_detail ?? this.tlpayment_type_detail,
      tlpayment_detail_actual_paid: tlpayment_detail_actual_paid ?? this.tlpayment_detail_actual_paid,
      tlpayment_detail_id: tlpayment_detail_id ?? this.tlpayment_detail_id,
      tlpayment_id: tlpayment_id ?? this.tlpayment_id,
      tlpayment_detail_paid: tlpayment_detail_paid ?? this.tlpayment_detail_paid,
      tlpayment_detail_paid_go: tlpayment_detail_paid_go ?? this.tlpayment_detail_paid_go,
      tlpayment_detail_diff_paid: tlpayment_detail_diff_paid ?? this.tlpayment_detail_diff_paid,
      tlpayment_detail_comment: tlpayment_detail_comment ?? this.tlpayment_detail_comment,
      tldeposit_id: tldeposit_id ?? this.tldeposit_id,
      tldeposit_create_by: tldeposit_create_by ?? this.tldeposit_create_by,
      deposit_fullname: deposit_fullname ?? this.deposit_fullname,
      tldeposit_detail_id: tldeposit_detail_id ?? this.tldeposit_detail_id,
      tldeposit_bank_account: tldeposit_bank_account ?? this.tldeposit_bank_account,
      tldeposit_date: tldeposit_date ?? this.tldeposit_date,
      tldeposit_total: tldeposit_total ?? this.tldeposit_total,
      tldeposit_total_actual: tldeposit_total_actual ?? this.tldeposit_total_actual,
      tldeposit_total_balance: tldeposit_total_balance ?? this.tldeposit_total_balance,
      tldeposit_comment: tldeposit_comment ?? this.tldeposit_comment,
      tlfinancial_type_id: tlfinancial_type_id ?? this.tlfinancial_type_id,
      tlfinancial_type_name: tlfinancial_type_name ?? this.tlfinancial_type_name,
      tlfinancial_type_group: tlfinancial_type_group ?? this.tlfinancial_type_group,
      tlfinancial_type_number: tlfinancial_type_number ?? this.tlfinancial_type_number,
      tlfinancial_detail_actual: tlfinancial_detail_actual ?? this.tlfinancial_detail_actual,
      tlfinancial_detail_comment: tlfinancial_detail_comment ?? this.tlfinancial_detail_comment,
      tlfinancial_detail_create_by: tlfinancial_detail_create_by ?? this.tlfinancial_detail_create_by,
      tlfinancial_detail_create_date: tlfinancial_detail_create_date ?? this.tlfinancial_detail_create_date,
      tlfinancial_detail_create_time: tlfinancial_detail_create_time ?? this.tlfinancial_detail_create_time,
      tlfinancial_detail_modify_by: tlfinancial_detail_modify_by ?? this.tlfinancial_detail_modify_by,
      tlfinancial_detail_modify_date: tlfinancial_detail_modify_date ?? this.tlfinancial_detail_modify_date,
      tlfinancial_detail_modify_time: tlfinancial_detail_modify_time ?? this.tlfinancial_detail_modify_time,
      tlfinancial_id: tlfinancial_id ?? this.tlfinancial_id,
      tlfinancial_menu_id: tlfinancial_menu_id ?? this.tlfinancial_menu_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlfinancial_detail_id': tlfinancial_detail_id,
      'tlpayment_detail_site_id': tlpayment_detail_site_id,
      'tlpayment_rec_by': tlpayment_rec_by,
      'tlpayment_rec_date': tlpayment_rec_date,
      'tlpayment_type_id': tlpayment_type_id,
      'tlpayment_type': tlpayment_type,
      'tlpayment_type_detail': tlpayment_type_detail,
      'tlpayment_detail_actual_paid': tlpayment_detail_actual_paid,
      'tlpayment_detail_id': tlpayment_detail_id,
      'tlpayment_id': tlpayment_id,
      'tlpayment_detail_paid': tlpayment_detail_paid,
      'tlpayment_detail_paid_go': tlpayment_detail_paid_go,
      'tlpayment_detail_diff_paid': tlpayment_detail_diff_paid,
      'tlpayment_detail_comment': tlpayment_detail_comment,
      'tldeposit_id': tldeposit_id,
      'tldeposit_create_by': tldeposit_create_by,
      'deposit_fullname': deposit_fullname,
      'tldeposit_detail_id': tldeposit_detail_id,
      'tldeposit_bank_account': tldeposit_bank_account,
      'tldeposit_date': tldeposit_date,
      'tldeposit_total': tldeposit_total,
      'tldeposit_total_actual': tldeposit_total_actual,
      'tldeposit_total_balance': tldeposit_total_balance,
      'tldeposit_comment': tldeposit_comment,
      'tlfinancial_type_id': tlfinancial_type_id,
      'tlfinancial_type_name': tlfinancial_type_name,
      'tlfinancial_type_group': tlfinancial_type_group,
      'tlfinancial_type_number': tlfinancial_type_number,
      'tlfinancial_detail_actual': tlfinancial_detail_actual,
      'tlfinancial_detail_comment': tlfinancial_detail_comment,
      'tlfinancial_detail_create_by': tlfinancial_detail_create_by,
      'tlfinancial_detail_create_date': tlfinancial_detail_create_date,
      'tlfinancial_detail_create_time': tlfinancial_detail_create_time,
      'tlfinancial_detail_modify_by': tlfinancial_detail_modify_by,
      'tlfinancial_detail_modify_date': tlfinancial_detail_modify_date,
      'tlfinancial_detail_modify_time': tlfinancial_detail_modify_time,
      'tlfinancial_id': tlfinancial_id,
      'tlfinancial_menu_id': tlfinancial_menu_id,
    };
  }

  factory FinancialDetailModel.fromMap(Map<String, dynamic> map) {
    return FinancialDetailModel(
      tlfinancial_detail_id: map['tlfinancial_detail_id'] as String,
      tlpayment_detail_site_id: map['tlpayment_detail_site_id'] as String,
      tlpayment_rec_by: map['tlpayment_rec_by'] as String,
      tlpayment_rec_date: map['tlpayment_rec_date'] as String,
      tlpayment_type_id: map['tlpayment_type_id'] as String,
      tlpayment_type: map['tlpayment_type'] as String,
      tlpayment_type_detail: map['tlpayment_type_detail'] as String,
      tlpayment_detail_actual_paid: map['tlpayment_detail_actual_paid'] as String,
      tlpayment_detail_id: map['tlpayment_detail_id'] as String,
      tlpayment_id: map['tlpayment_id'] as String,
      tlpayment_detail_paid: map['tlpayment_detail_paid'] as String,
      tlpayment_detail_paid_go: map['tlpayment_detail_paid_go'] as String,
      tlpayment_detail_diff_paid: map['tlpayment_detail_diff_paid'] as String,
      tlpayment_detail_comment: map['tlpayment_detail_comment'] as String,
      tldeposit_id: map['tldeposit_id'] as String,
      tldeposit_create_by: map['tldeposit_create_by'] as String,
      deposit_fullname: map['deposit_fullname'] as String,
      tldeposit_detail_id: map['tldeposit_detail_id'] as String,
      tldeposit_bank_account: map['tldeposit_bank_account'] as String,
      tldeposit_date: map['tldeposit_date'] as String,
      tldeposit_total: map['tldeposit_total'] as String,
      tldeposit_total_actual: map['tldeposit_total_actual'] as String,
      tldeposit_total_balance: map['tldeposit_total_balance'] as String,
      tldeposit_comment: map['tldeposit_comment'] as String,
      tlfinancial_type_id: map['tlfinancial_type_id'] as String,
      tlfinancial_type_name: map['tlfinancial_type_name'] as String,
      tlfinancial_type_group: map['tlfinancial_type_group'] as String,
      tlfinancial_type_number: map['tlfinancial_type_number'] as String,
      tlfinancial_detail_actual: map['tlfinancial_detail_actual'] as String,
      tlfinancial_detail_comment: map['tlfinancial_detail_comment'] as String,
      tlfinancial_detail_create_by: map['tlfinancial_detail_create_by'] as String,
      tlfinancial_detail_create_date: map['tlfinancial_detail_create_date'] as String,
      tlfinancial_detail_create_time: map['tlfinancial_detail_create_time'] as String,
      tlfinancial_detail_modify_by: map['tlfinancial_detail_modify_by'] as String,
      tlfinancial_detail_modify_date: map['tlfinancial_detail_modify_date'] as String,
      tlfinancial_detail_modify_time: map['tlfinancial_detail_modify_time'] as String,
      tlfinancial_id: map['tlfinancial_id'] as String,
      tlfinancial_menu_id: map['tlfinancial_menu_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialDetailModel.fromJson(String source) => FinancialDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinancialDetailModel(tlfinancial_detail_id: $tlfinancial_detail_id, tlpayment_detail_site_id: $tlpayment_detail_site_id, tlpayment_rec_by: $tlpayment_rec_by, tlpayment_rec_date: $tlpayment_rec_date, tlpayment_type_id: $tlpayment_type_id, tlpayment_type: $tlpayment_type, tlpayment_type_detail: $tlpayment_type_detail, tlpayment_detail_actual_paid: $tlpayment_detail_actual_paid, tlpayment_detail_id: $tlpayment_detail_id, tlpayment_id: $tlpayment_id, tlpayment_detail_paid: $tlpayment_detail_paid, tlpayment_detail_paid_go: $tlpayment_detail_paid_go, tlpayment_detail_diff_paid: $tlpayment_detail_diff_paid, tlpayment_detail_comment: $tlpayment_detail_comment, tldeposit_id: $tldeposit_id, tldeposit_create_by: $tldeposit_create_by, deposit_fullname: $deposit_fullname, tldeposit_detail_id: $tldeposit_detail_id, tldeposit_bank_account: $tldeposit_bank_account, tldeposit_date: $tldeposit_date, tldeposit_total: $tldeposit_total, tldeposit_total_actual: $tldeposit_total_actual, tldeposit_total_balance: $tldeposit_total_balance, tldeposit_comment: $tldeposit_comment, tlfinancial_type_id: $tlfinancial_type_id, tlfinancial_type_name: $tlfinancial_type_name, tlfinancial_type_group: $tlfinancial_type_group, tlfinancial_type_number: $tlfinancial_type_number, tlfinancial_detail_actual: $tlfinancial_detail_actual, tlfinancial_detail_comment: $tlfinancial_detail_comment, tlfinancial_detail_create_by: $tlfinancial_detail_create_by, tlfinancial_detail_create_date: $tlfinancial_detail_create_date, tlfinancial_detail_create_time: $tlfinancial_detail_create_time, tlfinancial_detail_modify_by: $tlfinancial_detail_modify_by, tlfinancial_detail_modify_date: $tlfinancial_detail_modify_date, tlfinancial_detail_modify_time: $tlfinancial_detail_modify_time, tlfinancial_id: $tlfinancial_id, tlfinancial_menu_id: $tlfinancial_menu_id)';
  }

  @override
  bool operator ==(covariant FinancialDetailModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlfinancial_detail_id == tlfinancial_detail_id &&
      other.tlpayment_detail_site_id == tlpayment_detail_site_id &&
      other.tlpayment_rec_by == tlpayment_rec_by &&
      other.tlpayment_rec_date == tlpayment_rec_date &&
      other.tlpayment_type_id == tlpayment_type_id &&
      other.tlpayment_type == tlpayment_type &&
      other.tlpayment_type_detail == tlpayment_type_detail &&
      other.tlpayment_detail_actual_paid == tlpayment_detail_actual_paid &&
      other.tlpayment_detail_id == tlpayment_detail_id &&
      other.tlpayment_id == tlpayment_id &&
      other.tlpayment_detail_paid == tlpayment_detail_paid &&
      other.tlpayment_detail_paid_go == tlpayment_detail_paid_go &&
      other.tlpayment_detail_diff_paid == tlpayment_detail_diff_paid &&
      other.tlpayment_detail_comment == tlpayment_detail_comment &&
      other.tldeposit_id == tldeposit_id &&
      other.tldeposit_create_by == tldeposit_create_by &&
      other.deposit_fullname == deposit_fullname &&
      other.tldeposit_detail_id == tldeposit_detail_id &&
      other.tldeposit_bank_account == tldeposit_bank_account &&
      other.tldeposit_date == tldeposit_date &&
      other.tldeposit_total == tldeposit_total &&
      other.tldeposit_total_actual == tldeposit_total_actual &&
      other.tldeposit_total_balance == tldeposit_total_balance &&
      other.tldeposit_comment == tldeposit_comment &&
      other.tlfinancial_type_id == tlfinancial_type_id &&
      other.tlfinancial_type_name == tlfinancial_type_name &&
      other.tlfinancial_type_group == tlfinancial_type_group &&
      other.tlfinancial_type_number == tlfinancial_type_number &&
      other.tlfinancial_detail_actual == tlfinancial_detail_actual &&
      other.tlfinancial_detail_comment == tlfinancial_detail_comment &&
      other.tlfinancial_detail_create_by == tlfinancial_detail_create_by &&
      other.tlfinancial_detail_create_date == tlfinancial_detail_create_date &&
      other.tlfinancial_detail_create_time == tlfinancial_detail_create_time &&
      other.tlfinancial_detail_modify_by == tlfinancial_detail_modify_by &&
      other.tlfinancial_detail_modify_date == tlfinancial_detail_modify_date &&
      other.tlfinancial_detail_modify_time == tlfinancial_detail_modify_time &&
      other.tlfinancial_id == tlfinancial_id &&
      other.tlfinancial_menu_id == tlfinancial_menu_id;
  }

  @override
  int get hashCode {
    return tlfinancial_detail_id.hashCode ^
      tlpayment_detail_site_id.hashCode ^
      tlpayment_rec_by.hashCode ^
      tlpayment_rec_date.hashCode ^
      tlpayment_type_id.hashCode ^
      tlpayment_type.hashCode ^
      tlpayment_type_detail.hashCode ^
      tlpayment_detail_actual_paid.hashCode ^
      tlpayment_detail_id.hashCode ^
      tlpayment_id.hashCode ^
      tlpayment_detail_paid.hashCode ^
      tlpayment_detail_paid_go.hashCode ^
      tlpayment_detail_diff_paid.hashCode ^
      tlpayment_detail_comment.hashCode ^
      tldeposit_id.hashCode ^
      tldeposit_create_by.hashCode ^
      deposit_fullname.hashCode ^
      tldeposit_detail_id.hashCode ^
      tldeposit_bank_account.hashCode ^
      tldeposit_date.hashCode ^
      tldeposit_total.hashCode ^
      tldeposit_total_actual.hashCode ^
      tldeposit_total_balance.hashCode ^
      tldeposit_comment.hashCode ^
      tlfinancial_type_id.hashCode ^
      tlfinancial_type_name.hashCode ^
      tlfinancial_type_group.hashCode ^
      tlfinancial_type_number.hashCode ^
      tlfinancial_detail_actual.hashCode ^
      tlfinancial_detail_comment.hashCode ^
      tlfinancial_detail_create_by.hashCode ^
      tlfinancial_detail_create_date.hashCode ^
      tlfinancial_detail_create_time.hashCode ^
      tlfinancial_detail_modify_by.hashCode ^
      tlfinancial_detail_modify_date.hashCode ^
      tlfinancial_detail_modify_time.hashCode ^
      tlfinancial_id.hashCode ^
      tlfinancial_menu_id.hashCode;
  }
}
