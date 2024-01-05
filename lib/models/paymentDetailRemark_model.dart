// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentDetailRemarkModel {
  String tlpayment_d_remark_id;
  String tlpayment_detail_id;
  String tlpayment_id;
  String tlpayment_d_remark_bank;
  String tlpayment_d_remark_date;
  String tlpayment_d_remark_time;
  String tlpayment_d_remark_amount;
  String tlpayment_d_remark_comment;
  PaymentDetailRemarkModel({
    required this.tlpayment_d_remark_id,
    required this.tlpayment_detail_id,
    required this.tlpayment_id,
    required this.tlpayment_d_remark_bank,
    required this.tlpayment_d_remark_date,
    required this.tlpayment_d_remark_time,
    required this.tlpayment_d_remark_amount,
    required this.tlpayment_d_remark_comment,
  });

  PaymentDetailRemarkModel copyWith({
    String? tlpayment_d_remark_id,
    String? tlpayment_detail_id,
    String? tlpayment_id,
    String? tlpayment_d_remark_bank,
    String? tlpayment_d_remark_date,
    String? tlpayment_d_remark_time,
    String? tlpayment_d_remark_amount,
    String? tlpayment_d_remark_comment,
  }) {
    return PaymentDetailRemarkModel(
      tlpayment_d_remark_id: tlpayment_d_remark_id ?? this.tlpayment_d_remark_id,
      tlpayment_detail_id: tlpayment_detail_id ?? this.tlpayment_detail_id,
      tlpayment_id: tlpayment_id ?? this.tlpayment_id,
      tlpayment_d_remark_bank: tlpayment_d_remark_bank ?? this.tlpayment_d_remark_bank,
      tlpayment_d_remark_date: tlpayment_d_remark_date ?? this.tlpayment_d_remark_date,
      tlpayment_d_remark_time: tlpayment_d_remark_time ?? this.tlpayment_d_remark_time,
      tlpayment_d_remark_amount: tlpayment_d_remark_amount ?? this.tlpayment_d_remark_amount,
      tlpayment_d_remark_comment: tlpayment_d_remark_comment ?? this.tlpayment_d_remark_comment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlpayment_d_remark_id': tlpayment_d_remark_id,
      'tlpayment_detail_id': tlpayment_detail_id,
      'tlpayment_id': tlpayment_id,
      'tlpayment_d_remark_bank': tlpayment_d_remark_bank,
      'tlpayment_d_remark_date': tlpayment_d_remark_date,
      'tlpayment_d_remark_time': tlpayment_d_remark_time,
      'tlpayment_d_remark_amount': tlpayment_d_remark_amount,
      'tlpayment_d_remark_comment': tlpayment_d_remark_comment,
    };
  }

  factory PaymentDetailRemarkModel.fromMap(Map<String, dynamic> map) {
    return PaymentDetailRemarkModel(
      tlpayment_d_remark_id: map['tlpayment_d_remark_id'] as String,
      tlpayment_detail_id: map['tlpayment_detail_id'] as String,
      tlpayment_id: map['tlpayment_id'] as String,
      tlpayment_d_remark_bank: map['tlpayment_d_remark_bank'] as String,
      tlpayment_d_remark_date: map['tlpayment_d_remark_date'] as String,
      tlpayment_d_remark_time: map['tlpayment_d_remark_time'] as String,
      tlpayment_d_remark_amount: map['tlpayment_d_remark_amount'] as String,
      tlpayment_d_remark_comment: map['tlpayment_d_remark_comment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentDetailRemarkModel.fromJson(String source) => PaymentDetailRemarkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentDetailRemarkModel(tlpayment_d_remark_id: $tlpayment_d_remark_id, tlpayment_detail_id: $tlpayment_detail_id, tlpayment_id: $tlpayment_id, tlpayment_d_remark_bank: $tlpayment_d_remark_bank, tlpayment_d_remark_date: $tlpayment_d_remark_date, tlpayment_d_remark_time: $tlpayment_d_remark_time, tlpayment_d_remark_amount: $tlpayment_d_remark_amount, tlpayment_d_remark_comment: $tlpayment_d_remark_comment)';
  }

  @override
  bool operator ==(covariant PaymentDetailRemarkModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlpayment_d_remark_id == tlpayment_d_remark_id &&
      other.tlpayment_detail_id == tlpayment_detail_id &&
      other.tlpayment_id == tlpayment_id &&
      other.tlpayment_d_remark_bank == tlpayment_d_remark_bank &&
      other.tlpayment_d_remark_date == tlpayment_d_remark_date &&
      other.tlpayment_d_remark_time == tlpayment_d_remark_time &&
      other.tlpayment_d_remark_amount == tlpayment_d_remark_amount &&
      other.tlpayment_d_remark_comment == tlpayment_d_remark_comment;
  }

  @override
  int get hashCode {
    return tlpayment_d_remark_id.hashCode ^
      tlpayment_detail_id.hashCode ^
      tlpayment_id.hashCode ^
      tlpayment_d_remark_bank.hashCode ^
      tlpayment_d_remark_date.hashCode ^
      tlpayment_d_remark_time.hashCode ^
      tlpayment_d_remark_amount.hashCode ^
      tlpayment_d_remark_comment.hashCode;
  }
}
