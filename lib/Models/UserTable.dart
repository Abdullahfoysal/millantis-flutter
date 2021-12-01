import 'package:json_annotation/json_annotation.dart';

part 'UserTable.g.dart';

@JsonSerializable()
class UserTable {
  UserTable();

  int? id;
  String? name;
  String? address;
  String? rank;
  String? playTime;
  String? type;
  String? bestScore;

  factory UserTable.fromJson(Map<String, dynamic> json) =>
      _$UserTableFromJson(json);

  toJson() => _$UserTableToJson(this);

  fromJsonList(var userList) {
    return (userList as List).map((e) => UserTable.fromJson(e)).toList();
  }
}
