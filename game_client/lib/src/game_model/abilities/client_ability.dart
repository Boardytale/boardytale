part of boardytale.client.abilities;

List<core.Ability> createClientAbilityList(core.AbilitiesEnvelope envelope) {
  List<core.Ability> out = [];
  if (envelope.move != null) {
    out.add(ClientMoveAbility()..fromEnvelope(envelope.move));
  }
  if (envelope.attack != null) {
    out.add(ClientAttackAbility()..fromEnvelope(envelope.attack));
  }
  return out;
}

abstract class ClientAbility {
  List<FieldHighlight> highlights = [];
  void show(core.Unit unitOnMove, core.Track track);
}

class FieldHighlight {
  HighlightName highlightName;
  core.Field field;
}

enum HighlightName { track, attack, shoot }
