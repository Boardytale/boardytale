import { World } from '../../../core/lib/model/model';

export let world: World = {
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
    startingFieldIds: [
        '0_1',
        '0_2',
        '0_3',
        '0_4',
        '1_0',
        '1_1',
        '1_2',
        '1_3',
        '2_1',
        '2_2',
        '2_3',
        '2_4',
        '3_1',
        '3_2',
        '3_3',
        '3_4',
        '4_1',
        '4_2',
        '4_3',
        '4_4',
    ],
};
