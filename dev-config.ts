import {BoardytaleConfiguration} from './core/lib/configuration/configuration';

export let config: BoardytaleConfiguration = {
    aiServer: {
        uris: [{
            host: 'localhost',
            port: 5000,
        }],
        route: null,
        executableType: "dart",
        pathToExecutable: 'ai_server/bin/ai_server_start.dart',
        pathToWorkingDirectory: 'ai_server'
    },
    loggerServer: {
        uris: [{
            host: 'localhost',
            port: 3333,
        }],
        route: null,
        executableType: "dart",
        pathToExecutable: 'logger_server/bin/logger_server_start.dart',
        pathToWorkingDirectory: 'logger_server'
    },
    editorServer: {
        route: '/editorApi',
        uris: [{
            host: 'localhost',
            port: 9000,
        }],
        executableType: "dart",
        pathToExecutable: 'editor_server/mocked/run_mocked_editor.dart',
        pathToWorkingDirectory: 'editor_server',
        disabledForRunner: true
    },
    editorDatabase: {
        host: 'boardytale.vserver.cz',
        password: 'boardygame',
        username: 'boardytale',
        port: 5432,
        databaseName: 'boardytale',
    },
    gameServer: {
        runMockedEditor: true,
        route: '/gameApi',
        uris: [{
            host: 'localhost',
            port: 7000,
        }],
        executableType: 'dart',
        pathToExecutable: 'game_server/bin/game_server_start.dart',
        pathToWorkingDirectory: 'game_server',
        // frequently run in debug mode, so disable to not wait for false loads
        disabledForRunner: true
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
                port: 8083,
                host: 'localhost',
            }
        ],
        executableType: 'ts-node',
        pathToExecutable: 'proxy_server/index.ts',
        pathToWorkingDirectory: 'proxy_server'
    },
};

