import { TaleCreateEnvelope, AiGroup } from '../../model/model';
import { world } from './0lvl_bandits/world';

const bandits: AiGroup = {
    color: '#555555',
    id: 'bandits',
    name: {
        en: 'Bandits',
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
        dialogs: {},
        events: {},
        name: '0lvl_bandits',
        langs: { en: {} },
        aiGroups: {
            bandits: bandits,
        },
        langName: {
            en: 'Bandits camp',
            cz: 'Tábor banditů',
        },
        taleVersion: 0,
        units: [
            {
                fieldId: '10_10',
                aiGroupId: 'bandits',
                unitTypeName: 'pikeman',
                playerId: null,
            },
            {
                fieldId: '7_5',
                aiGroupId: 'bandits',
                unitTypeName: 'pikeman',
                playerId: null,
            },
        ],
        world: world,
        startingFieldIds: [
            "0_1","0_2","0_3","0_4",
            "1_0","1_1","1_2","1_3",
            "2_1","2_2","2_3","2_4",
            "3_1","3_2","3_3","3_4",
            "4_1","4_2","4_3","4_4",
        ],
    },
};
