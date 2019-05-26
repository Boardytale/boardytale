import { TaleCreateEnvelope, Player } from '../../../core/lib/model/model';
import { world } from './0lvl_kidnapping_world';

/**
 * Init: Hraci jsou ve vesnici obehnane palisadou, utoci bandite (distractionBandits).
 * 1. Banditi (distractionBandits) prorazi predni branu a vrhnou se do boje s hraci. Zradce (betrayerVillagers) vyrazi k zadni brane.
 * 2. Zradce otevre zadni branu, stealthyBandits vbehnou do vesnice. Zradce se k nim prida a nasedne na kone (despawn puvodni, spawn nova jednotka, AiGroup betrayerBandits.
 *      Hraci jsou informovani pomoci banteru (text, ktery nezastavi boj, zobrazuje se jako bubliny na kraji obrazovky)
 * 3. stealthyBandits a zradce se probiji do stredu vesnice, zradce zautoci na beauty. Vyskoci dialog (hraci si fakt potrebuji vsimnout), zradce bude 2 tahy idle + banter
 *      Naklada beauty na kone
 * 4. zradce prcha i s beauty pryc, stealthyBandits jdou branit zadni branu, distractionBandits se stahuji
 * 5. Zradce uprchl, stealthyBandits se stahuji
 * 6. Zadny bandita uz neni pobliz vesnice - konec aktu
 * 3-5 b) Zradce umrel, banditi se stahuji, pak 6
 */
// const changeTeamBetrayerToBandits: UnitCreateOrUpdateAction = {
//     aiGroupId: "betrayerBandits",
//     unitStoryId: 'betrayer',
//     unitTypeName: 'betrayer_on_horseback',
//     isUpdate: true,
//     state: {buffs: [{
//             he
//         }]}
// }

const aiPlayers: { [key: string]: Player } = {
    distractionBandits: {
        taleId: 'distractionBandits',
        aiGroup: {
            aiEngine: 'standard',
            langName: {
                cz: 'Banditi odvádějící pozornost',
                en: 'Distraction bandits',
            },
        },
        team: 'bandits',
        color: '#4affff',
    },
    stealthyBandits: {
        taleId: 'stealthyBandits',
        aiGroup: {
            aiEngine: 'standard',
            langName: {
                cz: 'Ukrývající se banditi',
                en: 'Stealthy bandits',
            },
        },
        team: 'bandits',
        color: '#39ffae',
    },
    betrayerBandits: {
        taleId: 'betrayerBandits',
        aiGroup: {
            aiEngine: 'standard',
            langName: {
                cz: 'Zrádci',
                en: 'Betrayers',
            },
        },
        team: 'bandits',
        color: '#39ffae',
    },
    betrayerVillagers: {
        taleId: 'betrayerVillagers',
        aiGroup: {
            aiEngine: 'standard',
            langName: {
                cz: 'Vesničani, kteří zradili',
                en: 'Betrayer villagers',
            },
        },
        team: 'bandits',
        color: '#39ffae',
    },
    panickedVillagers: {
        taleId: 'panickedVillagers',
        aiGroup: {
            aiEngine: 'panic',
            langName: {
                cz: 'Panikařící vesničané',
                en: 'Panicked villagers',
            },
        },
        team: 'villagers',
        color: '#39ffae',
    },
    beautyVillagers: {
        taleId: 'beautyVillagers',
        aiGroup: {
            aiEngine: 'passive',
            langName: {
                cz: 'Krásní vesničané',
                en: 'Beauty villagers',
            },
        },
        team: 'villagers',
        color: '#39ffae',
    },
    militiaVillagers: {
        taleId: 'militiaVillagers',
        aiGroup: {
            aiEngine: 'standard',
            langName: {
                cz: 'Obrana vesnice',
                en: 'Militia villagers',
            },
        },
        team: 'villagers',
        color: '#39ffae',
    },
    passive: {
        taleId: 'passive',
        aiGroup: {
            aiEngine: 'passive',
            langName: {
                cz: 'Pasivní',
                en: 'Passive',
            },
        },
        team: 'passive',
        color: '#ffffff',
    },
};

export let data: TaleCreateEnvelope = {
    lobby: {
        description: {
            en: 'A very simple tale for newbies.',
        },
        id: '0lvl_kidnapping',
        image: {
            authorEmail: 'wassago@seznam.cz',
            created: '2011-10-05T14:48:00.000Z',
            data: 'human/pikeman.png',
            dataModelVersion: 0,
            height: 84,
            width: 60,
            multiply: 0,
            name: 'pikeman',
            left: 0,
            top: 0,
            type: 'unitBase',
            origin: 'author',
            tags: [],
            imageVersion: 0,
        },
        name: {
            en: 'Kidnapping',
            cz: 'Unos',
        },
    },
    authorEmail: 'pavel.vesely92@gmail.com',
    tale: {
        dialogs: {},
        events: {},
        name: '0lvl_kidnapping',
        langs: { en: {} },
        aiPlayers,
        langName: {
            en: 'Bandits camp',
            cz: 'Tábor banditů',
        },
        taleVersion: 0,
        world: world,
        taleAttributes: {
            progress: 0,
            betrayerDiedInAttackOnVillage: null,
        },
        units: [
            {
                moveToFieldId: '1_1',
                changeToTypeName: 'pikeman',
                transferToPlayerId: 'distractionBandits',
            },
            {
                moveToFieldId: '30_30',
                changeToTypeName: 'banditArcher',
                transferToPlayerId: 'stealthyBandits',
            },
            {
                unitId: 'betrayer',
                moveToFieldId: '15_15',
                changeToTypeName: 'banditArcher',
                transferToPlayerId: 'betrayerVillagers',
            },
            {
                moveToFieldId: '30_30',
                changeToTypeName: 'banditArcher',
                transferToPlayerId: 'stealthyBandits',
            },
            {
                unitId: 'beauty',
                moveToFieldId: '20_20',
                changeToTypeName: 'beauty',
                transferToPlayerId: 'beautyVillagers',
            },
            {
                unitId: 'frontGate',
                moveToFieldId: '10_10',
                changeToTypeName: 'gate',
                transferToPlayerId: 'passive',
            },
            {
                unitId: 'backGate',
                moveToFieldId: '25_25',
                changeToTypeName: 'gate',
                transferToPlayerId: 'passive',
            },
        ],
        humanPlayerIds: ['0', '1', '2', '3'],
        triggers: {
            onInit: [],
            onUnitDies: [],
        },
        //     ['OnUnitDies', [{
        //         unitTaleId: 'frontGate',
        //         taleAttributesConditions: ['equality', 'progress', 0],
        //     }],[
        //         ['setAiProfile', [{
        //             aiGroupId: 'distractionBandits',
        //             profileId: 'attack', // Just fight everything hostile
        //         }]],
        //         ['setAiProfile', [{
        //             aiGroupId: 'betrayerVillagers',
        //             profileId: 'goTo', // No fighting, even when attacked
        //             targerField: '24_25',
        //         }]],
        //         ['setAiProfile', [{
        //             aiGroupId: 'stealthyBandits',
        //             profileId: 'attack',
        //             targerField: '26_25',
        //         }]],
        //         ['setTimer', [{
        //             turns: 2,
        //             action: ['playBanter', [{ // Dialogue that players do not participate in, does not stop game
        //                 actor: 'villager',
        //                 unitTaleId: 'villager1'
        //                 text: {
        //                     en: 'Hey, Calius, where are you going?',
        //                     cz: 'Hej, Calie, kam jdeš?',
        //                 }
        //             }]]
        //         }]],
        //
        //     ]],
        //
        //     ['OnUnitEntersLocation', [{
        //         unitTaleId: 'betrayer'
        //     }, [
        //         ['destroyUnit', [{
        //             unitTaleId: 'frontGate',
        //         }]],
        //         ['destroyUnit', [{
        //             unitTaleId: 'betrayer',
        //         }]],
        //     ]]
        // ]]
    },
};
