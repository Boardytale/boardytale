part of boardytale.client.abilities;

class ClientMoveAbility extends shared.MoveAbility implements ClientAbility {
  @override
  void show(shared.Unit invoker, shared.Track track) {
    highlights = [];
    for (int i = 1; i < track.fields.length; i++) {
      highlights.add(FieldHighlight()..field=track.fields[i]..highlightName=HighlightName.track);
    }
  }

  @override
  List<FieldHighlight> highlights = [];
}
