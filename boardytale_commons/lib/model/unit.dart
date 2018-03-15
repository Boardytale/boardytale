part of model;

class Unit {
  String name;
  int armor = 0;
  int speed = 0;
  int range = 0;
  List<int> attack;
  int _health = 0;
  int _far = 0;
  int id;
  int _actions = 1;
  int _steps = 1;
  UnitType type;
  Field field;
  Player player;
  List<Ability> abilities = [];
  List<Buff> _buffs = [];
  List<String> tags = [];

  bool get isUndead => tags.contains(UnitType.TAG_UNDEAD);

  bool get isEthernal => tags.contains(UnitType.TAG_ETHERNAL);

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
    assert(type != null);
    armor = type.armor;
    speed = type.speed;
    range = type.range;
    attack = type.attack.toList(growable: false);
    for (Buff buff in _buffs) {
      armor += buff.armorDelta;
      speed += buff.speedDelta;
      if (range != null) range += buff.rangeDelta;
      for (int i = 0; i < 6; i++) {
        attack[i] += buff.attackDelta[i];
      }
    }
    if (armor > 4) armor = 4;
    if (speed > 7) speed = 7;
    if (range != null && range > 7) range = 7;
    for (int i = 0; i < 6; i++) {
      if (attack[i] > 9) attack[i] = 9;
    }
  }

  /// called on health change with previous health state
  ValueNotificator<int> onHealthChanged = new ValueNotificator();
  Notificator onFieldChanged = new Notificator();
  Notificator onTypeChanged = new Notificator();
  Notificator onStepsChanged = new Notificator();
  Notificator onActionStateChanged = new Notificator();

  Unit(this.id, this.type) {
    _recalculate();
    _health = type.health;
    _steps = type.speed;
    setType(type);
  }

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

  set actualHealth(int val) {
    if (val == _health) return;
    int original = _health;
    _health = val;
    if (_health > type.health) {
      _health = type.health;
    }
    if (_health < -5) {
      destroy();
    }
    onHealthChanged.notify(original);
    field.refresh();
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
    onStepsChanged.notify();
  }

  bool get isAlive => _health > 0;

  Alea heal(Alea alea) {
    if (alea.attack != null) {
      alea.damage = alea.attack[alea.nums[0]];
      actualHealth += alea.damage;
    }
    return alea;
  }

  /// Type change cause nullation of abilities pseudostates.
  /// change type will not cause change in race, nation or faith
  void setType(UnitType type) {
    // health is transformed by new maximum. If unit is alive, type change cannot kill it
    bool alive = isAlive;
    int newActualHealth = ((type.health / this.type.health) * actualHealth).floor();
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

    abilities.clear();
    for (Ability a in type.abilities) {
      abilities.add(a.clone());
    }

    if (type.tags != null) {
      tags = type.tags.toList();
    }

    _recalculate();
  }

  void addAbility(Ability ability) {
    abilities.add(ability);
    ability.setInvoker(this);
  }

  void move(Field field, int steps) {
    this.steps -= steps;
    transport(field);
  }

  void transport(Field field) {
    this.field.removeUnit(this);
    this.field = field;
    field.addUnit(this);
  }

  int harm(Alea alea) {
    int realDamage = 0;
    int damage = alea.getDamage();
    damage -= armor;
    if (damage < 0) {
      damage = 0;
    }
    realDamage = Math.min(damage, actualHealth);
    actualHealth -= damage;
    return realDamage;
  }

  void newTurn(bool playerOnMove) {
    _steps = speed;
    _actions = type.actions;
    _far = 0;
    for (Ability a in abilities) {
      if (a.trigger != null && a.trigger == Ability.TRIGGER_MINE_TURN_START && playerOnMove) {
        a.perform(null);
      }
    }
    field.refresh();
  }

  Alea dice() {
    return new Alea(attack);
  }

  Map toSimpleJson() {
    Map<String, dynamic> out = <String, dynamic>{};
    out["id"] = id;
    out["type"] = type.id;
    out["field"] = field.id;
    out["health"] = _health;
    out["player"] = player.id;
    return out;
  }

  Ability getAbility(Track track, bool shift, bool alt, bool ctrl) {
    List<Ability> possibles = abilities.toList();
    List<Ability> toRemove = [];
    for (Ability ability in possibles) {
      if ((actions < ability.actions) ||
          (track.fields.length - 1 > ability.getPossiblesSteps() - far) ||
          (far > ability.getPossiblesSteps()) ||
          (ability.freeWayNeeded() && track.isEnemy(player))) {
        toRemove.add(ability);
        break;
      }

      //match target
      if (!track.matchTarget(ability.target, this)) {
        toRemove.add(ability);
        break;
      }
    }
    for (Ability a in toRemove) {
      possibles.remove(a);
    }

    int used = 0;
    if (possibles.isEmpty) {
      return null;
    } else if (possibles.length > 0) {
      if (possibles.length == 2 && (shift || alt || ctrl))
        used = 1;
      else if (possibles.length == 3) {
        if (ctrl)
          used = 1;
        else if (shift || alt) used = 2;
      } else if (possibles.length > 3) {
        if (ctrl)
          used = 1;
        else if (shift)
          used = 2;
        else if (alt) used = 3;
      }
    }
    return possibles[used];
  }

  void fromMap(Map m, Tale tale) {
    dynamic __fieldId = m["field"];
    if (__fieldId is String) {
      field = tale.world.fields[__fieldId];
    }

    dynamic __name = m["name"];
    if (__name is String) {
      name = __name;
    }
    dynamic __health = m["health"];
    if (__health is int) {
      _health = __health;
    }
    dynamic __player = m["player"];
    if (__player is int) {
      player = tale.players[__player];
    }
  }
}
