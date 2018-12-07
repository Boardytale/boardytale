part of model;

class Buff {
  int speedDelta = 0;
  int armorDelta = 0;
  int rangeDelta = 0;
  int healthDelta = 0;
  List<int> attackDelta = [0, 0, 0, 0, 0, 0];
  Set<String> extraTags;
  Set<String> bannedTags;

  /// null will never expire
  int expiration = null;

  /// used to recognize stack
  String buffType = "stackUnlimited";

  /// used for replacing
  int stackStrength = 3;

  /// must be injected
  Unit unit;

  /*   stack strength table (correlate with buff cost)

                    bonus1  bonus2        bonus3     bonus4
 one property         1       8           64         256

 two properties       4       64          256       5000

 three properties     32      2000     200 000     10 000 000

 all                 200      20 000   1 000 000   1 000 000 000


   */

  List<String> doesNotStackWith = [];

  Buff.fromJson(Map json) {
    if (json.containsKey("speed")) speedDelta = json["speed"] as int;
    if (json.containsKey("armor")) armorDelta = json["armor"] as int;
    if (json.containsKey("range")) rangeDelta = json["range"] as int;
    if (json.containsKey("health")) healthDelta = json["health"] as int;
    if (json.containsKey("attack")) attackDelta = json["speed"] as List<int>;
    if (json.containsKey("expiration")) expiration = json["expiration"] as int;
    if (json.containsKey("extraTags")) extraTags = (json["extraTags"] as List<String>).toSet();
    if (json.containsKey("bannedTags")) bannedTags = (json["bannedTags"] as List<String>).toSet();
  }

  void exchange() {
    if (expiration != null) {
      expiration--;
      if (expiration < 1) {
        unit.removeBuff(this);
      }
    }
  }
}
