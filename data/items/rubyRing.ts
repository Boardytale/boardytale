import {ItemEnvelope} from "../../core/lib/model/model";

export let data: ItemEnvelope = {
    id: 'rubyRing',
    name: 'rubyRing',
    langName: {
        cz: 'kouzelný prsten s malým rubínem',
        en: 'magic ring with small ruby'
    },
    inventoryImageData: "data/image_sources/rltiles/item/ring/gold_red.png",
    mapImageData: "data/image_sources/rltiles/item/ring/gold_red.png",
    recommendedPrice: 1000,
    weight: 0.1,
    healthBonus: 1,
    possiblePositions: ["leftWrist", "rightWrist"],
};
