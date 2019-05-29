part of model;

@Typescript()
@JsonSerializable()
class AbilitiesEnvelope {
  @TypescriptOptional()
  MoveAbilityEnvelope move;

  @TypescriptOptional()
  AttackAbilityEnvelope attack;

  @TypescriptOptional()
  ShootAbilityEnvelope shoot;

  @TypescriptOptional()
  HealAbilityEnvelope heal;

  static AbilitiesEnvelope fromJson(Map json) {
    return _$AbilitiesEnvelopeFromJson(json);
  }

  Map toJson() {
    return _$AbilitiesEnvelopeToJson(this);
  }
}

@Typescript()
enum Targets {
  @JsonValue('me')
  me,
  @JsonValue('own')
  own,
  @JsonValue('ally')
  ally,
  @JsonValue('enemy')
  enemy,
  @JsonValue('corpse')
  corpse,
  @JsonValue('empty')
  empty,
}

@Typescript()
enum TargetModificators {
  @JsonValue('wounded')
  wounded,
  @JsonValue('notUndead')
  notUndead,
  @JsonValue('undead')
  undead,
}

@Typescript()
enum AbilityReach {
  @JsonValue('mineTurnStart')
  mineTurnStart,
  @JsonValue('reachMove')
  move,
  @JsonValue('reachHand')
  hand,
  @JsonValue('reachArrow')
  reachArrow,
  @JsonValue('reachConjuration')
  conjuration,
}

abstract class Ability {
  AbilityName get name;

  String image;
  Map<Targets, List<TargetModificators>> targets;

  @TypescriptSkip()
  @TypescriptOptional()
  AbilityReach get reach;

  bool validate(Unit unitOnMove, Track track) {
    throw "not implemented";
  }

  /**
   *  use null to inherit unitOnMove speed
   *  use "+1" "-1" to modify unitOnMove steps
   *  use "5" to set specific value
   *  every value about 7 is cut
   */
  int resolveCurrentSteps(Unit unitOnMove, String steps) {
    return this.resolveStandardModificator(unitOnMove.steps, steps);
  }

  Track modifyTrack(Unit unitOnMove, Track track) {
    return track;
  }

  int resolveStandardModificator(int value, String modificator, {min: 0, max: 7}) {
    if (modificator != null) {
      if (modificator.contains("+")) {
        value += int.parse(modificator.replaceAll("+", ""));
      } else if (modificator.contains("-")) {
        value -= int.parse(modificator.replaceAll("-", ""));
      } else {
        value = int.parse(modificator);
      }
    } else {
      return value;
    }
    if (value > max) {
      value = max;
    }
    if (value < min) {
      value = min;
    }
    return value;
  }

  List<int> resolveSixNumberEffect(List<int> originalItems, String modificator, {min: 0, max: 9}) {
    if (modificator == null) {
      return originalItems;
    }
    List<String> modificatorItems = modificator.split(" ");
    List<int> out = [];
    for (int i = 0; i < 6; i++) {
      out.add(resolveStandardModificator(originalItems[i], modificatorItems[i], min: min, max: max));
    }
    return out;
  }
}

@Typescript()
enum AbilityName {
  @JsonValue('move')
  move,
  @JsonValue('attack')
  attack,
  @JsonValue('shoot')
  shoot,
  @JsonValue('heal')
  heal,
  @JsonValue('revive')
  revive,
  @JsonValue('hand_heal')
  hand_heal,
  @JsonValue('boost')
  boost,
  @JsonValue('linked_move')
  linked_move,
  @JsonValue('step_shoot')
  step_shoot,
  @JsonValue('light')
  light,
  @JsonValue('summon')
  summon,
  @JsonValue('dismiss')
  dismiss,
  @JsonValue('change_type')
  change_type,
  @JsonValue('regeneration')
  regeneration,
  @JsonValue('dark_shoot')
  dark_shoot,
  @JsonValue('teleport')
  teleport,
  @JsonValue('raise')
  raise
}
