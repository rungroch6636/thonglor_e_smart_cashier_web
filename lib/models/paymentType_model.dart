// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentTypeModel {
  String tlpayment_type_id;
  String tlpayment_type;
  PaymentTypeModel({
    required this.tlpayment_type_id,
    required this.tlpayment_type,
  });

  PaymentTypeModel copyWith({
    String? tlpayment_type_id,
    String? tlpayment_type,
  }) {
    return PaymentTypeModel(
      tlpayment_type_id: tlpayment_type_id ?? this.tlpayment_type_id,
      tlpayment_type: tlpayment_type ?? this.tlpayment_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tlpayment_type_id': tlpayment_type_id,
      'tlpayment_type': tlpayment_type,
    };
  }

  factory PaymentTypeModel.fromMap(Map<String, dynamic> map) {
    return PaymentTypeModel(
      tlpayment_type_id: map['tlpayment_type_id'] as String,
      tlpayment_type: map['tlpayment_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentTypeModel.fromJson(String source) => PaymentTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PaymentTypeModel(tlpayment_type_id: $tlpayment_type_id, tlpayment_type: $tlpayment_type)';

  @override
  bool operator ==(covariant PaymentTypeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tlpayment_type_id == tlpayment_type_id &&
      other.tlpayment_type == tlpayment_type;
  }

  @override
  int get hashCode => tlpayment_type_id.hashCode ^ tlpayment_type.hashCode;
}
