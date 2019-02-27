import { WorldCreateEnvelope } from '../../../model/model';

export let world: WorldCreateEnvelope = {
    baseTerrain: 'grass',
    fields: {
        '3_3': {
            terrain: 'rock',
        },
        '4_4': {
            terrain: 'forest',
        },
        '5_5': {
            terrain: 'water',
        },
    },
    height: 30,
    width: 30,
    startFieldId: '2_2',
};
