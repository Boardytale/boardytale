import {ItemEnvelope} from "../../core/lib/model/model";

export let data: ItemEnvelope = {
    typeName: 'shortWoodenBow',
    langName: {
        cz: 'dřevěný krátký luk',
        en: 'short wooden bow'
    },
    inventoryImageData: "rltiles/item/weapon/ranged/shortbow_1.png",
    mapImageData: "rltiles/item/weapon/ranged/shortbow_1.png",
    recommendedPrice: 50,
    sellPrice: 25,
    weight: 1,
    possiblePositions: ["bothHands"],
    weapon: {
        baseAttack: [0,0,1,2,2,2],
        range: 5,
        requiredAgility: 10
    }
};
