part of deskovka_client;

class UnitSelection extends Widget {
  String path = "game/unit_selection";
  Element target;
  GameFlow gameflow;
  UnitType _selected;

  UnitType get selected{
    if(_selected == null){
      _selected = gf.game.you.race.unitTypes.values.first;
    }
    return _selected;
  }

  Element selectionEnd;
  Element goldLeft;
  UnitSelectionWorldAdapter adapter;

  UnitSelection(this.gameflow) : super(){
    target = new DivElement();
    document.body.append(target);
    repaints.add(repaint);
    adapter = new UnitSelectionWorldAdapter(this);
    gf.game.world.adapters.add(adapter);
  }

  @override
  Map out(){
    Map out = {};
    out["lang"] = widgetLang;
    out["gold"] = gf.game.gold;
    Race race = gf.game.you.race;
    List units = [];
    unitTypes.forEach((k, v){
      if(v.race == race){
        Map type = v.toJson();
        units.add(type);
      }
    });
    if(units.isEmpty){
      throw new Exception("no units for selection $race $unitTypes");
    }
    out["units"] = units;
    return out;
  }

  @override
  void setChildrenTargets(){
    // do nothing
  }

  @override
  void tideFunctionality(){
    Game game = gf.game;
    selectionEnd = target.querySelector(".selectionEnd");
    goldLeft = target.querySelector(".goldLeft");
    Race race = game.you.race;
    unitTypes.forEach((k, v){
      if(v.race == race){
        Element unitDiv = target.querySelector(".unit_$k");
        unitDiv.onMouseDown.listen((e){
          e.preventDefault();
          selectType(v, unitDiv);
        });
        unitDiv.append(images["unit_$k"]);
      }
    });
    selectionEnd.onClick.listen((e){
      gf.send(ACTION_SELECTED_UNITS, {"world": game.world.toJson()});
      destroy();
    });

    for(ClientField field in game.world.fields){
      if(game.you.left){
        if(field.x - field.y > 4){
          field.highlight();
        }
      }else{
        if(field.x - field.y < -4){
          field.highlight();
        }
      }
    }
    if(!game.you.left){
      game.world.moveTo(-400, -800);
    }
  }

  void selectType(UnitType type, Element div){
    _selected = type;
    target.querySelectorAll(".unitToSelect").classes.remove("selected");
    div.classes.add("selected");
  }

  @override
  void destroy(){
    gf.game.world.adapters.remove(adapter);
    target.remove();
    for(ClientField field in gf.game.world.fields){
      field.clearEnlights();
    }
  }
}

class UnitSelectionWorldAdapter extends WorldActionAdapter {
  UnitSelection unitSelection;

  UnitSelectionWorldAdapter(this.unitSelection);

  @override
  int priority = 100;

  @override
  bool apply(ClientField field, bool right){
    if(gf.game.you.left){
      return (field.x - field.y > 4);
    }else{
      return field.x - field.y < -4;
    }
  }

  @override
  onFieldChanged(){
    // do nothing
  }

  @override
  onFieldDown(bool right, bool shift, bool alt, bool ctrl){
    ClientField field = track.fields.last;
    if(right){
      if(!field.units.isEmpty){
        gf.game.removeUnit(field.units.first);
      }
    }else{
      if(unitSelection.selected.cost > gf.game.you.gold){
        return;
      }
      Unit newUnit = gf.game.createUnit(unitSelection.selected, gf.game.you, field);
      if(newUnit != null){
        gf.game.you.gold -= newUnit.type.cost;
        unitSelection.goldLeft.text = "${gf.game.you.gold} / ${gf.game.gold}";
      }
    }
  }

  @override
  onFieldUp(){
    // do nothing
  }

  @override
  onPixelMove(int startPointX, int startPointY, int startPageX, int startPageY, int targetX, int targetY){
    // do nothing
  }
}
