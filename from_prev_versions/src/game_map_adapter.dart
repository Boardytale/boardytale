part of deskovka_client;

class GameMapAdapter extends WorldActionAdapter{
  Ability ability;
  Track track;

  @override
  bool apply(ClientField field, bool right){
    return !field.units.isEmpty && !right;
  }

  @override
  onFieldChanged(){
    var alives = track.first.alivesOnField();
    if(alives.isEmpty){

    }else{
      var unit = alives.first;
      if(unit.player!=gf.game.you || ! gf.OnMove)return;
      ability = unit.getAbility(track, false, false, false).clone();
      if(ability!=null){
        ability.setInvoker(unit);
        ability.show(track);
        gf.game.world.paintTrack(track, "#38FF2D");
      }
    }
    gf.send(ACTION_TRACK_CHANGE, track.toJson());
  }

  @override
  onFieldDown(bool right, bool shift, bool alt, bool ctrl){
    var alives = track.fields.last.alivesOnField();
    if(alives.isEmpty){

    }else{
      var unit = alives.first;
      if(unit.player!=gf.game.you || ! gf.OnMove)return;
      ability = unit.getAbility(track, shift, alt, ctrl).clone();
      if(ability!=null){
        ability.setInvoker(unit);
        ability.show(track);
        gf.send(ACTION_TRACK_CHANGE, track.toJson());
        gf.game.world.paintTrack(track, "#38FF2D");
      }
    }
  }

  @override
  onFieldUp(){
    if(ability!=null){
      ability.perform(track);
    }
    gf.send(ACTION_TRACK_CHANGE, null);
    gf.game.world.clearTrack();
  }

  @override
  onPixelMove(int startPointX, int startPointY, int startPageX, int startPageY, int targetX, int targetY){
    // do nothing
  }
}