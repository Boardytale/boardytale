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
  })
];
