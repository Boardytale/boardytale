import { Player, TaleCreateEnvelope } from '../../model/model'

const bandits: Player = {
    color: 'red',
    handler: 'ai',
    id: 'bandits',
    name: {
        en: 'Bandits',
    },
    team: 'bandits',
}

export let data: TaleCreateEnvelope = {
    lobby: {
        description: {
            en: 'A very simple tale for newbies.',
        },
        id: '0lvl_bandits',
        image: '36-pikeman_soubi',
        name: {
            en: 'Bandits camp',
        },
    },
    authorEmail: 'mlcoch.zdenek@gmail.com',
    taleDataVersion: 0,
    tale: {
        dialogs: {},
        events: {},
        id: '0lvl_bandits',
        langs: { en: {} },
        players: {
            bandits: bandits,
        },
        taleVersion: 0,
        units: {
            '0_0': 'pikeman',
        },
        world: {
            baseTerrainId: 'grass',
            fields: {},
            height: 30,
            width: 30,
            startField: '2_2',
        },
    },
}
