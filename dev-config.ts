import {BoardytaleConfiguration} from './config';

export let config: BoardytaleConfiguration = {
    aiService: ['http://localhost:5000'],
    database: {
        host: 'localhost',
        password: 'devdb',
        username: 'devdb',
        port: 5432
    },
    editorServers: [
        'http://localhost:9000'
    ],
    gameServers: [
        'http://localhost:7000'
    ],
    heroService: 'http://localhost:6001',
    userService: 'http://localhost:6000'
};
