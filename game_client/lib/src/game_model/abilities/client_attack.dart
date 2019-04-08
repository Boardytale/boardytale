part of boardytale.client.abilities;

class ClientAttackAbility extends shared.AttackAbility implements ClientAbility {
  @override
  void show(shared.Unit unitOnMove, shared.Track track) {
    highlights = [];
    for (int i = 1; i < track.fields.length - 1; i++) {
      highlights.add(FieldHighlight()
        ..field = track.fields[i]
        ..highlightName = HighlightName.track);
    }
    highlights.add(FieldHighlight()
      ..field = track.fields.last
      ..highlightName = HighlightName.attack);
  }

  @override
  List<FieldHighlight> highlights = [];
}
