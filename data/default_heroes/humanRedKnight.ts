import {HeroEnvelope} from "../../core/lib/model/model";

export let data: HeroEnvelope = {
    intelligence: 3,
    inventoryItems: [],
    strength:4,
    agility: 3,
    precision: 33,
    spirituality: 33,
    energy: 33,
    experience: 0,
    money: 50,
    gameHeroEnvelope: {
        "name": "Unnamed",
        "level": 1,
        "type": {
            "cost": 60,
            "icon": null,
            "name": "humanRedKnight",
            "race": "human",
            "tags": [],
            "armor": 1,
            "image": {
                "top": 3,
                "data":
                    "data:image/png;base64,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",
                "left": 13,
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
    }
};
