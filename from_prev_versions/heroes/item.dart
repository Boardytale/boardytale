part of heroes;

class Item {
  int id = 0;
  String name = "name";
  Hero _hero;
  num weight = 0;
  num armor = 0;
  num health = 0;
  num mana = 0;
  num strength = 0;
  num agility = 0;
  num intelligence = 0;
  Item() {}
  set hero(Hero hero) {
    this._hero = hero;
  }

  Hero get hero => _hero;

  fromData(String itemData) {
    var conv = new JsonDecoder(null);
    Map<String, dynamic> data = conv.convert(itemData);
    weight = data["weight"];
    mana = data["mana"];
    armor = data["armor"];
    health = data["health"];
    strength = data["strength"];
    agility = data["agility"];
    intelligence = data["intelligence"];
    name = data["name"];
    id = data["id"];
    return data;
  }

  Map toJson() {
    return {
      'health': health,
      'mana': mana,
      'armor': armor,
      'weight': weight,
      'strength': strength,
      'intelligence': intelligence,
      'agility': agility,
      'name': name,
      'id': id
    };
  }

  recalc() {}
}

class Weapon extends Item {
  int reqPrecision = 0;
  int reqEnergy = 0;
  int reqDarkness = 0;
  int reqLevel = 0;
  int damage = 1;
  int precision = 1;
  int strengthUse = 1;
  int intelligenceUse = 1;
  int agilityUse = 1;
  int darknessUse = 1;
  int energyUse = 1;
  int precisionUse = 1;
  double physicalImpact = 1.0;
  double mysticalImpact = 0.2;
  double impactedUsabilityMatch = 0.0;
  double impactedSuitabilityMatch = 0.0;
  double suitabilityMatch = 0.0;
  double usabilityMatch = 0.0;
  List<int> mask = [1, 1, 1, 1, 1, 1];
  Weapon();
  recalc() {
    suitabilityMeasure();
    usabilityMeasure();
  }

  isSuitable(Hero hero) {
    if (reqPrecision > hero.data.precision) return false;
    if (reqEnergy > hero.data.energy) return false;
    if (reqDarkness > hero.data.darkness) return false;
    return true;
  }

  fromJson(String itemData) {
    Map<String, dynamic> data = super.fromData(itemData);
    reqDarkness = data["reqDarkness"];
    reqEnergy = data["reqEnergy"];
    reqLevel = data["reqLevel"];
    reqPrecision = data["reqPrecision"];
    damage = data["damage"];
    precision = data["precision"];
    strengthUse = data["strengthUse"];
    agilityUse = data["agilityUse"];
    intelligenceUse = data["intelligenceUse"];
    energyUse = data["energyUse"];
    darknessUse = data["darknessUse"];
    precisionUse = data["precisionUse"];
    physicalImpact = data["physicalImpact"];
    mysticalImpact = data["mysticalImpact"];
    impactedSuitabilityMatch = data["impactedSuitabilityMatch"];
    impactedUsabilityMatch = data["impactedUsabilityMatch"];
    suitabilityMatch = data["suitabilityMatch"];
    usabilityMatch = data["usabilityMatch"];
    mask = data["mask"];
  }

  Map toJson() {
    Map out = super.toJson();
    out.addAll({
      'reqDarkness': reqDarkness,
      'reqEnergy': reqEnergy,
      'reqLevel': reqLevel,
      'reqPrecision': reqPrecision,
      'damage': damage,
      'precision': precision,
      'strengthUse': strengthUse,
      'agilityUse': agilityUse,
      'intelligenceUse': intelligenceUse,
      'energyUse': energyUse,
      'darknessUse': darknessUse,
      'precisionUse': precisionUse,
      'physicalImpact': physicalImpact,
      'mysticalImpact': mysticalImpact,
      'impactedSuitabilityMatch': impactedSuitabilityMatch,
      'impactedUsabilityMatch': impactedUsabilityMatch,
      'suitabilityMatch': suitabilityMatch,
      'usabilityMatch': usabilityMatch,
      'mask': mask
    });
    return out;
  }

  transform(a, b, c) {
    var x = 0;
    var y = 0;
    var sac = a + c;
    var x1 = (c / sac) / 2;

    // z rovnice přímky ac
    var y1 = -sqrt(3) * x1 + sqrt(3 / 4);

    // z rovnice přímky kolmé k ac
    var n2 = -sqrt(1 / 3) * x1 + y1;

    // konkrétní přímka odpovídající poměru a kolmá k ac má rovnici y= Math.sqrt(1/3)*x + n2

    var sbc = b + c;
    var x3 = b / sbc * 0.5 + 0.5;
    var y3 = sqrt(3) * x3 - sqrt(3 / 4);

    // z rovnice přímky kolmé k bc
    var n4 = sqrt(1 / 3) * x3 + y3;

    // konkrétní přímak odpovídající poměru a kolmá k bc má rovnici y = -Math.sqrt(1/3)*x+ n4

    y = (n2 + n4) / 2;
    x = (y - n2) / sqrt(1 / 3);
    return {x: x, y: y};
  }

  suitabilityMeasure() {
    var hgrid =
        transform(hero.data.precision, hero.data.energy, hero.data.darkness);
    var igrid = transform(precisionUse, energyUse, darknessUse);

    suitabilityMatch =
        sqrt(pow(hgrid.x - igrid.x, 2) + pow(hgrid.y - igrid.y, 2));
    impactedSuitabilityMatch = (suitabilityMatch * mysticalImpact);
  }

  usabilityMeasure() {
    var hgrid = transform(hero.calculated.strength, hero.calculated.agility,
        hero.calculated.intelligence);
    var igrid = transform(strengthUse, agilityUse, intelligenceUse);
    usabilityMatch =
        sqrt(pow(hgrid.x - igrid.x, 2) + pow(hgrid.y - igrid.y, 2));
    impactedUsabilityMatch = usabilityMatch * physicalImpact;
  }
}
