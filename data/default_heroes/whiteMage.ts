import {HeroEnvelope} from "../../core/lib/model/model";

export let data: HeroEnvelope = {
    intelligence: 3,
    inventoryItems: [],
    strength:3,
    agility: 4,
    precision: 33,
    spirituality: 33,
    energy: 33,
    experience: 0,
    money: 50,
    gameHeroEnvelope:{
        "name": "Unnamed",
        "level": 1,
        "type": {
            "cost": 600,
            "icon": null,
            "name": "whiteMage",
            "race": "human",
            "tags": [],
            "armor": 0,
            "image": {
                "top": 10,
                "data":
                    "data:image/png;base64,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",
                "left": 22,
                "name": "whiteMage",
                "tags": [],
                "type": "unitBase",
                "width": 30,
                "height": 57,
                "origin": "author",
                "created": "2011-10-05T14:48:00.000Z",
                "multiply": 1.0,
                "authorEmail": "wassago@seznam.cz",
                "imageVersion": 0,
                "dataModelVersion": 0
            },
            "range": 5,
            "speed": 4,
            "attack": "0 0 1 2 2 2",
            "health": 10,
            "actions": 1,
            "bigImage": null,
            "langName": {"cz": "Bílý mág", "en": "White mage"},
            "abilities": {
                "move": {"steps": null},
                "shoot": {"steps": null, "attack": null},
                "heal": {"steps": null, "effect": "1 2 2 3 3 3", "range": null}
            },
            "authorEmail": "mlcoch.zdenek@gmail.com",
            "unitTypeVersion": 0,
            "unitTypeDataVersion": 0
        }
    }
};
