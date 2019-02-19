part of heroes;

class HeroData {
  int _strength = 1;
  int _agility = 1;
  int _intelligence = 1;
  int _precision = 1;
  int _darkness = 1;
  int _energy = 1;
  int experience = 0;
  int floatStrength = 0;
  int floatIntelligence = 0;
  int floatAgility = 0;
  int floatDarkness = 0;
  int floatEnergy = 0;
  int floatPrecision = 0;
  String name = "hrdina";
  bool actualWeaponId = false;
  int budget = 1;
  int get intelligence => _intelligence + floatIntelligence;
  int get strength => _strength + floatStrength;
  int get agility => _agility + floatAgility;
  int get energy => _energy + floatEnergy;
  int get darkness => _darkness + floatDarkness;
  int get precision => _precision + floatPrecision;
  bool get canPhysical => _sumPhysical < (level + 20);
  bool get canMystical => _sumMystical < (level + 100);
  bool get canTenMystical => _sumMystical < (level + 91);
  set strength(str) {
    _strength = str + 10;
  }

  HeroData();
  int get level => (pow(experience, 0.65) / 4).floor();
  addStrength(int x) {
    if (level + 20 >= _sumPhysical + x) {
      floatStrength += x;
    }
  }

  addIntelligence(int x) {
    if (level + 20 >= _sumPhysical + x) {
      floatIntelligence += x;
    }
  }

  addAgility(int x) {
    if (level + 20 >= _sumPhysical + x) {
      floatAgility += x;
    }
  }

  addEnergy(int x) {
    if (level + 100 >= _sumMystical + x) {
      floatEnergy += x;
    }
  }

  addDarkness(int x) {
    if (level + 100 >= _sumMystical + x) {
      floatDarkness += x;
    }
  }

  addPrecision(int x) {
    if (level + 100 >= _sumMystical + x) {
      floatPrecision += x;
    }
  }

  int get _sumPhysical =>
      _strength +
      _agility +
      _intelligence +
      floatAgility +
      floatIntelligence +
      floatStrength;
  int get _sumMystical =>
      _energy +
      _darkness +
      _precision +
      floatDarkness +
      floatEnergy +
      floatPrecision;

  bool reduceStrength() {
    if (floatStrength < 1) {
      return false;
    } else {
      floatStrength--;
      return true;
    }
  }

  bool reduceAgility() {
    if (floatAgility < 1) {
      return false;
    } else {
      floatAgility--;
      return true;
    }
  }

  bool reduceIntelligence() {
    if (floatIntelligence < 1) {
      return false;
    } else {
      floatIntelligence--;
      return true;
    }
  }

  bool reduceDarkness() {
    if (floatDarkness < 1) {
      return false;
    } else {
      floatDarkness--;
      return true;
    }
  }

  bool reducePrecision() {
    if (floatPrecision < 1) {
      return false;
    } else {
      floatPrecision--;
      return true;
    }
  }

  bool reduceEnergy() {
    if (floatEnergy < 1) {
      return false;
    } else {
      floatEnergy--;
      return true;
    }
  }
}
