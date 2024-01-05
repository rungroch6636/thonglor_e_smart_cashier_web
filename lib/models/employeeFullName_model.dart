// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmployeeFullNameModel {
  String employee_id;
  String emp_fullname;
  String site_id;
  String bsp_id;
  String bsp_name;
  String fix_employee_type_id;
  EmployeeFullNameModel({
    required this.employee_id,
    required this.emp_fullname,
    required this.site_id,
    required this.bsp_id,
    required this.bsp_name,
    required this.fix_employee_type_id,
  });

  EmployeeFullNameModel copyWith({
    String? employee_id,
    String? emp_fullname,
    String? site_id,
    String? bsp_id,
    String? bsp_name,
    String? fix_employee_type_id,
  }) {
    return EmployeeFullNameModel(
      employee_id: employee_id ?? this.employee_id,
      emp_fullname: emp_fullname ?? this.emp_fullname,
      site_id: site_id ?? this.site_id,
      bsp_id: bsp_id ?? this.bsp_id,
      bsp_name: bsp_name ?? this.bsp_name,
      fix_employee_type_id: fix_employee_type_id ?? this.fix_employee_type_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employee_id': employee_id,
      'emp_fullname': emp_fullname,
      'site_id': site_id,
      'bsp_id': bsp_id,
      'bsp_name': bsp_name,
      'fix_employee_type_id': fix_employee_type_id,
    };
  }

  factory EmployeeFullNameModel.fromMap(Map<String, dynamic> map) {
    return EmployeeFullNameModel(
      employee_id: map['employee_id'] as String,
      emp_fullname: map['emp_fullname'] as String,
      site_id: map['site_id'] as String,
      bsp_id: map['bsp_id'] as String,
      bsp_name: map['bsp_name'] as String,
      fix_employee_type_id: map['fix_employee_type_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeFullNameModel.fromJson(String source) => EmployeeFullNameModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmployeeFullNameModel(employee_id: $employee_id, emp_fullname: $emp_fullname, site_id: $site_id, bsp_id: $bsp_id, bsp_name: $bsp_name, fix_employee_type_id: $fix_employee_type_id)';
  }

  @override
  bool operator ==(covariant EmployeeFullNameModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.employee_id == employee_id &&
      other.emp_fullname == emp_fullname &&
      other.site_id == site_id &&
      other.bsp_id == bsp_id &&
      other.bsp_name == bsp_name &&
      other.fix_employee_type_id == fix_employee_type_id;
  }

  @override
  int get hashCode {
    return employee_id.hashCode ^
      emp_fullname.hashCode ^
      site_id.hashCode ^
      bsp_id.hashCode ^
      bsp_name.hashCode ^
      fix_employee_type_id.hashCode;
  }
}
