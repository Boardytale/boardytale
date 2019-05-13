part of boardytale.client.abilities;

class ClientMoveAbility extends core.MoveAbility implements ClientAbility {
  @override
  void show(core.Unit unitOnMove, core.Track track) {
    int currentSteps = resolveCurrentSteps(unitOnMove, steps);
    highlights = [];
    for (int i = 1; i < track.fields.length; i++) {
      core.Track subTrack = track.subTrack(0, i + 1);
      //      print(
      //          "current steps ${currentSteps}  subtrack ${subTrack.fields.map((f) => f.id).join(",")} move cost ${subTrack.getMoveCostOfFreeWay()}");
      if (currentSteps < subTrack.getMoveCostOfFreeWay()) {
        highlights.add(FieldHighlight()
          ..field = track.fields[i]
          ..highlightName = HighlightName.noGo);
      } else {
        highlights.add(FieldHighlight()
          ..field = track.fields[i]
          ..highlightName = HighlightName.track);
      }
    }
  }

  @override
  List<FieldHighlight> highlights = [];

  // Client move validation - move if track is longer than possible
  @override
  bool validate(core.Unit unitOnMove, core.Track track) {
    if (track.fields.length == 1) {
      return false;
    }
    if (!track.isFreeWay(unitOnMove.player)) {
      return false;
    }
    return true;
  }

  @override
  core.Track modifyTrack(core.Unit unitOnMove, core.Track track) {
    int currentSteps = resolveCurrentSteps(unitOnMove, steps);
    core.Track out = track;
    for (int i = 1; i < track.fields.length; i++) {
      core.Track check = track.subTrack(0, i + 1);
      if (currentSteps < check.getMoveCostOfFreeWay()) {
        return out;
      }
      out = check;
    }
    return track;
  }
}
