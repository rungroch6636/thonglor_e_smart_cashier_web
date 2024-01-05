// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentApprovalModel {

String tlpayment_approval_id;
String tlpayment_id;
String emp_id_approver;
String emp_id_request;
String tlpayment_approve_date;
String tlpayment_approve_time;
String tlpayment_request_date;
String tlpayment_request_time;
String tlpayment_approve_status;
  PaymentApprovalModel({
    required this.tlpayment_approval_id,
    required this.tlpayment_id,
    required this.emp_id_approver,
    required this.emp_id_request,
    required this.tlpayment_approve_date,
    required this.tlpayment_approve_time,
    required this.tlpayment_request_date,
    required this.tlpayment_request_time,
    required this.tlpayment_approve_status,
  });


  PaymentApprovalModel copyWith({
    String? tlpayment_approval_id,
    String? tlpayment_id,
    String? emp_id_approver,
    String? emp_id_request,
    String? tlpayment_approve_date,
    String? tlpayment_approve_time,
    String? tlpayment_request_date,
    String? tlpayment_request_time,
    String? tlpayment_approve_status,
  }) {
    return PaymentApprovalModel(
      tlpayment_approval_id: tlpayment_approval_id ?? this.tlpayment_approval_id,
      tlpayment_id: tlpayment_id ?? this.tlpayment_id,
      emp_id_approver: emp_id_approver ?? this.emp_id_approver,
      emp_id_request: emp_id_request ?? this.emp_id_request,
      tlpayment_approve_date: tlpayment_approve_date ?? this.tlpayment_approve_date,
      tlpayment_approve_time: tlpayment_approve_time ?? this.tlpayment_approve_time,
      tlpayment_request_date: tlpayment_request_date ?? this.tlpayment_request_date,
      tlpayment_request_time: tlpayment_request_time ?? this.tlpayment_request_time,
      tlpayment_approve_status: tlpayment_approve_status ?? this.tlpayment_approve_status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlpayment_approval_id': tlpayment_approval_id,
      'tlpayment_id': tlpayment_id,
      'emp_id_approver': emp_id_approver,
      'emp_id_request': emp_id_request,
      'tlpayment_approve_date': tlpayment_approve_date,
      'tlpayment_approve_time': tlpayment_approve_time,
      'tlpayment_request_date': tlpayment_request_date,
      'tlpayment_request_time': tlpayment_request_time,
      'tlpayment_approve_status': tlpayment_approve_status,
    };
  }

  factory PaymentApprovalModel.fromMap(Map<String, dynamic> map) {
    return PaymentApprovalModel(
      tlpayment_approval_id: map['tlpayment_approval_id'] as String,
      tlpayment_id: map['tlpayment_id'] as String,
      emp_id_approver: map['emp_id_approver'] as String,
      emp_id_request: map['emp_id_request'] as String,
      tlpayment_approve_date: map['tlpayment_approve_date'] as String,
      tlpayment_approve_time: map['tlpayment_approve_time'] as String,
      tlpayment_request_date: map['tlpayment_request_date'] as String,
      tlpayment_request_time: map['tlpayment_request_time'] as String,
      tlpayment_approve_status: map['tlpayment_approve_status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentApprovalModel.fromJson(String source) => PaymentApprovalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentApprovalModel(tlpayment_approval_id: $tlpayment_approval_id, tlpayment_id: $tlpayment_id, emp_id_approver: $emp_id_approver, emp_id_request: $emp_id_request, tlpayment_approve_date: $tlpayment_approve_date, tlpayment_approve_time: $tlpayment_approve_time, tlpayment_request_date: $tlpayment_request_date, tlpayment_request_time: $tlpayment_request_time, tlpayment_approve_status: $tlpayment_approve_status)';
  }

  @override
  bool operator ==(covariant PaymentApprovalModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlpayment_approval_id == tlpayment_approval_id &&
      other.tlpayment_id == tlpayment_id &&
      other.emp_id_approver == emp_id_approver &&
      other.emp_id_request == emp_id_request &&
      other.tlpayment_approve_date == tlpayment_approve_date &&
      other.tlpayment_approve_time == tlpayment_approve_time &&
      other.tlpayment_request_date == tlpayment_request_date &&
      other.tlpayment_request_time == tlpayment_request_time &&
      other.tlpayment_approve_status == tlpayment_approve_status;
  }

  @override
  int get hashCode {
    return tlpayment_approval_id.hashCode ^
      tlpayment_id.hashCode ^
      emp_id_approver.hashCode ^
      emp_id_request.hashCode ^
      tlpayment_approve_date.hashCode ^
      tlpayment_approve_time.hashCode ^
      tlpayment_request_date.hashCode ^
      tlpayment_request_time.hashCode ^
      tlpayment_approve_status.hashCode;
  }
}
