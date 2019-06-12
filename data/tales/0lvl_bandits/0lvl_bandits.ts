import { TaleEnvelope, Player } from '../../../core/lib/model/model';
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

export let data: TaleEnvelope = {
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
        experienceForHeroes: 100,
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
                moveToFieldId: '5_0',
                changeToTypeName: 'pikemanCaptain',
                transferToPlayerId: 'players',
                unitId: 'headPikeman',
            },
            {
                moveToFieldId: '6_0',
                changeToTypeName: 'pikeman',
                transferToPlayerId: 'players',
            },
            {
                moveToFieldId: '7_0',
                changeToTypeName: 'pikeman',
                transferToPlayerId: 'players',
            },
            {
                moveToFieldId: '8_0',
                changeToTypeName: 'pikeman',
                transferToPlayerId: 'players',
            },
            {
                moveToFieldId: '5_1',
                changeToTypeName: 'pikeman',
                transferToPlayerId: 'players',
            },
            {
                moveToFieldId: '6_1',
                changeToTypeName: 'pikeman',
                transferToPlayerId: 'players',
            },
            {
                moveToFieldId: '7_1',
                changeToTypeName: 'pikeman',
                transferToPlayerId: 'players',
            },
            {
                moveToFieldId: '8_1',
                changeToTypeName: 'pikeman',
                transferToPlayerId: 'players',
            },
            {
                moveToFieldId: '4_4',
                changeToTypeName: 'elvenLizard',
                transferToPlayerId: 'bandits',
            },
            {
                moveToFieldId: '5_5',
                changeToTypeName: 'banditPikeman',
                transferToPlayerId: 'bandits',
            },
            {
                moveToFieldId: '5_4',
                changeToTypeName: 'banditPikeman',
                transferToPlayerId: 'bandits',
            },
        ],
        world: world,
        triggers: {
            onInit: [],
            onAfterGameStarted: [
                {
                    action: {
                        showBanterAction: {
                            title: {
                                en: 'Patrol commander',
                                cz: 'Velitel hlídky',
                            },
                            text: {
                                en:
                                    'The rest of the bandits are hiding here in this forest.',
                                cz:
                                    'Poslední bandité se skrývají zde v tomto lese.',
                            },
                            showTimeInMilliseconds: 5000,
                            speakingUnitId: 'headPikeman',
                            image: {
                                authorEmail: 'wassago@seznam.cz',
                                created: '2011-10-05T14:48:00.000Z',
                                data:
                                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADwAAABUCAYAAADeW1RFAAAABmJLR0QAAAAAAAD5Q7t/AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QYFEB0kBaOLfgAAAB1pVFh0Q29tbWVudAAAAAAAQ3JlYXRlZCB3aXRoIEdJTVBkLmUHAAAFoklEQVR42u2bTW8TVxSGn/HcsYd8GEitllIJEClVoyhRFjRCrajyD5BYdEXbDVKlqqq6QlW77S+ghVU3SFmxiMSKiBUiVFQQgREJtI6KoDIg0qQhcRz8MZ7ThceTcWLHxg5kxp0jjWLnjq/93vd83zsQSiihhBJK54gEHUDk/8aY1iK7WshwCDjYKi1tmkPIsN8Bd9dgVLa4fCuqSbBrlTdngafOSvUAe4AoUACWgB997tGbAZzbyJrlAI4AtofuNPAZcNRZjK9bT260nQRcqjfw/Yb3nzts686ivEL8fmNm8KorKWeBvx12E8CZOjf+DPwBLAIfA9++vt/0+gE/dlhMADHHyE9Xz+ky9g0w6CzQGtAFfLUDQFsG/IvDsAa8BZgOiHngh81zy04xuW1xWAfijvF7P2wAXwDfNW+XOxK+XpnhrQa/BHYDA473XnEW6IyPGG4FcKueNpCpaNgACAGHgEPAgQMcaMelthmo+D0URbYbrGVZWJblW21oWqVleropsG7N7Hkd1IRjq/aNXLlyRSzL8n27p2mGGzGWyWSYnZ1177tx40ZgvXTTLC0uLrqvi8VisNXZo65bqnzlvmvXrvlSpZsJG1JRU6UULVRLWiBtuBln9hHxjsjGxLIsuXz5cs2mu2VZVd75E/bKcfp826BXTTBY5ZCO08djMkTQeEQBpZSbbCil+I2lmp7dMQfB540AmZmZkXPnzrksjRKXfkw5TEwG6apiudEVhDx8k1qOkZBhuqWfmHzILgHk7t27dUE+ePDAV2rdyGlpG1XwKgtE0Yl4urDFYhGlVM2rIgOYgaqWNK9NT7MCQD/R8j+lDPzXDR/yNOcpuLtQwQtLLut/UahyUKc3gPU6rRWfAFZtfFarJCV37txxQVfUuAK28ncvin/KW2w76qnbbvFMTU1RKFQz7WU2n887X6TxKX2Bz7SwbRsRYWZmBqUU9+/fdx3W7du3se2yKpvoaD4IwardCbLZLLquMzIyAsDw8DAAs7OzZLNZRkdHAUiyCqx6w50WSMArKyvkcjlu3bqFiLgABwcHt8q4gstwOp12gZw8ebJu42DaaRFdunSJEydOBKo23pSJXbhwQc6fP+9mUzI5KTI+7qadyWRSJicnA3PSpx7guseW5OZNkYmJwB1pahkwIHL9euDB1gTcoFDwHeht3VvKZrOuo7p37x5TU1O+Y6wtwN5wk0qlmJ+fX6dfBF3XmZiYaLb3FSyGS6USS0vlboeu6wwNDdHT00MkEmF8fLwzGK7I3NwcT548ccvEygIopYjH42iaxsWLFzeWmsEFXCgUWFhY4NSpU9XllKbR29tLNBrtHIbn5uZIpVKbgAIcOXKEWCxGPB7HNM1AA3Z1d3l5mXw+v4ndSs6saRqGYWAYRuAbAJsKAXNvH7mlfwHoevtddzyZTLp18U5LqwfTBODQ0WMUcjmWnqaxi0WMri5Wnz8DoPud/UQiETLP0u1+py9U2v3RdslCNwx003TBAmSfP0VE2DcwxL6Boc5wWo+mf2ctk0GzbddR4WnylSwLEds37G5PAyD9uO6Yrmnk19Ywu7t9w3BbNjxGggx58tgUsfmTl945fbl92rJKj5FYTzwoVcBWyX4UhzGr7u2I1DK33mSvYs9AowRYPmnCt5NwuPXtCL1yiGitWlcOYsh762O+qIdVuyr9gnxDJ3GM3ZgYXGUh+Az3E6vHnhzEkAPV40L5qZ7geekxEuSxWCRHilytuQTgfXZhokgQqzC8h/LjEBJIhj/A3PI4Uz9R96SA5zKAn4LCsGvDyxRZ5iUPy9umteaSAxjsQhHHoNvZT/bYchfUiGc+cFoHgUdeZ7VKgZcUKTYIOQoNAV5QwEYwiLhzXGVh7U0nIs0CTnvB2g5IQVANQvlDz6Z5+UHV4KSWHflcUiihhBKKr+U/pwPiobnv//4AAAAASUVORK5CYII=',
                                dataModelVersion: 0,
                                height: 84,
                                width: 60,
                                multiply: 3,
                                name: 'pikeman',
                                left: 10,
                                top: -8,
                                type: 'unitBase',
                                origin: 'author',
                                tags: [],
                                imageVersion: 0,
                            },
                        },
                    },
                },
            ],
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
