import { TaleCreateEnvelope, AiGroup } from '../../model/model';

const bandits: AiGroup = {
    color: 'red',
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
        units: {
            '0_0': 'pikeman',
        },
        world: {
            baseTerrain: 'grass',
            fields: {},
            height: 30,
            width: 30,
            startFieldId: '2_2',
        },
    },
};
