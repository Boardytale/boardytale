part of model;

class ItemSum {
  double weight = 0;
  int armorPoints = 0;
  int speedPoints = 0;
  int healthBonus = 0;
  int manaBonus = 0;
  int strengthBonus = 0;
  int agilityBonus = 0;
  int intelligenceBonus = 0;
  int spiritualityBonus = 0;
  int precisionBonus = 0;
  int energyBonus = 0;

  void recalculate(List<ItemEnvelope> items) {
    items.forEach((ItemEnvelope item) {
      weight += item.weight;
      armorPoints += item.armorPoints;
      speedPoints += item.speedPoints;

      healthBonus += item.healthBonus;
      manaBonus += item.manaBonus;
      strengthBonus += item.strengthBonus;
      agilityBonus += item.agilityBonus;
      intelligenceBonus += item.intelligenceBonus;

      spiritualityBonus += spiritualityBonus;
      precisionBonus += precisionBonus;
      energyBonus += energyBonus;
    });
  }
}
