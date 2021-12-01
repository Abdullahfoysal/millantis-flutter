// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserTable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTable _$UserTableFromJson(Map<String, dynamic> json) {
  return UserTable()
    ..name = json['name'] as String?
    ..address = json['address'] as String?
    ..rank = json['rank'] as String?
    ..playTime = json['playTime'] as String?
    ..type = json['type'] as String?
    ..bestScore = json['bestScore'] as String?;
}

Map<String, dynamic> _$UserTableToJson(UserTable instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'rank': instance.rank,
      'playTime': instance.playTime,
      'type': instance.type,
      'bestScore': instance.bestScore,
    };
