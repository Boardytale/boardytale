part of model;

class Unit {
  String _name;
  int armor = 0;
  int speed = 0;
  int range = 0;
  List<int> attack;
  int _health = 0;
  int _far = 0;
  String id;
  int _actions = 1;
  int _steps = 1;
  UnitType type;
  Field _field;
  covariant Player player;
  List<Ability> abilities = [];
  List<Buff> _buffs = [];
  Set<String> tags = new Set<String>();
  String aiGroupId;

  /// called on health change with previous health state
  BehaviorSubject onTypeChanged = BehaviorSubject();
  BehaviorSubject onStepsChanged = BehaviorSubject();
  BehaviorSubject<int> onHealthChanged = BehaviorSubject<int>();
  BehaviorSubject<Field> onFieldChanged = BehaviorSubject<Field>();

//  Stream get onActionStateChanged => _onActionStateChanged.stream;

  bool get isUndead => tags.contains(UnitTypeTag.undead);

  bool get isEthernal => tags.contains(UnitTypeTag.ethernal);

  String get name => _name;

  List<Ability> Function(AbilitiesEnvelope envelope) _createClientAbilityList;

  Unit(List<Ability> this._createClientAbilityList(AbilitiesEnvelope envelope));


  static List<int> parseAttack(String input) {
    return input
        .split(" ")
        .map((segment) => int.parse(segment))
        .toList(growable: false);
  }

  void addBuff(Buff buff) {
    _buffs.add(buff);
    _recalculate();
  }

  void removeBuff(Buff buff) {
    _buffs.remove(buff);
    _recalculate();
  }

  // called on buffs and type change
  void _recalculate() {
    armor = type.armor;
    speed = type.speed;
    range = type.range;
    attack = parseAttack(type.attack);
    abilities = _createClientAbilityList(type.abilities);
    for (Buff buff in _buffs) {
      armor += buff.armorDelta;
      speed += buff.speedDelta;
      if (range != null) range += buff.rangeDelta;
      for (int i = 0; i < 6; i++) {
        attack[i] += buff.attackDelta[i];
      }
      if (buff.extraTags != null) {
        tags.addAll(buff.extraTags);
      }
      if (buff.bannedTags != null) {
        tags.removeAll(buff.bannedTags);
      }
    }
    limitAttributes();
  }

  void limitAttributes() {
    if (armor > 4) armor = 4;
    if (speed > 7) speed = 7;
    if (range != null && range > 7) range = 7;
    for (int i = 0; i < 6; i++) {
      if (attack[i] > 9) attack[i] = 9;
    }
  }

  bool get isPlayable => isAlive && _actions > 0;

  int get actions => _actions;

  set actions(int val) {
    if (val == actions) return;
    _actions = val;
    if (_actions <= 0) {
      steps = 0;
    } else {
      field.refresh();
    }
  }

  Field get field => _field;

  void set field(Field field) {
    _field?.removeUnit(this);
    _field = field;
    field.addUnit(this);
    onFieldChanged.add(_field);
  }

  set actualHealth(int val) {
    if (val == _health) return;
    _health = val;
    if (_health > type.health) {
      _health = type.health;
    }
    if (_health < -5) {
      destroy();
    }
    field.refresh();
    onHealthChanged.add(_health);
  }

  void destroy() {}

  int get actualHealth => _health;

  int get far => _far;

  int get steps => _steps;

  set steps(int val) {
    if (val == steps) return;
    _far += _steps - val;
    _steps = val;
    if (_steps <= 0) {
      _steps = 0;
      _actions = 0;
    }
    onStepsChanged.add(_steps);
  }

  bool get isAlive => _health > 0;

  Alea heal(Alea alea) {
    int damage = alea.getDamage();
    int realDamage = Math.min(damage, type.health - actualHealth);
    if (realDamage <= 0) return alea;
    actualHealth += realDamage;
    alea.damage += realDamage;
    return alea;
  }

  void fromUnitType(UnitType unitType, Field field, String id) {
    this.id = id;
    type = unitType;
    _health = type.health;
    _steps = type.speed;
    _actions = type.actions;
    _recalculate();
    setType(unitType);
    this.field = field;
  }

  /// Type change cause nullation of abilities pseudostates.
  /// change type will not cause change in race, nation or faith
  void setType(UnitType type) {
    // health is transformed by new maximum. If unit is alive, type change cannot kill it
    bool alive = isAlive;
    int newActualHealth =
        ((type.health / this.type.health) * actualHealth).floor();
    this.type = type;
    if (alive && actualHealth == 0) {
      newActualHealth = 1;
    } else {
      actualHealth = newActualHealth;
    }

    if (_steps == null) {
      _steps = type.speed;
    } else {
      // steps are transformed in the same way as health
      bool hasStep = steps > 0;
      int newSteps = ((type.speed / speed) * steps).floor();
      if (newSteps == 0 && hasStep) {
        steps = 1;
      } else {
        steps = newSteps;
      }
    }

    _recalculate();
    onTypeChanged.add(null);
  }

  void addAbility(Ability ability) {
    abilities.add(ability);
    ability.setInvoker(this);
  }

  void move(Track track) {
    this.steps -= track.length - 1;
    _far = track.length - 1;
    this.field = track.last;
  }

  Alea harm(Alea alea) {
    int realDamage = 0;
    int damage = alea.getDamage();
    damage -= armor;
    if (damage <= 0) {
      return alea;
    }
    realDamage = Math.min(damage, actualHealth);
    actualHealth -= realDamage;
    alea.damage += realDamage;
    return alea;
  }

  void newTurn() {
    if (_health == 0) {
      return notPlaying();
    }
    _steps = speed;
    _actions = type.actions;
    _far = 0;
  }

  void notPlaying() {
    _steps = 0;
    _actions = 0;
  }

  Map toSimpleJson() {
    Map<String, dynamic> out = <String, dynamic>{};
    out["id"] = id;
    out["field"] = field.id;
    out["health"] = _health;
    out["player"] = player.id;
    out["steps"] = _steps;
    out["name"] = _name;
    return out;
  }

  Ability getAbilityByName(String name) =>
      abilities.firstWhere((Ability ability) => ability.name == name,
          orElse: () => null);

}
