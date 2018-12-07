import {BoardytaleConfiguration} from './shared/lib/configuration/configuration';

export let config: BoardytaleConfiguration = {
    aiService: {
        uris: [{
            host: 'localhost',
            port: 5000,
        }],
        route: null,
        innerRoute: '/innerApi'
    },
    editorServer: {
        innerRoute: '/innerApi',
        route: '/editorApi',
        uris: [{
            host: 'localhost',
            port: 9000,
        }]
    },
    editorDatabase: {
        host: 'boardytale.vserver.cz',
        password: 'boardygame',
        username: 'boardytale',
        port: 5432,
        databaseName: 'boardytale',
    },
    gameServer: {
        innerRoute: '/innerApi',
        route: '/gameApi',
        uris: [{
            host: 'localhost',
            port: 7000,
        }]
    },
    userDatabase: {
        host: 'boardytale.vserver.cz',
        password: 'complexPassword',
        username: 'userdb',
        port: 5432,
        databaseName: 'userdb',
    },
    userService: {
        innerRoute: '/innerApi',
        route: '/userApi',
        uris: [{
            host: 'localhost',
            port: 6000,
        }]
    },
    editorStaticDev: {
        active: true,
        target: '/editor',
        host: 'localhost',
        port: 4300,
    },
    gameStaticDev: {
        active: true,
        target: '/game',
        host: 'localhost',
        port: 4200,
    },
    heroesService: {
        innerRoute: '/innerHeroes',
        route: '/heroes',
        uris: [
            {
                port: 10000,
                host: 'localhost',
            }
        ]
    }
};

