import {ItemEnvelope} from "../../core/lib/model/model";

export let data: ItemEnvelope = {
    typeName: 'longWoodenBow',
    langName: {
        cz: 'dřevěný dlouhý luk',
        en: 'long wooden bow'
    },
    inventoryImageData: "rltiles/item/weapon/ranged/longbow_1.png",
    mapImageData: "rltiles/item/weapon/ranged/longbow_1.png",
    recommendedPrice: 500,
    sellPrice: 250,
    weight: 3,
    possiblePositions: ["bothHands"],
    weapon: {
        baseAttack: [0, 1, 2, 2, 3, 3],
        range: 5,
        requiredAgility: 30,
        requiredStrength: 9,
    }
};
