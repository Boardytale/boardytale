part of boardytale.client.abilities;

class ClientMoveAbility extends core.MoveAbility implements ClientAbility {
  @override
  void show(core.Unit unitOnMove, core.Track track) {
    highlights = [];
    for (int i = 1; i < track.fields.length; i++) {
      highlights.add(FieldHighlight()..field=track.fields[i]..highlightName=HighlightName.track);
    }
  }

  @override
  List<FieldHighlight> highlights = [];
}
