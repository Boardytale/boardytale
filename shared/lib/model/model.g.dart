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

const _$ImageTagEnumMap = <ImageTag, dynamic>{
  ImageTag.grass: 'grass',
  ImageTag.forest: 'forest',
  ImageTag.water: 'water',
  ImageTag.rock: 'rock'
};

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

LiveUnitState _$LiveUnitStateFromJson(Map<String, dynamic> json) {
  return LiveUnitState()
    ..far = json['far'] as int
    ..steps = json['steps'] as int
    ..health = json['health'] as int
    ..buffs = (json['buffs'] as List)
        ?.map(
            (e) => e == null ? null : Buff.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..actions = json['actions'] as int
    ..changeToTypeName = json['changeToTypeName'] as String
    ..moveToFieldId = json['moveToFieldId'] as String
    ..transferToPlayerId = json['transferToPlayerId'] as String
    ..useAnimationName =
        _$enumDecodeNullable(_$AnimationNameEnumMap, json['useAnimationName']);
}

Map<String, dynamic> _$LiveUnitStateToJson(LiveUnitState instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('far', instance.far);
  writeNotNull('steps', instance.steps);
  writeNotNull('health', instance.health);
  writeNotNull('buffs', instance.buffs?.map((e) => e?.toJson())?.toList());
  writeNotNull('actions', instance.actions);
  writeNotNull('changeToTypeName', instance.changeToTypeName);
  writeNotNull('moveToFieldId', instance.moveToFieldId);
  writeNotNull('transferToPlayerId', instance.transferToPlayerId);
  writeNotNull(
      'useAnimationName', _$AnimationNameEnumMap[instance.useAnimationName]);
  return val;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$AnimationNameEnumMap = <AnimationName, dynamic>{
  AnimationName.move: 'move'
};

UnitCreateOrUpdateAction _$UnitCreateOrUpdateActionFromJson(
    Map<String, dynamic> json) {
  return UnitCreateOrUpdateAction()
    ..actionId = json['actionId'] as String
    ..unitId = json['unitId'] as String
    ..state = json['state'] == null
        ? null
        : LiveUnitState.fromJson(json['state'] as Map<String, dynamic>)
    ..newUnitTypeToTale = json['newUnitTypeToTale'] == null
        ? null
        : UnitTypeCompiled.fromJson(
            json['newUnitTypeToTale'] as Map<String, dynamic>)
    ..newPlayerToTale = json['newPlayerToTale'] == null
        ? null
        : Player.fromJson(json['newPlayerToTale'] as Map<String, dynamic>)
    ..isNewPlayerOnMove = json['isNewPlayerOnMove'] as bool
    ..diceNumber = json['diceNumber'] as int;
}

Map<String, dynamic> _$UnitCreateOrUpdateActionToJson(
    UnitCreateOrUpdateAction instance) {
  final val = <String, dynamic>{
    'actionId': instance.actionId,
    'unitId': instance.unitId,
    'state': instance.state?.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('newUnitTypeToTale', instance.newUnitTypeToTale?.toJson());
  writeNotNull('newPlayerToTale', instance.newPlayerToTale?.toJson());
  writeNotNull('isNewPlayerOnMove', instance.isNewPlayerOnMove);
  writeNotNull('diceNumber', instance.diceNumber);
  return val;
}

UnitDeleteAction _$UnitDeleteActionFromJson(Map<String, dynamic> json) {
  return UnitDeleteAction()
    ..actionId = json['actionId'] as String
    ..unitId = json['unitId'] as String
    ..animationName =
        _$enumDecodeNullable(_$AnimationNameEnumMap, json['animationName']);
}

Map<String, dynamic> _$UnitDeleteActionToJson(UnitDeleteAction instance) =>
    <String, dynamic>{
      'actionId': instance.actionId,
      'unitId': instance.unitId,
      'animationName': _$AnimationNameEnumMap[instance.animationName]
    };

CancelOnFieldAction _$CancelOnFieldActionFromJson(Map<String, dynamic> json) {
  return CancelOnFieldAction()
    ..actionId = json['actionId'] as String
    ..fieldId = json['fieldId'] as String
    ..animationName =
        _$enumDecodeNullable(_$AnimationNameEnumMap, json['animationName']);
}

Map<String, dynamic> _$CancelOnFieldActionToJson(
        CancelOnFieldAction instance) =>
    <String, dynamic>{
      'actionId': instance.actionId,
      'fieldId': instance.fieldId,
      'animationName': _$AnimationNameEnumMap[instance.animationName]
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

const _$RacesEnumMap = <Races, dynamic>{
  Races.human: 'human',
  Races.undead: 'undead',
  Races.gultam: 'gultam',
  Races.elf: 'elf',
  Races.animal: 'animal',
  Races.dragon: 'dragon'
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

GameHeroCreateEnvelope _$GameHeroCreateEnvelopeFromJson(
    Map<String, dynamic> json) {
  return GameHeroCreateEnvelope()
    ..level = json['level'] as int
    ..name = json['name'] as String
    ..type = json['type'] == null
        ? null
        : UnitTypeCompiled.fromJson(json['type'] as Map<String, dynamic>)
    ..unit = json['unit'] == null
        ? null
        : UnitCreateOrUpdateAction.fromJson(
            json['unit'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GameHeroCreateEnvelopeToJson(
        GameHeroCreateEnvelope instance) =>
    <String, dynamic>{
      'level': instance.level,
      'name': instance.name,
      'type': instance.type?.toJson(),
      'unit': instance.unit?.toJson()
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
    ..terrain = _$enumDecodeNullable(_$TerrainEnumMap, json['terrain']);
}

Map<String, dynamic> _$FieldCreateEnvelopeToJson(
        FieldCreateEnvelope instance) =>
    <String, dynamic>{'terrain': _$TerrainEnumMap[instance.terrain]};

const _$TerrainEnumMap = <Terrain, dynamic>{
  Terrain.grass: 'grass',
  Terrain.rock: 'rock',
  Terrain.water: 'water',
  Terrain.forest: 'forest'
};

WorldCreateEnvelope _$WorldCreateEnvelopeFromJson(Map<String, dynamic> json) {
  return WorldCreateEnvelope()
    ..width = json['width'] as int
    ..height = json['height'] as int
    ..baseTerrain = _$enumDecodeNullable(_$TerrainEnumMap, json['baseTerrain'])
    ..fields = (json['fields'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        k,
        e == null
            ? null
            : FieldCreateEnvelope.fromJson(e as Map<String, dynamic>)))
    ..startingFieldIds =
        (json['startingFieldIds'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$WorldCreateEnvelopeToJson(
        WorldCreateEnvelope instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'baseTerrain': _$TerrainEnumMap[instance.baseTerrain],
      'fields': instance.fields?.map((k, e) => MapEntry(k, e?.toJson())),
      'startingFieldIds': instance.startingFieldIds
    };

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player()
    ..id = json['id'] as String
    ..taleId = json['taleId'] as String
    ..team = json['team'] as String
    ..color = json['color'] as String
    ..humanPlayer = json['humanPlayer'] == null
        ? null
        : HumanPlayer.fromJson(json['humanPlayer'] as Map<String, dynamic>)
    ..aiGroup = json['aiGroup'] == null
        ? null
        : AiGroup.fromJson(json['aiGroup'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'taleId': instance.taleId,
      'team': instance.team,
      'color': instance.color,
      'humanPlayer': instance.humanPlayer?.toJson(),
      'aiGroup': instance.aiGroup?.toJson()
    };

HumanPlayer _$HumanPlayerFromJson(Map<String, dynamic> json) {
  return HumanPlayer()
    ..name = json['name'] as String
    ..isGameMaster = json['isGameMaster'] as bool
    ..portrait = json['portrait'] == null
        ? null
        : Image.fromJson(json['portrait'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HumanPlayerToJson(HumanPlayer instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isGameMaster': instance.isGameMaster,
      'portrait': instance.portrait?.toJson()
    };

AiGroup _$AiGroupFromJson(Map<String, dynamic> json) {
  return AiGroup()
    ..langName = (json['langName'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String));
}

Map<String, dynamic> _$AiGroupToJson(AiGroup instance) => <String, dynamic>{
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e))
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
    ..aiPlayers = (json['aiPlayers'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(
            k, e == null ? null : Player.fromJson(e as Map<String, dynamic>)))
    ..events = (json['events'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        k, e == null ? null : Event.fromJson(e as Map<String, dynamic>)))
    ..dialogs = (json['dialogs'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(
            k, e == null ? null : Dialog.fromJson(e as Map<String, dynamic>)))
    ..units = (json['units'] as List)
        ?.map(
            (e) => e == null ? null : UnitCreateEnvelope.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..humanPlayerIds = (json['humanPlayerIds'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$TaleInnerEnvelopeToJson(TaleInnerEnvelope instance) =>
    <String, dynamic>{
      'name': instance.name,
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'langs': instance.langs?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'taleVersion': instance.taleVersion,
      'world': instance.world?.toJson(),
      'aiPlayers': instance.aiPlayers?.map((k, e) => MapEntry(k, e?.toJson())),
      'events': instance.events?.map((k, e) => MapEntry(k, e?.toJson())),
      'dialogs': instance.dialogs?.map((k, e) => MapEntry(k, e?.toJson())),
      'units': instance.units?.map((e) => e?.toJson())?.toList(),
      'humanPlayerIds': instance.humanPlayerIds
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
    ..aiPlayers = (json['aiPlayers'] as Map<String, dynamic>)?.map((k, e) =>
        MapEntry(
            k, e == null ? null : Player.fromJson(e as Map<String, dynamic>)))
    ..events = (json['events'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        k, e == null ? null : Event.fromJson(e as Map<String, dynamic>)))
    ..dialogs = (json['dialogs'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
        k, e == null ? null : Dialog.fromJson(e as Map<String, dynamic>)))
    ..units = (json['units'] as List)
        ?.map((e) =>
            e == null ? null : UnitCreateEnvelope.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..humanPlayerIds = (json['humanPlayerIds'] as List)?.map((e) => e as String)?.toList()
    ..assets = json['assets'] == null ? null : TaleCompiledAssets.fromJson(json['assets'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TaleInnerCompiledToJson(TaleInnerCompiled instance) =>
    <String, dynamic>{
      'name': instance.name,
      'langs': instance.langs?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'taleVersion': instance.taleVersion,
      'world': instance.world?.toJson(),
      'aiPlayers': instance.aiPlayers?.map((k, e) => MapEntry(k, e?.toJson())),
      'events': instance.events?.map((k, e) => MapEntry(k, e?.toJson())),
      'dialogs': instance.dialogs?.map((k, e) => MapEntry(k, e?.toJson())),
      'units': instance.units?.map((e) => e?.toJson())?.toList(),
      'humanPlayerIds': instance.humanPlayerIds,
      'assets': instance.assets?.toJson()
    };

UnitCreateEnvelope _$UnitCreateEnvelopeFromJson(Map<String, dynamic> json) {
  return UnitCreateEnvelope()
    ..fieldId = json['fieldId'] as String
    ..unitTypeName = json['unitTypeName'] as String
    ..playerId = json['playerId'] as String;
}

Map<String, dynamic> _$UnitCreateEnvelopeToJson(UnitCreateEnvelope instance) =>
    <String, dynamic>{
      'fieldId': instance.fieldId,
      'unitTypeName': instance.unitTypeName,
      'playerId': instance.playerId
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
            e == null ? null : Player.fromJson(e as Map<String, dynamic>))
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
        : TaleCompiledAssets.fromJson(json['assets'] as Map<String, dynamic>)
    ..players = (json['players'] as List)
        ?.map((e) =>
            e == null ? null : Player.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..playerIdOnThisClientMachine =
        json['playerIdOnThisClientMachine'] as String
    ..playerOnMoveIds =
        (json['playerOnMoveIds'] as List)?.map((e) => e as String)?.toList()
    ..aiGroupOnMove = json['aiGroupOnMove'] as String
    ..humanPlayerIds =
        (json['humanPlayerIds'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$ClientTaleDataToJson(ClientTaleData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'langs': instance.langs?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'world': instance.world?.toJson(),
      'assets': instance.assets?.toJson(),
      'players': instance.players?.map((e) => e?.toJson())?.toList(),
      'playerIdOnThisClientMachine': instance.playerIdOnThisClientMachine,
      'playerOnMoveIds': instance.playerOnMoveIds,
      'aiGroupOnMove': instance.aiGroupOnMove,
      'humanPlayerIds': instance.humanPlayerIds
    };

Buff _$BuffFromJson(Map<String, dynamic> json) {
  return Buff()
    ..speedDelta = json['speedDelta'] as int
    ..armorDelta = json['armorDelta'] as int
    ..rangeDelta = json['rangeDelta'] as int
    ..healthDelta = json['healthDelta'] as int
    ..attackDelta =
        (json['attackDelta'] as List)?.map((e) => e as int)?.toList()
    ..extraTags = (json['extraTags'] as List)?.map((e) => e as String)?.toSet()
    ..bannedTags =
        (json['bannedTags'] as List)?.map((e) => e as String)?.toSet()
    ..expiration = json['expiration'] as int
    ..buffType = json['buffType'] as String
    ..stackStrength = json['stackStrength'] as int
    ..doesNotStackWith =
        (json['doesNotStackWith'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$BuffToJson(Buff instance) => <String, dynamic>{
      'speedDelta': instance.speedDelta,
      'armorDelta': instance.armorDelta,
      'rangeDelta': instance.rangeDelta,
      'healthDelta': instance.healthDelta,
      'attackDelta': instance.attackDelta,
      'extraTags': instance.extraTags?.toList(),
      'bannedTags': instance.bannedTags?.toList(),
      'expiration': instance.expiration,
      'buffType': instance.buffType,
      'stackStrength': instance.stackStrength,
      'doesNotStackWith': instance.doesNotStackWith
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
  OnClientAction.unitCreateOrUpdate: 'unitCreateOrUpdate',
  OnClientAction.unitDelete: 'unitDelete',
  OnClientAction.cancelOnField: 'cancelOnField',
  OnClientAction.intentionUpdate: 'intentionUpdate',
  OnClientAction.playersOnMove: 'playersOnMove',
  OnClientAction.addUnitType: 'addUnitType'
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

UnitCreateOrUpdate _$UnitCreateOrUpdateFromJson(Map<String, dynamic> json) {
  return UnitCreateOrUpdate()
    ..actions = (json['actions'] as List)
        ?.map((e) => e == null
            ? null
            : UnitCreateOrUpdateAction.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UnitCreateOrUpdateToJson(UnitCreateOrUpdate instance) =>
    <String, dynamic>{
      'actions': instance.actions?.map((e) => e?.toJson())?.toList()
    };

UnitDelete _$UnitDeleteFromJson(Map<String, dynamic> json) {
  return UnitDelete()
    ..actions = (json['actions'] as List)
        ?.map((e) => e == null
            ? null
            : UnitDeleteAction.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UnitDeleteToJson(UnitDelete instance) =>
    <String, dynamic>{
      'actions': instance.actions?.map((e) => e?.toJson())?.toList()
    };

CancelOnField _$CancelOnFieldFromJson(Map<String, dynamic> json) {
  return CancelOnField()
    ..actions = (json['actions'] as List)
        ?.map((e) => e == null
            ? null
            : CancelOnFieldAction.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CancelOnFieldToJson(CancelOnField instance) =>
    <String, dynamic>{
      'actions': instance.actions?.map((e) => e?.toJson())?.toList()
    };

IntentionUpdate _$IntentionUpdateFromJson(Map<String, dynamic> json) {
  return IntentionUpdate()
    ..playerId = json['playerId'] as String
    ..trackFieldsId =
        (json['trackFieldsId'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$IntentionUpdateToJson(IntentionUpdate instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'trackFieldsId': instance.trackFieldsId
    };

PlayersOnMove _$PlayersOnMoveFromJson(Map<String, dynamic> json) {
  return PlayersOnMove()
    ..playerOnMoveIds =
        (json['playerOnMoveIds'] as List)?.map((e) => e as String);
}

Map<String, dynamic> _$PlayersOnMoveToJson(PlayersOnMove instance) =>
    <String, dynamic>{'playerOnMoveIds': instance.playerOnMoveIds?.toList()};

AddUnitType _$AddUnitTypeFromJson(Map<String, dynamic> json) {
  return AddUnitType()
    ..type = json['type'] == null
        ? null
        : UnitTypeCompiled.fromJson(json['type'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AddUnitTypeToJson(AddUnitType instance) =>
    <String, dynamic>{'type': instance.type?.toJson()};

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
  OnServerAction.unitTrackAction: 'unitTrackAction',
  OnServerAction.playerGameIntention: 'playerGameIntention',
  OnServerAction.controlsAction: 'controlsAction'
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

UnitTrackAction _$UnitTrackActionFromJson(Map<String, dynamic> json) {
  return UnitTrackAction()
    ..abilityName =
        _$enumDecodeNullable(_$AbilityNameEnumMap, json['abilityName'])
    ..unitId = json['unitId'] as String
    ..track = (json['track'] as List)?.map((e) => e as String)?.toList()
    ..actionId = json['actionId'] as String;
}

Map<String, dynamic> _$UnitTrackActionToJson(UnitTrackAction instance) =>
    <String, dynamic>{
      'abilityName': _$AbilityNameEnumMap[instance.abilityName],
      'unitId': instance.unitId,
      'track': instance.track,
      'actionId': instance.actionId
    };

const _$AbilityNameEnumMap = <AbilityName, dynamic>{
  AbilityName.move: 'move',
  AbilityName.attack: 'attack',
  AbilityName.shoot: 'shoot',
  AbilityName.heal: 'heal',
  AbilityName.revive: 'revive',
  AbilityName.hand_heal: 'hand_heal',
  AbilityName.boost: 'boost',
  AbilityName.linked_move: 'linked_move',
  AbilityName.step_shoot: 'step_shoot',
  AbilityName.light: 'light',
  AbilityName.summon: 'summon',
  AbilityName.dismiss: 'dismiss',
  AbilityName.change_type: 'change_type',
  AbilityName.regeneration: 'regeneration',
  AbilityName.dark_shoot: 'dark_shoot',
  AbilityName.teleport: 'teleport',
  AbilityName.raise: 'raise'
};

PlayerGameIntention _$PlayerGameIntentionFromJson(Map<String, dynamic> json) {
  return PlayerGameIntention()
    ..fieldsId = (json['fieldsId'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$PlayerGameIntentionToJson(
        PlayerGameIntention instance) =>
    <String, dynamic>{'fieldsId': instance.fieldsId};

ControlsAction _$ControlsActionFromJson(Map<String, dynamic> json) {
  return ControlsAction()
    ..actionName =
        _$enumDecodeNullable(_$ControlsActionNameEnumMap, json['actionName']);
}

Map<String, dynamic> _$ControlsActionToJson(ControlsAction instance) =>
    <String, dynamic>{
      'actionName': _$ControlsActionNameEnumMap[instance.actionName]
    };

const _$ControlsActionNameEnumMap = <ControlsActionName, dynamic>{
  ControlsActionName.andOfTurn: 'andOfTurn'
};

ToHeroServerMessage _$ToHeroServerMessageFromJson(Map<String, dynamic> json) {
  return ToHeroServerMessage()
    ..message =
        _$enumDecodeNullable(_$OnHeroServerActionEnumMap, json['message'])
    ..content = json['content'] as String;
}

Map<String, dynamic> _$ToHeroServerMessageToJson(
        ToHeroServerMessage instance) =>
    <String, dynamic>{
      'message': _$OnHeroServerActionEnumMap[instance.message],
      'content': instance.content
    };

const _$OnHeroServerActionEnumMap = <OnHeroServerAction, dynamic>{
  OnHeroServerAction.getHeroesOfPlayer: 'getHeroesOfPlayer'
};

GetHeroesOfPlayer _$GetHeroesOfPlayerFromJson(Map<String, dynamic> json) {
  return GetHeroesOfPlayer()
    ..requestPlayerEmail = json['requestPlayerEmail'] as String
    ..responseHeroes = (json['responseHeroes'] as List)
        ?.map((e) => e == null
            ? null
            : GameHeroCreateEnvelope.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GetHeroesOfPlayerToJson(GetHeroesOfPlayer instance) =>
    <String, dynamic>{
      'requestPlayerEmail': instance.requestPlayerEmail,
      'responseHeroes':
          instance.responseHeroes?.map((e) => e?.toJson())?.toList()
    };

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
    ..steps = json['steps'] as String
    ..attack = json['attack'] as String;
}

Map<String, dynamic> _$AttackAbilityEnvelopeToJson(
        AttackAbilityEnvelope instance) =>
    <String, dynamic>{'steps': instance.steps, 'attack': instance.attack};
