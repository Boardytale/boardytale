part of boardytale.client.abilities;

class ClientAttackAbility extends shared.AttackAbility implements ClientAbility {
  @override
  void show(shared.Unit invoker, shared.Track track) {
    // TODO: implement perform
  }

  bool validate(shared.Unit invoker, shared.Track track) {
    return false;
  }

  @override
  List<FieldHighlight> highlights = [];

}
