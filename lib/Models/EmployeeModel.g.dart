// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmployeeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) {
  return EmployeeModel()
    ..name = json['name'] as String?
    ..age = json['age'] as int?
    ..school = json['school'] as String?
    ..college = json['college'] as String?;
}

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'school': instance.school,
      'college': instance.college,
    };
