import {ItemEnvelope} from "../../core/lib/model/model";

export let data: ItemEnvelope = {
    id: 'ironShotSword',
    name: 'ironShotSword',
    langName: {
        cz: 'Krátký železný meč',
        en: 'iron short sword'
    },
    inventoryImageData: "rltiles/item/weapon/short_sword_2_old.png",
    mapImageData: "rltiles/item/weapon/short_sword_2_old.png",
    recommendedPrice: 50,
    weight: 1,
    possiblePositions: ["rightHand", "leftHand"],
    weapon: {
        baseAttack: [0,0,0,2,3,3]
    }
};
