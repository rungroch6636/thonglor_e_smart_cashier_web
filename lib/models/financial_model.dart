// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FinancialModel {
  String tlfinancial_id;
  String tlfinancial_rec_date;
  String tlfinancial_rec_site;
  String tlfinancial_create_by;
  String tlfinancial_create_date;
  String tlfinancial_create_time;

  String tlfin_imed_paid; //6.10 รายได้
  String tlfin_payment_paid; //รายได้ปิดผลัดรวม
  String tlfin_payment_paid_go; //นำส่ง
  String tlfin_payment_paid_actual; //นำส่งจริง
  String tlfinancial_actual; //finตรวจสอบ
  String tlfinancial_diff; //paid_actual - actual

  String tlfinancial_status;
  String tlfinancial_comment;
  String tlfinancial_modify_by;
  String tlfinancial_modify_date;
  String tlfinancial_modify_time;
  FinancialModel({
    required this.tlfinancial_id,
    required this.tlfinancial_rec_date,
    required this.tlfinancial_rec_site,
    required this.tlfinancial_create_by,
    required this.tlfinancial_create_date,
    required this.tlfinancial_create_time,
    required this.tlfin_imed_paid,
    required this.tlfin_payment_paid,
    required this.tlfin_payment_paid_go,
    required this.tlfin_payment_paid_actual,
    required this.tlfinancial_actual,
    required this.tlfinancial_diff,
    required this.tlfinancial_status,
    required this.tlfinancial_comment,
    required this.tlfinancial_modify_by,
    required this.tlfinancial_modify_date,
    required this.tlfinancial_modify_time,
  });

  FinancialModel copyWith({
    String? tlfinancial_id,
    String? tlfinancial_rec_date,
    String? tlfinancial_rec_site,
    String? tlfinancial_create_by,
    String? tlfinancial_create_date,
    String? tlfinancial_create_time,
    String? tlfin_imed_paid,
    String? tlfin_payment_paid,
    String? tlfin_payment_paid_go,
    String? tlfin_payment_paid_actual,
    String? tlfinancial_actual,
    String? tlfinancial_diff,
    String? tlfinancial_status,
    String? tlfinancial_comment,
    String? tlfinancial_modify_by,
    String? tlfinancial_modify_date,
    String? tlfinancial_modify_time,
  }) {
    return FinancialModel(
      tlfinancial_id: tlfinancial_id ?? this.tlfinancial_id,
      tlfinancial_rec_date: tlfinancial_rec_date ?? this.tlfinancial_rec_date,
      tlfinancial_rec_site: tlfinancial_rec_site ?? this.tlfinancial_rec_site,
      tlfinancial_create_by: tlfinancial_create_by ?? this.tlfinancial_create_by,
      tlfinancial_create_date: tlfinancial_create_date ?? this.tlfinancial_create_date,
      tlfinancial_create_time: tlfinancial_create_time ?? this.tlfinancial_create_time,
      tlfin_imed_paid: tlfin_imed_paid ?? this.tlfin_imed_paid,
      tlfin_payment_paid: tlfin_payment_paid ?? this.tlfin_payment_paid,
      tlfin_payment_paid_go: tlfin_payment_paid_go ?? this.tlfin_payment_paid_go,
      tlfin_payment_paid_actual: tlfin_payment_paid_actual ?? this.tlfin_payment_paid_actual,
      tlfinancial_actual: tlfinancial_actual ?? this.tlfinancial_actual,
      tlfinancial_diff: tlfinancial_diff ?? this.tlfinancial_diff,
      tlfinancial_status: tlfinancial_status ?? this.tlfinancial_status,
      tlfinancial_comment: tlfinancial_comment ?? this.tlfinancial_comment,
      tlfinancial_modify_by: tlfinancial_modify_by ?? this.tlfinancial_modify_by,
      tlfinancial_modify_date: tlfinancial_modify_date ?? this.tlfinancial_modify_date,
      tlfinancial_modify_time: tlfinancial_modify_time ?? this.tlfinancial_modify_time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlfinancial_id': tlfinancial_id,
      'tlfinancial_rec_date': tlfinancial_rec_date,
      'tlfinancial_rec_site': tlfinancial_rec_site,
      'tlfinancial_create_by': tlfinancial_create_by,
      'tlfinancial_create_date': tlfinancial_create_date,
      'tlfinancial_create_time': tlfinancial_create_time,
      'tlfin_imed_paid': tlfin_imed_paid,
      'tlfin_payment_paid': tlfin_payment_paid,
      'tlfin_payment_paid_go': tlfin_payment_paid_go,
      'tlfin_payment_paid_actual': tlfin_payment_paid_actual,
      'tlfinancial_actual': tlfinancial_actual,
      'tlfinancial_diff': tlfinancial_diff,
      'tlfinancial_status': tlfinancial_status,
      'tlfinancial_comment': tlfinancial_comment,
      'tlfinancial_modify_by': tlfinancial_modify_by,
      'tlfinancial_modify_date': tlfinancial_modify_date,
      'tlfinancial_modify_time': tlfinancial_modify_time,
    };
  }

  factory FinancialModel.fromMap(Map<String, dynamic> map) {
    return FinancialModel(
      tlfinancial_id: map['tlfinancial_id'] as String,
      tlfinancial_rec_date: map['tlfinancial_rec_date'] as String,
      tlfinancial_rec_site: map['tlfinancial_rec_site'] as String,
      tlfinancial_create_by: map['tlfinancial_create_by'] as String,
      tlfinancial_create_date: map['tlfinancial_create_date'] as String,
      tlfinancial_create_time: map['tlfinancial_create_time'] as String,
      tlfin_imed_paid: map['tlfin_imed_paid'] as String,
      tlfin_payment_paid: map['tlfin_payment_paid'] as String,
      tlfin_payment_paid_go: map['tlfin_payment_paid_go'] as String,
      tlfin_payment_paid_actual: map['tlfin_payment_paid_actual'] as String,
      tlfinancial_actual: map['tlfinancial_actual'] as String,
      tlfinancial_diff: map['tlfinancial_diff'] as String,
      tlfinancial_status: map['tlfinancial_status'] as String,
      tlfinancial_comment: map['tlfinancial_comment'] as String,
      tlfinancial_modify_by: map['tlfinancial_modify_by'] as String,
      tlfinancial_modify_date: map['tlfinancial_modify_date'] as String,
      tlfinancial_modify_time: map['tlfinancial_modify_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialModel.fromJson(String source) => FinancialModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinancialModel(tlfinancial_id: $tlfinancial_id, tlfinancial_rec_date: $tlfinancial_rec_date, tlfinancial_rec_site: $tlfinancial_rec_site, tlfinancial_create_by: $tlfinancial_create_by, tlfinancial_create_date: $tlfinancial_create_date, tlfinancial_create_time: $tlfinancial_create_time, tlfin_imed_paid: $tlfin_imed_paid, tlfin_payment_paid: $tlfin_payment_paid, tlfin_payment_paid_go: $tlfin_payment_paid_go, tlfin_payment_paid_actual: $tlfin_payment_paid_actual, tlfinancial_actual: $tlfinancial_actual, tlfinancial_diff: $tlfinancial_diff, tlfinancial_status: $tlfinancial_status, tlfinancial_comment: $tlfinancial_comment, tlfinancial_modify_by: $tlfinancial_modify_by, tlfinancial_modify_date: $tlfinancial_modify_date, tlfinancial_modify_time: $tlfinancial_modify_time)';
  }

  @override
  bool operator ==(covariant FinancialModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlfinancial_id == tlfinancial_id &&
      other.tlfinancial_rec_date == tlfinancial_rec_date &&
      other.tlfinancial_rec_site == tlfinancial_rec_site &&
      other.tlfinancial_create_by == tlfinancial_create_by &&
      other.tlfinancial_create_date == tlfinancial_create_date &&
      other.tlfinancial_create_time == tlfinancial_create_time &&
      other.tlfin_imed_paid == tlfin_imed_paid &&
      other.tlfin_payment_paid == tlfin_payment_paid &&
      other.tlfin_payment_paid_go == tlfin_payment_paid_go &&
      other.tlfin_payment_paid_actual == tlfin_payment_paid_actual &&
      other.tlfinancial_actual == tlfinancial_actual &&
      other.tlfinancial_diff == tlfinancial_diff &&
      other.tlfinancial_status == tlfinancial_status &&
      other.tlfinancial_comment == tlfinancial_comment &&
      other.tlfinancial_modify_by == tlfinancial_modify_by &&
      other.tlfinancial_modify_date == tlfinancial_modify_date &&
      other.tlfinancial_modify_time == tlfinancial_modify_time;
  }

  @override
  int get hashCode {
    return tlfinancial_id.hashCode ^
      tlfinancial_rec_date.hashCode ^
      tlfinancial_rec_site.hashCode ^
      tlfinancial_create_by.hashCode ^
      tlfinancial_create_date.hashCode ^
      tlfinancial_create_time.hashCode ^
      tlfin_imed_paid.hashCode ^
      tlfin_payment_paid.hashCode ^
      tlfin_payment_paid_go.hashCode ^
      tlfin_payment_paid_actual.hashCode ^
      tlfinancial_actual.hashCode ^
      tlfinancial_diff.hashCode ^
      tlfinancial_status.hashCode ^
      tlfinancial_comment.hashCode ^
      tlfinancial_modify_by.hashCode ^
      tlfinancial_modify_date.hashCode ^
      tlfinancial_modify_time.hashCode;
  }
}
