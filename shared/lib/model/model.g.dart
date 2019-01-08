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

FieldCreateEnvelope _$FieldCreateEnvelopeFromJson(Map<String, dynamic> json) {
  return FieldCreateEnvelope()
    ..id = json['id'] as String
    ..terrainId = json['terrainId'] as int
    ..x = json['x'] as int
    ..y = json['y'] as int;
}

Map<String, dynamic> _$FieldCreateEnvelopeToJson(
        FieldCreateEnvelope instance) =>
    <String, dynamic>{
      'id': instance.id,
      'terrainId': instance.terrainId,
      'x': instance.x,
      'y': instance.y
    };

WorldCreateEnvelope _$WorldCreateEnvelopeFromJson(Map<String, dynamic> json) {
  return WorldCreateEnvelope()
    ..width = json['width'] as int
    ..height = json['height'] as int
    ..baseTerrainId =
        _$enumDecodeNullable(_$TerrainEnumMap, json['baseTerrainId'])
    ..fields = (json['fields'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        k,
        e == null
            ? null
            : FieldCreateEnvelope.fromJson(e as Map<String, dynamic>)))
    ..startField = json['startField'] as String;
}

Map<String, dynamic> _$WorldCreateEnvelopeToJson(
        WorldCreateEnvelope instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'baseTerrainId': _$TerrainEnumMap[instance.baseTerrainId],
      'fields': instance.fields,
      'startField': instance.startField
    };

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$TerrainEnumMap = <Terrain, dynamic>{
  Terrain.grass: 'grass',
  Terrain.rock: 'rock',
  Terrain.water: 'water',
  Terrain.forest: 'forest'
};

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player()
    ..id = json['id'] as String
    ..name = (json['name'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..team = json['team'] as String
    ..handler = _$enumDecodeNullable(_$PlayerHandlerEnumMap, json['handler'])
    ..color = json['color'] as String;
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'team': instance.team,
      'handler': _$PlayerHandlerEnumMap[instance.handler],
      'color': instance.color
    };

const _$LangEnumMap = <Lang, dynamic>{Lang.en: 'en', Lang.cz: 'cz'};

const _$PlayerHandlerEnumMap = <PlayerHandler, dynamic>{
  PlayerHandler.firstHuman: 'firstHuman',
  PlayerHandler.ai: 'ai',
  PlayerHandler.passive: 'passive',
  PlayerHandler.everyHuman: 'everyHuman'
};

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(json['name'] as String)
    ..triggers = (json['triggers'] as List)
        ?.map((e) =>
            e == null ? null : Trigger.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$EventToJson(Event instance) =>
    <String, dynamic>{'name': instance.name, 'triggers': instance.triggers};

Trigger _$TriggerFromJson(Map<String, dynamic> json) {
  return Trigger()
    ..event = json['event'] == null
        ? null
        : Call.fromJson(json['event'] as Map<String, dynamic>)
    ..action = json['action'] == null
        ? null
        : Call.fromJson(json['action'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TriggerToJson(Trigger instance) =>
    <String, dynamic>{'event': instance.event, 'action': instance.action};

Dialog _$DialogFromJson(Map<String, dynamic> json) {
  return Dialog()
    ..name = json['name'] as String
    ..image = json['image'] == null
        ? null
        : Call.fromJson(json['image'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DialogToJson(Dialog instance) =>
    <String, dynamic>{'name': instance.name, 'image': instance.image};

Call _$CallFromJson(Map<String, dynamic> json) {
  return Call()
    ..name = json['name'] as String
    ..arguments = json['arguments'] as List;
}

Map<String, dynamic> _$CallToJson(Call instance) =>
    <String, dynamic>{'name': instance.name, 'arguments': instance.arguments};

TaleCreateEnvelope _$TaleCreateEnvelopeFromJson(Map<String, dynamic> json) {
  return TaleCreateEnvelope()
    ..authorEmail = json['authorEmail'] as String
    ..tale = json['tale'] == null
        ? null
        : TaleInnerEnvelope.fromJson(json['tale'] as Map<String, dynamic>)
    ..lobby = json['lobby'] == null
        ? null
        : LobbyTale.fromJson(json['lobby'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TaleCreateEnvelopeToJson(TaleCreateEnvelope instance) =>
    <String, dynamic>{
      'authorEmail': instance.authorEmail,
      'tale': instance.tale,
      'lobby': instance.lobby
    };

TaleInnerEnvelope _$TaleInnerEnvelopeFromJson(Map<String, dynamic> json) {
  return TaleInnerEnvelope()
    ..id = json['id'] as String
    ..langs = (json['langs'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        _$enumDecodeNullable(_$LangEnumMap, k),
        (e as Map<String, dynamic>)?.map((k, e) => MapEntry(k, e as String))))
    ..taleVersion = json['taleVersion'] as int
    ..world = json['world'] == null
        ? null
        : WorldCreateEnvelope.fromJson(json['world'] as Map<String, dynamic>)
    ..players = (json['players'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(
            k, e == null ? null : Player.fromJson(e as Map<String, dynamic>)))
    ..events = (json['events'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        k, e == null ? null : Event.fromJson(e as Map<String, dynamic>)))
    ..dialogs = (json['dialogs'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(
            k, e == null ? null : Dialog.fromJson(e as Map<String, dynamic>)))
    ..units = (json['units'] as Map<String, dynamic>)
        ?.map((k, e) => MapEntry(k, e as String));
}

Map<String, dynamic> _$TaleInnerEnvelopeToJson(TaleInnerEnvelope instance) =>
    <String, dynamic>{
      'id': instance.id,
      'langs': instance.langs?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'taleVersion': instance.taleVersion,
      'world': instance.world,
      'players': instance.players,
      'events': instance.events,
      'dialogs': instance.dialogs,
      'units': instance.units
    };

LobbyTale _$LobbyTaleFromJson(Map<String, dynamic> json) {
  return LobbyTale()
    ..id = json['id'] as String
    ..name = (json['name'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..description = (json['description'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..image = json['image'] as String;
}

Map<String, dynamic> _$LobbyTaleToJson(LobbyTale instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'description':
          instance.description?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'image': instance.image
    };
