part of model;

class Unit {
  String _name;
  int _armor = 0;
  int _speed = 0;
  int _range = 0;
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
  List<UnitCreateOrUpdateAction> actionLog = [];

  /// called on health change with previous health state
  BehaviorSubject onTypeChanged = BehaviorSubject();
  BehaviorSubject onStepsChanged = BehaviorSubject();
  BehaviorSubject<int> onHealthChanged = BehaviorSubject<int>();
  BehaviorSubject<Field> onFieldChanged = BehaviorSubject<Field>();

//  Stream get onActionStateChanged => _onActionStateChanged.stream;

  bool get isUndead => tags.contains(UnitTypeTag.undead);

  bool get isEthernal => tags.contains(UnitTypeTag.ethernal);

  String get name => _name;

  int get armor => _armor;

  int get speed => _speed;

  int get range => _range;

  int get far => _far;

  List<Ability> Function(AbilitiesEnvelope envelope) _createClientAbilityList;

  Unit(List<Ability> this._createClientAbilityList(AbilitiesEnvelope envelope));

  static List<int> _parseAttack(String input) {
    return input
        .split(" ")
        .map((segment) => int.parse(segment))
        .toList(growable: false);
  }

  // called on buffs and type change
  void _recalculate() {
    _armor = type.armor;
    _speed = type.speed;
    _range = type.range;
    attack = _parseAttack(type.attack);
    abilities = _createClientAbilityList(type.abilities);
    for (Buff buff in _buffs) {
      _armor += buff.armorDelta;
      _speed += buff.speedDelta;
      if (range != null) _range += buff.rangeDelta;
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
    _limitAttributes();
  }

  void _limitAttributes() {
    if (armor > 4) _armor = 4;
    if (speed > 7) _speed = 7;
    if (range != null && range > 7) _range = 7;
    for (int i = 0; i < 6; i++) {
      if (attack[i] > 9) attack[i] = 9;
    }
  }

  bool get isPlayable => isAlive && _actions > 0;

  int get actions => _actions;

  Field get field => _field;

  void destroy() {}

  int get actualHealth => _health;

  int get steps => _steps;

  bool get isAlive => _health > 0;

  void fromUnitType(UnitType unitType, Field field, String id) {
    this.id = id;
    type = unitType;
    _health = type.health;
    _steps = type.speed;
    _actions = type.actions;
    _recalculate();
    _setType(unitType);
    _field?.removeUnit(this);
    _field = field;
    field.addUnit(this);
  }

  void fromCreateAction(UnitCreateOrUpdateAction action, Map<String, Field> fields, Map<String, Player> players, Map<String, UnitType> types, void Function(Unit unit) onAfterCreate){
    fromUnitType(types[action.state.changeToTypeName], fields[action.state.moveToFieldId], action.unitId);
    if(action.state.transferToPlayerId != null){
      player = players[action.state.transferToPlayerId];
    }else{
      aiGroupId = action.state.transferToAiGroupId;
    }
    onAfterCreate(this);
    addUnitUpdateAction(action, fields[action.state.moveToFieldId]);
  }

  /// Type change cause nullation of abilities pseudostates.
  /// change type will not cause change in race, nation or faith
  void _setType(UnitType type) {
    // health is transformed by new maximum. If unit is alive, type change cannot kill it
    bool alive = isAlive;
    int newActualHealth =
        ((type.health / this.type.health) * actualHealth).floor();
    this.type = type;
    if (alive && actualHealth == 0) {
      newActualHealth = 1;
    } else {
      _health = newActualHealth;
    }

    if (_steps == null) {
      _steps = type.speed;
    } else {
      // steps are transformed in the same way as health
      bool hasStep = steps > 0;
      int newSteps = ((type.speed / speed) * steps).floor();
      if (newSteps == 0 && hasStep) {
        _steps = 1;
      } else {
        _steps = newSteps;
      }
    }

    _recalculate();
    onTypeChanged.add(null);
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

  UnitUpdateReport addUnitUpdateAction(
      UnitCreateOrUpdateAction action, Field newField) {
    UnitUpdateReport report = UnitUpdateReport();
    print("unit action ${id} ${action.toJson()}");
    report.action = action;
    LiveUnitState state = action.state;
    bool changed = false;
    bool stepsChanged = false;
    bool healthChanged = false;
    bool fieldChanged = false;

    if (state.far != null && _far != state.far) {
      report.deltaFar = _far - state.far;
      _far = state.far;
      changed = true;
    }

    if (state.steps != null && state.steps != steps) {
      int originalSteps = _steps;
      _steps = state.steps;
      if (_steps <= 0) {
        _steps = 0;
        _actions = 0;
      }
      report.deltaSteps = originalSteps - _steps;
      changed = true;
      stepsChanged = true;
    }

    if (state.actions != null && _actions != state.actions) {
      int originalActions = _actions;
      _actions = state.actions;
      if (_actions <= 0) {
        _steps = 0;
      }
      report.deltaActions = originalActions - _actions;
      changed = true;
    }

    if (state.health != null && _health != state.health) {
      int originalHealth = _health;
      _health = state.health;
      report.deltaHealth = originalHealth - _health;
      changed = true;
      healthChanged = true;
    }

    if (_health == 0 && (_steps != 0 || _actions != 0)) {
      _steps = 0;
      _actions = 0;
      changed = true;
    }

    if (state.moveToFieldId != null && field.id != state.moveToFieldId) {
      _field?.removeUnit(this);
      _field = newField;
      _field.addUnit(this);
      changed = true;
      fieldChanged = true;
    }

    // TODO: manage buff diff && effect

    if (!changed) {
      return null;
    }
    actionLog.add(action);
    if (fieldChanged) {
      onFieldChanged.add(_field);
    }
    if (healthChanged) {
      onHealthChanged.add(_health);
    }
    if (stepsChanged) {
      onStepsChanged.add(_steps);
    }
    report.unit = this;
    return report;
  }

  LiveUnitState getState() {
    return LiveUnitState()
        ..health = _health
        ..actions = _actions
        ..steps = _steps
        ..buffs = _buffs;
  }
}
