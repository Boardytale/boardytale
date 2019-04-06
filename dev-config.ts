import {BoardytaleConfiguration} from './shared/lib/configuration/configuration';

export let config: BoardytaleConfiguration = {
    aiServer: {
        uris: [{
            host: 'localhost',
            port: 5000,
        }],
        route: null,
        executableType: "dart",
        pathToExecutable: 'ai_server/bin/main.dart',
        pathToWorkingDirectory: 'ai_server'
    },
    editorServer: {
        route: '/editorApi',
        uris: [{
            host: 'localhost',
            port: 9000,
        }],
        executableType: 'dart',
        pathToExecutable: 'editor_server/bin/editor_server_start.dart',
        pathToWorkingDirectory: 'editor_server'
    },
    editorDatabase: {
        host: 'boardytale.vserver.cz',
        password: 'boardygame',
        username: 'boardytale',
        port: 5432,
        databaseName: 'boardytale',
    },
    gameServer: {
        route: '/gameApi',
        uris: [{
            host: 'localhost',
            port: 7000,
        }],
        executableType: 'dart',
        pathToExecutable: 'game_server/bin/game_server_start.dart',
        pathToWorkingDirectory: 'game_server'
    },
    userDatabase: {
        host: 'boardytale.vserver.cz',
        password: 'complexPassword',
        username: 'userdb',
        port: 5432,
        databaseName: 'userdb',
    },
    userServer: {
        route: '/userApi',
        uris: [{
            host: 'localhost',
            port: 4400,
        }],
        innerPort: 4500,
        executableType: 'dart',
        pathToExecutable: 'user_server/bin/main.dart',
        pathToWorkingDirectory: 'user_server'
    },
    editorStaticDev: {
        active: true,
        route: '/editor',
        port: 4300,
    },
    gameStaticDev: {
        active: true,
        route: '/game',
        port: 4201,
    },
    heroesServer: {
        route: '/heroes',
        uris: [
            {
                port: 10000,
                host: 'localhost',
            }
        ],
        executableType: 'dart',
        pathToExecutable: 'hero_server/bin/hero_server_start.dart',
        pathToWorkingDirectory: 'hero_server'
    },
    proxyServer: {
        route: '/',
        uris: [
            {
                port: 80,
                host: 'localhost',
            }
        ],
        executableType: 'ts-node',
        pathToExecutable: 'proxy_server/index.ts',
        pathToWorkingDirectory: 'proxy_server'
    },
};

