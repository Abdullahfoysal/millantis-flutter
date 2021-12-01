import 'package:json_annotation/json_annotation.dart';

part 'UserTable.g.dart';

@JsonSerializable()
class UserTable {
  UserTable();

  String? name;
  String? address;
  String? rank;
  String? playTime;
  String? type;
  String? bestScore;
  factory UserTable.fromJson(Map<String, dynamic> json) =>
      _$UserTableFromJson(json);

  toJson() => _$UserTableToJson(this);
}
