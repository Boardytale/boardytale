import {ItemEnvelope} from "../../core/lib/model/model";

export let data: ItemEnvelope = {
    typeName: 'steelKatana',
    langName: {
        cz: 'ocelová katana',
        en: 'steel katana'
    },
    inventoryImageData: "rltiles/item/weapon/katana_1.png",
    mapImageData: "rltiles/item/weapon/katana_1.png",
    recommendedPrice: 500,
    sellPrice: 250,
    weight: 2,
    possiblePositions: ["bothHands"],
    weapon: {
        baseAttack: [0,1,2,2,3,3],
        requiredStrength: 17,
        requiredAgility: 22
    }
};
