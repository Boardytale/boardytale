part of hero_server;

List<shared.GameHeroCreateEnvelope> mockedHeroes = [
  shared.GameHeroCreateEnvelope.fromJson({
    "name": "První",
    "level": 1,
    "type": {
      "cost": 500,
      "icon": null,
      "name": "elvenSwordmaster",
      "race": "human",
      "tags": [],
      "armor": 1,
      "image": {
        "top": -8,
        "data":
            "data:image/png;base64,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",
        "left": 10,
        "name": "elfSwordmaster",
        "tags": [],
        "type": "unitBase",
        "width": 60,
        "height": 84,
        "origin": "author",
        "created": "2011-10-05T14:48:00.000Z",
        "multiply": 1.0,
        "authorEmail": "wassago@seznam.cz",
        "imageVersion": 0,
        "dataModelVersion": 0
      },
      "range": 0,
      "speed": 5,
      "attack": "0 1 1 2 3 2",
      "health": 10,
      "actions": 1,
      "bigImage": null,
      "langName": {"cz": "elfí pán mečů", "en": "elf swordmaster"},
      "abilities": {
        "move": {"steps": null},
        "attack": {"range": null, "attack": null}
      },
      "authorEmail": "mlcoch.zdenek@gmail.com",
      "unitTypeVersion": 0,
      "unitTypeDataVersion": 0
    }
  }),
  shared.GameHeroCreateEnvelope.fromJson({
    "name": "Druhý",
    "level": 1,
    "type": {
      "cost": 60,
      "icon": null,
      "name": "humanRedKnight",
      "race": "human",
      "tags": [],
      "armor": 1,
      "image": {
        "top": 0,
        "data":
            "data:image/png;base64,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",
        "left": 0,
        "name": "humanRedKnight",
        "tags": [],
        "type": "unitBase",
        "width": 44,
        "height": 65,
        "origin": "author",
        "created": "2011-10-05T14:48:00.000Z",
        "multiply": 1.0,
        "authorEmail": "wassago@seznam.cz",
        "imageVersion": 0,
        "dataModelVersion": 0
      },
      "range": 0,
      "speed": 3,
      "attack": "0 0 2 2 3 2",
      "health": 10,
      "actions": 1,
      "bigImage": null,
      "langName": {"cz": "rytíř", "en": "knight"},
      "abilities": {
        "move": {"steps": null},
        "attack": {"steps": null, "attack": null}
      },
      "authorEmail": "moravcikjosef0810@gmail.com",
      "unitTypeVersion": 0,
      "unitTypeDataVersion": 0
    }
  }),
];
