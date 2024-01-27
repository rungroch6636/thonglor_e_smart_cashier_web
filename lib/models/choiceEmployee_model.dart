// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChoiceEmployeeModel {
  String employeeId;
  String empFullname;
  String paymentId;
  ChoiceEmployeeModel({
    required this.employeeId,
    required this.empFullname,
    required this.paymentId,
  });

  ChoiceEmployeeModel copyWith({
    String? employeeId,
    String? empFullname,
    String? paymentId,
  }) {
    return ChoiceEmployeeModel(
      employeeId: employeeId ?? this.employeeId,
      empFullname: empFullname ?? this.empFullname,
      paymentId: paymentId ?? this.paymentId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeId': employeeId,
      'empFullname': empFullname,
      'paymentId': paymentId,
    };
  }

  factory ChoiceEmployeeModel.fromMap(Map<String, dynamic> map) {
    return ChoiceEmployeeModel(
      employeeId: map['employeeId'] as String,
      empFullname: map['empFullname'] as String,
      paymentId: map['paymentId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChoiceEmployeeModel.fromJson(String source) => ChoiceEmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChoiceEmployeeModel(employeeId: $employeeId, empFullname: $empFullname, paymentId: $paymentId)';

  @override
  bool operator ==(covariant ChoiceEmployeeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.employeeId == employeeId &&
      other.empFullname == empFullname &&
      other.paymentId == paymentId;
  }

  @override
  int get hashCode => employeeId.hashCode ^ empFullname.hashCode ^ paymentId.hashCode;
}
