part of model;

@Typescript()
@JsonSerializable()
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

  /*   stack strength table (correlate with buff cost)
                    bonus1  bonus2        bonus3     bonus4
 one property         1       8           64         256

 two properties       4       64          256       5000

 three properties     32      2000     200 000     10 000 000

 all                 200      20 000   1 000 000   1 000 000 000

   */

  List<String> doesNotStackWith = [];

  static Buff fromJson(Map data) {
    return _$BuffFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$BuffToJson(this);
  }
}
