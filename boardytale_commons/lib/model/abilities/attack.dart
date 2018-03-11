part of model;

class AttackAbility extends Ability {
  @override
  Ability clone() {
    return new AttackAbility()..fromMap(toMap());
  }

  @override
  void perform(Track track) {
    // TODO: implement perform
  }

  @override
  void show(Track track) {
    // TODO: implement show
  }

  @override
  void fromMap(Map<String, dynamic> ability) {
    super.fromMap(ability);
  }
}
