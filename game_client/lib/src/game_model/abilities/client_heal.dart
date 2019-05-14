part of boardytale.client.abilities;

class ClientHealAbility extends core.HealAbility implements ClientAbility {
  @override
  void show(core.Unit unitOnMove, core.Track track) {
    highlights = [];
    highlights.add(FieldHighlight()
      ..field = track.fields.last
      ..highlightName = HighlightName.heal);
  }

  @override
  List<FieldHighlight> highlights = [];
}
