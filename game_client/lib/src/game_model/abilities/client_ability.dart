part of boardytale.client.abilities;

List<core.Ability> createClientAbilityList(core.AbilitiesEnvelope envelope) {
  List<core.Ability> out = [];
  if (envelope.move != null) {
    out.add(ClientMoveAbility()..fromEnvelope(envelope.move));
  }
  if (envelope.attack != null) {
    out.add(ClientAttackAbility()..fromEnvelope(envelope.attack));
  }
  if (envelope.shoot != null) {
    out.add(ClientShootAbility()..fromEnvelope(envelope.shoot));
  }
  if (envelope.heal != null) {
    out.add(ClientHealAbility()..fromEnvelope(envelope.heal));
  }
  return out;
}

abstract class ClientAbility {
  List<FieldHighlight> highlights = [];

  void show(core.Unit unitOnMove, core.Track track);
}

class NoActionPossible extends ClientAbility {
  @override
  List<FieldHighlight> highlights = [];

  @override
  void show(core.Unit unitOnMove, core.Track track) {
    highlights = [];
    for (int i = 1; i < track.fields.length; i++) {
      highlights.add(FieldHighlight()
        ..field = track.fields[i]
        ..highlightName = HighlightName.noAction);
    }
  }
}

class FieldHighlight {
  HighlightName highlightName;
  core.Field field;
}

enum HighlightName { track, attack, shoot, noGo, heal, noAction }
