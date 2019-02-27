part of game_server;

List<shared.Ability> createServerAbilityList(shared.AbilitiesEnvelope envelope){
  List<shared.Ability> out = [];
  if(envelope.move != null){
    out.add(ServerMoveAbility()..fromEnvelope(envelope.move));
  }
  if(envelope.attack != null){
    out.add(ServerAttackAbility()..fromEnvelope(envelope.attack));
  }
  return out;
}

class ServerUnit extends shared.Unit {
  @override
  ServerPlayer player;
  ServerUnit() : super(createServerAbilityList);


  void fromUnitType(shared.UnitType unitType, shared.Field field, String id) {
    super.fromUnitType(unitType, field, id);
  }

  void perform(shared.AbilityName name, shared.Track track, shared.UnitTrackAction action, ServerTale tale) {
    for(int i = 0;i<abilities.length;i++){
      ServerAbility ability  = abilities[i];
      if(ability.name == name){
        ability.perform(this, track, action, tale);
      }
    }
  }
}

