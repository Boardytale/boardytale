part of boardytale.client.abilities;

class ShootAbility extends core.ShootAbility implements ClientAbility {
  @override
  void show(core.Unit unitOnMove, core.Track track) {
    highlights = [];
//    for (int i = 1; i < track.fields.length - 1; i++) {
//      highlights.add(FieldHighlight()
//        ..field = track.fields[i]
//        ..highlightName = HighlightName.track);
//    }
    highlights.add(FieldHighlight()
      ..field = track.fields.last
      ..highlightName = HighlightName.shoot);
  }

  @override
  List<FieldHighlight> highlights = [];
}
