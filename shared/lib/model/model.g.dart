// GENERATED CODE - DO NOT MODIFY BY HAND

part of model;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image()
    ..id = json['id'] as String
    ..data = json['data'] as String
    ..multiply = (json['multiply'] as num).toDouble()
    ..width = json['width'] as int
    ..height = json['height'] as int
    ..top = json['top'] as int
    ..left = json['left'] as int
    ..name = json['name'] as String
    ..type = _$enumDecode(_$ImageTypeEnumMap, json['type'])
    ..authorEmail = json['authorEmail'] as String
    ..origin = json['origin'] as String
    ..created = DateTime.parse(json['created'] as String)
    ..tags = (json['tags'] as List).map((e) => e as String).toList();
}

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'multiply': instance.multiply,
      'width': instance.width,
      'height': instance.height,
      'top': instance.top,
      'left': instance.left,
      'name': instance.name,
      'type': _$ImageTypeEnumMap[instance.type],
      'authorEmail': instance.authorEmail,
      'origin': instance.origin,
      'created': instance.created.toIso8601String(),
      'tags': instance.tags
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

const _$ImageTypeEnumMap = <ImageType, dynamic>{
  ImageType.field: 'field',
  ImageType.unitIcon: 'unitIcon',
  ImageType.unitBase: 'unitBase',
  ImageType.unitHighRes: 'unitHighRes',
  ImageType.item: 'item',
  ImageType.taleFullScreen: 'taleFullScreen',
  ImageType.taleBottomScreen: 'taleBottomScreen'
};

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
