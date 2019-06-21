// GENERATED CODE - DO NOT MODIFY BY HAND

part of model;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image()
    ..name = json['name'] as String
    ..data = json['data'] as String
    ..width = json['width'] as int
    ..height = json['height'] as int
    ..type = _$enumDecode(_$ImageTypeEnumMap, json['type'])
    ..authorEmail = json['authorEmail'] as String
    ..imageVersion = json['imageVersion'] as int
    ..dataModelVersion = json['dataModelVersion'] as int
    ..created = DateTime.parse(json['created'] as String)
    ..tags = (json['tags'] as List)
        .map((e) => _$enumDecode(_$ImageTagEnumMap, e))
        .toList()
    ..origin = json['origin'] as String
    ..multiply = (json['multiply'] as num).toDouble()
    ..top = json['top'] as int
    ..left = json['left'] as int;
}

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'name': instance.name,
      'data': instance.data,
      'width': instance.width,
      'height': instance.height,
      'type': _$ImageTypeEnumMap[instance.type],
      'authorEmail': instance.authorEmail,
      'imageVersion': instance.imageVersion,
      'dataModelVersion': instance.dataModelVersion,
      'created': instance.created.toIso8601String(),
      'tags': instance.tags.map((e) => _$ImageTagEnumMap[e]).toList(),
      'origin': instance.origin,
      'multiply': instance.multiply,
      'top': instance.top,
      'left': instance.left
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
    ..innerToken = json['innerToken'] as String
    ..hasHero = json['hasHero'] as bool;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'innerToken': instance.innerToken,
      'hasHero': instance.hasHero
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

Triggers _$TriggersFromJson(Map<String, dynamic> json) {
  return Triggers()
    ..onInit = (json['onInit'] as List)
        .map((e) => Trigger.fromJson(e as Map<String, dynamic>))
        .toList()
    ..onAfterGameStarted = (json['onAfterGameStarted'] as List)
        .map((e) => Trigger.fromJson(e as Map<String, dynamic>))
        .toList()
    ..onUnitDies = (json['onUnitDies'] as List)
        .map((e) => UnitTrigger.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$TriggersToJson(Triggers instance) => <String, dynamic>{
      'onInit': instance.onInit.map((e) => e.toJson()).toList(),
      'onAfterGameStarted':
          instance.onAfterGameStarted.map((e) => e.toJson()).toList(),
      'onUnitDies': instance.onUnitDies.map((e) => e.toJson()).toList()
    };

Trigger _$TriggerFromJson(Map<String, dynamic> json) {
  return Trigger()
    ..condition = json['condition'] == null
        ? null
        : Condition.fromJson(json['condition'] as Map<String, dynamic>)
    ..action = json['action'] == null
        ? null
        : Action.fromJson(json['action'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TriggerToJson(Trigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('condition', instance.condition?.toJson());
  val['action'] = instance.action?.toJson();
  return val;
}

UnitTrigger _$UnitTriggerFromJson(Map<String, dynamic> json) {
  return UnitTrigger()
    ..condition = json['condition'] == null
        ? null
        : Condition.fromJson(json['condition'] as Map<String, dynamic>)
    ..action = json['action'] == null
        ? null
        : Action.fromJson(json['action'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UnitTriggerToJson(UnitTrigger instance) =>
    <String, dynamic>{
      'condition': instance.condition?.toJson(),
      'action': instance.action?.toJson()
    };

Condition _$ConditionFromJson(Map<String, dynamic> json) {
  return Condition()
    ..andCondition = json['andCondition'] == null
        ? null
        : AndCondition.fromJson(json['andCondition'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ConditionToJson(Condition instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('andCondition', instance.andCondition?.toJson());
  return val;
}

AndCondition _$AndConditionFromJson(Map<String, dynamic> json) {
  return AndCondition()
    ..condition1 = json['condition1'] == null
        ? null
        : Condition.fromJson(json['condition1'] as Map<String, dynamic>)
    ..condition2 = json['condition2'] == null
        ? null
        : Condition.fromJson(json['condition2'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AndConditionToJson(AndCondition instance) =>
    <String, dynamic>{
      'condition1': instance.condition1?.toJson(),
      'condition2': instance.condition2?.toJson()
    };

EqualCondition _$EqualConditionFromJson(Map<String, dynamic> json) {
  return EqualCondition()
    ..value = json['value'] as String
    ..equalsTo = json['equalsTo'];
}

Map<String, dynamic> _$EqualConditionToJson(EqualCondition instance) =>
    <String, dynamic>{'value': instance.value, 'equalsTo': instance.equalsTo};

Action _$ActionFromJson(Map<String, dynamic> json) {
  return Action()
    ..unitAction = json['unitAction'] == null
        ? null
        : UnitCreateOrUpdateAction.fromJson(
            json['unitAction'] as Map<String, dynamic>)
    ..victoryCheckAction = json['victoryCheckAction'] == null
        ? null
        : VictoryCheckAction.fromJson(
            json['victoryCheckAction'] as Map<String, dynamic>)
    ..showBanterAction = json['showBanterAction'] == null
        ? null
        : ShowBanterAction.fromJson(
            json['showBanterAction'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ActionToJson(Action instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unitAction', instance.unitAction?.toJson());
  writeNotNull('victoryCheckAction', instance.victoryCheckAction?.toJson());
  writeNotNull('showBanterAction', instance.showBanterAction?.toJson());
  return val;
}

VictoryCheckAction _$VictoryCheckActionFromJson(Map<String, dynamic> json) {
  return VictoryCheckAction()
    ..allTeamsEliminatedForWin = (json['allTeamsEliminatedForWin'] as List)
        ?.map((e) => e as String)
        ?.toList()
    ..anyOfTeamsEliminatedForWin = (json['anyOfTeamsEliminatedForWin'] as List)
        ?.map((e) => e as String)
        ?.toList()
    ..anyOfTeamsEliminatedForLost =
        (json['anyOfTeamsEliminatedForLost'] as List)
            ?.map((e) => e as String)
            ?.toList()
    ..allOfTeamsEliminatedForLost =
        (json['allOfTeamsEliminatedForLost'] as List)
            ?.map((e) => e as String)
            ?.toList()
    ..unitsEliminatedForLost = (json['unitsEliminatedForLost'] as List)
        ?.map((e) => e as String)
        ?.toList();
}

Map<String, dynamic> _$VictoryCheckActionToJson(VictoryCheckAction instance) =>
    <String, dynamic>{
      'allTeamsEliminatedForWin': instance.allTeamsEliminatedForWin,
      'anyOfTeamsEliminatedForWin': instance.anyOfTeamsEliminatedForWin,
      'anyOfTeamsEliminatedForLost': instance.anyOfTeamsEliminatedForLost,
      'allOfTeamsEliminatedForLost': instance.allOfTeamsEliminatedForLost,
      'unitsEliminatedForLost': instance.unitsEliminatedForLost
    };

ShowBanterAction _$ShowBanterActionFromJson(Map<String, dynamic> json) {
  return ShowBanterAction()
    ..title = (json['title'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
    ..text = (json['text'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
    ..image = json['image'] == null
        ? null
        : Image.fromJson(json['image'] as Map<String, dynamic>)
    ..showTimeInMilliseconds = json['showTimeInMilliseconds'] as int
    ..speakingUnitId = json['speakingUnitId'] as String;
}

Map<String, dynamic> _$ShowBanterActionToJson(ShowBanterAction instance) {
  final val = <String, dynamic>{
    'title': instance.title?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'text', instance.text?.map((k, e) => MapEntry(_$LangEnumMap[k], e)));
  writeNotNull('image', instance.image?.toJson());
  writeNotNull('showTimeInMilliseconds', instance.showTimeInMilliseconds);
  writeNotNull('speakingUnitId', instance.speakingUnitId);
  return val;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$LangEnumMap = <Lang, dynamic>{Lang.en: 'en', Lang.cz: 'cz'};

AiInstruction _$AiInstructionFromJson(Map<String, dynamic> json) {
  return AiInstruction()
    ..unitAction = json['unitAction'] == null
        ? null
        : UnitCreateOrUpdateAction.fromJson(
            json['unitAction'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AiInstructionToJson(AiInstruction instance) =>
    <String, dynamic>{'unitAction': instance.unitAction?.toJson()};

AiInstructionSetUnitTarget _$AiInstructionSetUnitTargetFromJson(
    Map<String, dynamic> json) {
  return AiInstructionSetUnitTarget()
    ..unitTaleId = json['unitTaleId'] as String
    ..actionOnTarget =
        _$enumDecodeNullable(_$AiActionEnumMap, json['actionOnTarget']);
}

Map<String, dynamic> _$AiInstructionSetUnitTargetToJson(
        AiInstructionSetUnitTarget instance) =>
    <String, dynamic>{
      'unitTaleId': instance.unitTaleId,
      'actionOnTarget': _$AiActionEnumMap[instance.actionOnTarget]
    };

const _$AiActionEnumMap = <AiAction, dynamic>{
  AiAction.attackAllOnRoad: 'attackAllOnRoad',
  AiAction.attackAllNearTarget: 'attackAllNearTarget',
  AiAction.attack: 'attack',
  AiAction.move: 'move'
};

Race _$RaceFromJson(Map<String, dynamic> json) {
  return Race()
    ..id = _$enumDecodeNullable(_$RacesEnumMap, json['id'])
    ..name = (json['name'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    );
}

Map<String, dynamic> _$RaceToJson(Race instance) => <String, dynamic>{
      'id': _$RacesEnumMap[instance.id],
      'name': instance.name?.map((k, e) => MapEntry(_$LangEnumMap[k], e))
    };

const _$RacesEnumMap = <Races, dynamic>{
  Races.human: 'human',
  Races.undead: 'undead',
  Races.gultam: 'gultam',
  Races.elf: 'elf',
  Races.animal: 'animal',
  Races.dragon: 'dragon'
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
    ..langName = (json['langName'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
    ..aiEngine = _$enumDecodeNullable(_$AiEngineEnumMap, json['aiEngine']);
}

Map<String, dynamic> _$AiGroupToJson(AiGroup instance) => <String, dynamic>{
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'aiEngine': _$AiEngineEnumMap[instance.aiEngine]
    };

const _$AiEngineEnumMap = <AiEngine, dynamic>{
  AiEngine.passive: 'passive',
  AiEngine.standard: 'standard',
  AiEngine.panic: 'panic'
};

UnitCreateOrUpdateAction _$UnitCreateOrUpdateActionFromJson(
    Map<String, dynamic> json) {
  return UnitCreateOrUpdateAction()
    ..unitId = json['unitId'] as String
    ..actionId = json['actionId'] as String
    ..stepsSpent = json['stepsSpent'] as int
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
        _$enumDecodeNullable(_$AnimationNameEnumMap, json['useAnimationName'])
    ..diceNumbers =
        (json['diceNumbers'] as List)?.map((e) => e as int)?.toList()
    ..explain =
        _$enumDecodeNullable(_$ActionExplanationEnumMap, json['explain'])
    ..explainFirstValue = json['explainFirstValue'] as String
    ..itemDrops = json['itemDrops'] == null
        ? null
        : ItemDrops.fromJson(json['itemDrops'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UnitCreateOrUpdateActionToJson(
    UnitCreateOrUpdateAction instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unitId', instance.unitId);
  writeNotNull('actionId', instance.actionId);
  writeNotNull('stepsSpent', instance.stepsSpent);
  writeNotNull('steps', instance.steps);
  writeNotNull('health', instance.health);
  writeNotNull('buffs', instance.buffs?.map((e) => e?.toJson())?.toList());
  writeNotNull('actions', instance.actions);
  writeNotNull('changeToTypeName', instance.changeToTypeName);
  writeNotNull('moveToFieldId', instance.moveToFieldId);
  writeNotNull('transferToPlayerId', instance.transferToPlayerId);
  writeNotNull(
      'useAnimationName', _$AnimationNameEnumMap[instance.useAnimationName]);
  writeNotNull('diceNumbers', instance.diceNumbers);
  writeNotNull('explain', _$ActionExplanationEnumMap[instance.explain]);
  writeNotNull('explainFirstValue', instance.explainFirstValue);
  writeNotNull('itemDrops', instance.itemDrops?.toJson());
  return val;
}

const _$AnimationNameEnumMap = <AnimationName, dynamic>{
  AnimationName.move: 'move'
};

const _$ActionExplanationEnumMap = <ActionExplanation, dynamic>{
  ActionExplanation.unitAttacking: 'unitAttacking',
  ActionExplanation.unitGotDamage: 'unitGotDamage',
  ActionExplanation.unitHealing: 'unitHealing',
  ActionExplanation.unitHealed: 'unitHealed'
};

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
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
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

const _$UnitTypeTagEnumMap = <UnitTypeTag, dynamic>{
  UnitTypeTag.undead: 'undead',
  UnitTypeTag.ethernal: 'ethernal',
  UnitTypeTag.mechanic: 'mechanic'
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
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
    ..unitTypeDataVersion = json['unitTypeDataVersion'] as int
    ..unitTypeVersion = json['unitTypeVersion'] as int
    ..imageName = json['imageName'] as String
    ..iconName = json['iconName'] as String
    ..bigImageName = json['bigImageName'] as String
    ..abilities = json['abilities'] == null
        ? null
        : AbilitiesEnvelope.fromJson(json['abilities'] as Map<String, dynamic>);
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
      'imageName': instance.imageName,
      'iconName': instance.iconName,
      'bigImageName': instance.bigImageName,
      'abilities': instance.abilities?.toJson()
    };

UnitTypeEnvelope _$UnitTypeEnvelopeFromJson(Map<String, dynamic> json) {
  return UnitTypeEnvelope()
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
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
    ..unitTypeDataVersion = json['unitTypeDataVersion'] as int
    ..unitTypeVersion = json['unitTypeVersion'] as int
    ..imageName = json['imageName'] as String
    ..iconName = json['iconName'] as String
    ..bigImageName = json['bigImageName'] as String
    ..abilities = json['abilities'] == null
        ? null
        : AbilitiesEnvelope.fromJson(json['abilities'] as Map<String, dynamic>)
    ..authorEmail = json['authorEmail'] as String
    ..created = json['created'] as String;
}

Map<String, dynamic> _$UnitTypeEnvelopeToJson(UnitTypeEnvelope instance) =>
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
      'imageName': instance.imageName,
      'iconName': instance.iconName,
      'bigImageName': instance.bigImageName,
      'abilities': instance.abilities?.toJson(),
      'authorEmail': instance.authorEmail,
      'created': instance.created
    };

FieldEnvelope _$FieldEnvelopeFromJson(Map<String, dynamic> json) {
  return FieldEnvelope()
    ..terrain = _$enumDecodeNullable(_$TerrainEnumMap, json['terrain']);
}

Map<String, dynamic> _$FieldEnvelopeToJson(FieldEnvelope instance) =>
    <String, dynamic>{'terrain': _$TerrainEnumMap[instance.terrain]};

const _$TerrainEnumMap = <Terrain, dynamic>{
  Terrain.grass: 'grass',
  Terrain.rock: 'rock',
  Terrain.water: 'water',
  Terrain.forest: 'forest'
};

World _$WorldFromJson(Map<String, dynamic> json) {
  return World()
    ..width = json['width'] as int
    ..height = json['height'] as int
    ..baseTerrain = _$enumDecodeNullable(_$TerrainEnumMap, json['baseTerrain'])
    ..fields = (json['fields'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k,
          e == null ? null : FieldEnvelope.fromJson(e as Map<String, dynamic>)),
    )
    ..startingFieldIds =
        (json['startingFieldIds'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$WorldToJson(World instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'baseTerrain': _$TerrainEnumMap[instance.baseTerrain],
      'fields': instance.fields?.map((k, e) => MapEntry(k, e?.toJson())),
      'startingFieldIds': instance.startingFieldIds
    };

Tale _$TaleFromJson(Map<String, dynamic> json) {
  return Tale()
    ..name = json['name'] as String
    ..langs = (json['langs'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          _$enumDecodeNullable(_$LangEnumMap, k),
          (e as Map<String, dynamic>)?.map(
            (k, e) => MapEntry(k, e as String),
          )),
    )
    ..langName = (json['langName'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
    ..world = json['world'] == null
        ? null
        : World.fromJson(json['world'] as Map<String, dynamic>)
    ..unitTypes = (json['unitTypes'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : UnitType.fromJson(e as Map<String, dynamic>)),
    )
    ..players = (json['players'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Player.fromJson(e as Map<String, dynamic>)),
    )
    ..playerOnMoveIds =
        (json['playerOnMoveIds'] as List)?.map((e) => e as String)?.toList()
    ..units = (json['units'] as List)
        ?.map((e) => e == null
            ? null
            : UnitCreateOrUpdateAction.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TaleToJson(Tale instance) => <String, dynamic>{
      'name': instance.name,
      'langs': instance.langs?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'langName':
          instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
      'world': instance.world?.toJson(),
      'unitTypes': instance.unitTypes?.map((k, e) => MapEntry(k, e?.toJson())),
      'players': instance.players?.map((k, e) => MapEntry(k, e?.toJson())),
      'playerOnMoveIds': instance.playerOnMoveIds,
      'units': instance.units?.map((e) => e?.toJson())?.toList()
    };

Assets _$AssetsFromJson(Map<String, dynamic> json) {
  return Assets()
    ..images = (json['images'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Image.fromJson(e as Map<String, dynamic>)),
    );
}

Map<String, dynamic> _$AssetsToJson(Assets instance) => <String, dynamic>{
      'images': instance.images?.map((k, e) => MapEntry(k, e?.toJson()))
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

Dialog _$DialogFromJson(Map<String, dynamic> json) {
  return Dialog()..name = json['name'] as String;
}

Map<String, dynamic> _$DialogToJson(Dialog instance) =>
    <String, dynamic>{'name': instance.name};

TaleEnvelope _$TaleEnvelopeFromJson(Map<String, dynamic> json) {
  return TaleEnvelope()
    ..authorEmail = json['authorEmail'] as String
    ..tale = json['tale'] == null
        ? null
        : TaleInnerEnvelope.fromJson(json['tale'] as Map<String, dynamic>)
    ..lobby = json['lobby'] == null
        ? null
        : LobbyTale.fromJson(json['lobby'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TaleEnvelopeToJson(TaleEnvelope instance) =>
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
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
    ..langs = (json['langs'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          _$enumDecodeNullable(_$LangEnumMap, k),
          (e as Map<String, dynamic>)?.map(
            (k, e) => MapEntry(k, e as String),
          )),
    )
    ..taleVersion = json['taleVersion'] as int
    ..world = json['world'] == null
        ? null
        : World.fromJson(json['world'] as Map<String, dynamic>)
    ..aiPlayers = (json['aiPlayers'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Player.fromJson(e as Map<String, dynamic>)),
    )
    ..events = (json['events'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Event.fromJson(e as Map<String, dynamic>)),
    )
    ..dialogs = (json['dialogs'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Dialog.fromJson(e as Map<String, dynamic>)),
    )
    ..units = (json['units'] as List)
        ?.map((e) => e == null
            ? null
            : UnitCreateOrUpdateAction.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..humanPlayerIds =
        (json['humanPlayerIds'] as List)?.map((e) => e as String)?.toList()
    ..taleAttributes = json['taleAttributes'] as Map<String, dynamic>
    ..triggers = json['triggers'] == null
        ? null
        : Triggers.fromJson(json['triggers'] as Map<String, dynamic>)
    ..experienceForHeroes = json['experienceForHeroes'] as int;
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
      'humanPlayerIds': instance.humanPlayerIds,
      'taleAttributes': instance.taleAttributes,
      'triggers': instance.triggers?.toJson(),
      'experienceForHeroes': instance.experienceForHeroes
    };

TaleInnerCompiled _$TaleInnerCompiledFromJson(Map<String, dynamic> json) {
  return TaleInnerCompiled()
    ..name = json['name'] as String
    ..langs = (json['langs'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          _$enumDecodeNullable(_$LangEnumMap, k),
          (e as Map<String, dynamic>)?.map(
            (k, e) => MapEntry(k, e as String),
          )),
    )
    ..langName = (json['langName'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
    ..taleVersion = json['taleVersion'] as int
    ..world = json['world'] == null
        ? null
        : World.fromJson(json['world'] as Map<String, dynamic>)
    ..aiPlayers = (json['aiPlayers'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Player.fromJson(e as Map<String, dynamic>)),
    )
    ..events = (json['events'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Event.fromJson(e as Map<String, dynamic>)),
    )
    ..dialogs = (json['dialogs'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Dialog.fromJson(e as Map<String, dynamic>)),
    )
    ..units = (json['units'] as List)
        ?.map((e) => e == null
            ? null
            : UnitCreateOrUpdateAction.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..humanPlayerIds =
        (json['humanPlayerIds'] as List)?.map((e) => e as String)?.toList()
    ..images = (json['images'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Image.fromJson(e as Map<String, dynamic>)),
    )
    ..unitTypes = (json['unitTypes'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          e == null
              ? null
              : UnitTypeCompiled.fromJson(e as Map<String, dynamic>)),
    )
    ..triggers = json['triggers'] == null
        ? null
        : Triggers.fromJson(json['triggers'] as Map<String, dynamic>)
    ..experienceForHeroes = json['experienceForHeroes'] as int;
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
      'images': instance.images?.map((k, e) => MapEntry(k, e?.toJson())),
      'unitTypes': instance.unitTypes?.map((k, e) => MapEntry(k, e?.toJson())),
      'triggers': instance.triggers?.toJson(),
      'experienceForHeroes': instance.experienceForHeroes
    };

LobbyTale _$LobbyTaleFromJson(Map<String, dynamic> json) {
  return LobbyTale()
    ..id = json['id'] as String
    ..name = (json['name'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
    ..description = (json['description'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
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
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
    ..description = (json['description'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
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
        _$enumDecodeNullable(_$GameNavigationStateEnumMap, json['newState'])
    ..destroyCurrentTale = json['destroyCurrentTale'] as bool;
}

Map<String, dynamic> _$SetNavigationStateToJson(SetNavigationState instance) =>
    <String, dynamic>{
      'newState': _$GameNavigationStateEnumMap[instance.newState],
      'destroyCurrentTale': instance.destroyCurrentTale
    };

const _$GameNavigationStateEnumMap = <GameNavigationState, dynamic>{
  GameNavigationState.findLobby: 'findLobby',
  GameNavigationState.createGame: 'createGame',
  GameNavigationState.inGame: 'inGame',
  GameNavigationState.loading: 'loading',
  GameNavigationState.inLobby: 'inLobby',
  GameNavigationState.userPanel: 'userPanel',
  GameNavigationState.login: 'login',
  GameNavigationState.heroPanel: 'heroPanel'
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
    ..tale = json['tale'] == null
        ? null
        : Tale.fromJson(json['tale'] as Map<String, dynamic>)
    ..assets = json['assets'] == null
        ? null
        : Assets.fromJson(json['assets'] as Map<String, dynamic>)
    ..playerIdOnThisClientMachine =
        json['playerIdOnThisClientMachine'] as String;
}

Map<String, dynamic> _$TaleDataToJson(TaleData instance) => <String, dynamic>{
      'tale': instance.tale?.toJson(),
      'assets': instance.assets?.toJson(),
      'playerIdOnThisClientMachine': instance.playerIdOnThisClientMachine
    };

TaleUpdate _$TaleUpdateFromJson(Map<String, dynamic> json) {
  return TaleUpdate()
    ..actions = (json['actions'] as List)
        ?.map((e) => e == null
            ? null
            : UnitCreateOrUpdateAction.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..playerOnMoveIds =
        (json['playerOnMoveIds'] as List)?.map((e) => e as String)
    ..newUnitTypesToTale = (json['newUnitTypesToTale'] as List)
        ?.map((e) =>
            e == null ? null : UnitType.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..unitToRemoveIds =
        (json['unitToRemoveIds'] as List)?.map((e) => e as String)?.toList()
    ..newAssetsToTale = json['newAssetsToTale'] == null
        ? null
        : Assets.fromJson(json['newAssetsToTale'] as Map<String, dynamic>)
    ..newPlayersToTale = (json['newPlayersToTale'] as List)
        ?.map((e) =>
            e == null ? null : Player.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..removePlayerId = json['removePlayerId'] as String
    ..banterAction = json['banterAction'] == null
        ? null
        : ShowBanterAction.fromJson(
            json['banterAction'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TaleUpdateToJson(TaleUpdate instance) {
  final val = <String, dynamic>{
    'actions': instance.actions?.map((e) => e?.toJson())?.toList(),
    'playerOnMoveIds': instance.playerOnMoveIds?.toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('newUnitTypesToTale',
      instance.newUnitTypesToTale?.map((e) => e?.toJson())?.toList());
  writeNotNull('unitToRemoveIds', instance.unitToRemoveIds);
  writeNotNull('newAssetsToTale', instance.newAssetsToTale?.toJson());
  writeNotNull('newPlayersToTale',
      instance.newPlayersToTale?.map((e) => e?.toJson())?.toList());
  writeNotNull('removePlayerId', instance.removePlayerId);
  writeNotNull('banterAction', instance.banterAction?.toJson());
  return val;
}

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
  OnServerAction.leaveGame: 'leaveGame',
  OnServerAction.unitTrackAction: 'unitTrackAction',
  OnServerAction.playerGameIntention: 'playerGameIntention',
  OnServerAction.controlsAction: 'controlsAction',
  OnServerAction.setHeroForNextGame: 'setHeroForNextGame'
};

GoToState _$GoToStateFromJson(Map<String, dynamic> json) {
  return GoToState()
    ..newState =
        _$enumDecodeNullable(_$GameNavigationStateEnumMap, json['newState']);
}

Map<String, dynamic> _$GoToStateToJson(GoToState instance) => <String, dynamic>{
      'newState': _$GameNavigationStateEnumMap[instance.newState]
    };

CreateLobby _$CreateLobbyFromJson(Map<String, dynamic> json) {
  return CreateLobby()
    ..taleName = json['taleName'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$CreateLobbyToJson(CreateLobby instance) =>
    <String, dynamic>{'taleName': instance.taleName, 'name': instance.name};

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

PlayerIntention _$PlayerIntentionFromJson(Map<String, dynamic> json) {
  return PlayerIntention()
    ..fieldsId = (json['fieldsId'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$PlayerIntentionToJson(PlayerIntention instance) =>
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
  ControlsActionName.endOfTurn: 'endOfTurn',
  ControlsActionName.unitWillNotPlay: 'unitWillNotPlay'
};

ToAiServerMessage _$ToAiServerMessageFromJson(Map<String, dynamic> json) {
  return ToAiServerMessage()
    ..message = _$enumDecodeNullable(_$OnAiServerActionEnumMap, json['message'])
    ..content = json['content'] as String;
}

Map<String, dynamic> _$ToAiServerMessageToJson(ToAiServerMessage instance) =>
    <String, dynamic>{
      'message': _$OnAiServerActionEnumMap[instance.message],
      'content': instance.content
    };

const _$OnAiServerActionEnumMap = <OnAiServerAction, dynamic>{
  OnAiServerAction.getNextMoveByState: 'getNextMoveByState',
  OnAiServerAction.getNextMoveByUpdate: 'getNextMoveByUpdate'
};

GetNextMoveByState _$GetNextMoveByStateFromJson(Map<String, dynamic> json) {
  return GetNextMoveByState()
    ..responseAction = json['responseAction'] == null
        ? null
        : UnitTrackAction.fromJson(
            json['responseAction'] as Map<String, dynamic>)
    ..requestData = json['requestData'] == null
        ? null
        : Tale.fromJson(json['requestData'] as Map<String, dynamic>)
    ..requestEngine =
        _$enumDecodeNullable(_$AiEngineEnumMap, json['requestEngine'])
    ..idOfAiPlayerOnMove = json['idOfAiPlayerOnMove'] as String;
}

Map<String, dynamic> _$GetNextMoveByStateToJson(GetNextMoveByState instance) =>
    <String, dynamic>{
      'responseAction': instance.responseAction?.toJson(),
      'requestData': instance.requestData?.toJson(),
      'requestEngine': _$AiEngineEnumMap[instance.requestEngine],
      'idOfAiPlayerOnMove': instance.idOfAiPlayerOnMove
    };

GetNextMoveByUpdate _$GetNextMoveByUpdateFromJson(Map<String, dynamic> json) {
  return GetNextMoveByUpdate()
    ..responseAction = json['responseAction'] == null
        ? null
        : UnitTrackAction.fromJson(
            json['responseAction'] as Map<String, dynamic>)
    ..requestUpdateData = json['requestUpdateData'] == null
        ? null
        : TaleUpdate.fromJson(
            json['requestUpdateData'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetNextMoveByUpdateToJson(
        GetNextMoveByUpdate instance) =>
    <String, dynamic>{
      'responseAction': instance.responseAction?.toJson(),
      'requestUpdateData': instance.requestUpdateData?.toJson()
    };

ToUserServerMessage _$ToUserServerMessageFromJson(Map<String, dynamic> json) {
  return ToUserServerMessage()
    ..message =
        _$enumDecodeNullable(_$OnUserServerActionEnumMap, json['message'])
    ..content = json['content'] as String
    ..error = json['error'] as String
    ..innerToken = json['innerToken'] as String;
}

Map<String, dynamic> _$ToUserServerMessageToJson(
        ToUserServerMessage instance) =>
    <String, dynamic>{
      'message': _$OnUserServerActionEnumMap[instance.message],
      'content': instance.content,
      'error': instance.error,
      'innerToken': instance.innerToken
    };

const _$OnUserServerActionEnumMap = <OnUserServerAction, dynamic>{
  OnUserServerAction.getHeroesToCreate: 'getHeroesToCreate',
  OnUserServerAction.createHero: 'createHero',
  OnUserServerAction.getMyHeroes: 'getMyHeroes',
  OnUserServerAction.updateUser: 'updateUser',
  OnUserServerAction.getHeroDetail: 'getHeroDetail',
  OnUserServerAction.updateHero: 'updateHero'
};

ListOfHeroes _$ListOfHeroesFromJson(Map<String, dynamic> json) {
  return ListOfHeroes()
    ..responseHeroes = (json['responseHeroes'] as List)
        ?.map((e) => e == null
            ? null
            : GameHeroEnvelope.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListOfHeroesToJson(ListOfHeroes instance) =>
    <String, dynamic>{
      'responseHeroes':
          instance.responseHeroes?.map((e) => e?.toJson())?.toList()
    };

CreateHeroData _$CreateHeroDataFromJson(Map<String, dynamic> json) {
  return CreateHeroData()
    ..name = json['name'] as String
    ..typeName = json['typeName'] as String
    ..responseHero = json['responseHero'] == null
        ? null
        : GameHeroEnvelope.fromJson(
            json['responseHero'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateHeroDataToJson(CreateHeroData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'typeName': instance.typeName,
      'responseHero': instance.responseHero?.toJson()
    };

GetHeroDetail _$GetHeroDetailFromJson(Map<String, dynamic> json) {
  return GetHeroDetail()
    ..heroId = json['heroId'] as String
    ..responseHero = json['responseHero'] == null
        ? null
        : HeroEnvelope.fromJson(json['responseHero'] as Map<String, dynamic>)
    ..gains = (json['gains'] as List)
        ?.map((e) => e == null
            ? null
            : HeroAfterGameGain.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..gainItems = (json['gainItems'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k,
          e == null ? null : ItemEnvelope.fromJson(e as Map<String, dynamic>)),
    );
}

Map<String, dynamic> _$GetHeroDetailToJson(GetHeroDetail instance) =>
    <String, dynamic>{
      'heroId': instance.heroId,
      'responseHero': instance.responseHero?.toJson(),
      'gains': instance.gains?.map((e) => e?.toJson())?.toList(),
      'gainItems': instance.gainItems?.map((k, e) => MapEntry(k, e?.toJson()))
    };

ToUserServerInnerMessage _$ToUserServerInnerMessageFromJson(
    Map<String, dynamic> json) {
  return ToUserServerInnerMessage()
    ..message =
        _$enumDecodeNullable(_$OnUserServerInnerActionEnumMap, json['message'])
    ..content = json['content'] as String
    ..error = json['error'] as String;
}

Map<String, dynamic> _$ToUserServerInnerMessageToJson(
        ToUserServerInnerMessage instance) =>
    <String, dynamic>{
      'message': _$OnUserServerInnerActionEnumMap[instance.message],
      'content': instance.content,
      'error': instance.error
    };

const _$OnUserServerInnerActionEnumMap = <OnUserServerInnerAction, dynamic>{
  OnUserServerInnerAction.getUserByInnerToken: 'getUserByInnerToken',
  OnUserServerInnerAction.getStartingUnits: 'getStartingUnits',
  OnUserServerInnerAction.setHeroAfterGameGain: 'setHeroAfterGameGain'
};

GetUserByInnerToken _$GetUserByInnerTokenFromJson(Map<String, dynamic> json) {
  return GetUserByInnerToken()
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..innerToken = json['innerToken'] as String;
}

Map<String, dynamic> _$GetUserByInnerTokenToJson(
        GetUserByInnerToken instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'innerToken': instance.innerToken
    };

HeroesAndUnitsOfPlayer _$HeroesAndUnitsOfPlayerFromJson(
    Map<String, dynamic> json) {
  return HeroesAndUnitsOfPlayer()
    ..requestedPlayerEmail = json['requestedPlayerEmail'] as String
    ..requestedHeroId = json['requestedHeroId'] as String
    ..responseHeroes = (json['responseHeroes'] as List)
        ?.map((e) => e == null
            ? null
            : GameHeroEnvelope.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..responseUnits = (json['responseUnits'] as List)
        ?.map((e) => e == null
            ? null
            : UnitTypeCompiled.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HeroesAndUnitsOfPlayerToJson(
        HeroesAndUnitsOfPlayer instance) =>
    <String, dynamic>{
      'requestedPlayerEmail': instance.requestedPlayerEmail,
      'requestedHeroId': instance.requestedHeroId,
      'responseHeroes':
          instance.responseHeroes?.map((e) => e?.toJson())?.toList(),
      'responseUnits': instance.responseUnits?.map((e) => e?.toJson())?.toList()
    };

LoggerMessage _$LoggerMessageFromJson(Map<String, dynamic> json) {
  return LoggerMessage()
    ..message =
        _$enumDecodeNullable(_$LoggerMessageTypeEnumMap, json['message'])
    ..content = json['content'] as String
    ..gameId = json['gameId'] as String;
}

Map<String, dynamic> _$LoggerMessageToJson(LoggerMessage instance) =>
    <String, dynamic>{
      'message': _$LoggerMessageTypeEnumMap[instance.message],
      'content': instance.content,
      'gameId': instance.gameId
    };

const _$LoggerMessageTypeEnumMap = <LoggerMessageType, dynamic>{
  LoggerMessageType.initial: 'initial',
  LoggerMessageType.taleUpdate: 'taleUpdate',
  LoggerMessageType.trace: 'trace'
};

LoggerTale _$LoggerTaleFromJson(Map<String, dynamic> json) {
  return LoggerTale()
    ..initial = json['initial'] == null
        ? null
        : Tale.fromJson(json['initial'] as Map<String, dynamic>)
    ..updates = (json['updates'] as List)
        ?.map((e) =>
            e == null ? null : TaleUpdate.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..trace = (json['trace'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$LoggerTaleToJson(LoggerTale instance) =>
    <String, dynamic>{
      'initial': instance.initial?.toJson(),
      'updates': instance.updates?.map((e) => e?.toJson())?.toList(),
      'trace': instance.trace
    };

AbilitiesEnvelope _$AbilitiesEnvelopeFromJson(Map<String, dynamic> json) {
  return AbilitiesEnvelope()
    ..move = json['move'] == null
        ? null
        : MoveAbilityEnvelope.fromJson(json['move'] as Map<String, dynamic>)
    ..attack = json['attack'] == null
        ? null
        : AttackAbilityEnvelope.fromJson(json['attack'] as Map<String, dynamic>)
    ..shoot = json['shoot'] == null
        ? null
        : ShootAbilityEnvelope.fromJson(json['shoot'] as Map<String, dynamic>)
    ..heal = json['heal'] == null
        ? null
        : HealAbilityEnvelope.fromJson(json['heal'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AbilitiesEnvelopeToJson(AbilitiesEnvelope instance) =>
    <String, dynamic>{
      'move': instance.move?.toJson(),
      'attack': instance.attack?.toJson(),
      'shoot': instance.shoot?.toJson(),
      'heal': instance.heal?.toJson()
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

ShootAbilityEnvelope _$ShootAbilityEnvelopeFromJson(Map<String, dynamic> json) {
  return ShootAbilityEnvelope()
    ..steps = json['steps'] as int
    ..attack = json['attack'] as String;
}

Map<String, dynamic> _$ShootAbilityEnvelopeToJson(
        ShootAbilityEnvelope instance) =>
    <String, dynamic>{'steps': instance.steps, 'attack': instance.attack};

ItemEnvelope _$ItemEnvelopeFromJson(Map<String, dynamic> json) {
  return ItemEnvelope()
    ..possiblePositions = (json['possiblePositions'] as List)
        ?.map((e) => _$enumDecodeNullable(_$ItemPositionEnumMap, e))
        ?.toList()
    ..id = json['id'] as String
    ..typeName = json['typeName'] as String
    ..langName = (json['langName'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$LangEnumMap, k), e as String),
    )
    ..mapImageData = json['mapImageData'] as String
    ..inventoryImageData = json['inventoryImageData'] as String
    ..heroId = json['heroId'] as String
    ..weight = json['weight'] as num ?? 0
    ..armorPoints = json['armorPoints'] as num ?? 0
    ..speedPoints = json['speedPoints'] as num ?? 0
    ..healthBonus = json['healthBonus'] as num ?? 0
    ..manaBonus = json['manaBonus'] as num ?? 0
    ..strengthBonus = json['strengthBonus'] as num ?? 0
    ..agilityBonus = json['agilityBonus'] as num ?? 0
    ..intelligenceBonus = json['intelligenceBonus'] as num ?? 0
    ..spiritualityBonus = json['spiritualityBonus'] as num ?? 0
    ..energyBonus = json['energyBonus'] as num ?? 0
    ..precisionBonus = json['precisionBonus'] as num ?? 0
    ..recommendedPrice = json['recommendedPrice'] as int ?? 100
    ..sellPrice = json['sellPrice'] as int
    ..requiredLevel = json['requiredLevel'] as int ?? 0
    ..weapon = json['weapon'] == null
        ? null
        : WeaponEnvelope.fromJson(json['weapon'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ItemEnvelopeToJson(ItemEnvelope instance) {
  final val = <String, dynamic>{
    'possiblePositions': instance.possiblePositions
        ?.map((e) => _$ItemPositionEnumMap[e])
        ?.toList(),
    'id': instance.id,
    'typeName': instance.typeName,
    'langName': instance.langName?.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
    'mapImageData': instance.mapImageData,
    'inventoryImageData': instance.inventoryImageData,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('heroId', instance.heroId);
  writeNotNull('weight', instance.weight);
  writeNotNull('armorPoints', instance.armorPoints);
  writeNotNull('speedPoints', instance.speedPoints);
  writeNotNull('healthBonus', instance.healthBonus);
  writeNotNull('manaBonus', instance.manaBonus);
  writeNotNull('strengthBonus', instance.strengthBonus);
  writeNotNull('agilityBonus', instance.agilityBonus);
  writeNotNull('intelligenceBonus', instance.intelligenceBonus);
  writeNotNull('spiritualityBonus', instance.spiritualityBonus);
  writeNotNull('energyBonus', instance.energyBonus);
  writeNotNull('precisionBonus', instance.precisionBonus);
  writeNotNull('recommendedPrice', instance.recommendedPrice);
  val['sellPrice'] = instance.sellPrice;
  writeNotNull('requiredLevel', instance.requiredLevel);
  writeNotNull('weapon', instance.weapon?.toJson());
  return val;
}

const _$ItemPositionEnumMap = <ItemPosition, dynamic>{
  ItemPosition.head: 'head',
  ItemPosition.neck: 'neck',
  ItemPosition.body: 'body',
  ItemPosition.elbows: 'elbows',
  ItemPosition.leftHand: 'leftHand',
  ItemPosition.rightHand: 'rightHand',
  ItemPosition.leftWrist: 'leftWrist',
  ItemPosition.rightWrist: 'rightWrist',
  ItemPosition.legs: 'legs',
  ItemPosition.bothHands: 'bothHands'
};

WeaponEnvelope _$WeaponEnvelopeFromJson(Map<String, dynamic> json) {
  return WeaponEnvelope()
    ..requiredStrength = json['requiredStrength'] as int ?? 0
    ..requiredAgility = json['requiredAgility'] as int ?? 0
    ..requiredIntelligence = json['requiredIntelligence'] as int ?? 0
    ..baseAttack = (json['baseAttack'] as List)?.map((e) => e as int)?.toList()
    ..bonusAttack =
        (json['bonusAttack'] as List)?.map((e) => e as int)?.toList() ??
            [0, 0, 0, 0, 0, 0]
    ..range = json['range'] as int ?? 0;
}

Map<String, dynamic> _$WeaponEnvelopeToJson(WeaponEnvelope instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('requiredStrength', instance.requiredStrength);
  writeNotNull('requiredAgility', instance.requiredAgility);
  writeNotNull('requiredIntelligence', instance.requiredIntelligence);
  val['baseAttack'] = instance.baseAttack;
  writeNotNull('bonusAttack', instance.bonusAttack);
  writeNotNull('range', instance.range);
  return val;
}

ItemDrops _$ItemDropsFromJson(Map<String, dynamic> json) {
  return ItemDrops()
    ..maxItemDrops = json['maxItemDrops'] as int ?? 1
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ItemDrop.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ItemDropsToJson(ItemDrops instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('maxItemDrops', instance.maxItemDrops);
  val['items'] = instance.items?.map((e) => e?.toJson())?.toList();
  return val;
}

ItemDrop _$ItemDropFromJson(Map<String, dynamic> json) {
  return ItemDrop()
    ..probability = (json['probability'] as num)?.toDouble() ?? 1
    ..byName = json['byName'] as String
    ..byItemPriceFrom = json['byItemPriceFrom'] as int
    ..byItemPriceTo = json['byItemPriceTo'] as int;
}

Map<String, dynamic> _$ItemDropToJson(ItemDrop instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('probability', instance.probability);
  writeNotNull('byName', instance.byName);
  writeNotNull('byItemPriceFrom', instance.byItemPriceFrom);
  writeNotNull('byItemPriceTo', instance.byItemPriceTo);
  return val;
}

GameHeroEnvelope _$GameHeroEnvelopeFromJson(Map<String, dynamic> json) {
  return GameHeroEnvelope()
    ..id = json['id'] as String
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

Map<String, dynamic> _$GameHeroEnvelopeToJson(GameHeroEnvelope instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'level': instance.level,
    'name': instance.name,
    'type': instance.type?.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unit', instance.unit?.toJson());
  return val;
}

HeroEnvelope _$HeroEnvelopeFromJson(Map<String, dynamic> json) {
  return HeroEnvelope()
    ..gameHeroEnvelope = json['gameHeroEnvelope'] == null
        ? null
        : GameHeroEnvelope.fromJson(
            json['gameHeroEnvelope'] as Map<String, dynamic>)
    ..inventoryItems = (json['inventoryItems'] as List)
        ?.map((e) =>
            e == null ? null : ItemEnvelope.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..equippedItemNames =
        (json['equippedItemNames'] as Map<String, dynamic>)?.map(
      (k, e) =>
          MapEntry(_$enumDecodeNullable(_$ItemPositionEnumMap, k), e as String),
    )
    ..equippedItems = (json['equippedItems'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$ItemPositionEnumMap, k),
          e == null ? null : ItemEnvelope.fromJson(e as Map<String, dynamic>)),
    )
    ..strength = json['strength'] as int
    ..agility = json['agility'] as int
    ..intelligence = json['intelligence'] as int
    ..precision = json['precision'] as int
    ..spirituality = json['spirituality'] as int
    ..energy = json['energy'] as int
    ..experience = json['experience'] as int
    ..money = json['money'] as int;
}

Map<String, dynamic> _$HeroEnvelopeToJson(HeroEnvelope instance) {
  final val = <String, dynamic>{
    'gameHeroEnvelope': instance.gameHeroEnvelope?.toJson(),
    'inventoryItems':
        instance.inventoryItems?.map((e) => e?.toJson())?.toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'equippedItemNames',
      instance.equippedItemNames
          ?.map((k, e) => MapEntry(_$ItemPositionEnumMap[k], e)));
  writeNotNull(
      'equippedItems',
      instance.equippedItems
          ?.map((k, e) => MapEntry(_$ItemPositionEnumMap[k], e?.toJson())));
  val['strength'] = instance.strength;
  val['agility'] = instance.agility;
  val['intelligence'] = instance.intelligence;
  val['precision'] = instance.precision;
  val['spirituality'] = instance.spirituality;
  val['energy'] = instance.energy;
  val['experience'] = instance.experience;
  val['money'] = instance.money;
  return val;
}

HeroUpdate _$HeroUpdateFromJson(Map<String, dynamic> json) {
  return HeroUpdate()
    ..heroId = json['heroId'] as String
    ..name = json['name'] as String
    ..strength = json['strength'] as int
    ..agility = json['agility'] as int
    ..intelligence = json['intelligence'] as int
    ..precision = json['precision'] as int
    ..spirituality = json['spirituality'] as int
    ..energy = json['energy'] as int
    ..pickGainId = json['pickGainId'] as int
    ..itemManipulations = (json['itemManipulations'] as List)
        ?.map((e) => e == null
            ? null
            : ItemManipulation.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..responseHero = json['responseHero'] == null
        ? null
        : HeroEnvelope.fromJson(json['responseHero'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HeroUpdateToJson(HeroUpdate instance) =>
    <String, dynamic>{
      'heroId': instance.heroId,
      'name': instance.name,
      'strength': instance.strength,
      'agility': instance.agility,
      'intelligence': instance.intelligence,
      'precision': instance.precision,
      'spirituality': instance.spirituality,
      'energy': instance.energy,
      'pickGainId': instance.pickGainId,
      'itemManipulations':
          instance.itemManipulations?.map((e) => e?.toJson())?.toList(),
      'responseHero': instance.responseHero?.toJson()
    };

ItemManipulation _$ItemManipulationFromJson(Map<String, dynamic> json) {
  return ItemManipulation()
    ..equipItemId = json['equipItemId'] as String
    ..equipTo = _$enumDecodeNullable(_$ItemPositionEnumMap, json['equipTo'])
    ..moveToInventoryItemId = json['moveToInventoryItemId'] as String
    ..sellItemId = json['sellItemId'] as String;
}

Map<String, dynamic> _$ItemManipulationToJson(ItemManipulation instance) =>
    <String, dynamic>{
      'equipItemId': instance.equipItemId,
      'equipTo': _$ItemPositionEnumMap[instance.equipTo],
      'moveToInventoryItemId': instance.moveToInventoryItemId,
      'sellItemId': instance.sellItemId
    };

HeroAfterGameGain _$HeroAfterGameGainFromJson(Map<String, dynamic> json) {
  return HeroAfterGameGain()
    ..id = json['id'] as int
    ..xp = json['xp'] as int
    ..money = json['money'] as int
    ..itemTypeNames =
        (json['itemTypeNames'] as List)?.map((e) => e as String)?.toList()
    ..heroId = json['heroId'] as String;
}

Map<String, dynamic> _$HeroAfterGameGainToJson(HeroAfterGameGain instance) =>
    <String, dynamic>{
      'id': instance.id,
      'xp': instance.xp,
      'money': instance.money,
      'itemTypeNames': instance.itemTypeNames,
      'heroId': instance.heroId
    };

HealAbilityEnvelope _$HealAbilityEnvelopeFromJson(Map<String, dynamic> json) {
  return HealAbilityEnvelope()
    ..steps = json['steps'] as int
    ..effect = json['effect'] as String
    ..range = json['range'] as String;
}

Map<String, dynamic> _$HealAbilityEnvelopeToJson(
        HealAbilityEnvelope instance) =>
    <String, dynamic>{
      'steps': instance.steps,
      'effect': instance.effect,
      'range': instance.range
    };
