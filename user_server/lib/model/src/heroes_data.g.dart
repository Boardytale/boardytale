part of heroes;

// generated from data/default_heroes by user_server/bin/generate_default_heroes_data.dart
List<core.HeroEnvelope> heroesData = [
  core.HeroEnvelope.fromJson({
    "gameHeroEnvelope": {
      "id": null,
      "level": 1,
      "name": "Unnamed",
      "type": {
        "name": "archeress",
        "race": "elf",
        "tags": [],
        "health": 10,
        "armor": 0,
        "speed": 5,
        "range": 5,
        "actions": 1,
        "attack": "0 0 1 2 3 2",
        "cost": 500,
        "langName": {"cz": "Lukostřelkyně", "en": "Archeress"},
        "unitTypeDataVersion": 0,
        "unitTypeVersion": 0,
        "abilities": {
          "move": {"steps": null},
          "attack": null,
          "shoot": {"steps": null, "attack": null},
          "heal": null
        },
        "authorEmail": "mlcoch.zdenek@gmail.com",
        "image": {
          "name": "archeress",
          "data":
              "data:image/png;base64,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",
          "width": 42,
          "height": 61,
          "type": "unitBase",
          "authorEmail": "wassago@seznam.cz",
          "imageVersion": 0,
          "dataModelVersion": 0,
          "created": "2011-10-05T14:48:00.000Z",
          "tags": [],
          "origin": "author",
          "multiply": 1.0,
          "top": 8,
          "left": 19
        },
        "icon": null,
        "bigImage": null
      }
    },
    "inventoryItems": [],
    "equippedItemNames": {
      "rightHand": "shortWoodenBow",
      "legs": "leatherBoots"
    },
    "equippedItems": {
      "rightHand": {
        "possiblePositions": ["bothHands"],
        "id": null,
        "typeName": "shortWoodenBow",
        "langName": {"cz": "dřevěný krátký luk", "en": "short wooden bow"},
        "mapImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAABNVBMVEUAAAA6LRYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADEeQGjYQGNVQGBXhqvbAGjYwEDAgCAgGBXNQC8cgGVWwE8JwKGWghNOA9oQAGdYAGBVQm+dAGzbAGDVwmhYQGNVgGWTghyNQFrMgBHIQGVTwlsMwEJ+EBtAAAASnRSTlMACAgCirIhoQzlr/H8jOHH+vVQzucxkv27BC7g3BkSyvdhgT4bS8ZatP5wqYglH9UG0mpftYvrF9m99KODd/jC3w7eseKP7q37k9Zf0P0AAAEeSURBVHjaldPZNgNBEAbg0iGWYcSSTMYaRjC2xB7Evv8Gg1gSO+H9H0E6x4WLqp6jbvs7f5/uqqK/1QAyF84QAYJzKCO4uAyvTALXN6VQ36KUBIDSLSjW2BSXQPNdeI+WVrRJgKyHoAwL7R0SIFRC2J2Jrm4RlINHUA96kwIgPFVAKQdpVwLPAaivHwODPMDL6xtoaBiZESnh/QOKRpHweDCGzyrcrI3xGA8m8FVLmIQ/RTyYxncVNANrlgdzOZ2Qn0eaeLBg6wTP8Rd54C7Vn7mMlVUeJAtr+qPWsUE8KNqb+quxlRXAdq7eLOzsCmBvX7fb8VMkgIOMHhgcksucqxo40iOHY2Ir/zu0J0Xz2Bfi5sU5jVg977/LG7n+P/V5T1LoM/wXAAAAAElFTkSuQmCC",
        "inventoryImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAABNVBMVEUAAAA6LRYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADEeQGjYQGNVQGBXhqvbAGjYwEDAgCAgGBXNQC8cgGVWwE8JwKGWghNOA9oQAGdYAGBVQm+dAGzbAGDVwmhYQGNVgGWTghyNQFrMgBHIQGVTwlsMwEJ+EBtAAAASnRSTlMACAgCirIhoQzlr/H8jOHH+vVQzucxkv27BC7g3BkSyvdhgT4bS8ZatP5wqYglH9UG0mpftYvrF9m99KODd/jC3w7eseKP7q37k9Zf0P0AAAEeSURBVHjaldPZNgNBEAbg0iGWYcSSTMYaRjC2xB7Evv8Gg1gSO+H9H0E6x4WLqp6jbvs7f5/uqqK/1QAyF84QAYJzKCO4uAyvTALXN6VQ36KUBIDSLSjW2BSXQPNdeI+WVrRJgKyHoAwL7R0SIFRC2J2Jrm4RlINHUA96kwIgPFVAKQdpVwLPAaivHwODPMDL6xtoaBiZESnh/QOKRpHweDCGzyrcrI3xGA8m8FVLmIQ/RTyYxncVNANrlgdzOZ2Qn0eaeLBg6wTP8Rd54C7Vn7mMlVUeJAtr+qPWsUE8KNqb+quxlRXAdq7eLOzsCmBvX7fb8VMkgIOMHhgcksucqxo40iOHY2Ir/zu0J0Xz2Bfi5sU5jVg977/LG7n+P/V5T1LoM/wXAAAAAElFTkSuQmCC",
        "weight": 1,
        "armorPoints": 0,
        "speedPoints": 0,
        "healthBonus": 0,
        "manaBonus": 0,
        "strengthBonus": 0,
        "agilityBonus": 0,
        "intelligenceBonus": 0,
        "spiritualityBonus": 0,
        "energyBonus": 0,
        "precisionBonus": 0,
        "recommendedPrice": 50,
        "sellPrice": 25,
        "requiredLevel": 0,
        "weapon": {
          "requiredStrength": 0,
          "requiredAgility": 10,
          "requiredIntelligence": 0,
          "baseAttack": [0, 0, 1, 2, 2, 2],
          "bonusAttack": [0, 0, 0, 0, 0, 0],
          "range": 5
        }
      },
      "legs": {
        "possiblePositions": ["legs"],
        "id": null,
        "typeName": "leatherBoots",
        "langName": {"cz": "kožené body", "en": "leather boots"},
        "mapImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAADAFBMVEX/AADgAADAAACgAACAAABgAABAAAAwAAAgAAAYAAAQAACAQECgUFDAYGDgcHD/gID/QADgOADAMACgKACAIABgGABAEAAwDAAgIAAYGAAQEACAgECgoFDAwGDg4HD//4D/gADgcADAYACgUACAQABgMABAIAAwGAAAIAAAGAAAEABAgEBQoFBgwGBw4HCA/4D/wADgqADAkACgeACAYABgSABAMAAwJAAAICAAGBgAEBBAgIBQoKBgwMBw4OCA/////wDg4ADAwACgoACAgABgYABAQAAwMAAAACAAABgAABBAQIBQUKBgYMBwcOCAgP+A/wBw4ABgwABQoABAgAAwYAAgQAAYMAAgACAYABgQABCAQICgUKDAYMDgcOD/gP8A/wAA4AAAwAAAoAAAgAAAYAAAQAAAMABgMDBAICAwGBiAYGCgeHjAkJDgqKj/wMAA/4AA4HAAwGAAoFAAgEAAYDAAQCAAMBhgYDBAQCAwMBiAgGCgoHjAwJDg4Kj//8AA//8A4OAAwMAAoKAAgIAAYGAAQEAAMDAwYDAgQCAYMBhggGB4oHiQwJCo4KjA/8AAgP8AcOAAYMAAUKAAQIAAMGAAIEAAGDAwYGAgQEAYMDBggIB4oKCQwMCo4ODA//8AAP8AAOAAAMAAAKAAAIAAAGAAAEAAADAwMGAgIEAYGDBgYIB4eKCQkMCoqODAwP+AAP9wAOBgAMBQAKBAAIAwAGAgAEAYADBgMGBAIEAwGDCAYICgeKDAkMDgqOD/wP//AP/gAODAAMCgAKCAAIBgAGBAAEAwADD////g4ODAwMCgoKCAgIBgYGBAQEAgICD/AIDgAHDAAGCgAFCAAEBgADBAACAwABjw8PDQ0NCwsLCQkJBwcHBQUFAwMDAQEBB/Wkildl7Kj3LlooL/tpH/069oVB+AcCCqiDTAoEDyxE344GD8/Jl1aViRh26rmoHgwKDQqFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABHbGzm1GiTAAAAAXRSTlMAQObYZgAAAAFiS0dEAIgFHUgAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfYDBwQJibgc5RtAAAAvElEQVQ4y+WTQQ7EIAhFOYrDh/vfyyUnGEDbqglNZj0/XfU99GtToj8MMxHwxo0ZteE8UxqDvywRK7DvIXUHgEUEKBcBg0eTwghus+kGms95hd4v4dgjuKf7I2EgbmNrP9MBu46yV5uBSF7lsQCNNxLpvk36MHuEOLhoax/HYaSwG+I8S3RehMcw1cb3SRJDbDPsLppQou4qkAnw4Igegl4fSXJWD06kqsvkzCr4zEjBo+cbHUZFNuX3X+ULJDSeLFbnumcAAAAASUVORK5CYII=",
        "inventoryImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAADAFBMVEX/AADgAADAAACgAACAAABgAABAAAAwAAAgAAAYAAAQAACAQECgUFDAYGDgcHD/gID/QADgOADAMACgKACAIABgGABAEAAwDAAgIAAYGAAQEACAgECgoFDAwGDg4HD//4D/gADgcADAYACgUACAQABgMABAIAAwGAAAIAAAGAAAEABAgEBQoFBgwGBw4HCA/4D/wADgqADAkACgeACAYABgSABAMAAwJAAAICAAGBgAEBBAgIBQoKBgwMBw4OCA/////wDg4ADAwACgoACAgABgYABAQAAwMAAAACAAABgAABBAQIBQUKBgYMBwcOCAgP+A/wBw4ABgwABQoABAgAAwYAAgQAAYMAAgACAYABgQABCAQICgUKDAYMDgcOD/gP8A/wAA4AAAwAAAoAAAgAAAYAAAQAAAMABgMDBAICAwGBiAYGCgeHjAkJDgqKj/wMAA/4AA4HAAwGAAoFAAgEAAYDAAQCAAMBhgYDBAQCAwMBiAgGCgoHjAwJDg4Kj//8AA//8A4OAAwMAAoKAAgIAAYGAAQEAAMDAwYDAgQCAYMBhggGB4oHiQwJCo4KjA/8AAgP8AcOAAYMAAUKAAQIAAMGAAIEAAGDAwYGAgQEAYMDBggIB4oKCQwMCo4ODA//8AAP8AAOAAAMAAAKAAAIAAAGAAAEAAADAwMGAgIEAYGDBgYIB4eKCQkMCoqODAwP+AAP9wAOBgAMBQAKBAAIAwAGAgAEAYADBgMGBAIEAwGDCAYICgeKDAkMDgqOD/wP//AP/gAODAAMCgAKCAAIBgAGBAAEAwADD////g4ODAwMCgoKCAgIBgYGBAQEAgICD/AIDgAHDAAGCgAFCAAEBgADBAACAwABjw8PDQ0NCwsLCQkJBwcHBQUFAwMDAQEBB/Wkildl7Kj3LlooL/tpH/069oVB+AcCCqiDTAoEDyxE344GD8/Jl1aViRh26rmoHgwKDQqFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABHbGzm1GiTAAAAAXRSTlMAQObYZgAAAAFiS0dEAIgFHUgAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfYDBwQJibgc5RtAAAAvElEQVQ4y+WTQQ7EIAhFOYrDh/vfyyUnGEDbqglNZj0/XfU99GtToj8MMxHwxo0ZteE8UxqDvywRK7DvIXUHgEUEKBcBg0eTwghus+kGms95hd4v4dgjuKf7I2EgbmNrP9MBu46yV5uBSF7lsQCNNxLpvk36MHuEOLhoax/HYaSwG+I8S3RehMcw1cb3SRJDbDPsLppQou4qkAnw4Igegl4fSXJWD06kqsvkzCr4zEjBo+cbHUZFNuX3X+ULJDSeLFbnumcAAAAASUVORK5CYII=",
        "weight": 0.3,
        "armorPoints": 0,
        "speedPoints": 0,
        "healthBonus": 0,
        "manaBonus": 0,
        "strengthBonus": 0,
        "agilityBonus": 0,
        "intelligenceBonus": 0,
        "spiritualityBonus": 0,
        "energyBonus": 0,
        "precisionBonus": 0,
        "recommendedPrice": 10,
        "sellPrice": 5,
        "requiredLevel": 0
      }
    },
    "strength": 8,
    "agility": 13,
    "intelligence": 9,
    "precision": 33,
    "spirituality": 33,
    "energy": 33,
    "experience": 0,
    "money": 50
  }),
  core.HeroEnvelope.fromJson({
    "gameHeroEnvelope": {
      "id": null,
      "level": 1,
      "name": "Unnamed",
      "type": {
        "name": "elvenSwordmaster",
        "race": "human",
        "tags": [],
        "health": 10,
        "armor": 1,
        "speed": 5,
        "range": 0,
        "actions": 1,
        "attack": "0 1 1 2 3 2",
        "cost": 500,
        "langName": {"cz": "elfí pán mečů", "en": "elf swordmaster"},
        "unitTypeDataVersion": 0,
        "unitTypeVersion": 0,
        "abilities": {
          "move": {"steps": null},
          "attack": {"steps": null, "attack": null},
          "shoot": null,
          "heal": null
        },
        "authorEmail": "mlcoch.zdenek@gmail.com",
        "image": {
          "name": "elfSwordmaster",
          "data":
              "data:image/png;base64,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",
          "width": 60,
          "height": 84,
          "type": "unitBase",
          "authorEmail": "wassago@seznam.cz",
          "imageVersion": 0,
          "dataModelVersion": 0,
          "created": "2011-10-05T14:48:00.000Z",
          "tags": [],
          "origin": "author",
          "multiply": 1.0,
          "top": -8,
          "left": 10
        },
        "icon": null,
        "bigImage": null
      }
    },
    "inventoryItems": [],
    "equippedItemNames": {"rightHand": "ironKatana", "legs": "leatherBoots"},
    "equippedItems": {
      "rightHand": {
        "possiblePositions": ["bothHands"],
        "id": null,
        "typeName": "ironKatana",
        "langName": {"cz": "železná katana", "en": "iron katana"},
        "mapImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAACQklEQVR42sXWPWhTURjGcZOWYFESlWInJeosClKRWL1DcXJQcXRwVAQ/QYMgBHHooAVHB3FxKhg/EAeHIiKCk7FQB0Xwg1QCqZbWaJrG5Pi/lwe5HEhzL4GTB35ckiHPe865N8maPiSNvmVEV4O+xRSLRdOvIUyhUDClUskvb8NpPLRDA3yC08x6nhfe/lNwlpy1/b/hNF9ZfTCAVn8LznIOTX/rtf01JOEkm9AIbX0DeTjLO+vsq3CWG2haz/04nGQcLcqDc/dvQF4/gZNswbKeeaPVLyHlonwYC1Z5CzkX5etRyWaz4ZvuL665Kp+zymt4BieZt8qrmEWnJJCSnvPLKveVu3z4WuyRnuI/YnZ5VUfSKetwGpPIRyrp8H5L5eGf2EqX8gFcwB+8Ri7SP5jQEMN4D2OV1/ABqVXOfASXMYM2bmIwyhaHV7gMs/jqqF8e0KM2jeQq530Mj7Gi1d9FJvY5UxyYmtgb0JfMBOyksB8ncBvzaGIOVzAU70bTEIdG00ExV7+83mGrN+M6yqhryBnkMRbn0TO+k/CQyWT+D6Gf2Q0YwFZsx26t+AFW0MQLnfsuDCJqVAxWzJVhQkNouI04jkeY1iqXVF7EWWxDEiTOqlV8UEPo/be6H8JD/FRpHYt6PaljSCBy2qHioPSAiuUOHuILjPzAN3zEVRyRIcSIVbxPBVLTyhoo4zsq2o2nuAiv1+90M4ZRlUoZb/ASn7GA58jjMHYiizQS6ClJGDmDS7iPKdzDeW3tju6F8fMP8FdlL9cqiD0AAAAASUVORK5CYII=",
        "inventoryImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAACQklEQVR42sXWPWhTURjGcZOWYFESlWInJeosClKRWL1DcXJQcXRwVAQ/QYMgBHHooAVHB3FxKhg/EAeHIiKCk7FQB0Xwg1QCqZbWaJrG5Pi/lwe5HEhzL4GTB35ckiHPe865N8maPiSNvmVEV4O+xRSLRdOvIUyhUDClUskvb8NpPLRDA3yC08x6nhfe/lNwlpy1/b/hNF9ZfTCAVn8LznIOTX/rtf01JOEkm9AIbX0DeTjLO+vsq3CWG2haz/04nGQcLcqDc/dvQF4/gZNswbKeeaPVLyHlonwYC1Z5CzkX5etRyWaz4ZvuL665Kp+zymt4BieZt8qrmEWnJJCSnvPLKveVu3z4WuyRnuI/YnZ5VUfSKetwGpPIRyrp8H5L5eGf2EqX8gFcwB+8Ri7SP5jQEMN4D2OV1/ABqVXOfASXMYM2bmIwyhaHV7gMs/jqqF8e0KM2jeQq530Mj7Gi1d9FJvY5UxyYmtgb0JfMBOyksB8ncBvzaGIOVzAU70bTEIdG00ExV7+83mGrN+M6yqhryBnkMRbn0TO+k/CQyWT+D6Gf2Q0YwFZsx26t+AFW0MQLnfsuDCJqVAxWzJVhQkNouI04jkeY1iqXVF7EWWxDEiTOqlV8UEPo/be6H8JD/FRpHYt6PaljSCBy2qHioPSAiuUOHuILjPzAN3zEVRyRIcSIVbxPBVLTyhoo4zsq2o2nuAiv1+90M4ZRlUoZb/ASn7GA58jjMHYiizQS6ClJGDmDS7iPKdzDeW3tju6F8fMP8FdlL9cqiD0AAAAASUVORK5CYII=",
        "weight": 1,
        "armorPoints": 0,
        "speedPoints": 0,
        "healthBonus": 0,
        "manaBonus": 0,
        "strengthBonus": 0,
        "agilityBonus": 0,
        "intelligenceBonus": 0,
        "spiritualityBonus": 0,
        "energyBonus": 0,
        "precisionBonus": 0,
        "recommendedPrice": 50,
        "sellPrice": 25,
        "requiredLevel": 0,
        "weapon": {
          "requiredStrength": 0,
          "requiredAgility": 0,
          "requiredIntelligence": 0,
          "baseAttack": [0, 0, 1, 2, 2, 2],
          "bonusAttack": [0, 0, 0, 0, 0, 0],
          "range": 0
        }
      },
      "legs": {
        "possiblePositions": ["legs"],
        "id": null,
        "typeName": "leatherBoots",
        "langName": {"cz": "kožené body", "en": "leather boots"},
        "mapImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAADAFBMVEX/AADgAADAAACgAACAAABgAABAAAAwAAAgAAAYAAAQAACAQECgUFDAYGDgcHD/gID/QADgOADAMACgKACAIABgGABAEAAwDAAgIAAYGAAQEACAgECgoFDAwGDg4HD//4D/gADgcADAYACgUACAQABgMABAIAAwGAAAIAAAGAAAEABAgEBQoFBgwGBw4HCA/4D/wADgqADAkACgeACAYABgSABAMAAwJAAAICAAGBgAEBBAgIBQoKBgwMBw4OCA/////wDg4ADAwACgoACAgABgYABAQAAwMAAAACAAABgAABBAQIBQUKBgYMBwcOCAgP+A/wBw4ABgwABQoABAgAAwYAAgQAAYMAAgACAYABgQABCAQICgUKDAYMDgcOD/gP8A/wAA4AAAwAAAoAAAgAAAYAAAQAAAMABgMDBAICAwGBiAYGCgeHjAkJDgqKj/wMAA/4AA4HAAwGAAoFAAgEAAYDAAQCAAMBhgYDBAQCAwMBiAgGCgoHjAwJDg4Kj//8AA//8A4OAAwMAAoKAAgIAAYGAAQEAAMDAwYDAgQCAYMBhggGB4oHiQwJCo4KjA/8AAgP8AcOAAYMAAUKAAQIAAMGAAIEAAGDAwYGAgQEAYMDBggIB4oKCQwMCo4ODA//8AAP8AAOAAAMAAAKAAAIAAAGAAAEAAADAwMGAgIEAYGDBgYIB4eKCQkMCoqODAwP+AAP9wAOBgAMBQAKBAAIAwAGAgAEAYADBgMGBAIEAwGDCAYICgeKDAkMDgqOD/wP//AP/gAODAAMCgAKCAAIBgAGBAAEAwADD////g4ODAwMCgoKCAgIBgYGBAQEAgICD/AIDgAHDAAGCgAFCAAEBgADBAACAwABjw8PDQ0NCwsLCQkJBwcHBQUFAwMDAQEBB/Wkildl7Kj3LlooL/tpH/069oVB+AcCCqiDTAoEDyxE344GD8/Jl1aViRh26rmoHgwKDQqFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABHbGzm1GiTAAAAAXRSTlMAQObYZgAAAAFiS0dEAIgFHUgAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfYDBwQJibgc5RtAAAAvElEQVQ4y+WTQQ7EIAhFOYrDh/vfyyUnGEDbqglNZj0/XfU99GtToj8MMxHwxo0ZteE8UxqDvywRK7DvIXUHgEUEKBcBg0eTwghus+kGms95hd4v4dgjuKf7I2EgbmNrP9MBu46yV5uBSF7lsQCNNxLpvk36MHuEOLhoax/HYaSwG+I8S3RehMcw1cb3SRJDbDPsLppQou4qkAnw4Igegl4fSXJWD06kqsvkzCr4zEjBo+cbHUZFNuX3X+ULJDSeLFbnumcAAAAASUVORK5CYII=",
        "inventoryImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAADAFBMVEX/AADgAADAAACgAACAAABgAABAAAAwAAAgAAAYAAAQAACAQECgUFDAYGDgcHD/gID/QADgOADAMACgKACAIABgGABAEAAwDAAgIAAYGAAQEACAgECgoFDAwGDg4HD//4D/gADgcADAYACgUACAQABgMABAIAAwGAAAIAAAGAAAEABAgEBQoFBgwGBw4HCA/4D/wADgqADAkACgeACAYABgSABAMAAwJAAAICAAGBgAEBBAgIBQoKBgwMBw4OCA/////wDg4ADAwACgoACAgABgYABAQAAwMAAAACAAABgAABBAQIBQUKBgYMBwcOCAgP+A/wBw4ABgwABQoABAgAAwYAAgQAAYMAAgACAYABgQABCAQICgUKDAYMDgcOD/gP8A/wAA4AAAwAAAoAAAgAAAYAAAQAAAMABgMDBAICAwGBiAYGCgeHjAkJDgqKj/wMAA/4AA4HAAwGAAoFAAgEAAYDAAQCAAMBhgYDBAQCAwMBiAgGCgoHjAwJDg4Kj//8AA//8A4OAAwMAAoKAAgIAAYGAAQEAAMDAwYDAgQCAYMBhggGB4oHiQwJCo4KjA/8AAgP8AcOAAYMAAUKAAQIAAMGAAIEAAGDAwYGAgQEAYMDBggIB4oKCQwMCo4ODA//8AAP8AAOAAAMAAAKAAAIAAAGAAAEAAADAwMGAgIEAYGDBgYIB4eKCQkMCoqODAwP+AAP9wAOBgAMBQAKBAAIAwAGAgAEAYADBgMGBAIEAwGDCAYICgeKDAkMDgqOD/wP//AP/gAODAAMCgAKCAAIBgAGBAAEAwADD////g4ODAwMCgoKCAgIBgYGBAQEAgICD/AIDgAHDAAGCgAFCAAEBgADBAACAwABjw8PDQ0NCwsLCQkJBwcHBQUFAwMDAQEBB/Wkildl7Kj3LlooL/tpH/069oVB+AcCCqiDTAoEDyxE344GD8/Jl1aViRh26rmoHgwKDQqFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABHbGzm1GiTAAAAAXRSTlMAQObYZgAAAAFiS0dEAIgFHUgAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfYDBwQJibgc5RtAAAAvElEQVQ4y+WTQQ7EIAhFOYrDh/vfyyUnGEDbqglNZj0/XfU99GtToj8MMxHwxo0ZteE8UxqDvywRK7DvIXUHgEUEKBcBg0eTwghus+kGms95hd4v4dgjuKf7I2EgbmNrP9MBu46yV5uBSF7lsQCNNxLpvk36MHuEOLhoax/HYaSwG+I8S3RehMcw1cb3SRJDbDPsLppQou4qkAnw4Igegl4fSXJWD06kqsvkzCr4zEjBo+cbHUZFNuX3X+ULJDSeLFbnumcAAAAASUVORK5CYII=",
        "weight": 0.3,
        "armorPoints": 0,
        "speedPoints": 0,
        "healthBonus": 0,
        "manaBonus": 0,
        "strengthBonus": 0,
        "agilityBonus": 0,
        "intelligenceBonus": 0,
        "spiritualityBonus": 0,
        "energyBonus": 0,
        "precisionBonus": 0,
        "recommendedPrice": 10,
        "sellPrice": 5,
        "requiredLevel": 0
      }
    },
    "strength": 9,
    "agility": 13,
    "intelligence": 8,
    "precision": 33,
    "spirituality": 33,
    "energy": 33,
    "experience": 0,
    "money": 50
  }),
  core.HeroEnvelope.fromJson({
    "gameHeroEnvelope": {
      "id": null,
      "level": 1,
      "name": "Unnamed",
      "type": {
        "name": "humanRedKnight",
        "race": "human",
        "tags": [],
        "health": 10,
        "armor": 1,
        "speed": 3,
        "range": 0,
        "actions": 1,
        "attack": "0 0 2 2 3 2",
        "cost": 60,
        "langName": {"cz": "rytíř", "en": "knight"},
        "unitTypeDataVersion": 0,
        "unitTypeVersion": 0,
        "abilities": {
          "move": {"steps": null},
          "attack": {"steps": null, "attack": null},
          "shoot": null,
          "heal": null
        },
        "authorEmail": "moravcikjosef0810@gmail.com",
        "image": {
          "name": "humanRedKnight",
          "data":
              "data:image/png;base64,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",
          "width": 44,
          "height": 65,
          "type": "unitBase",
          "authorEmail": "wassago@seznam.cz",
          "imageVersion": 0,
          "dataModelVersion": 0,
          "created": "2011-10-05T14:48:00.000Z",
          "tags": [],
          "origin": "author",
          "multiply": 1.0,
          "top": 3,
          "left": 13
        },
        "icon": null,
        "bigImage": null
      }
    },
    "inventoryItems": [],
    "equippedItemNames": {
      "rightHand": "ironShortSword",
      "leftHand": "woodenBuckler"
    },
    "equippedItems": {
      "rightHand": {
        "possiblePositions": ["rightHand", "leftHand"],
        "id": null,
        "typeName": "ironShotSword",
        "langName": {"cz": "Krátký železný meč", "en": "iron short sword"},
        "mapImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAABj0lEQVRYhe2VsW3DMBBFn4MMwDJlRtAIKlOqdKkRXGaMjMDSpcqUHEEj0J3L2+BSSFRoyZbJmHYR+AMnQMDh3r/jiYKnnnqMdIyFXh4BFhG89+H9RK/3hIsIAJGBhe5lQEWEYGBNm0fAvffUdX2WV3oHkjsPKjmBs/C17ksaUO/9BDfGJMFLGTiBB4nIVXgJA9r3PSIydZ0Dv9XABA8yxmTBbzGwgMPQedM0WXVTEuPrcxPgzjkAqqr6MzwlWdXB4Qj+CPUOArxpGowxOOcQEdq2zYZD4kXkj+B6cM4VhScbCOr7vig8VaoOdV9o+4GKiHZdp9bai//4HGVNoK5gtzVFO7+6hBawgN0PuxD2AcB+J9VY1IzZaxPQdoTXQLuF97ch6iobGMeJkUsG1AIeEKADHPC+/TWwYuIScK7N9IgdAbQjvB7BbqXKWCNnGc8emapD7TB2taDVGNweq5qO4HAcOvUM594AfUZbUXfzSJLaT9TvVzufcskb+VXHsYn5JzbPiU0Uuf3mReZ/vv+vHzHtDbishAToAAAAAElFTkSuQmCCAAAAAElFTkSuQmCC",
        "inventoryImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAABj0lEQVRYhe2VsW3DMBBFn4MMwDJlRtAIKlOqdKkRXGaMjMDSpcqUHEEj0J3L2+BSSFRoyZbJmHYR+AMnQMDh3r/jiYKnnnqMdIyFXh4BFhG89+H9RK/3hIsIAJGBhe5lQEWEYGBNm0fAvffUdX2WV3oHkjsPKjmBs/C17ksaUO/9BDfGJMFLGTiBB4nIVXgJA9r3PSIydZ0Dv9XABA8yxmTBbzGwgMPQedM0WXVTEuPrcxPgzjkAqqr6MzwlWdXB4Qj+CPUOArxpGowxOOcQEdq2zYZD4kXkj+B6cM4VhScbCOr7vig8VaoOdV9o+4GKiHZdp9bai//4HGVNoK5gtzVFO7+6hBawgN0PuxD2AcB+J9VY1IzZaxPQdoTXQLuF97ch6iobGMeJkUsG1AIeEKADHPC+/TWwYuIScK7N9IgdAbQjvB7BbqXKWCNnGc8emapD7TB2taDVGNweq5qO4HAcOvUM594AfUZbUXfzSJLaT9TvVzufcskb+VXHsYn5JzbPiU0Uuf3mReZ/vv+vHzHtDbishAToAAAAAElFTkSuQmCCAAAAAElFTkSuQmCC",
        "weight": 1,
        "armorPoints": 0,
        "speedPoints": 0,
        "healthBonus": 0,
        "manaBonus": 0,
        "strengthBonus": 0,
        "agilityBonus": 0,
        "intelligenceBonus": 0,
        "spiritualityBonus": 0,
        "energyBonus": 0,
        "precisionBonus": 0,
        "recommendedPrice": 50,
        "sellPrice": 25,
        "requiredLevel": 0,
        "weapon": {
          "requiredStrength": 0,
          "requiredAgility": 0,
          "requiredIntelligence": 0,
          "baseAttack": [0, 0, 0, 2, 3, 3],
          "bonusAttack": [0, 0, 0, 0, 0, 0],
          "range": 0
        }
      },
      "leftHand": {
        "possiblePositions": ["rightHand", "leftHand"],
        "id": null,
        "typeName": "woodenBuckler",
        "langName": {"cz": "dřevěný štít", "en": "wooden shield"},
        "mapImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAABuklEQVRYhe2VP3KrMBDGf/vSqEihklI3yBGgS4lvwBF8hVzFR6BMZ26g19kzr6CkVJHCnVJgYf4akXkzafhmBOxK6PtY7S6wY8eOX4b8+EURP/Z57zfvt/2FO3Ge52itAXDOAVCW5WYhmwSIiM/zHACtNVmWUdc15/MZAGMMzjnKsowWEa9UxKdvHvcF+hVM0vrtv9aG1hfs6q/g/eSUJrx/tpAHUjOaNzwEBSHFu0dk8fs6ZVEC5kgHSICmZzdLC6dYFSAivngfhXKOsO+7P4coLETCRwlYJF1asxFPk1BE/PF4pK7rLsND5td1DTAoxTDnnBuMqqqWElKiItDfOBD3bWtt5+vPZVm2uvfLSgQ+lFI0TYNzjtvtBoC1FmMMTdOglCJJko7cWotSCuccl8sFrTXX63V2++6yIsKnb4/whT4Qaz/pBwKRSWiS++jbPGp/1k6GvWGOPEqA915OnxENs18l9/vp82k3jBMwIZkjDKTJwtwQg6+JEhAdhR5O07OXMflEzRpExBdFAbR1fzgcBj0B2hIc1f3zXrNFQBABkKYpxpgBeVVVAIH8//6Ol4T0sYV4x44dAd8uHOGbariMLgAAAABJRU5ErkJgggAAAABJRU5ErkJggg==",
        "inventoryImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAABuklEQVRYhe2VP3KrMBDGf/vSqEihklI3yBGgS4lvwBF8hVzFR6BMZ26g19kzr6CkVJHCnVJgYf4akXkzafhmBOxK6PtY7S6wY8eOX4b8+EURP/Z57zfvt/2FO3Ge52itAXDOAVCW5WYhmwSIiM/zHACtNVmWUdc15/MZAGMMzjnKsowWEa9UxKdvHvcF+hVM0vrtv9aG1hfs6q/g/eSUJrx/tpAHUjOaNzwEBSHFu0dk8fs6ZVEC5kgHSICmZzdLC6dYFSAivngfhXKOsO+7P4coLETCRwlYJF1asxFPk1BE/PF4pK7rLsND5td1DTAoxTDnnBuMqqqWElKiItDfOBD3bWtt5+vPZVm2uvfLSgQ+lFI0TYNzjtvtBoC1FmMMTdOglCJJko7cWotSCuccl8sFrTXX63V2++6yIsKnb4/whT4Qaz/pBwKRSWiS++jbPGp/1k6GvWGOPEqA915OnxENs18l9/vp82k3jBMwIZkjDKTJwtwQg6+JEhAdhR5O07OXMflEzRpExBdFAbR1fzgcBj0B2hIc1f3zXrNFQBABkKYpxpgBeVVVAIH8//6Ol4T0sYV4x44dAd8uHOGbariMLgAAAABJRU5ErkJgggAAAABJRU5ErkJggg==",
        "weight": 1,
        "armorPoints": 3,
        "speedPoints": 0,
        "healthBonus": 0,
        "manaBonus": 0,
        "strengthBonus": 0,
        "agilityBonus": 0,
        "intelligenceBonus": 0,
        "spiritualityBonus": 0,
        "energyBonus": 0,
        "precisionBonus": 0,
        "recommendedPrice": 10,
        "sellPrice": 5,
        "requiredLevel": 0
      }
    },
    "strength": 13,
    "agility": 9,
    "intelligence": 8,
    "precision": 33,
    "spirituality": 33,
    "energy": 33,
    "experience": 0,
    "money": 50
  }),
  core.HeroEnvelope.fromJson({
    "gameHeroEnvelope": {
      "id": null,
      "level": 1,
      "name": "Unnamed",
      "type": {
        "name": "whiteMage",
        "race": "human",
        "tags": [],
        "health": 10,
        "armor": 0,
        "speed": 4,
        "range": 5,
        "actions": 1,
        "attack": "0 0 1 2 2 2",
        "cost": 600,
        "langName": {"cz": "Bílý mág", "en": "White mage"},
        "unitTypeDataVersion": 0,
        "unitTypeVersion": 0,
        "abilities": {
          "move": {"steps": null},
          "attack": null,
          "shoot": {"steps": null, "attack": null},
          "heal": {"steps": null, "effect": "1 2 2 3 3 3", "range": null}
        },
        "authorEmail": "mlcoch.zdenek@gmail.com",
        "image": {
          "name": "whiteMage",
          "data":
              "data:image/png;base64,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",
          "width": 30,
          "height": 57,
          "type": "unitBase",
          "authorEmail": "wassago@seznam.cz",
          "imageVersion": 0,
          "dataModelVersion": 0,
          "created": "2011-10-05T14:48:00.000Z",
          "tags": [],
          "origin": "author",
          "multiply": 1.0,
          "top": 10,
          "left": 22
        },
        "icon": null,
        "bigImage": null
      }
    },
    "inventoryItems": [],
    "equippedItemNames": {
      "rightHand": "simpleWoodenStaff",
      "body": "graySimpleRobe"
    },
    "equippedItems": {
      "rightHand": {
        "possiblePositions": ["bothHands"],
        "id": null,
        "typeName": "simpleWoodenStaff",
        "langName": {"cz": "dřevěný hůl", "en": "simple wooden staff"},
        "mapImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAA7ElEQVRYhe2XvQ2DMBSEL0nDGB7hjZHyjeCRKCk9isvQMYLLbHEpCMiJAooxGEXhJIRlhL8zvB8A/kj8NHkuBbd22kQRAyGAexmgcyA5GoiPMgZI0Nr+HEI/HgyctoarKowxEKkBAM9YGLQpn6rKuq4pIsUf/xx8c03Bi+iAJ8PXSIMx1bz36Louae3cXkASi+G5oojQ+77UYuE7X+qUIgJjDEII5XdOgt5jlWi/pMJVFW17RVXd0DT3YX7xzlNuzIr2XP1mkTngB/wbvadQ8VSLm9EujSVenM71g+jLdfMi82Jg5lox7fb7tJse1r3iEg99E50AAAAASUVORK5CYIIAAAAASUVORK5CYII=",
        "inventoryImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAA7ElEQVRYhe2XvQ2DMBSEL0nDGB7hjZHyjeCRKCk9isvQMYLLbHEpCMiJAooxGEXhJIRlhL8zvB8A/kj8NHkuBbd22kQRAyGAexmgcyA5GoiPMgZI0Nr+HEI/HgyctoarKowxEKkBAM9YGLQpn6rKuq4pIsUf/xx8c03Bi+iAJ8PXSIMx1bz36Louae3cXkASi+G5oojQ+77UYuE7X+qUIgJjDEII5XdOgt5jlWi/pMJVFW17RVXd0DT3YX7xzlNuzIr2XP1mkTngB/wbvadQ8VSLm9EujSVenM71g+jLdfMi82Jg5lox7fb7tJse1r3iEg99E50AAAAASUVORK5CYIIAAAAASUVORK5CYII=",
        "weight": 1,
        "armorPoints": 0,
        "speedPoints": 0,
        "healthBonus": 0,
        "manaBonus": 0,
        "strengthBonus": 0,
        "agilityBonus": 0,
        "intelligenceBonus": 0,
        "spiritualityBonus": 0,
        "energyBonus": 0,
        "precisionBonus": 0,
        "recommendedPrice": 50,
        "sellPrice": 25,
        "requiredLevel": 0,
        "weapon": {
          "requiredStrength": 0,
          "requiredAgility": 0,
          "requiredIntelligence": 10,
          "baseAttack": [0, 0, 1, 2, 2, 2],
          "bonusAttack": [0, 0, 0, 0, 0, 0],
          "range": 4
        }
      },
      "body": {
        "possiblePositions": ["body"],
        "id": null,
        "typeName": "graySimpleRobe",
        "langName": {"cz": "jednoduchá šedá róba", "en": "gray simple robe"},
        "mapImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAACp0lEQVRYhe2Wv2sUQRTHP1GRFPGYIsqJFlOkOA4RkRQpUkxhIQFhK+stUlmJf8HaBQuRFGJhcXVIYXGI5RQWARUWEo4UFiOmOEJCBrG4bixys87+uh+bwsI8WI7Zmcf7vO+89/bg0i7tH9tCAx93Qf/GAA5Aa40xBoA4ji8MMquj01rjAbxJKUOQRhCzODmftTEmA7DWAhBFEVLKxhDXZjkUBveBhRDZvleiiV2Zsp9lXwyulCJJEgB6vV5jgKkK+ILzJoTIAodX44GZ8xomATitNf6x1iKEII5jqgqyqU1UoCh9HMe5QpRSIqXEGINSqhFQHYDr9Xol+b3kSqnsXViAY4i5rqG2CKWUuezDIMWq90oE7eiY0aoAXJIkYJLSxkbnADi/Gg/hVQrBxgq5imcmgFp7+2mJ7mI/C+yvwneCh5BS5q4pTK4IMxeAtZbB8CRba61zEH49BSKEqQaYNNl0Kuku9rMzYVC/DmtiCgRXi1RxHKOU4viwz5fv1xmNRrkDo9GI/aMWgg/IToS1FmMMQgiEEKRpWkpCCFHqqLG9rL2CW+2lWmprLd32claM4TRUSmVrr8AkRYsKJFEUAZAaQawMe4eLJRUA9o9abHQOuHPvKWmalj5SIZQQAvXAoPdyLb0AU4rwePi7di+cD2FL+szDdy8efaPbXi4Fh4pJOM+ndTA8YTAuwuLkNMaw0TlgMDyhtW5Ct9yUrBzFf/u6vg7gvCOePe5jjCzVwvbmKa31r0WX0ogOAZz/zHp7uHIDa3+ytnIGQPvuAsMjl/3CGXAzJ7sxBil0MevK4EWAzLx8cJu1lTPe7f6oOgbAq+f3+fj+PNj25imvdw3Jm9mCh+Z2tlad7in36/MTt7O1OnWGh741PrP45siKh+f+y34B///Y/gCM+4RthkqpQAAAAABJRU5ErkJgggAAAABJRU5ErkJggg==",
        "inventoryImageData":
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAACp0lEQVRYhe2Wv2sUQRTHP1GRFPGYIsqJFlOkOA4RkRQpUkxhIQFhK+stUlmJf8HaBQuRFGJhcXVIYXGI5RQWARUWEo4UFiOmOEJCBrG4bixys87+uh+bwsI8WI7Zmcf7vO+89/bg0i7tH9tCAx93Qf/GAA5Aa40xBoA4ji8MMquj01rjAbxJKUOQRhCzODmftTEmA7DWAhBFEVLKxhDXZjkUBveBhRDZvleiiV2Zsp9lXwyulCJJEgB6vV5jgKkK+ILzJoTIAodX44GZ8xomATitNf6x1iKEII5jqgqyqU1UoCh9HMe5QpRSIqXEGINSqhFQHYDr9Xol+b3kSqnsXViAY4i5rqG2CKWUuezDIMWq90oE7eiY0aoAXJIkYJLSxkbnADi/Gg/hVQrBxgq5imcmgFp7+2mJ7mI/C+yvwneCh5BS5q4pTK4IMxeAtZbB8CRba61zEH49BSKEqQaYNNl0Kuku9rMzYVC/DmtiCgRXi1RxHKOU4viwz5fv1xmNRrkDo9GI/aMWgg/IToS1FmMMQgiEEKRpWkpCCFHqqLG9rL2CW+2lWmprLd32claM4TRUSmVrr8AkRYsKJFEUAZAaQawMe4eLJRUA9o9abHQOuHPvKWmalj5SIZQQAvXAoPdyLb0AU4rwePi7di+cD2FL+szDdy8efaPbXi4Fh4pJOM+ndTA8YTAuwuLkNMaw0TlgMDyhtW5Ct9yUrBzFf/u6vg7gvCOePe5jjCzVwvbmKa31r0WX0ogOAZz/zHp7uHIDa3+ytnIGQPvuAsMjl/3CGXAzJ7sxBil0MevK4EWAzLx8cJu1lTPe7f6oOgbAq+f3+fj+PNj25imvdw3Jm9mCh+Z2tlad7in36/MTt7O1OnWGh741PrP45siKh+f+y34B///Y/gCM+4RthkqpQAAAAABJRU5ErkJgggAAAABJRU5ErkJggg==",
        "weight": 0.3,
        "armorPoints": 3,
        "speedPoints": 0,
        "healthBonus": 0,
        "manaBonus": 0,
        "strengthBonus": 0,
        "agilityBonus": 0,
        "intelligenceBonus": 0,
        "spiritualityBonus": 0,
        "energyBonus": 0,
        "precisionBonus": 0,
        "recommendedPrice": 10,
        "sellPrice": 5,
        "requiredLevel": 0
      }
    },
    "strength": 6,
    "agility": 6,
    "intelligence": 18,
    "precision": 33,
    "spirituality": 33,
    "energy": 33,
    "experience": 0,
    "money": 50
  })
];
