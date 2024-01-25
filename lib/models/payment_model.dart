// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentModel {
  String tlpayment_id;
  String tlpayment_imed_total;
  String tlpayment_actual_total;
  String tlpayment_diff_abs;
  String tlpayment_rec_date;
  String tlpayment_rec_time_from;
  String tlpayment_rec_time_to;
  String tlpayment_rec_site;
  String tlpayment_rec_by;
  String tlpayment_create_date;
  String tlpayment_create_time;
  String tlpayment_modify_date;
  String tlpayment_modify_time;
  String tlpayment_status;
  String tlpayment_merge_id;
  String tlpayment_comment;
  String tlpayment_imed_total_income;
  String tlpayment_print_number;
  PaymentModel({
    required this.tlpayment_id,
    required this.tlpayment_imed_total,
    required this.tlpayment_actual_total,
    required this.tlpayment_diff_abs,
    required this.tlpayment_rec_date,
    required this.tlpayment_rec_time_from,
    required this.tlpayment_rec_time_to,
    required this.tlpayment_rec_site,
    required this.tlpayment_rec_by,
    required this.tlpayment_create_date,
    required this.tlpayment_create_time,
    required this.tlpayment_modify_date,
    required this.tlpayment_modify_time,
    required this.tlpayment_status,
    required this.tlpayment_merge_id,
    required this.tlpayment_comment,
    required this.tlpayment_imed_total_income,
    required this.tlpayment_print_number,
  });

  PaymentModel copyWith({
    String? tlpayment_id,
    String? tlpayment_imed_total,
    String? tlpayment_actual_total,
    String? tlpayment_diff_abs,
    String? tlpayment_rec_date,
    String? tlpayment_rec_time_from,
    String? tlpayment_rec_time_to,
    String? tlpayment_rec_site,
    String? tlpayment_rec_by,
    String? tlpayment_create_date,
    String? tlpayment_create_time,
    String? tlpayment_modify_date,
    String? tlpayment_modify_time,
    String? tlpayment_status,
    String? tlpayment_merge_id,
    String? tlpayment_comment,
    String? tlpayment_imed_total_income,
    String? tlpayment_print_number,
  }) {
    return PaymentModel(
      tlpayment_id: tlpayment_id ?? this.tlpayment_id,
      tlpayment_imed_total: tlpayment_imed_total ?? this.tlpayment_imed_total,
      tlpayment_actual_total: tlpayment_actual_total ?? this.tlpayment_actual_total,
      tlpayment_diff_abs: tlpayment_diff_abs ?? this.tlpayment_diff_abs,
      tlpayment_rec_date: tlpayment_rec_date ?? this.tlpayment_rec_date,
      tlpayment_rec_time_from: tlpayment_rec_time_from ?? this.tlpayment_rec_time_from,
      tlpayment_rec_time_to: tlpayment_rec_time_to ?? this.tlpayment_rec_time_to,
      tlpayment_rec_site: tlpayment_rec_site ?? this.tlpayment_rec_site,
      tlpayment_rec_by: tlpayment_rec_by ?? this.tlpayment_rec_by,
      tlpayment_create_date: tlpayment_create_date ?? this.tlpayment_create_date,
      tlpayment_create_time: tlpayment_create_time ?? this.tlpayment_create_time,
      tlpayment_modify_date: tlpayment_modify_date ?? this.tlpayment_modify_date,
      tlpayment_modify_time: tlpayment_modify_time ?? this.tlpayment_modify_time,
      tlpayment_status: tlpayment_status ?? this.tlpayment_status,
      tlpayment_merge_id: tlpayment_merge_id ?? this.tlpayment_merge_id,
      tlpayment_comment: tlpayment_comment ?? this.tlpayment_comment,
      tlpayment_imed_total_income: tlpayment_imed_total_income ?? this.tlpayment_imed_total_income,
      tlpayment_print_number: tlpayment_print_number ?? this.tlpayment_print_number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlpayment_id': tlpayment_id,
      'tlpayment_imed_total': tlpayment_imed_total,
      'tlpayment_actual_total': tlpayment_actual_total,
      'tlpayment_diff_abs': tlpayment_diff_abs,
      'tlpayment_rec_date': tlpayment_rec_date,
      'tlpayment_rec_time_from': tlpayment_rec_time_from,
      'tlpayment_rec_time_to': tlpayment_rec_time_to,
      'tlpayment_rec_site': tlpayment_rec_site,
      'tlpayment_rec_by': tlpayment_rec_by,
      'tlpayment_create_date': tlpayment_create_date,
      'tlpayment_create_time': tlpayment_create_time,
      'tlpayment_modify_date': tlpayment_modify_date,
      'tlpayment_modify_time': tlpayment_modify_time,
      'tlpayment_status': tlpayment_status,
      'tlpayment_merge_id': tlpayment_merge_id,
      'tlpayment_comment': tlpayment_comment,
      'tlpayment_imed_total_income': tlpayment_imed_total_income,
      'tlpayment_print_number': tlpayment_print_number,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      tlpayment_id: map['tlpayment_id'] as String,
      tlpayment_imed_total: map['tlpayment_imed_total'] as String,
      tlpayment_actual_total: map['tlpayment_actual_total'] as String,
      tlpayment_diff_abs: map['tlpayment_diff_abs'] as String,
      tlpayment_rec_date: map['tlpayment_rec_date'] as String,
      tlpayment_rec_time_from: map['tlpayment_rec_time_from'] as String,
      tlpayment_rec_time_to: map['tlpayment_rec_time_to'] as String,
      tlpayment_rec_site: map['tlpayment_rec_site'] as String,
      tlpayment_rec_by: map['tlpayment_rec_by'] as String,
      tlpayment_create_date: map['tlpayment_create_date'] as String,
      tlpayment_create_time: map['tlpayment_create_time'] as String,
      tlpayment_modify_date: map['tlpayment_modify_date'] as String,
      tlpayment_modify_time: map['tlpayment_modify_time'] as String,
      tlpayment_status: map['tlpayment_status'] as String,
      tlpayment_merge_id: map['tlpayment_merge_id'] as String,
      tlpayment_comment: map['tlpayment_comment'] as String,
      tlpayment_imed_total_income: map['tlpayment_imed_total_income'] as String,
      tlpayment_print_number: map['tlpayment_print_number'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) => PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentModel(tlpayment_id: $tlpayment_id, tlpayment_imed_total: $tlpayment_imed_total, tlpayment_actual_total: $tlpayment_actual_total, tlpayment_diff_abs: $tlpayment_diff_abs, tlpayment_rec_date: $tlpayment_rec_date, tlpayment_rec_time_from: $tlpayment_rec_time_from, tlpayment_rec_time_to: $tlpayment_rec_time_to, tlpayment_rec_site: $tlpayment_rec_site, tlpayment_rec_by: $tlpayment_rec_by, tlpayment_create_date: $tlpayment_create_date, tlpayment_create_time: $tlpayment_create_time, tlpayment_modify_date: $tlpayment_modify_date, tlpayment_modify_time: $tlpayment_modify_time, tlpayment_status: $tlpayment_status, tlpayment_merge_id: $tlpayment_merge_id, tlpayment_comment: $tlpayment_comment, tlpayment_imed_total_income: $tlpayment_imed_total_income, tlpayment_print_number: $tlpayment_print_number)';
  }

  @override
  bool operator ==(covariant PaymentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlpayment_id == tlpayment_id &&
      other.tlpayment_imed_total == tlpayment_imed_total &&
      other.tlpayment_actual_total == tlpayment_actual_total &&
      other.tlpayment_diff_abs == tlpayment_diff_abs &&
      other.tlpayment_rec_date == tlpayment_rec_date &&
      other.tlpayment_rec_time_from == tlpayment_rec_time_from &&
      other.tlpayment_rec_time_to == tlpayment_rec_time_to &&
      other.tlpayment_rec_site == tlpayment_rec_site &&
      other.tlpayment_rec_by == tlpayment_rec_by &&
      other.tlpayment_create_date == tlpayment_create_date &&
      other.tlpayment_create_time == tlpayment_create_time &&
      other.tlpayment_modify_date == tlpayment_modify_date &&
      other.tlpayment_modify_time == tlpayment_modify_time &&
      other.tlpayment_status == tlpayment_status &&
      other.tlpayment_merge_id == tlpayment_merge_id &&
      other.tlpayment_comment == tlpayment_comment &&
      other.tlpayment_imed_total_income == tlpayment_imed_total_income &&
      other.tlpayment_print_number == tlpayment_print_number;
  }

  @override
  int get hashCode {
    return tlpayment_id.hashCode ^
      tlpayment_imed_total.hashCode ^
      tlpayment_actual_total.hashCode ^
      tlpayment_diff_abs.hashCode ^
      tlpayment_rec_date.hashCode ^
      tlpayment_rec_time_from.hashCode ^
      tlpayment_rec_time_to.hashCode ^
      tlpayment_rec_site.hashCode ^
      tlpayment_rec_by.hashCode ^
      tlpayment_create_date.hashCode ^
      tlpayment_create_time.hashCode ^
      tlpayment_modify_date.hashCode ^
      tlpayment_modify_time.hashCode ^
      tlpayment_status.hashCode ^
      tlpayment_merge_id.hashCode ^
      tlpayment_comment.hashCode ^
      tlpayment_imed_total_income.hashCode ^
      tlpayment_print_number.hashCode;
  }
}
