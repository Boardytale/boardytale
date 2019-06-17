import {ItemEnvelope} from "../../core/lib/model/model";

export let data: ItemEnvelope = {
    id: 'ironKatana',
    name: 'ironKatana',
    langName: {
        cz: 'železná katana',
        en: 'iron katana'
    },
    inventoryImageData: "rltiles/item/weapon/artefact/urand_katana.png",
    mapImageData: "rltiles/item/weapon/artefact/urand_katana.png",
    recommendedPrice: 50,
    weight: 1,
    possiblePositions: ["bothHands"],
    weapon: {
        baseAttack: [0,0,1,2,2,2]
    }
};
