part of game_server;

List<shared.Ability> createServerAbilityList(shared.AbilitiesEnvelope envelope){
  List<shared.Ability> out = [];
  if(envelope.move != null){
//    out.add(ClientMoveAbility()..fromEnvelope(envelope.move));
  }
  if(envelope.attack != null){
//    out.add(ClientAttackAbility()..fromEnvelope(envelope.attack));
  }
  return out;
}

class ServerUnit extends shared.Unit {
  ServerUnit() : super(createServerAbilityList);


  void fromUnitType(shared.UnitType unitType) {
    super.fromUnitType(unitType);
  }

}

