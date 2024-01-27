// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReceiptModel {
  
  int paid_method;
  String paid_method_func;
  String paid_method_th;
  String paid_method_sub_th;
  int? c_num;
  String opd_paid;
  String ipd_paid;
  String paid;
  String paid_go;
  int? grpdsp;
  ReceiptModel({
    required this.paid_method,
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

  ReceiptModel copyWith({
    int? paid_method,
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
    return ReceiptModel(
      paid_method: paid_method ?? this.paid_method,
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

  factory ReceiptModel.fromMap(Map<String, dynamic> map) {
    return ReceiptModel(
      paid_method: map['paid_method'] as int,
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

  factory ReceiptModel.fromJson(String source) =>
      ReceiptModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReceiptModel(paid_method: $paid_method, paid_method_func: $paid_method_func, paid_method_th: $paid_method_th, paid_method_sub_th: $paid_method_sub_th, c_num: $c_num, opd_paid: $opd_paid, ipd_paid: $ipd_paid, paid: $paid, paid_go: $paid_go, grpdsp: $grpdsp)';
  }

  @override
  bool operator ==(covariant ReceiptModel other) {
    if (identical(this, other)) return true;

    return other.paid_method == paid_method &&
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
