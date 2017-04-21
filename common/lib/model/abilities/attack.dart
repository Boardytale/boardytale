part of model;


class AttackAbility extends Ability{
  
  @override
  Ability clone() {
    return new AttackAbility();
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
  void fromJson(Map ability) {
    super.fromJson(ability);
  }
}
