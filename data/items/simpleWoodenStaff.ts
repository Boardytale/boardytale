import {ItemEnvelope} from "../../core/lib/model/model";

export let data: ItemEnvelope = {
    typeName: 'simpleWoodenStaff',
    langName: {
        cz: 'dřevěný hůl',
        en: 'simple wooden staff'
    },
    inventoryImageData: "data/image_sources/rltiles/item/staff/staff_4.png",
    mapImageData: "data/image_sources/rltiles/item/staff/staff_4.png",
    recommendedPrice: 50,
    sellPrice: 25,
    weight: 1,
    possiblePositions: ["bothHands"],
    weapon: {
        baseAttack: [0,0,1,2,2,2],
        range: 4,
        requiredIntelligence: 10
    }
};
