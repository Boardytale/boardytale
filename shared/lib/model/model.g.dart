// GENERATED CODE - DO NOT MODIFY BY HAND

part of model;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
