part of model;

class AttackAbility extends Ability {

  @override
  void fromMap(Map<String, dynamic> ability) {
    super.fromMap(ability);
  }

  @override
  String get reach => Ability.REACH_HAND;
}
