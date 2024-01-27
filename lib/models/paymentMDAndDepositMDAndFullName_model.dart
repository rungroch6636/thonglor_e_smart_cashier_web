// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentMDAndDepositMDAndFullNameModel {
  String emp_fullname;
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
  String tlpayment_detail_id;
  String tlpayment_type_id;
  String tlpayment_type;
  String tlpayment_type_detail_id;
  String tlpayment_type_detail;
  String paid_go;
  String tlpayment_detail_site_id;
  String tlpayment_detail_actual_paid;
  String tlpayment_detail_diff_paid;
  String tlpayment_detail_comment;
  String ischeck;
  String tldeposit_id;
  String tldeposit_detail_id;
  String tldeposit_create_by;
  String tldeposit_create_by_fullname;
  String tldeposit_create_date;
  PaymentMDAndDepositMDAndFullNameModel({
    required this.emp_fullname,
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
    required this.tlpayment_detail_id,
    required this.tlpayment_type_id,
    required this.tlpayment_type,
    required this.tlpayment_type_detail_id,
    required this.tlpayment_type_detail,
    required this.paid_go,
    required this.tlpayment_detail_site_id,
    required this.tlpayment_detail_actual_paid,
    required this.tlpayment_detail_diff_paid,
    required this.tlpayment_detail_comment,
    required this.ischeck,
    required this.tldeposit_id,
    required this.tldeposit_detail_id,
    required this.tldeposit_create_by,
    required this.tldeposit_create_by_fullname,
    required this.tldeposit_create_date,
  });

  PaymentMDAndDepositMDAndFullNameModel copyWith({
    String? emp_fullname,
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
    String? tlpayment_detail_id,
    String? tlpayment_type_id,
    String? tlpayment_type,
    String? tlpayment_type_detail_id,
    String? tlpayment_type_detail,
    String? paid_go,
    String? tlpayment_detail_site_id,
    String? tlpayment_detail_actual_paid,
    String? tlpayment_detail_diff_paid,
    String? tlpayment_detail_comment,
    String? ischeck,
    String? tldeposit_id,
    String? tldeposit_detail_id,
    String? tldeposit_create_by,
    String? tldeposit_create_by_fullname,
    String? tldeposit_create_date,
  }) {
    return PaymentMDAndDepositMDAndFullNameModel(
      emp_fullname: emp_fullname ?? this.emp_fullname,
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
      tlpayment_detail_id: tlpayment_detail_id ?? this.tlpayment_detail_id,
      tlpayment_type_id: tlpayment_type_id ?? this.tlpayment_type_id,
      tlpayment_type: tlpayment_type ?? this.tlpayment_type,
      tlpayment_type_detail_id: tlpayment_type_detail_id ?? this.tlpayment_type_detail_id,
      tlpayment_type_detail: tlpayment_type_detail ?? this.tlpayment_type_detail,
      paid_go: paid_go ?? this.paid_go,
      tlpayment_detail_site_id: tlpayment_detail_site_id ?? this.tlpayment_detail_site_id,
      tlpayment_detail_actual_paid: tlpayment_detail_actual_paid ?? this.tlpayment_detail_actual_paid,
      tlpayment_detail_diff_paid: tlpayment_detail_diff_paid ?? this.tlpayment_detail_diff_paid,
      tlpayment_detail_comment: tlpayment_detail_comment ?? this.tlpayment_detail_comment,
      ischeck: ischeck ?? this.ischeck,
      tldeposit_id: tldeposit_id ?? this.tldeposit_id,
      tldeposit_detail_id: tldeposit_detail_id ?? this.tldeposit_detail_id,
      tldeposit_create_by: tldeposit_create_by ?? this.tldeposit_create_by,
      tldeposit_create_by_fullname: tldeposit_create_by_fullname ?? this.tldeposit_create_by_fullname,
      tldeposit_create_date: tldeposit_create_date ?? this.tldeposit_create_date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'emp_fullname': emp_fullname,
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
      'tlpayment_detail_id': tlpayment_detail_id,
      'tlpayment_type_id': tlpayment_type_id,
      'tlpayment_type': tlpayment_type,
      'tlpayment_type_detail_id': tlpayment_type_detail_id,
      'tlpayment_type_detail': tlpayment_type_detail,
      'paid_go': paid_go,
      'tlpayment_detail_site_id': tlpayment_detail_site_id,
      'tlpayment_detail_actual_paid': tlpayment_detail_actual_paid,
      'tlpayment_detail_diff_paid': tlpayment_detail_diff_paid,
      'tlpayment_detail_comment': tlpayment_detail_comment,
      'ischeck': ischeck,
      'tldeposit_id': tldeposit_id,
      'tldeposit_detail_id': tldeposit_detail_id,
      'tldeposit_create_by': tldeposit_create_by,
      'tldeposit_create_by_fullname': tldeposit_create_by_fullname,
      'tldeposit_create_date': tldeposit_create_date,
    };
  }

  factory PaymentMDAndDepositMDAndFullNameModel.fromMap(Map<String, dynamic> map) {
    return PaymentMDAndDepositMDAndFullNameModel(
      emp_fullname: map['emp_fullname'] as String,
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
      tlpayment_detail_id: map['tlpayment_detail_id'] as String,
      tlpayment_type_id: map['tlpayment_type_id'] as String,
      tlpayment_type: map['tlpayment_type'] as String,
      tlpayment_type_detail_id: map['tlpayment_type_detail_id'] as String,
      tlpayment_type_detail: map['tlpayment_type_detail'] as String,
      paid_go: map['paid_go'] as String,
      tlpayment_detail_site_id: map['tlpayment_detail_site_id'] as String,
      tlpayment_detail_actual_paid: map['tlpayment_detail_actual_paid'] as String,
      tlpayment_detail_diff_paid: map['tlpayment_detail_diff_paid'] as String,
      tlpayment_detail_comment: map['tlpayment_detail_comment'] as String,
      ischeck: map['ischeck'] as String,
      tldeposit_id: map['tldeposit_id'] as String,
      tldeposit_detail_id: map['tldeposit_detail_id'] as String,
      tldeposit_create_by: map['tldeposit_create_by'] as String,
      tldeposit_create_by_fullname: map['tldeposit_create_by_fullname'] as String,
      tldeposit_create_date: map['tldeposit_create_date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMDAndDepositMDAndFullNameModel.fromJson(String source) => PaymentMDAndDepositMDAndFullNameModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentMDAndDepositMDAndFullNameModel(emp_fullname: $emp_fullname, tlpayment_id: $tlpayment_id, tlpayment_imed_total: $tlpayment_imed_total, tlpayment_actual_total: $tlpayment_actual_total, tlpayment_diff_abs: $tlpayment_diff_abs, tlpayment_rec_date: $tlpayment_rec_date, tlpayment_rec_time_from: $tlpayment_rec_time_from, tlpayment_rec_time_to: $tlpayment_rec_time_to, tlpayment_rec_site: $tlpayment_rec_site, tlpayment_rec_by: $tlpayment_rec_by, tlpayment_create_date: $tlpayment_create_date, tlpayment_create_time: $tlpayment_create_time, tlpayment_modify_date: $tlpayment_modify_date, tlpayment_modify_time: $tlpayment_modify_time, tlpayment_status: $tlpayment_status, tlpayment_merge_id: $tlpayment_merge_id, tlpayment_comment: $tlpayment_comment, tlpayment_detail_id: $tlpayment_detail_id, tlpayment_type_id: $tlpayment_type_id, tlpayment_type: $tlpayment_type, tlpayment_type_detail_id: $tlpayment_type_detail_id, tlpayment_type_detail: $tlpayment_type_detail, paid_go: $paid_go, tlpayment_detail_site_id: $tlpayment_detail_site_id, tlpayment_detail_actual_paid: $tlpayment_detail_actual_paid, tlpayment_detail_diff_paid: $tlpayment_detail_diff_paid, tlpayment_detail_comment: $tlpayment_detail_comment, ischeck: $ischeck, tldeposit_id: $tldeposit_id, tldeposit_detail_id: $tldeposit_detail_id, tldeposit_create_by: $tldeposit_create_by, tldeposit_create_by_fullname: $tldeposit_create_by_fullname, tldeposit_create_date: $tldeposit_create_date)';
  }

  @override
  bool operator ==(covariant PaymentMDAndDepositMDAndFullNameModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.emp_fullname == emp_fullname &&
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
      other.tlpayment_detail_id == tlpayment_detail_id &&
      other.tlpayment_type_id == tlpayment_type_id &&
      other.tlpayment_type == tlpayment_type &&
      other.tlpayment_type_detail_id == tlpayment_type_detail_id &&
      other.tlpayment_type_detail == tlpayment_type_detail &&
      other.paid_go == paid_go &&
      other.tlpayment_detail_site_id == tlpayment_detail_site_id &&
      other.tlpayment_detail_actual_paid == tlpayment_detail_actual_paid &&
      other.tlpayment_detail_diff_paid == tlpayment_detail_diff_paid &&
      other.tlpayment_detail_comment == tlpayment_detail_comment &&
      other.ischeck == ischeck &&
      other.tldeposit_id == tldeposit_id &&
      other.tldeposit_detail_id == tldeposit_detail_id &&
      other.tldeposit_create_by == tldeposit_create_by &&
      other.tldeposit_create_by_fullname == tldeposit_create_by_fullname &&
      other.tldeposit_create_date == tldeposit_create_date;
  }

  @override
  int get hashCode {
    return emp_fullname.hashCode ^
      tlpayment_id.hashCode ^
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
      tlpayment_detail_id.hashCode ^
      tlpayment_type_id.hashCode ^
      tlpayment_type.hashCode ^
      tlpayment_type_detail_id.hashCode ^
      tlpayment_type_detail.hashCode ^
      paid_go.hashCode ^
      tlpayment_detail_site_id.hashCode ^
      tlpayment_detail_actual_paid.hashCode ^
      tlpayment_detail_diff_paid.hashCode ^
      tlpayment_detail_comment.hashCode ^
      ischeck.hashCode ^
      tldeposit_id.hashCode ^
      tldeposit_detail_id.hashCode ^
      tldeposit_create_by.hashCode ^
      tldeposit_create_by_fullname.hashCode ^
      tldeposit_create_date.hashCode;
  }
}
