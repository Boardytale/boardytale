// GENERATED CODE - DO NOT MODIFY BY HAND

part of model;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image()
    ..name = json['name'] as String
    ..data = json['data'] as String
    ..multiply = (json['multiply'] as num).toDouble()
    ..width = json['width'] as int
    ..height = json['height'] as int
    ..top = json['top'] as int
    ..left = json['left'] as int
    ..type = _$enumDecode(_$ImageTypeEnumMap, json['type'])
    ..authorEmail = json['authorEmail'] as String
    ..imageVersion = json['imageVersion'] as int
    ..dataModelVersion = json['dataModelVersion'] as int
    ..origin = json['origin'] as String
    ..created = DateTime.parse(json['created'] as String)
    ..tags = (json['tags'] as List)
        .map((e) => _$enumDecode(_$ImageTagEnumMap, e))
        .toList();
}

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'name': instance.name,
      'data': instance.data,
      'multiply': instance.multiply,
      'width': instance.width,
      'height': instance.height,
      'top': instance.top,
      'left': instance.left,
      'type': _$ImageTypeEnumMap[instance.type],
      'authorEmail': instance.authorEmail,
      'imageVersion': instance.imageVersion,
      'dataModelVersion': instance.dataModelVersion,
      'origin': instance.origin,
      'created': instance.created.toIso8601String(),
      'tags': instance.tags.map((e) => _$ImageTagEnumMap[e]).toList()
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

const _$ImageTagEnumMap = <ImageTag, dynamic>{ImageTag.grass: 'grass'};

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..innerToken = json['innerToken'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'innerToken': instance.innerToken
    };

UnitTypeCreateEnvelope _$UnitTypeCreateEnvelopeFromJson(
    Map<String, dynamic> json) {
  return UnitTypeCreateEnvelope()
    ..name = json['name'] as String
    ..race = _$enumDecodeNullable(_$RacesEnumMap, json['race'])
    ..tags = (json['tags'] as List)
        ?.map((e) => _$enumDecodeNullable(_$UnitTypeTagEnumMap, e))
        ?.toList()
    ..health = json['health'] as int
    ..armor = json['armor'] as int
    ..speed = json['speed'] as int
    ..range = json['range'] as int
    ..actions = json['actions'] as int
    ..attack = json['attack'] as String
    ..cost = json['cost'] as int
    ..langName = (json['langName'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..unitTypeDataVersion = json['unitTypeDataVersion'] as int
    ..unitTypeVersion = json['unitTypeVersion'] as int
    ..abilities = json['abilities'] == null
        ? null
        : AbilitiesEnvelope.fromJson(json['abilities'] as Map<String, dynamic>)
    ..authorEmail = json['authorEmail'] as String
    ..created = json['created'] as String
    ..imageName = json['imageName'] as String
    ..iconName = json['iconName'] as String
    ..bigImageName = json['bigImageName'] as String;
}

Map<String, dynamic> _$UnitTypeCreateEnvelopeToJson(
        UnitTypeCreateEnvelope instance) =>
    <String, dynamic>{
      'name': instance.name,
      'race': _$RacesEnumMap[instance.race],
      'tags': instance.tags?.map((e) => _$UnitTypeTagEnumMap[e])?.toList(),
      'health': instance.health,
      'armor': instance.armor,
      'speed': instance.speed,
      'range': instance.range,
      'actions': instance.actions,
      'attack': instance.attack,
      'cost': instance.cost,
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'unitTypeDataVersion': instance.unitTypeDataVersion,
      'unitTypeVersion': instance.unitTypeVersion,
      'abilities': instance.abilities?.toJson(),
      'authorEmail': instance.authorEmail,
      'created': instance.created,
      'imageName': instance.imageName,
      'iconName': instance.iconName,
      'bigImageName': instance.bigImageName
    };

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$RacesEnumMap = <Races, dynamic>{
  Races.human: 'human',
  Races.undead: 'undead',
  Races.gultam: 'gultam',
  Races.elf: 'elf',
  Races.animal: 'animal'
};

const _$UnitTypeTagEnumMap = <UnitTypeTag, dynamic>{
  UnitTypeTag.undead: 'undead',
  UnitTypeTag.ethernal: 'ethernal',
  UnitTypeTag.mechanic: 'mechanic'
};

const _$LangEnumMap = <Lang, dynamic>{Lang.en: 'en', Lang.cz: 'cz'};

UnitTypeCompiled _$UnitTypeCompiledFromJson(Map<String, dynamic> json) {
  return UnitTypeCompiled()
    ..name = json['name'] as String
    ..race = _$enumDecodeNullable(_$RacesEnumMap, json['race'])
    ..tags = (json['tags'] as List)
        ?.map((e) => _$enumDecodeNullable(_$UnitTypeTagEnumMap, e))
        ?.toList()
    ..health = json['health'] as int
    ..armor = json['armor'] as int
    ..speed = json['speed'] as int
    ..range = json['range'] as int
    ..actions = json['actions'] as int
    ..attack = json['attack'] as String
    ..cost = json['cost'] as int
    ..langName = (json['langName'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..unitTypeDataVersion = json['unitTypeDataVersion'] as int
    ..unitTypeVersion = json['unitTypeVersion'] as int
    ..abilities = json['abilities'] == null
        ? null
        : AbilitiesEnvelope.fromJson(json['abilities'] as Map<String, dynamic>)
    ..authorEmail = json['authorEmail'] as String
    ..image = json['image'] == null
        ? null
        : Image.fromJson(json['image'] as Map<String, dynamic>)
    ..icon = json['icon'] == null
        ? null
        : Image.fromJson(json['icon'] as Map<String, dynamic>)
    ..bigImage = json['bigImage'] == null
        ? null
        : Image.fromJson(json['bigImage'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UnitTypeCompiledToJson(UnitTypeCompiled instance) =>
    <String, dynamic>{
      'name': instance.name,
      'race': _$RacesEnumMap[instance.race],
      'tags': instance.tags?.map((e) => _$UnitTypeTagEnumMap[e])?.toList(),
      'health': instance.health,
      'armor': instance.armor,
      'speed': instance.speed,
      'range': instance.range,
      'actions': instance.actions,
      'attack': instance.attack,
      'cost': instance.cost,
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'unitTypeDataVersion': instance.unitTypeDataVersion,
      'unitTypeVersion': instance.unitTypeVersion,
      'abilities': instance.abilities?.toJson(),
      'authorEmail': instance.authorEmail,
      'image': instance.image?.toJson(),
      'icon': instance.icon?.toJson(),
      'bigImage': instance.bigImage?.toJson()
    };

UnitType _$UnitTypeFromJson(Map<String, dynamic> json) {
  return UnitType()
    ..name = json['name'] as String
    ..race = _$enumDecodeNullable(_$RacesEnumMap, json['race'])
    ..tags = (json['tags'] as List)
        ?.map((e) => _$enumDecodeNullable(_$UnitTypeTagEnumMap, e))
        ?.toList()
    ..health = json['health'] as int
    ..armor = json['armor'] as int
    ..speed = json['speed'] as int
    ..range = json['range'] as int
    ..actions = json['actions'] as int
    ..attack = json['attack'] as String
    ..cost = json['cost'] as int
    ..langName = (json['langName'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..unitTypeDataVersion = json['unitTypeDataVersion'] as int
    ..unitTypeVersion = json['unitTypeVersion'] as int
    ..bigImage = json['bigImage'] == null
        ? null
        : Image.fromJson(json['bigImage'] as Map<String, dynamic>)
    ..image = json['image'] == null
        ? null
        : Image.fromJson(json['image'] as Map<String, dynamic>)
    ..icon = json['icon'] == null
        ? null
        : Image.fromJson(json['icon'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UnitTypeToJson(UnitType instance) => <String, dynamic>{
      'name': instance.name,
      'race': _$RacesEnumMap[instance.race],
      'tags': instance.tags?.map((e) => _$UnitTypeTagEnumMap[e])?.toList(),
      'health': instance.health,
      'armor': instance.armor,
      'speed': instance.speed,
      'range': instance.range,
      'actions': instance.actions,
      'attack': instance.attack,
      'cost': instance.cost,
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'unitTypeDataVersion': instance.unitTypeDataVersion,
      'unitTypeVersion': instance.unitTypeVersion,
      'bigImage': instance.bigImage?.toJson(),
      'image': instance.image?.toJson(),
      'icon': instance.icon?.toJson()
    };

Race _$RaceFromJson(Map<String, dynamic> json) {
  return Race()
    ..id = _$enumDecodeNullable(_$RacesEnumMap, json['id'])
    ..name = (json['name'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String));
}

Map<String, dynamic> _$RaceToJson(Race instance) => <String, dynamic>{
      'id': _$RacesEnumMap[instance.id],
      'name': instance.name?.map((k, e) => MapEntry(_$LangEnumMap[k], e))
    };

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
      'fields': instance.fields?.map((k, e) => MapEntry(k, e?.toJson())),
      'startField': instance.startField
    };

const _$TerrainEnumMap = <Terrain, dynamic>{
  Terrain.grass: 'grass',
  Terrain.rock: 'rock',
  Terrain.water: 'water',
  Terrain.forest: 'forest'
};

PlayerBase _$PlayerBaseFromJson(Map<String, dynamic> json) {
  return PlayerBase()
    ..portrait = json['portrait'] == null
        ? null
        : Image.fromJson(json['portrait'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PlayerBaseToJson(PlayerBase instance) =>
    <String, dynamic>{'portrait': instance.portrait?.toJson()};

LobbyPlayer _$LobbyPlayerFromJson(Map<String, dynamic> json) {
  return LobbyPlayer()
    ..portrait = json['portrait'] == null
        ? null
        : Image.fromJson(json['portrait'] as Map<String, dynamic>)
    ..lobbyMaster = json['lobbyMaster'] as bool
    ..name = json['name'] as String;
}

Map<String, dynamic> _$LobbyPlayerToJson(LobbyPlayer instance) =>
    <String, dynamic>{
      'portrait': instance.portrait?.toJson(),
      'lobbyMaster': instance.lobbyMaster,
      'name': instance.name
    };

TalePlayer _$TalePlayerFromJson(Map<String, dynamic> json) {
  return TalePlayer()
    ..portrait = json['portrait'] == null
        ? null
        : Image.fromJson(json['portrait'] as Map<String, dynamic>)
    ..team = json['team'] as String
    ..color = json['color'] as String;
}

Map<String, dynamic> _$TalePlayerToJson(TalePlayer instance) =>
    <String, dynamic>{
      'portrait': instance.portrait?.toJson(),
      'team': instance.team,
      'color': instance.color
    };

GamePlayer _$GamePlayerFromJson(Map<String, dynamic> json) {
  return GamePlayer()
    ..portrait = json['portrait'] == null
        ? null
        : Image.fromJson(json['portrait'] as Map<String, dynamic>)
    ..team = json['team'] as String
    ..color = json['color'] as String
    ..id = json['id'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$GamePlayerToJson(GamePlayer instance) =>
    <String, dynamic>{
      'portrait': instance.portrait?.toJson(),
      'team': instance.team,
      'color': instance.color,
      'id': instance.id,
      'name': instance.name
    };

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(json['name'] as String)
    ..triggers = (json['triggers'] as List)
        ?.map((e) =>
            e == null ? null : Trigger.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'name': instance.name,
      'triggers': instance.triggers?.map((e) => e?.toJson())?.toList()
    };

Trigger _$TriggerFromJson(Map<String, dynamic> json) {
  return Trigger()
    ..event = json['event'] == null
        ? null
        : Call.fromJson(json['event'] as Map<String, dynamic>)
    ..action = json['action'] == null
        ? null
        : Call.fromJson(json['action'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TriggerToJson(Trigger instance) => <String, dynamic>{
      'event': instance.event?.toJson(),
      'action': instance.action?.toJson()
    };

Dialog _$DialogFromJson(Map<String, dynamic> json) {
  return Dialog()
    ..name = json['name'] as String
    ..image = json['image'] == null
        ? null
        : Call.fromJson(json['image'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DialogToJson(Dialog instance) =>
    <String, dynamic>{'name': instance.name, 'image': instance.image?.toJson()};

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
      'tale': instance.tale?.toJson(),
      'lobby': instance.lobby?.toJson()
    };

TaleCompiled _$TaleCompiledFromJson(Map<String, dynamic> json) {
  return TaleCompiled()
    ..authorEmail = json['authorEmail'] as String
    ..tale = json['tale'] == null
        ? null
        : TaleInnerCompiled.fromJson(json['tale'] as Map<String, dynamic>)
    ..lobby = json['lobby'] == null
        ? null
        : LobbyTale.fromJson(json['lobby'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TaleCompiledToJson(TaleCompiled instance) =>
    <String, dynamic>{
      'authorEmail': instance.authorEmail,
      'tale': instance.tale?.toJson(),
      'lobby': instance.lobby?.toJson()
    };

TaleInnerEnvelope _$TaleInnerEnvelopeFromJson(Map<String, dynamic> json) {
  return TaleInnerEnvelope()
    ..name = json['name'] as String
    ..langName = (json['langName'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..langs = (json['langs'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        _$enumDecodeNullable(_$LangEnumMap, k),
        (e as Map<String, dynamic>)?.map((k, e) => MapEntry(k, e as String))))
    ..taleVersion = json['taleVersion'] as int
    ..world = json['world'] == null
        ? null
        : WorldCreateEnvelope.fromJson(json['world'] as Map<String, dynamic>)
    ..aiGroups = (json['aiGroups'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(
            k, e == null ? null : AiGroup.fromJson(e as Map<String, dynamic>)))
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
      'name': instance.name,
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'langs': instance.langs?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'taleVersion': instance.taleVersion,
      'world': instance.world?.toJson(),
      'aiGroups': instance.aiGroups?.map((k, e) => MapEntry(k, e?.toJson())),
      'events': instance.events?.map((k, e) => MapEntry(k, e?.toJson())),
      'dialogs': instance.dialogs?.map((k, e) => MapEntry(k, e?.toJson())),
      'units': instance.units
    };

TaleInnerCompiled _$TaleInnerCompiledFromJson(Map<String, dynamic> json) {
  return TaleInnerCompiled()
    ..name = json['name'] as String
    ..langs = (json['langs'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        _$enumDecodeNullable(_$LangEnumMap, k),
        (e as Map<String, dynamic>)?.map((k, e) => MapEntry(k, e as String))))
    ..langName = (json['langName'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..taleVersion = json['taleVersion'] as int
    ..world = json['world'] == null
        ? null
        : WorldCreateEnvelope.fromJson(json['world'] as Map<String, dynamic>)
    ..aiGroups = (json['aiGroups'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(
            k, e == null ? null : AiGroup.fromJson(e as Map<String, dynamic>)))
    ..events = (json['events'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        k, e == null ? null : Event.fromJson(e as Map<String, dynamic>)))
    ..dialogs = (json['dialogs'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(
            k, e == null ? null : Dialog.fromJson(e as Map<String, dynamic>)))
    ..units = (json['units'] as Map<String, dynamic>)
        ?.map((k, e) => MapEntry(k, e as String))
    ..assets = json['assets'] == null
        ? null
        : TaleCompiledAssets.fromJson(json['assets'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TaleInnerCompiledToJson(TaleInnerCompiled instance) =>
    <String, dynamic>{
      'name': instance.name,
      'langs': instance.langs?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'taleVersion': instance.taleVersion,
      'world': instance.world?.toJson(),
      'aiGroups': instance.aiGroups?.map((k, e) => MapEntry(k, e?.toJson())),
      'events': instance.events?.map((k, e) => MapEntry(k, e?.toJson())),
      'dialogs': instance.dialogs?.map((k, e) => MapEntry(k, e?.toJson())),
      'units': instance.units,
      'assets': instance.assets?.toJson()
    };

TaleCompiledAssets _$TaleCompiledAssetsFromJson(Map<String, dynamic> json) {
  return TaleCompiledAssets()
    ..images = (json['images'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        k, e == null ? null : Image.fromJson(e as Map<String, dynamic>)))
    ..unitTypes = (json['unitTypes'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(
            k,
            e == null
                ? null
                : UnitTypeCompiled.fromJson(e as Map<String, dynamic>)));
}

Map<String, dynamic> _$TaleCompiledAssetsToJson(TaleCompiledAssets instance) =>
    <String, dynamic>{
      'images': instance.images?.map((k, e) => MapEntry(k, e?.toJson())),
      'unitTypes': instance.unitTypes?.map((k, e) => MapEntry(k, e?.toJson()))
    };

AiGroup _$AiGroupFromJson(Map<String, dynamic> json) {
  return AiGroup()
    ..id = json['id'] as String
    ..name = (json['name'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..team = json['team'] as String
    ..color = json['color'] as String;
}

Map<String, dynamic> _$AiGroupToJson(AiGroup instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'team': instance.team,
      'color': instance.color
    };

LobbyTale _$LobbyTaleFromJson(Map<String, dynamic> json) {
  return LobbyTale()
    ..id = json['id'] as String
    ..name = (json['name'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..description = (json['description'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..image = json['image'] == null
        ? null
        : Image.fromJson(json['image'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LobbyTaleToJson(LobbyTale instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'description':
          instance.description?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'image': instance.image?.toJson()
    };

OpenedLobby _$OpenedLobbyFromJson(Map<String, dynamic> json) {
  return OpenedLobby()
    ..id = json['id'] as String
    ..name = (json['name'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..description = (json['description'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..image = json['image'] == null
        ? null
        : Image.fromJson(json['image'] as Map<String, dynamic>)
    ..lobbyName = json['lobbyName'] as String
    ..players = (json['players'] as List)
        ?.map((e) =>
            e == null ? null : LobbyPlayer.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OpenedLobbyToJson(OpenedLobby instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'description':
          instance.description?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'image': instance.image?.toJson(),
      'lobbyName': instance.lobbyName,
      'players': instance.players?.map((e) => e?.toJson())?.toList()
    };

ClientTaleData _$ClientTaleDataFromJson(Map<String, dynamic> json) {
  return ClientTaleData()
    ..name = json['name'] as String
    ..langs = (json['langs'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        _$enumDecodeNullable(_$LangEnumMap, k),
        (e as Map<String, dynamic>)?.map((k, e) => MapEntry(k, e as String))))
    ..langName = (json['langName'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..world = json['world'] == null
        ? null
        : WorldCreateEnvelope.fromJson(json['world'] as Map<String, dynamic>)
    ..assets = json['assets'] == null
        ? null
        : TaleCompiledAssets.fromJson(json['assets'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ClientTaleDataToJson(ClientTaleData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'langs': instance.langs?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'world': instance.world?.toJson(),
      'assets': instance.assets?.toJson()
    };

ToClientMessage _$ToClientMessageFromJson(Map<String, dynamic> json) {
  return ToClientMessage()
    ..message = _$enumDecodeNullable(_$OnClientActionEnumMap, json['message'])
    ..content = json['content'] as String;
}

Map<String, dynamic> _$ToClientMessageToJson(ToClientMessage instance) =>
    <String, dynamic>{
      'message': _$OnClientActionEnumMap[instance.message],
      'content': instance.content
    };

const _$OnClientActionEnumMap = <OnClientAction, dynamic>{
  OnClientAction.setNavigationState: 'setNavigationState',
  OnClientAction.refreshLobbyList: 'refreshLobbyList',
  OnClientAction.getGamesToCreate: 'getGamesToCreate',
  OnClientAction.setCurrentUser: 'setCurrentUser',
  OnClientAction.openedLobbyData: 'openedLobbyData',
  OnClientAction.taleData: 'taleData',
  OnClientAction.taleStateUpdate: 'taleStateUpdate'
};

SetNavigationState _$SetNavigationStateFromJson(Map<String, dynamic> json) {
  return SetNavigationState()
    ..newState =
        _$enumDecodeNullable(_$GameNavigationStateEnumMap, json['newState']);
}

Map<String, dynamic> _$SetNavigationStateToJson(SetNavigationState instance) =>
    <String, dynamic>{
      'newState': _$GameNavigationStateEnumMap[instance.newState]
    };

const _$GameNavigationStateEnumMap = <GameNavigationState, dynamic>{
  GameNavigationState.findLobby: 'findLobby',
  GameNavigationState.createGame: 'createGame',
  GameNavigationState.inGame: 'inGame',
  GameNavigationState.loading: 'loading',
  GameNavigationState.inLobby: 'inLobby'
};

RefreshLobbyList _$RefreshLobbyListFromJson(Map<String, dynamic> json) {
  return RefreshLobbyList()
    ..lobbies = (json['lobbies'] as List)
        ?.map((e) =>
            e == null ? null : OpenedLobby.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$RefreshLobbyListToJson(RefreshLobbyList instance) =>
    <String, dynamic>{
      'lobbies': instance.lobbies?.map((e) => e?.toJson())?.toList()
    };

GetGamesToCreate _$GetGamesToCreateFromJson(Map<String, dynamic> json) {
  return GetGamesToCreate()
    ..games = (json['games'] as List)
        ?.map((e) =>
            e == null ? null : LobbyTale.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GetGamesToCreateToJson(GetGamesToCreate instance) =>
    <String, dynamic>{
      'games': instance.games?.map((e) => e?.toJson())?.toList()
    };

SetCurrentUser _$SetCurrentUserFromJson(Map<String, dynamic> json) {
  return SetCurrentUser()
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SetCurrentUserToJson(SetCurrentUser instance) =>
    <String, dynamic>{'user': instance.user?.toJson()};

OpenedLobbyData _$OpenedLobbyDataFromJson(Map<String, dynamic> json) {
  return OpenedLobbyData()
    ..lobby = json['lobby'] == null
        ? null
        : OpenedLobby.fromJson(json['lobby'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OpenedLobbyDataToJson(OpenedLobbyData instance) =>
    <String, dynamic>{'lobby': instance.lobby?.toJson()};

TaleData _$TaleDataFromJson(Map<String, dynamic> json) {
  return TaleData()
    ..data = json['data'] == null
        ? null
        : ClientTaleData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TaleDataToJson(TaleData instance) =>
    <String, dynamic>{'data': instance.data?.toJson()};

TaleStateUpdate _$TaleStateUpdateFromJson(Map<String, dynamic> json) {
  return TaleStateUpdate()
    ..lobby = json['lobby'] == null
        ? null
        : OpenedLobby.fromJson(json['lobby'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TaleStateUpdateToJson(TaleStateUpdate instance) =>
    <String, dynamic>{'lobby': instance.lobby?.toJson()};

ToGameServerMessage _$ToGameServerMessageFromJson(Map<String, dynamic> json) {
  return ToGameServerMessage()
    ..message = _$enumDecodeNullable(_$OnServerActionEnumMap, json['message'])
    ..content = json['content'] as String;
}

Map<String, dynamic> _$ToGameServerMessageToJson(
        ToGameServerMessage instance) =>
    <String, dynamic>{
      'message': _$OnServerActionEnumMap[instance.message],
      'content': instance.content
    };

const _$OnServerActionEnumMap = <OnServerAction, dynamic>{
  OnServerAction.goToState: 'goToState',
  OnServerAction.init: 'init',
  OnServerAction.createLobby: 'createLobby',
  OnServerAction.enterLobby: 'enterLobby',
  OnServerAction.enterGame: 'enterGame',
  OnServerAction.playerGameAction: 'playerGameAction'
};

GoToState _$GoToStateFromJson(Map<String, dynamic> json) {
  return GoToState()
    ..newState =
        _$enumDecodeNullable(_$GameNavigationStateEnumMap, json['newState']);
}

Map<String, dynamic> _$GoToStateToJson(GoToState instance) => <String, dynamic>{
      'newState': _$GameNavigationStateEnumMap[instance.newState]
    };

InitMessage _$InitMessageFromJson(Map<String, dynamic> json) {
  return InitMessage()..innerToken = json['innerToken'] as String;
}

Map<String, dynamic> _$InitMessageToJson(InitMessage instance) =>
    <String, dynamic>{'innerToken': instance.innerToken};

CreateLobby _$CreateLobbyFromJson(Map<String, dynamic> json) {
  return CreateLobby()
    ..taleName = json['taleName'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$CreateLobbyToJson(CreateLobby instance) =>
    <String, dynamic>{'taleName': instance.taleName, 'name': instance.name};

EnterLobby _$EnterLobbyFromJson(Map<String, dynamic> json) {
  return EnterLobby()..lobbyId = json['lobbyId'] as String;
}

Map<String, dynamic> _$EnterLobbyToJson(EnterLobby instance) =>
    <String, dynamic>{'lobbyId': instance.lobbyId};

EnterGame _$EnterGameFromJson(Map<String, dynamic> json) {
  return EnterGame()..lobbyId = json['lobbyId'] as String;
}

Map<String, dynamic> _$EnterGameToJson(EnterGame instance) =>
    <String, dynamic>{'lobbyId': instance.lobbyId};

PlayerGameAction _$PlayerGameActionFromJson(Map<String, dynamic> json) {
  return PlayerGameAction()..lobbyId = json['lobbyId'] as String;
}

Map<String, dynamic> _$PlayerGameActionToJson(PlayerGameAction instance) =>
    <String, dynamic>{'lobbyId': instance.lobbyId};

AbilitiesEnvelope _$AbilitiesEnvelopeFromJson(Map<String, dynamic> json) {
  return AbilitiesEnvelope()
    ..move = json['move'] == null
        ? null
        : MoveAbilityEnvelope.fromJson(json['move'] as Map<String, dynamic>)
    ..attack = json['attack'] == null
        ? null
        : AttackAbilityEnvelope.fromJson(
            json['attack'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AbilitiesEnvelopeToJson(AbilitiesEnvelope instance) =>
    <String, dynamic>{
      'move': instance.move?.toJson(),
      'attack': instance.attack?.toJson()
    };

MoveAbilityEnvelope _$MoveAbilityEnvelopeFromJson(Map<String, dynamic> json) {
  return MoveAbilityEnvelope()..steps = json['steps'] as String;
}

Map<String, dynamic> _$MoveAbilityEnvelopeToJson(
        MoveAbilityEnvelope instance) =>
    <String, dynamic>{'steps': instance.steps};

AttackAbilityEnvelope _$AttackAbilityEnvelopeFromJson(
    Map<String, dynamic> json) {
  return AttackAbilityEnvelope()
    ..range = json['range'] as String
    ..attack = json['attack'] as String;
}

Map<String, dynamic> _$AttackAbilityEnvelopeToJson(
        AttackAbilityEnvelope instance) =>
    <String, dynamic>{'range': instance.range, 'attack': instance.attack};
