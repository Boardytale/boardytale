part of model;

//
//class Calculations{
//  static List<int> sumAttacks(List<int> a, List<int>b){
//    return [a[0]+b[0],a[1]+b[1],a[2]+b[2],a[3]+b[3],a[4]+b[4],a[5]+b[5]];
//  }
//  static List<int> scaleAttack(List<int> attack, int scale){
//    return [scale*attack[0],scale*attack[1],scale*attack[2],scale*attack[3],scale*attack[4],scale*attack[5]];
//  }
//  static List<int> capAttack(List<int> attack, List<int> cap){
//    return [Math.min(attack[0],cap[0]),Math.min(attack[1],cap[1]),Math.min(attack[2],cap[2]),Math.min(attack[3],cap[3]),Math.min(attack[4],cap[4]),Math.min(attack[5],cap[5])];
//  }
//  static int levelForExperience(num experience) => (Math.pow(experience, 0.65) / 4).floor();
//  static int healthForStrength(int strength) => 6 + (strength / 2).floor();
//  static num weightLimitForStrength(int strength) => 20*Math.sqrt(strength);
//  static int getEffectiveAgility(num heroAgility, num itemAgilityBonus,num itemWeight, num weightLimit) =>(heroAgility + itemAgilityBonus)*Math.min(1,2-(itemWeight/weightLimit));
//  static int getArmor(num effectiveAgility, num itemArmorBonus){
//    num agilityArmor = 0.5*Math.sqrt(effectiveAgility);
//    return Math.min(4.0,Math.sqrt((agilityArmor*agilityArmor) + (itemArmorBonus*itemArmorBonus))).floor();
//  }
//  static int getSpeed(num itemWeight, num weightLimit)=> Math.max(1,5-(2*itemWeight/weightLimit)).floor();
//  static List<int> getDmgFromAttributes(int strength, int agility) {
//    List<int> dmg = [0];
//
//    num sumDmg = 1+((strength+agility)/8);
//    num shift = 0.5;
//    num atanShift = Math.atan(shift);
//    num coef = (Math.atan(shift+(agility/8))-atanShift)/((Math.pi/2)-atanShift);
//    dmg.add((sumDmg*Math.pow(coef,2.5)).floor());
//    dmg.add((sumDmg*Math.pow(coef,1.5)).floor());
//    dmg.add((sumDmg*coef).floor());
//    dmg.add(((strength/10)+(sumDmg)).floor());
//    dmg.add(((strength/5)+(sumDmg)).floor());
//
//    return dmg;
//  }
//
//   static List<int> getMaxAttackFromAttributes(int strength, int agility) {
//    List<int> dmg = [0];
//
//    num sumDmg = 1+((strength+agility)/8);
//    num shift = 0.5;
//    num atanShift = Math.atan(shift);
//    num coef = (Math.atan(shift+(agility/8))-atanShift)/((Math.pi/2)-atanShift);
//    dmg.add((sumDmg*Math.pow(coef,2.5)*3).floor());
//    dmg.add((sumDmg*Math.pow(coef,1.5)*3).floor());
//    dmg.add((sumDmg*coef*3).floor());
//    dmg.add((((strength/10)+(sumDmg))*3).floor());
//    dmg.add((((strength/5)+(sumDmg))*3).floor());
//
//    return dmg;
//  }
//}
//
//
//class HeroState {
//  Hero hero;
//  num effectiveStrength = 1;
//  num effectiveAgility = 1;
//  num _effectivePrecision = 1;
//  num _effectiveEnergy = 1;
//  num _effectiveSpirituality = 1;
//  num level = 0;
//  num baseHealth = 0;
//  num weightLimit = 0;
//  num itemsArmorPoints = 0;
//  num speedPoints = 1;
//  int itemWeight = 0;
//  num armor = 0;
//  num speed = 1;
//  num mana = 0;
//  num health;
//  List<int> ownAttack = [0, 0, 0, 0, 0, 0];
//  List<int> maxAttack = [0, 0, 0, 0, 0, 0];
//  List<int> itemAttack = [0, 0, 0, 0, 0, 0];
//  List<int> itemBonusAttack = [0, 0, 0, 0, 0, 0];
//  List<int> attack = [0, 0, 0, 0, 0, 0];
//
//  HeroState(this.hero) {
//    ItemSum items = hero.getItemSum();
//    itemWeight = items.weight;
//    _effectivePrecision = hero.precision + items.precisionBonus;
//    _effectiveEnergy = hero.energy + items.energyBonus;
//    _effectiveSpirituality = hero.spirituality + items.spiritualityBonus;
//    effectiveStrength = hero.strength + items.strengthBonus;
//    weightLimit = Calculations.weightLimitForStrength(effectiveStrength);
//    effectiveAgility = Calculations.getEffectiveAgility(hero.agility, items.agilityBonus, itemWeight, weightLimit);
//    baseHealth = Calculations.healthForStrength(effectiveStrength);
//    ownAttack = Calculations.getDmgFromAttributes(effectiveStrength, effectiveAgility);
//    maxAttack = Calculations.getMaxAttackFromAttributes(effectiveStrength, effectiveAgility);
//    level = Calculations.levelForExperience(hero.experience);
//    armor = Calculations.getArmor(effectiveAgility, items.armorPoints);
//    speed = Calculations.getSpeed(itemWeight, weightLimit);
//    itemAttack = hero.getWeapon() == null ? [0, 0, 0, 0, 0, 0] : hero.getWeapon().baseAttack;
//    itemBonusAttack = hero.getWeapon() == null ? [0, 0, 0, 0, 0, 0] : hero.getWeapon().bonusAttack;
//    attack = Calculations.sumAttacks(
//        itemBonusAttack, Calculations.capAttack(Calculations.sumAttacks(ownAttack, itemAttack), maxAttack));
//    health = baseHealth + items.healthBonus;
//    mana = 10 * _effectiveEnergy + items.manaBonus;
//  }
//}
//
//
//class HeroTest{
//  HeroState _hero1;
//  HeroState _hero2;
//  //  who strikes first, hp of hero1, hp of hero2, probability of win1
//  Map<int, Map<int, Map<int, double>>> partialResults = {};
//
//  Map<int, double> damageChances1to2 = {};
//  Map<int, double> damageChances2to1 = {};
//
//  HeroTest inverseTest;
//
//  HeroTest(this._hero1, this._hero2){
//    if(_hero1.attack[0]>_hero1.attack[1])throw "wrong attack order";
//    if(_hero1.attack[1]>_hero1.attack[2])throw "wrong attack order";
//    if(_hero1.attack[2]>_hero1.attack[3])throw "wrong attack order";
//    if(_hero1.attack[3]>_hero1.attack[4])throw "wrong attack order";
//
//    if(_hero2.attack[0]>_hero2.attack[1])throw "wrong attack order";
//    if(_hero2.attack[1]>_hero2.attack[2])throw "wrong attack order";
//    if(_hero2.attack[2]>_hero2.attack[3])throw "wrong attack order";
//    if(_hero2.attack[3]>_hero2.attack[4])throw "wrong attack order";
//
//    int dmg = 0;
//    int diceThrow = 1;
//    while(dmg<_hero2.health){
//      if(diceThrow%6 == 0)diceThrow++;
//      dmg = max(0, getRawDamage(_hero1.attack, diceThrow)-_hero2.armor);
//      double prob = getDiceThrowProbability(diceThrow);
//      if(dmg>=_hero2.health){
//        prob = 1.0 - damageChances1to2.values.reduce((a,b)=>a+b);
//      }
//      if(damageChances1to2[dmg]==null){damageChances1to2[dmg] = prob;}else{damageChances1to2[dmg] += prob;}
//      diceThrow++;
//    }
//
//    dmg = 0;
//    diceThrow = 1;
//    while(dmg<_hero1.health){
//      if(diceThrow%6 == 0)diceThrow++;
//      dmg = max(0, getRawDamage(_hero2.attack, diceThrow)-_hero1.armor);
//      double prob = getDiceThrowProbability(diceThrow);
//      if(dmg>=_hero1.health){
//        prob = 1.0 - damageChances2to1.values.reduce((a,b)=>a+b);
//      }
//      if(damageChances2to1[dmg]==null){damageChances2to1[dmg] = prob;}else{damageChances2to1[dmg] += prob;}
//      diceThrow++;
//    }
//    //    print(damageChances1to2);
//    //    print(damageChances2to1);
//  }
//
//  double getChance(int firstPlayer){
//    if(firstPlayer==0)return getProbability(0, _hero1.health, _hero2.health);
//    if(firstPlayer==1){
//      if(inverseTest==null)inverseTest=new HeroTest(_hero2, _hero1);
//      return 1.0-inverseTest.getProbability(0, _hero2.health, _hero1.health);
//    }
//    throw "wierd firdt player";
//  }
//
//  double getSavedProbability(int firstPlayer, int hp1, int hp2){
//    if(partialResults[firstPlayer]==null)return null;
//    if(partialResults[firstPlayer][hp1]==null)return null;
//    if(partialResults[firstPlayer][hp1][hp2]==null)return null;
//    return partialResults[firstPlayer][hp1][hp2];
//  }
//
//  double getProbability(int firstPlayer, int hp1, int hp2){
//    double toReturn = getSavedProbability(firstPlayer, hp1, hp2);
//    if(toReturn == null)toReturn = calculateProbability(firstPlayer, hp1, hp2);
//    return toReturn;
//  }
//
//  double calculateProbability(int firstPlayer, int hp1, int hp2) {
//    //    if(hp1<1)return 0.0;
//    //    if(hp2<1)return 1.0;
//    if(hp2<1 && hp1<1)throw "oops";
//    print("First player: $firstPlayer, hp1: $hp1, hp2: $hp2");
//    double nullDamageChance = damageChances1to2[0]*damageChances2to1[0];
//    double kill1To2Chance = damageChances1to2.keys.fold(0.0, (prob, key)=>(key>=hp2) ? prob+damageChances1to2[key] : prob);
//    //    double kill2To1Chance = damageChances2to1.keys.fold(0.0, (prob, key)=>(key>=hp2) ? prob+damageChances2to1[key] : prob);
//    //    double chanceToWin2Now = kill2To1Chance*(1.0-kill1To2Chance);
//    double chanceToWin1Later = 0.0;
//    double chanceToWin2Later = 0.0;
//
//    for(int dmg1 = 0; dmg1<hp2; dmg1++){
//      if(damageChances1to2[dmg1]!=null)for(int dmg2 = 0; dmg2<hp1; dmg2++){
//        if(damageChances2to1[dmg2]!=null){
//          if(!(dmg1==0&&dmg2==0)){
//            double prob = getProbability(firstPlayer, hp1-dmg2, hp2-dmg1);
//            chanceToWin1Later += damageChances1to2[dmg1]*damageChances2to1[dmg2]*prob;
//            chanceToWin2Later += damageChances1to2[dmg1]*damageChances2to1[dmg2]*(1.0-prob);
//          }
//        }
//      }
//    }
//
//    print("($hp1/$hp2) chanceToWin2Later: $chanceToWin2Later, chanceToWin1Later: $chanceToWin1Later, kill1To2Chance: $kill1To2Chance, nullDamageChance: $nullDamageChance");
//    double toReturn = (chanceToWin1Later+kill1To2Chance)/(1.0-nullDamageChance);
//    saveProbability(firstPlayer, hp1, hp2, toReturn);
//    return toReturn;
//  }
//
//  void saveProbability(int firstPlayer, int hp1, int hp2, double win1probability) {
//    if(partialResults[firstPlayer]==null)partialResults[firstPlayer]={};
//    if(partialResults[firstPlayer][hp1]==null)partialResults[firstPlayer][hp1] = {};
//    if(partialResults[firstPlayer][hp1][hp2]==null)partialResults[firstPlayer][hp1][hp2] = win1probability;
//  }
//
//  int getRawDamage(List<int> attack, int diceThrow){
//    if(diceThrow<7)return attack[diceThrow-1];
//    int overThrow = diceThrow-6;
//    return attack[5]+overThrow;
//  }
//
//  double getDiceThrowProbability(int diceThrow){
//    int throws = (diceThrow/6.0).ceil();
//    return pow(6,-throws);
//  }
//}
