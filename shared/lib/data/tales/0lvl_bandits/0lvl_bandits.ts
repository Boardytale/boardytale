import { TaleCreateEnvelope, Player } from '../../../model/model';
import { world } from './world';

const bandits: Player = {
    color: '#555555',
    id: 'bandits',
    taleId: 'bandits',
    aiGroup: {
        aiEngine: 'standard',
        langName: {
            en: 'Bandits',
        },
    },
    team: 'bandits',
};

export let data: TaleCreateEnvelope = {
    lobby: {
        description: {
            en: 'A very simple tale for newbies.',
        },
        id: '0lvl_bandits',
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
            en: 'Bandits camp',
            cz: 'Tábor banditů',
        },
    },
    authorEmail: 'mlcoch.zdenek@gmail.com',
    tale: {
        humanPlayerIds: ['0', '1', '2', '3'],
        dialogs: {},
        events: {},
        name: '0lvl_bandits',
        langs: { en: {} },
        aiPlayers: {
            bandits: bandits,
        },
        langName: {
            en: 'Bandits camp',
            cz: 'Tábor banditů',
        },
        taleVersion: 0,
        units: [
            {
                moveToFieldId: '3_3',
                changeToTypeName: 'pikeman',
                transferToPlayerId: 'bandits',
            },
        ],
        world: world,
        triggers: {
            onInit: [],
            onUnitDies: [
                {
                    action: {
                        victoryCheckAction: {
                            allOfTeamsEliminatedForLost: null,
                            anyOfTeamsEliminatedForLost: ['players'],
                            allTeamsEliminatedForWin: ['bandits'],
                            anyOfTeamsEliminatedForWin: null,
                            unitsEliminatedForLost: null,
                        },
                    },
                },
            ],
        },
        taleAttributes: {},
    },
};
