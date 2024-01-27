// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReceiptReviewModel {
  int paid_method;
  String rec_by;
  String rec_date;
  String rec_site;
  String paid_method_func;
  String paid_method_th;
  String paid_method_sub_th;
  int? c_num;
  String opd_paid;
  String ipd_paid;
  String paid;
  String paid_go;
  int? grpdsp;
  ReceiptReviewModel({
    required this.paid_method,
    required this.rec_by,
    required this.rec_date,
    required this.rec_site,
    required this.paid_method_func,
    required this.paid_method_th,
    required this.paid_method_sub_th,
    this.c_num,
    required this.opd_paid,
    required this.ipd_paid,
    required this.paid,
    required this.paid_go,
    this.grpdsp,
  });

  ReceiptReviewModel copyWith({
    int? paid_method,
    String? rec_by,
    String? rec_date,
    String? rec_site,
    String? paid_method_func,
    String? paid_method_th,
    String? paid_method_sub_th,
    int? c_num,
    String? opd_paid,
    String? ipd_paid,
    String? paid,
    String? paid_go,
    int? grpdsp,
  }) {
    return ReceiptReviewModel(
      paid_method: paid_method ?? this.paid_method,
      rec_by: rec_by ?? this.rec_by,
      rec_date: rec_date ?? this.rec_date,
      rec_site: rec_site ?? this.rec_site,
      paid_method_func: paid_method_func ?? this.paid_method_func,
      paid_method_th: paid_method_th ?? this.paid_method_th,
      paid_method_sub_th: paid_method_sub_th ?? this.paid_method_sub_th,
      c_num: c_num ?? this.c_num,
      opd_paid: opd_paid ?? this.opd_paid,
      ipd_paid: ipd_paid ?? this.ipd_paid,
      paid: paid ?? this.paid,
      paid_go: paid_go ?? this.paid_go,
      grpdsp: grpdsp ?? this.grpdsp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paid_method': paid_method,
      'rec_by': rec_by,
      'rec_date': rec_date,
      'rec_site': rec_site,
      'paid_method_func': paid_method_func,
      'paid_method_th': paid_method_th,
      'paid_method_sub_th': paid_method_sub_th,
      'c_num': c_num,
      'opd_paid': opd_paid,
      'ipd_paid': ipd_paid,
      'paid': paid,
      'paid_go': paid_go,
      'grpdsp': grpdsp,
    };
  }

  factory ReceiptReviewModel.fromMap(Map<String, dynamic> map) {
    return ReceiptReviewModel(
      paid_method: map['paid_method'] as int,
      rec_by: map['rec_by'] as String,
      rec_date: map['rec_date'] as String,
      rec_site: map['rec_site'] as String,
      paid_method_func: map['paid_method_func'] as String,
      paid_method_th: map['paid_method_th'] as String,
      paid_method_sub_th: map['paid_method_sub_th'] as String,
      c_num: map['c_num'] != null ? map['c_num'] as int : null,
      opd_paid: map['opd_paid'] as String,
      ipd_paid: map['ipd_paid'] as String,
      paid: map['paid'] as String,
      paid_go: map['paid_go'] as String,
      grpdsp: map['grpdsp'] != null ? map['grpdsp'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceiptReviewModel.fromJson(String source) => ReceiptReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReceiptReviewModel(paid_method: $paid_method, rec_by: $rec_by, rec_date: $rec_date, rec_site: $rec_site, paid_method_func: $paid_method_func, paid_method_th: $paid_method_th, paid_method_sub_th: $paid_method_sub_th, c_num: $c_num, opd_paid: $opd_paid, ipd_paid: $ipd_paid, paid: $paid, paid_go: $paid_go, grpdsp: $grpdsp)';
  }

  @override
  bool operator ==(covariant ReceiptReviewModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.paid_method == paid_method &&
      other.rec_by == rec_by &&
      other.rec_date == rec_date &&
      other.rec_site == rec_site &&
      other.paid_method_func == paid_method_func &&
      other.paid_method_th == paid_method_th &&
      other.paid_method_sub_th == paid_method_sub_th &&
      other.c_num == c_num &&
      other.opd_paid == opd_paid &&
      other.ipd_paid == ipd_paid &&
      other.paid == paid &&
      other.paid_go == paid_go &&
      other.grpdsp == grpdsp;
  }

  @override
  int get hashCode {
    return paid_method.hashCode ^
      rec_by.hashCode ^
      rec_date.hashCode ^
      rec_site.hashCode ^
      paid_method_func.hashCode ^
      paid_method_th.hashCode ^
      paid_method_sub_th.hashCode ^
      c_num.hashCode ^
      opd_paid.hashCode ^
      ipd_paid.hashCode ^
      paid.hashCode ^
      paid_go.hashCode ^
      grpdsp.hashCode;
  }
}
