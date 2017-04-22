part of heroes;

class HeroCalculated{
  num strength= 1;
  num agility= 1;
  num intelligence= 1;
  num bodyWeight= 55;
  num weight= 55;
  num level= 0;
  int precision = 0;
  num strengthHealth= 0;
  num armorHealth= 0;
  int armorPoints = 0;
  num unflooredArmorPoints= 0;
  num strengthOnHeightArmor= 0;
  num agilityOnHeightArmor= 0;
  num speedPoints= 1;
  num speedPrecisionPoints= 0;
  num precisionPoints= 0;
  num unusedPrecisionPoints= 0;
  int itemWeight = 0;
  num damage= 1;
  num dmgPoints= 0;
  num suitability= 1;
  num usability= 1;
  get health=>strengthHealth + armorHealth;
  HeroCalculated();
  
  takeBasic(Hero hero, HeroItemSum items) {
    strength = hero.data.strength + items.strength;
    agility = hero.data.agility + items.agility;
    intelligence = hero.data.intelligence + items.intelligence;
    bodyWeight = 55 +hero.data.strength*3;
    itemWeight = items.weight;
    weight = bodyWeight + items.weight;
    level = (pow(hero.data.experience, 0.65)/4).floor();
    strengthHealth = 1 +(strength/2).floor();
  }
  
  int recalcArmor(HeroItemSum items, HeroOut out) {
      strengthOnHeightArmor = strength*20*max(items.armor,0.5)/weight;
      agilityOnHeightArmor = agility/pow(weight/50, 2.2);
      unflooredArmorPoints = pow(strengthOnHeightArmor+agilityOnHeightArmor,0.8);
      armorPoints = unflooredArmorPoints.floor();
      armorHealth = armorPoints;
    if (armorHealth > 7) {
      out.armor = 4;
      armorHealth -= 8;
    } else if (armorHealth > 5) {
      out.armor = 3;
      armorHealth -= 6;
    } else if (armorHealth > 3) {
      out.armor = 2;
      armorHealth -= 4;
    } else if (armorHealth > 1) {
      out.armor = 1;
      armorHealth -= 2;
    } else {
      out.armor = 0;
    }
  }
  recalcSpeed (out) {
    var a = 15;
    var b = 1.5;
    var c = 2;
    var d = 2.9;
    var weight = this.weight - 30;
    var points = log(a * strength / weight + b * pow(strength, 2) * pow(agility, 2) / pow(weight, 2) + c) * d;
    speedPoints = points;
    var stops = [1, 2, 3, 4, 5, 6, 7];
    var i = 0;
    while (stops[i] < points) {
      i++;
    }
    out.speed = i;
    speedPrecisionPoints = points - stops[i - 1];
  }
}