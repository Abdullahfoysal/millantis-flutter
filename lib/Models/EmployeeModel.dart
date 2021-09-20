import 'package:json_annotation/json_annotation.dart';

part 'EmployeeModel.g.dart';

@JsonSerializable()
class EmployeeModel {
  EmployeeModel();
  int? EmpID;
  String? Name;
  String? EmpCode;
  int? Salary;
  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);
}
