import 'package:json_annotation/json_annotation.dart';

part 'EmployeeModel.g.dart';

@JsonSerializable()
class EmployeeModel {
  EmployeeModel();

  String? name;
  int? age;
  String? school;
  String? college;
  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  fromJsonList(var employeeList) {
    return (employeeList as List)
        .map((e) => EmployeeModel.fromJson(e))
        .toList();
  }
}
