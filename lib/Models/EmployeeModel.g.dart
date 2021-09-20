// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmployeeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) {
  return EmployeeModel()
    ..EmpID = json['EmpID'] as int?
    ..Name = json['Name'] as String?
    ..EmpCode = json['EmpCode'] as String?
    ..Salary = json['Salary'] as int?;
}

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'EmpID': instance.EmpID,
      'Name': instance.Name,
      'EmpCode': instance.EmpCode,
      'Salary': instance.Salary,
    };
