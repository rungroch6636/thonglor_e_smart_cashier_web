// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FinancialMenuModel {
  String tlfinancial_menu_id;
  String tlfinancial_id;
  String rec_by;
  String rec_date;
  String rec_site;
  String rec_sum_paid_imed;
  String tlpayment_fullname;
  String tlpayment_sum_paid;
  String tlpayment_sum_paid_go;
  String tlpayment_sum_actual;
  String tlpayment_id;
  String tlfinancial_menu_diffimedpaid;
  String tlfinancial_menu_status;
  FinancialMenuModel({
    required this.tlfinancial_menu_id,
    required this.tlfinancial_id,
    required this.rec_by,
    required this.rec_date,
    required this.rec_site,
    required this.rec_sum_paid_imed,
    required this.tlpayment_fullname,
    required this.tlpayment_sum_paid,
    required this.tlpayment_sum_paid_go,
    required this.tlpayment_sum_actual,
    required this.tlpayment_id,
    required this.tlfinancial_menu_diffimedpaid,
    required this.tlfinancial_menu_status,
  });

  FinancialMenuModel copyWith({
    String? tlfinancial_menu_id,
    String? tlfinancial_id,
    String? rec_by,
    String? rec_date,
    String? rec_site,
    String? rec_sum_paid_imed,
    String? tlpayment_fullname,
    String? tlpayment_sum_paid,
    String? tlpayment_sum_paid_go,
    String? tlpayment_sum_actual,
    String? tlpayment_id,
    String? tlfinancial_menu_diffimedpaid,
    String? tlfinancial_menu_status,
  }) {
    return FinancialMenuModel(
      tlfinancial_menu_id: tlfinancial_menu_id ?? this.tlfinancial_menu_id,
      tlfinancial_id: tlfinancial_id ?? this.tlfinancial_id,
      rec_by: rec_by ?? this.rec_by,
      rec_date: rec_date ?? this.rec_date,
      rec_site: rec_site ?? this.rec_site,
      rec_sum_paid_imed: rec_sum_paid_imed ?? this.rec_sum_paid_imed,
      tlpayment_fullname: tlpayment_fullname ?? this.tlpayment_fullname,
      tlpayment_sum_paid: tlpayment_sum_paid ?? this.tlpayment_sum_paid,
      tlpayment_sum_paid_go: tlpayment_sum_paid_go ?? this.tlpayment_sum_paid_go,
      tlpayment_sum_actual: tlpayment_sum_actual ?? this.tlpayment_sum_actual,
      tlpayment_id: tlpayment_id ?? this.tlpayment_id,
      tlfinancial_menu_diffimedpaid: tlfinancial_menu_diffimedpaid ?? this.tlfinancial_menu_diffimedpaid,
      tlfinancial_menu_status: tlfinancial_menu_status ?? this.tlfinancial_menu_status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlfinancial_menu_id': tlfinancial_menu_id,
      'tlfinancial_id': tlfinancial_id,
      'rec_by': rec_by,
      'rec_date': rec_date,
      'rec_site': rec_site,
      'rec_sum_paid_imed': rec_sum_paid_imed,
      'tlpayment_fullname': tlpayment_fullname,
      'tlpayment_sum_paid': tlpayment_sum_paid,
      'tlpayment_sum_paid_go': tlpayment_sum_paid_go,
      'tlpayment_sum_actual': tlpayment_sum_actual,
      'tlpayment_id': tlpayment_id,
      'tlfinancial_menu_diffimedpaid': tlfinancial_menu_diffimedpaid,
      'tlfinancial_menu_status': tlfinancial_menu_status,
    };
  }

  factory FinancialMenuModel.fromMap(Map<String, dynamic> map) {
    return FinancialMenuModel(
      tlfinancial_menu_id: map['tlfinancial_menu_id'] as String,
      tlfinancial_id: map['tlfinancial_id'] as String,
      rec_by: map['rec_by'] as String,
      rec_date: map['rec_date'] as String,
      rec_site: map['rec_site'] as String,
      rec_sum_paid_imed: map['rec_sum_paid_imed'] as String,
      tlpayment_fullname: map['tlpayment_fullname'] as String,
      tlpayment_sum_paid: map['tlpayment_sum_paid'] as String,
      tlpayment_sum_paid_go: map['tlpayment_sum_paid_go'] as String,
      tlpayment_sum_actual: map['tlpayment_sum_actual'] as String,
      tlpayment_id: map['tlpayment_id'] as String,
      tlfinancial_menu_diffimedpaid: map['tlfinancial_menu_diffimedpaid'] as String,
      tlfinancial_menu_status: map['tlfinancial_menu_status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialMenuModel.fromJson(String source) => FinancialMenuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinancialMenuModel(tlfinancial_menu_id: $tlfinancial_menu_id, tlfinancial_id: $tlfinancial_id, rec_by: $rec_by, rec_date: $rec_date, rec_site: $rec_site, rec_sum_paid_imed: $rec_sum_paid_imed, tlpayment_fullname: $tlpayment_fullname, tlpayment_sum_paid: $tlpayment_sum_paid, tlpayment_sum_paid_go: $tlpayment_sum_paid_go, tlpayment_sum_actual: $tlpayment_sum_actual, tlpayment_id: $tlpayment_id, tlfinancial_menu_diffimedpaid: $tlfinancial_menu_diffimedpaid, tlfinancial_menu_status: $tlfinancial_menu_status)';
  }

  @override
  bool operator ==(covariant FinancialMenuModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlfinancial_menu_id == tlfinancial_menu_id &&
      other.tlfinancial_id == tlfinancial_id &&
      other.rec_by == rec_by &&
      other.rec_date == rec_date &&
      other.rec_site == rec_site &&
      other.rec_sum_paid_imed == rec_sum_paid_imed &&
      other.tlpayment_fullname == tlpayment_fullname &&
      other.tlpayment_sum_paid == tlpayment_sum_paid &&
      other.tlpayment_sum_paid_go == tlpayment_sum_paid_go &&
      other.tlpayment_sum_actual == tlpayment_sum_actual &&
      other.tlpayment_id == tlpayment_id &&
      other.tlfinancial_menu_diffimedpaid == tlfinancial_menu_diffimedpaid &&
      other.tlfinancial_menu_status == tlfinancial_menu_status;
  }

  @override
  int get hashCode {
    return tlfinancial_menu_id.hashCode ^
      tlfinancial_id.hashCode ^
      rec_by.hashCode ^
      rec_date.hashCode ^
      rec_site.hashCode ^
      rec_sum_paid_imed.hashCode ^
      tlpayment_fullname.hashCode ^
      tlpayment_sum_paid.hashCode ^
      tlpayment_sum_paid_go.hashCode ^
      tlpayment_sum_actual.hashCode ^
      tlpayment_id.hashCode ^
      tlfinancial_menu_diffimedpaid.hashCode ^
      tlfinancial_menu_status.hashCode;
  }
}
