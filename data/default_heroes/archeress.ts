import {HeroEnvelope} from "../../core/lib/model/model";

export let data: HeroEnvelope = {
    intelligence: 9,
    inventoryItems: [],
    strength:8,
    agility: 13,
    precision: 33,
    spirituality: 33,
    energy: 33,
    experience: 0,
    money: 50,
    equippedItems: {
        rightHand: {
            id: 'heroDefaultBow',
            name: 'wooden bow',
            recommendedPrice: 1,
            weight: 1,
            possiblePositions: ["bothHands"],
            weapon: {
                baseAttack: [0,0,1,2,2,2]
            }
        },
        legs: {
            id: 'heroDefaultShoes',
            name: 'simple shoes',
            recommendedPrice: 1,
            weight: 1,
            possiblePositions: ["legs"],
            speedPoints: 3
        }
    },
    gameHeroEnvelope:{
        "name": "Unnamed",
        "level": 1,
        "type": {
            "cost": 500,
            "icon": null,
            "name": "archeress",
            "race": "elf",
            "tags": [],
            "armor": 0,
            "image": {
                "top": 8,
                "data":
                    "data:image/png;base64,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",
                "left": 19,
                "name": "archeress",
                "tags": [],
                "type": "unitBase",
                "width": 42,
                "height": 61,
                "origin": "author",
                "created": "2011-10-05T14:48:00.000Z",
                "multiply": 1.0,
                "authorEmail": "wassago@seznam.cz",
                "imageVersion": 0,
                "dataModelVersion": 0
            },
            "range": 5,
            "speed": 5,
            "attack": "0 0 1 2 3 2",
            "health": 10,
            "actions": 1,
            "bigImage": null,
            "langName": {"cz": "Lukostřelkyně", "en": "Archeress"},
            "abilities": {
                "move": {"steps": null},
                "shoot": {"steps": null, "attack": null}
            },
            "authorEmail": "mlcoch.zdenek@gmail.com",
            "unitTypeVersion": 0,
            "unitTypeDataVersion": 0
        }
    }
};
