part of model;

class ItemSum {
  num weight = 0;
  num armorPoints = 0;
  num healthBonus = 0;
  num manaBonus = 0;
  num strengthBonus = 0;
  num agilityBonus = 0;
  num intelligenceBonus = 0;
  num spiritualityBonus = 0;
  num precisionBonus = 0;
  num energyBonus = 0;

  void recalculate(List<ItemEnvelope> items) {
    items.forEach((ItemEnvelope item) {
      weight += item.weight;
      armorPoints += item.armorPoints;

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
