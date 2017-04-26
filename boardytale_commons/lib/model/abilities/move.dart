part of model;

class MoveAbility extends Ability{
  String imgData;


  @override
  void perform(Track track) {
    // TODO: implement perform
  }

  @override
  void show(Track track) {

  }

  @override
  Ability clone() {
    return new MoveAbility();
  }

  @override
  void fromMap(Map ability) {
    super.fromMap(ability);
  }
}