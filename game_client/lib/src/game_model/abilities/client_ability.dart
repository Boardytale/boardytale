part of boardytale.client.abilities;

List<shared.Ability> createClientAbilityList(shared.AbilitiesEnvelope envelope){
  List<shared.Ability> out = [];
  if(envelope.move != null){
    out.add(ClientMoveAbility()..fromEnvelope(envelope.move));
  }
  if(envelope.attack != null){
    out.add(ClientAttackAbility()..fromEnvelope(envelope.attack));
  }
  return out;
}

abstract class ClientAbility {
  List<FieldHighlight> highlights = [];
  void show(shared.Unit unitOnMove, shared.Track track);
}

class FieldHighlight {
  HighlightName highlightName;
  shared.Field field;
}

enum HighlightName{
  track,
  attack
}
