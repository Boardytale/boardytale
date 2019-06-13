part of model;

class Hero {
  final HeroEnvelope envelope;
  AbilitiesEnvelope abilities = AbilitiesEnvelope();
  ItemSum itemSum = ItemSum();
  HeroState state;

  Hero(this.envelope) {
    itemSum.recalculate(envelope.equippedItems.equippedItemsList());
    state = HeroState(this);
  }

  ItemEnvelope getFirstWeapon() {
    if (envelope.equippedItems.leftHand != null && envelope.equippedItems.leftHand.isWeapon) {
      return envelope.equippedItems.leftHand;
    }
    if (envelope.equippedItems.rightHand != null && envelope.equippedItems.rightHand.isWeapon) {
      return envelope.equippedItems.rightHand;
    }
    return null;
  }
  bool get isLowLevel => envelope.gameHeroEnvelope.level < 6;

  bool get isMidLevel => envelope.gameHeroEnvelope.level > 5 && envelope.gameHeroEnvelope.level < 12;

  bool get isMidOrHighLevel => envelope.gameHeroEnvelope.level > 5;

  bool get isHighLevel => envelope.gameHeroEnvelope.level > 11;

}

class HeroState {
  Hero hero;
  num effectiveStrength = 1;
  num effectiveAgility = 1;
  num _effectiveEnergy = 1;
  num level = 0;
  num baseHealth = 0;
  num weightLimit = 0;
  num itemsArmorPoints = 0;
  num speedPoints = 1;
  int itemWeight = 0;
  num armor = 0;
  num speed = 1;
  num mana = 0;
  num health;
  num range;
  List<int> ownAttack = [0, 0, 0, 0, 0, 0];
  List<int> maxAttack = [0, 0, 0, 0, 0, 0];
  List<int> itemAttack = [0, 0, 0, 0, 0, 0];
  List<int> itemBonusAttack = [0, 0, 0, 0, 0, 0];
  List<int> attack = [0, 0, 0, 0, 0, 0];

  HeroState(this.hero) {
    recalculate();
  }

  void recalculate() {
    ItemSum items = hero.itemSum;
    if (hero.isHighLevel) {
      itemWeight = items.weight;
      _effectiveEnergy = hero.envelope.energy + items.energyBonus;
      effectiveStrength = hero.envelope.strength + items.strengthBonus;
      weightLimit = Calculations.weightLimitForStrength(effectiveStrength);
      effectiveAgility =
          Calculations.getEffectiveAgility(hero.envelope.agility, items.agilityBonus, itemWeight, weightLimit);
      baseHealth = Calculations.healthForStrength(effectiveStrength);
      ownAttack = Calculations.getDmgFromAttributes(effectiveStrength, effectiveAgility);
      maxAttack = Calculations.getMaxAttackFromAttributes(effectiveStrength, effectiveAgility);
      level = Calculations.levelForExperience(hero.envelope.experience);
      armor = Calculations.getArmor(effectiveAgility, items.armorPoints);
      speed = Calculations.getSpeed(itemWeight, weightLimit);
      itemAttack = hero.getFirstWeapon() == null ? [0, 0, 0, 0, 0, 0] : hero.getFirstWeapon().weapon.baseAttack;
      itemBonusAttack = hero.getFirstWeapon() == null ? [0, 0, 0, 0, 0, 0] : hero.getFirstWeapon().weapon.bonusAttack;
      attack = Calculations.sumAttacks(
          itemBonusAttack, Calculations.capAttack(Calculations.sumAttacks(ownAttack, itemAttack), maxAttack));
      health = baseHealth + items.healthBonus;
      mana = 10 * _effectiveEnergy + items.manaBonus;
    } else if (hero.isMidLevel) {
      UnitTypeCompiled type = hero.envelope.gameHeroEnvelope.type;
      health = type.health + items.healthBonus;
      armor = type.armor + items.armorPoints * 0;
      range = type.range;
      speed = type.speed;
      attack = type.attack.split((" ")).map((item) => int.tryParse(item)).toList();
    } else {
      UnitTypeCompiled type = hero.envelope.gameHeroEnvelope.type;
      health = type.health + items.healthBonus;
      armor = type.armor + items.armorPoints * 0;
      range = type.range;
      speed = type.speed;
      attack = type.attack.split((" ")).map((item) => int.tryParse(item)).toList();
    }
  }
}
