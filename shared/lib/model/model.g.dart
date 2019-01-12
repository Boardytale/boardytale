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
    ..tags = (json['tags'] as List)
        .map((e) => _$enumDecode(_$ImageTagEnumMap, e))
        .toList();
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
    ..id = json['id'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

UnitTypeCreateEnvelope _$UnitTypeCreateEnvelopeFromJson(
    Map<String, dynamic> json) {
  return UnitTypeCreateEnvelope()
    ..id = json['id'] as String
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
    ..abilities = json['abilities'] == null
        ? null
        : Abilities.fromJson(json['abilities'] as Map<String, dynamic>)
    ..unitTypeName = (json['unitTypeName'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..unitTypeDataVersion = json['unitTypeDataVersion'] as int
    ..unitTypeVersion = json['unitTypeVersion'] as int
    ..authorEmail = json['authorEmail'] as String
    ..created = json['created'] as String
    ..imageId = json['imageId'] as String
    ..iconId = json['iconId'] as String
    ..bigImageId = json['bigImageId'] as String;
}

Map<String, dynamic> _$UnitTypeCreateEnvelopeToJson(
        UnitTypeCreateEnvelope instance) =>
    <String, dynamic>{
      'id': instance.id,
      'race': _$RacesEnumMap[instance.race],
      'tags': instance.tags?.map((e) => _$UnitTypeTagEnumMap[e])?.toList(),
      'health': instance.health,
      'armor': instance.armor,
      'speed': instance.speed,
      'range': instance.range,
      'actions': instance.actions,
      'attack': instance.attack,
      'cost': instance.cost,
      'abilities': instance.abilities,
      'unitTypeName':
          instance.unitTypeName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'unitTypeDataVersion': instance.unitTypeDataVersion,
      'unitTypeVersion': instance.unitTypeVersion,
      'authorEmail': instance.authorEmail,
      'created': instance.created,
      'imageId': instance.imageId,
      'iconId': instance.iconId,
      'bigImageId': instance.bigImageId
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

UnitType _$UnitTypeFromJson(Map<String, dynamic> json) {
  return UnitType()
    ..id = json['id'] as String
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
    ..abilities = json['abilities'] == null
        ? null
        : Abilities.fromJson(json['abilities'] as Map<String, dynamic>)
    ..unitTypeName = (json['unitTypeName'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String))
    ..unitTypeDataVersion = json['unitTypeDataVersion'] as int
    ..unitTypeVersion = json['unitTypeVersion'] as int
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

Map<String, dynamic> _$UnitTypeToJson(UnitType instance) => <String, dynamic>{
      'id': instance.id,
      'race': _$RacesEnumMap[instance.race],
      'tags': instance.tags?.map((e) => _$UnitTypeTagEnumMap[e])?.toList(),
      'health': instance.health,
      'armor': instance.armor,
      'speed': instance.speed,
      'range': instance.range,
      'actions': instance.actions,
      'attack': instance.attack,
      'cost': instance.cost,
      'abilities': instance.abilities,
      'unitTypeName':
          instance.unitTypeName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'unitTypeDataVersion': instance.unitTypeDataVersion,
      'unitTypeVersion': instance.unitTypeVersion,
      'image': instance.image,
      'icon': instance.icon,
      'bigImage': instance.bigImage
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
      'fields': instance.fields,
      'startField': instance.startField
    };

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

Abilities _$AbilitiesFromJson(Map<String, dynamic> json) {
  return Abilities()
    ..move = json['move'] == null
        ? null
        : MoveAbility.fromJson(json['move'] as Map<String, dynamic>)
    ..attack = json['attack'] == null
        ? null
        : AttackAbility.fromJson(json['attack'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AbilitiesToJson(Abilities instance) =>
    <String, dynamic>{'move': instance.move, 'attack': instance.attack};

MoveAbility _$MoveAbilityFromJson(Map<String, dynamic> json) {
  return MoveAbility()
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..targets = (json['targets'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(
            _$enumDecodeNullable(_$TargetsEnumMap, k),
            (e as List)
                ?.map(
                    (e) => _$enumDecodeNullable(_$TargetModificatorsEnumMap, e))
                ?.toList()))
    ..steps = json['steps'] as String;
}

Map<String, dynamic> _$MoveAbilityToJson(MoveAbility instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'targets': instance.targets?.map((k, e) => MapEntry(_$TargetsEnumMap[k],
          e?.map((e) => _$TargetModificatorsEnumMap[e])?.toList())),
      'steps': instance.steps
    };

const _$TargetModificatorsEnumMap = <TargetModificators, dynamic>{
  TargetModificators.wounded: 'wounded',
  TargetModificators.notUndead: 'notUndead',
  TargetModificators.undead: 'undead'
};

const _$TargetsEnumMap = <Targets, dynamic>{
  Targets.me: 'me',
  Targets.own: 'own',
  Targets.ally: 'ally',
  Targets.enemy: 'enemy',
  Targets.corpse: 'corpse',
  Targets.empty: 'empty'
};

AttackAbility _$AttackAbilityFromJson(Map<String, dynamic> json) {
  return AttackAbility()
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..targets = (json['targets'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(
            _$enumDecodeNullable(_$TargetsEnumMap, k),
            (e as List)
                ?.map(
                    (e) => _$enumDecodeNullable(_$TargetModificatorsEnumMap, e))
                ?.toList()))
    ..range = json['range'] as String
    ..attack = json['attack'] as String;
}

Map<String, dynamic> _$AttackAbilityToJson(AttackAbility instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'targets': instance.targets?.map((k, e) => MapEntry(_$TargetsEnumMap[k],
          e?.map((e) => _$TargetModificatorsEnumMap[e])?.toList())),
      'range': instance.range,
      'attack': instance.attack
    };
