part of model;

@JsonSerializable(nullable: false)
@Typescript()
class Triggers {

  // Cannot be optional. Null condition is not generated on lists. Probably json_serializable issue.
  // TODO: report issue to https://github.com/dart-lang/json_serializable
  List<Trigger> onInit = [];
  List<UnitTrigger> onUnitDies = [];

  static Triggers fromJson(Map data) {
    return _$TriggersFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$TriggersToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class Trigger {
  @JsonKey(includeIfNull: false)
  @TypescriptOptional()
  Condition condition;
  Action action;

  static Trigger fromJson(Map data) {
    return _$TriggerFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$TriggerToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class UnitTrigger {
  @TypescriptOptional()
  Condition condition;
  Action action;

  static UnitTrigger fromJson(Map data) {
    return _$UnitTriggerFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitTriggerToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class Condition {
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  AndCondition andCondition;

  static Condition fromJson(Map<String, dynamic> json) {
    return _$ConditionFromJson(json);
  }

  Map toJson() {
    return _$ConditionToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class AndCondition {
  Condition condition1;
  Condition condition2;

  static AndCondition fromJson(Map<String, dynamic> json) {
    return _$AndConditionFromJson(json);
  }

  Map toJson() {
    return _$AndConditionToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class EqualCondition {
  String value;
  dynamic equalsTo;

  static EqualCondition fromJson(Map<String, dynamic> json) {
    return _$EqualConditionFromJson(json);
  }

  Map toJson() {
    return _$EqualConditionToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class Action {
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  UnitCreateOrUpdateAction unitAction;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  VictoryCheckAction victoryCheckAction;

  static Action fromJson(Map<String, dynamic> json) {
    return _$ActionFromJson(json);
  }

  Map toJson() {
    return _$ActionToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class VictoryCheckAction {
  List<String> allTeamsEliminatedForWin;
  List<String> anyOfTeamsEliminatedForWin;
  List<String> anyOfTeamsEliminatedForLost;
  List<String> allOfTeamsEliminatedForLost;
  List<String> unitsEliminatedForLost;
  static VictoryCheckAction fromJson(Map<String, dynamic> json) {
    return _$VictoryCheckActionFromJson(json);
  }

  Map toJson() {
    return _$VictoryCheckActionToJson(this);
  }
}
