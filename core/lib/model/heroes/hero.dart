part of model;

class Hero {
  static double baseWeight = 70;
  static int baseHealth = 7;
  static List<int> armorStops = const [15, 30, 60, 120];
  static List<int> speedStops = const [0, 2, 10, 20, 40, 80, 120];
  final HeroEnvelope envelope;
  AbilitiesEnvelope abilities = AbilitiesEnvelope();
  ItemSum itemSum = ItemSum();
  HeroSum heroSum;

  Hero(this.envelope) {
    envelope.gameHeroEnvelope.level = Math.pow(envelope.experience, 0.3).floor();
    itemSum.recalculate(envelope.equippedItems.equippedItemsList());
    heroSum = HeroSum(envelope, itemSum, getFirstWeapon());
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

  void updateType() {
    UnitTypeCompiled type = envelope.gameHeroEnvelope.type;
    heroSum.updateUnitType(type);
  }
}

class HeroSum {
  int strength = 0;
  int agility = 0;
  int intelligence = 0;
  int precision = 0;
  int spirituality = 0;
  int energy = 0;
  double weight = Hero.baseWeight;
  int armorPoints = 0;
  int speedPoints = 0;
  double itemWeight = 0;
  int mana = 0;
  int health = 7;
  int range = 0;
  List<int> attack = [0, 0, 0, 0, 0, 0];

  HeroSum(HeroEnvelope envelope, ItemSum items, ItemEnvelope weapon) {
    strength = envelope.strength + items.strengthBonus;
    agility = envelope.agility + items.agilityBonus;
    intelligence = envelope.intelligence + items.intelligenceBonus;
    precision = envelope.precision + items.precisionBonus;
    spirituality = envelope.spirituality + items.spiritualityBonus;
    energy = envelope.energy + items.energyBonus;
    weight += items.weight;
    itemWeight += items.weight;

    armorPoints = items.armorPoints + ((agility / weight) * 100).floor();

    int highSpeedPart = ((agility ~/ Math.max(weight - Hero.baseWeight + 2, 1)));
    int lowSpeedPart = (((Math.sqrt((strength + weight) / weight)) - 1) * 100).floor();
    int lowLevelBonus = ((Math.sqrt(strength + agility) / (itemWeight + 20)) * 20).floor();
    speedPoints = items.speedPoints + highSpeedPart + lowSpeedPart + lowLevelBonus;

    mana = items.manaBonus + intelligence;

    health = items.healthBonus + (strength ~/ 3) + Hero.baseHealth;

    if (weapon != null) {
      attack = weapon.weapon.baseAttack;
      range = weapon.weapon.range;
    } else {
      int attackPrecision = 2;
      if (agility > 5) {
        attackPrecision = 3;
      }
      if (agility > 15) {
        attackPrecision = 4;
      }
      if (agility > 45) {
        attackPrecision = 5;
      }
      int damage = (strength ~/ 8) + 1;
      attack = [0, 0, 0, 0, 0, 0];
      bool firstRun = true;
      while (damage > 0) {
        for (int i = 5; i > 5 - attackPrecision; i--) {
          if (firstRun) {
            attack[i]++;
          } else if (damage > 0) {
            damage--;
            attack[i]++;
          }
        }
        firstRun = false;
      }
    }
  }

  void updateUnitType(UnitTypeCompiled type) {
    type.range = range;
    type.health = health;
    type.attack = attack.join(" ");
    type.armor = 0;
    for (int i = 0; i < Hero.armorStops.length; i++) {
      if (armorPoints > Hero.armorStops[i]) {
        type.armor++;
      }
    }
    type.speed = 0;
    for (int i = 0; i < Hero.speedStops.length; i++) {
      if (speedPoints > Hero.speedStops[i]) {
        type.speed++;
      }
    }
  }
}
