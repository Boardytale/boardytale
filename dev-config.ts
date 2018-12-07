import {BoardytaleConfiguration} from './shared/lib/configuration/configuration';

export let config: BoardytaleConfiguration = {
    aiServer: {
        uris: [{
            host: 'localhost',
            port: 5000,
        }],
        route: null,
        innerRoute: '/innerApi',
        executableType: 'dart',
        pathToExecutable: 'ai_server/bin/main.dart'
    },
    editorServer: {
        innerRoute: '/innerApi',
        route: '/editorApi',
        uris: [{
            host: 'localhost',
            port: 9000,
        }],
        executableType: 'dart',
        pathToExecutable: 'editor_server/bin/main.dart'
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
        }],
        executableType: 'dart',
        pathToExecutable: 'game_server/bin/main.dart'
    },
    userDatabase: {
        host: 'boardytale.vserver.cz',
        password: 'complexPassword',
        username: 'userdb',
        port: 5432,
        databaseName: 'userdb',
    },
    userServer: {
        innerRoute: '/innerApi',
        route: '/userApi',
        uris: [{
            host: 'localhost',
            port: 6000,
        }],
        executableType: 'dart',
        pathToExecutable: 'user_server/bin/main.dart'
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
    heroesServer: {
        innerRoute: '/innerHeroes',
        route: '/heroes',
        uris: [
            {
                port: 10000,
                host: 'localhost',
            }
        ],
        executableType: 'dart',
        pathToExecutable: 'heroes_service/bin/main.dart'
    },
    proxyServer: {
        innerRoute: '/',
        route: '/',
        uris: [
            {
                port: 80,
                host: 'localhost',
            }
        ],
        executableType: 'ts-node',
        pathToExecutable: 'proxy_server/index.ts'
    },
};

