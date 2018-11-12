part of model;

Math.Random random = new Math.Random();

class Alea {
  int damage = 0;
  List<int> attack = null;
  List<int> nums = [];

  Alea(this.attack) {
    nums = [(random.nextDouble() * 6).floor(), (random.nextDouble() * 6).floor()];
  }

  int getDamage() {
    int out = attack[nums.first];
    if (nums.first == 5) {
      out += nums[1] + 1;
    }
    return out;
  }

  String toString() {
    String numLast = "";
    if (nums.first == 5) {
      numLast = ",${nums.last+1}";
    }

    return "[${nums.first+1}$numLast] => $damage";
  }
}
