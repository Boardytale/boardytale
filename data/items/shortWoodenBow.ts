import {ItemEnvelope} from "../../core/lib/model/model";

export let data: ItemEnvelope = {
    id: 'shortWoodenBow',
    name: 'wooden bow',
    langName: {
        cz: 'dřevěný krátký luk',
        en: 'short wooden bow'
    },
    inventoryImageData: "inventory_items/shortWoodenBow.png",
    mapImageData: "map_items/shortWoodenBow.png",
    recommendedPrice: 1,
    weight: 1,
    possiblePositions: ["bothHands"],
    weapon: {
        baseAttack: [0,0,1,2,2,2]
    }
};
