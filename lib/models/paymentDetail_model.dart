// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentDetailModel {
  String tlpayment_detail_id;
  String tlpayment_id;
  //String paid_method;
  String tlpayment_type_id; //paid_method_func;
  String tlpayment_type; //paid_method_th;
  String tlpayment_type_detail_id; //c_num;
  String tlpayment_type_detail; //paid_method_sub_th;
  String opd_paid;
  String ipd_paid;
  String paid;
  String paid_go;
  String prpdsp;
  String tlpayment_detail_site_id;
  String tlpayment_detail_actual_paid;
  String tlpayment_detail_diff_paid;
  String tlpayment_detail_comment;
  PaymentDetailModel({
    required this.tlpayment_detail_id,
    required this.tlpayment_id,
    required this.tlpayment_type_id,
    required this.tlpayment_type,
    required this.tlpayment_type_detail_id,
    required this.tlpayment_type_detail,
    required this.opd_paid,
    required this.ipd_paid,
    required this.paid,
    required this.paid_go,
    required this.prpdsp,
    required this.tlpayment_detail_site_id,
    required this.tlpayment_detail_actual_paid,
    required this.tlpayment_detail_diff_paid,
    required this.tlpayment_detail_comment,
  });

  PaymentDetailModel copyWith({
    String? tlpayment_detail_id,
    String? tlpayment_id,
    String? tlpayment_type_id,
    String? tlpayment_type,
    String? tlpayment_type_detail_id,
    String? tlpayment_type_detail,
    String? opd_paid,
    String? ipd_paid,
    String? paid,
    String? paid_go,
    String? prpdsp,
    String? tlpayment_detail_site_id,
    String? tlpayment_detail_actual_paid,
    String? tlpayment_detail_diff_paid,
    String? tlpayment_detail_comment,
  }) {
    return PaymentDetailModel(
      tlpayment_detail_id: tlpayment_detail_id ?? this.tlpayment_detail_id,
      tlpayment_id: tlpayment_id ?? this.tlpayment_id,
      tlpayment_type_id: tlpayment_type_id ?? this.tlpayment_type_id,
      tlpayment_type: tlpayment_type ?? this.tlpayment_type,
      tlpayment_type_detail_id: tlpayment_type_detail_id ?? this.tlpayment_type_detail_id,
      tlpayment_type_detail: tlpayment_type_detail ?? this.tlpayment_type_detail,
      opd_paid: opd_paid ?? this.opd_paid,
      ipd_paid: ipd_paid ?? this.ipd_paid,
      paid: paid ?? this.paid,
      paid_go: paid_go ?? this.paid_go,
      prpdsp: prpdsp ?? this.prpdsp,
      tlpayment_detail_site_id: tlpayment_detail_site_id ?? this.tlpayment_detail_site_id,
      tlpayment_detail_actual_paid: tlpayment_detail_actual_paid ?? this.tlpayment_detail_actual_paid,
      tlpayment_detail_diff_paid: tlpayment_detail_diff_paid ?? this.tlpayment_detail_diff_paid,
      tlpayment_detail_comment: tlpayment_detail_comment ?? this.tlpayment_detail_comment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlpayment_detail_id': tlpayment_detail_id,
      'tlpayment_id': tlpayment_id,
      'tlpayment_type_id': tlpayment_type_id,
      'tlpayment_type': tlpayment_type,
      'tlpayment_type_detail_id': tlpayment_type_detail_id,
      'tlpayment_type_detail': tlpayment_type_detail,
      'opd_paid': opd_paid,
      'ipd_paid': ipd_paid,
      'paid': paid,
      'paid_go': paid_go,
      'prpdsp': prpdsp,
      'tlpayment_detail_site_id': tlpayment_detail_site_id,
      'tlpayment_detail_actual_paid': tlpayment_detail_actual_paid,
      'tlpayment_detail_diff_paid': tlpayment_detail_diff_paid,
      'tlpayment_detail_comment': tlpayment_detail_comment,
    };
  }

  factory PaymentDetailModel.fromMap(Map<String, dynamic> map) {
    return PaymentDetailModel(
      tlpayment_detail_id: map['tlpayment_detail_id'] as String,
      tlpayment_id: map['tlpayment_id'] as String,
      tlpayment_type_id: map['tlpayment_type_id'] as String,
      tlpayment_type: map['tlpayment_type'] as String,
      tlpayment_type_detail_id: map['tlpayment_type_detail_id'] as String,
      tlpayment_type_detail: map['tlpayment_type_detail'] as String,
      opd_paid: map['opd_paid'] as String,
      ipd_paid: map['ipd_paid'] as String,
      paid: map['paid'] as String,
      paid_go: map['paid_go'] as String,
      prpdsp: map['prpdsp'] as String,
      tlpayment_detail_site_id: map['tlpayment_detail_site_id'] as String,
      tlpayment_detail_actual_paid: map['tlpayment_detail_actual_paid'] as String,
      tlpayment_detail_diff_paid: map['tlpayment_detail_diff_paid'] as String,
      tlpayment_detail_comment: map['tlpayment_detail_comment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentDetailModel.fromJson(String source) => PaymentDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentDetailModel(tlpayment_detail_id: $tlpayment_detail_id, tlpayment_id: $tlpayment_id, tlpayment_type_id: $tlpayment_type_id, tlpayment_type: $tlpayment_type, tlpayment_type_detail_id: $tlpayment_type_detail_id, tlpayment_type_detail: $tlpayment_type_detail, opd_paid: $opd_paid, ipd_paid: $ipd_paid, paid: $paid, paid_go: $paid_go, prpdsp: $prpdsp, tlpayment_detail_site_id: $tlpayment_detail_site_id, tlpayment_detail_actual_paid: $tlpayment_detail_actual_paid, tlpayment_detail_diff_paid: $tlpayment_detail_diff_paid, tlpayment_detail_comment: $tlpayment_detail_comment)';
  }

  @override
  bool operator ==(covariant PaymentDetailModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlpayment_detail_id == tlpayment_detail_id &&
      other.tlpayment_id == tlpayment_id &&
      other.tlpayment_type_id == tlpayment_type_id &&
      other.tlpayment_type == tlpayment_type &&
      other.tlpayment_type_detail_id == tlpayment_type_detail_id &&
      other.tlpayment_type_detail == tlpayment_type_detail &&
      other.opd_paid == opd_paid &&
      other.ipd_paid == ipd_paid &&
      other.paid == paid &&
      other.paid_go == paid_go &&
      other.prpdsp == prpdsp &&
      other.tlpayment_detail_site_id == tlpayment_detail_site_id &&
      other.tlpayment_detail_actual_paid == tlpayment_detail_actual_paid &&
      other.tlpayment_detail_diff_paid == tlpayment_detail_diff_paid &&
      other.tlpayment_detail_comment == tlpayment_detail_comment;
  }

  @override
  int get hashCode {
    return tlpayment_detail_id.hashCode ^
      tlpayment_id.hashCode ^
      tlpayment_type_id.hashCode ^
      tlpayment_type.hashCode ^
      tlpayment_type_detail_id.hashCode ^
      tlpayment_type_detail.hashCode ^
      opd_paid.hashCode ^
      ipd_paid.hashCode ^
      paid.hashCode ^
      paid_go.hashCode ^
      prpdsp.hashCode ^
      tlpayment_detail_site_id.hashCode ^
      tlpayment_detail_actual_paid.hashCode ^
      tlpayment_detail_diff_paid.hashCode ^
      tlpayment_detail_comment.hashCode;
  }
}
