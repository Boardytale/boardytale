part of model;

class Hero {
  static double baseWeight = 70;
  static int baseHealth = 7;
  static List<int> armorStops = const [15, 30, 60, 120];
  static List<int> speedStops = const [0, 2, 10, 20, 40, 80, 120];
  final HeroEnvelope serverState;
  final Map<String, ItemEnvelope> itemsData;
  AbilitiesEnvelope abilities = AbilitiesEnvelope();
  HeroState currentState;

  String get id => serverState.gameHeroEnvelope.id;

  bool get enableAddPhysicalPoint => Hero.enableAddPhysicalPointStatic(
      serverState.gameHeroEnvelope.level, currentState.strength, currentState.agility, currentState.intelligence);

  static bool enableAddPhysicalPointStatic(int level, int strength, int agility, int intelligence) {
    return (level * 3 + 30) > (strength + intelligence + agility);
  }

  Hero(this.serverState, this.itemsData) {
    serverState.gameHeroEnvelope.level = Math.pow(serverState.experience, 0.3).floor();
    currentState = HeroState(serverState);
  }

  bool get showStrAgiInt => true;

  bool get isLowLevel => serverState.gameHeroEnvelope.level < 6;

  bool get isMidLevel => serverState.gameHeroEnvelope.level > 5 && serverState.gameHeroEnvelope.level < 12;

  bool get isMidOrHighLevel => serverState.gameHeroEnvelope.level > 5;

  bool get isHighLevel => serverState.gameHeroEnvelope.level > 11;

  void updateType() {
    UnitTypeCompiled type = serverState.gameHeroEnvelope.type;
    currentState.updateUnitType(type);
  }

  void recalculateSum(HeroUpdate nextUpdate) {
    currentState = HeroState(serverState, nextUpdate);
  }
}

// HeroState = serverState + nextUpdate;
class HeroState implements ItemManipulable {
  final HeroEnvelope envelope;
  Map<ItemPosition, ItemEnvelope> equippedItems = {};
  List<ItemEnvelope> inventoryItems = [];
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
  int armor = 0;
  int speed = 1;
  int money;
  ItemSum equippedItemsSum = ItemSum();
  ItemEnvelope weaponItem;

  HeroState(this.envelope, [HeroUpdate update]) {
    strength = envelope.strength;
    agility = envelope.agility;
    intelligence = envelope.intelligence;
    money = envelope.money;

    // create deep copies of items
    equippedItems = {};
    envelope.equippedItems.forEach((key, item) {
      equippedItems[key] = ItemEnvelope.fromJson(item.toJson());
    });
    inventoryItems = envelope.inventoryItems.toList().map((item) => ItemEnvelope.fromJson(item.toJson())).toList();

    if (update != null) {
      applyHeroUpdate(update);
    }

    weaponItem = getFirstWeapon();
    equippedItemsSum.recalculate(equippedItems);

    strength += equippedItemsSum.strengthBonus;
    agility += equippedItemsSum.agilityBonus;
    intelligence += equippedItemsSum.intelligenceBonus;

    precision = envelope.precision + equippedItemsSum.precisionBonus;
    spirituality = envelope.spirituality + equippedItemsSum.spiritualityBonus;
    energy = envelope.energy + equippedItemsSum.energyBonus;
    weight += equippedItemsSum.weight;
    itemWeight += equippedItemsSum.weight;

    armorPoints = equippedItemsSum.armorPoints + ((agility / weight) * 100).floor();

    int highSpeedPart = ((agility ~/ Math.max(weight - Hero.baseWeight + 2, 1)));
    int lowSpeedPart = (((Math.sqrt((strength + weight) / weight)) - 1) * 100).floor();
    int lowLevelBonus = ((Math.sqrt(strength + agility) / (itemWeight + 5)) * 30).floor();
    speedPoints = equippedItemsSum.speedPoints + highSpeedPart + lowSpeedPart + lowLevelBonus;

    mana = equippedItemsSum.manaBonus + intelligence;

    health = equippedItemsSum.healthBonus + (strength ~/ 3) + Hero.baseHealth;

    if (weaponItem != null) {
      attack = weaponItem.weapon.baseAttack;
      range = weaponItem.weapon.range;
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
    armor = 0;
    for (int i = 0; i < Hero.armorStops.length; i++) {
      if (armorPoints >= Hero.armorStops[i]) {
        armor++;
      }
    }
    speed = 0;
    for (int i = 0; i < Hero.speedStops.length; i++) {
      if (speedPoints >= Hero.speedStops[i]) {
        speed++;
      }
    }
  }

  void applyHeroUpdate(HeroUpdate update) {
    strength = update.strength ?? strength;
    agility = update.agility ?? agility;
    intelligence = update.intelligence ?? intelligence;
    ItemManipulable.applyManipulations(update, this);
  }

  ItemEnvelope getFirstWeapon() {
    if (equippedItems[ItemPosition.leftHand] != null && equippedItems[ItemPosition.leftHand].isWeapon) {
      return equippedItems[ItemPosition.leftHand];
    }
    if (equippedItems[ItemPosition.rightHand] != null && equippedItems[ItemPosition.rightHand].isWeapon) {
      return equippedItems[ItemPosition.rightHand];
    }
    return null;
  }

  void updateUnitType(UnitTypeCompiled type) {
    type.range = range;
    type.health = health;
    type.attack = attack.join(" ");
    type.armor = armor;
    type.speed = speed;
  }
}
