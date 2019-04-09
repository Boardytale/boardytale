part of model;

@JsonSerializable()
class TaleAction {
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String actionId;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  Player newPlayerToTale;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  List<String> playersOnMove;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  List<UnitCreateOrUpdateAction> newUnitsToTale;

  static TaleAction fromJson(Map json) {
    return _$TaleActionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TaleActionToJson(this);
  }

}

