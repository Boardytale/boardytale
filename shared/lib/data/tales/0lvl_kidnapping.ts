import { TaleCreateEnvelope, AiGroup, Team, UnitTypeCreateEnvelope, UnitManipulateAction } from '../../model/model';
import { world } from './0lvl_kidnapping/0lvl_kidnapping_world';

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
const changeTeamBetrayerToBandits: UnitManipulateAction = {
    aiGroupId: "betrayerBandits",
    unitStoryId: 'betrayer',
    unitTypeName: 'betrayer_on_horseback',
    isUpdate: true,
    state: {buffs: [{
            he
        }]}
}

const teamBandits: Team = {
    id: 'bandits',
    name: {
        en: 'Bandits',
    },
    color: 'red',
    hostiles: ['players', 'villagers'],
    allies: [],
};

const teamVillagers: Team = {
    id: 'villagers',
    name: {
        en: 'Villagers',
    },
    color: 'yellow',
    hostiles: ['bandits'],
    allies: ['players'],
};

const teamPlayers: Team = {
    id: 'players',
    name: {
        en: 'Players',
    },
    color: null,
    hostiles: ['bandits'],
    allies: ['villagers'],
};

const distractionBandits: AiGroup = {
    id: 'distractionBandits',
    team: 'bandits',
};

const stealthyBandits: AiGroup = {
    id: 'stealthyBandits',
    team: 'bandits',
};

const betrayerBandits: AiGroup = {
    id: 'betrayerBandits',
    team: 'bandits',
};

const betrayerVillagers: AiGroup = {
    id: 'betrayerVillagers',
    team: 'villagers',
};

const panickedVillagers: AiGroup = {
    id: 'panickedVillagers',
    team: 'villagers',
};

const beautyVillagers: AiGroup = {
    id: 'beautyVillagers',
    team: 'villagers',
};

const militiaVillagers: AiGroup = {
    id: 'militiaVillagers',
    team: 'villagers',
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
        aiGroups: {
            distractionBandits,
            stealthyBandits,
            betrayerBandits,
            betrayerVillagers,
            panickedVillagers,
            beautyVillagers,
            militiaVillagers,
        },
        teams: [teamBandits, teamPlayers, teamVillagers],
        langName: {
            en: 'Bandits camp',
            cz: 'Tábor banditů',
        },
        taleVersion: 0,
        unitTypes: [
            {
                unitTypeName: 'pikeman',
            },
            {
                unitTypeName: 'pikeman',
            },
            {
                unitPatchName: 'betrayer_on_foot',
            },
            {
                unitPatchName: 'betrayer_on_horseback',
            },
        ],
        world: world,
        taleAttributes: {
            progress: 0,
            betrayerDiedInAttackOnVillage: null,
        },
    },
    triggers: [
        ['onInitTrigger', [], [ // Trigger funtion, parameters
            ['createUnit', [{ // Code to execute on trigger triggered
                fieldId: '1_1',
                aiGroupId: 'distractionBandits',
                unitTypeName: 'pikeman',
                playerId: null,
            }]],
            ['createUnit', [{
                fieldId: '30_30',
                aiGroupId: 'stealthyBandits',
                unitTypeName: 'banditArcher',
                playerId: null,
            }]],
            ['createUnit', [{
                fieldId: '15_15',
                aiGroupId: 'betrayerVillagers',
                unitPatchName: 'betrayer_on_foot',
                playerId: null,
                unitTaleId: 'betrayer',
            }]],
            ['createUnit', [{
                fieldId: '20_20',
                aiGroupId: 'beautyVillagers',
                unitPatchName: 'beauty', // damsel in distress
                playerId: null,
                unitTaleId: 'beauty',
            }]],
            // ... dalsi spawn jednotek
            ['createDestructible', [{ // can be just unit with speed 0
                fieldId: '10_10',
                destructibleTypeId: 'gate',
                health: 20,
                unitTaleId: 'frontGate',
            }]],
            ['createDestructible', [{
                fieldId: '25_25',
                destructibleTypeId: 'gate',
                health: 20,
                unitTaleId: 'backGate',
            }]],

            ['setAiProfile', [{
                aiGroupId: 'stealthyBandits',
                profileId: 'idle',
            }]],
            ['setAiProfile', [{
                aiGroupId: 'distractionBandits',
                profileId: 'goAttactTo', // Travel to X, fight all the way, then hold position
                targerField: '10_10'
            }]],
            ['setAiProfile', [{
                aiGroupId: 'betrayerVillagers',
                profileId: 'idle',
            }]],
            ['setAiProfile', [{
                aiGroupId: 'beautyVillagers',
                profileId: 'idle',
            }]],
            ['setAiProfile', [{
                aiGroupId: 'panickedVillagers',
                profileId: 'panic', // Run around, don't attack anything
            }]],
        ]],

        ['OnUnitDies', [{
            unitTaleId: 'frontGate',
            taleAttributesConditions: ['equality', 'progress', 0],
        }],[
            ['setAiProfile', [{
                aiGroupId: 'distractionBandits',
                profileId: 'attack', // Just fight everything hostile
            }]],
            ['setAiProfile', [{
                aiGroupId: 'betrayerVillagers',
                profileId: 'goTo', // No fighting, even when attacked
                targerField: '24_25',
            }]],
            ['setAiProfile', [{
                aiGroupId: 'stealthyBandits',
                profileId: 'attack',
                targerField: '26_25',
            }]],
            ['setTimer', [{
                turns: 2,
                action: ['playBanter', [{ // Dialogue that players do not participate in, does not stop game
                    actor: 'villager',
                    unitTaleId: 'villager1'
                    text: {
                        en: 'Hey, Calius, where are you going?',
                        cz: 'Hej, Calie, kam jdeš?',
                    }
                }]]
            }]],

        ]],

        ['OnUnitEntersLocation', [{
            unitTaleId: 'betrayer'
        }, [
            ['destroyUnit', [{
                unitTaleId: 'frontGate',
            }]],
            ['destroyUnit', [{
                unitTaleId: 'betrayer',
            }]],
        ]]
    ]
};
