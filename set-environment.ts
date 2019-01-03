import * as fs from 'fs';
import {BoardytaleConfiguration} from './shared/lib/configuration/configuration';

let configPath = null;
process.argv.forEach(function (val, index, array) {
    if (val.indexOf('--config=') === 0) {
        configPath = val.replace('--config=', '');
    }
});
import('./' + configPath).then((configFile: { config: BoardytaleConfiguration }) => {
    fs.writeFileSync('config.json', JSON.stringify(configFile.config));
    const config = configFile.config;

    fs.writeFileSync('user_server/database.yaml', `  
username: "${config.userDatabase.username}"
password: "${config.userDatabase.password}"
host: "${config.userDatabase.host}"
port: ${config.userDatabase.port}
databaseName: "${config.userDatabase.databaseName}" 
    `);

    fs.writeFileSync('editor_server/database.yaml', `  
username: "${config.editorDatabase.username}"
password: "${config.editorDatabase.password}"
host: "${config.editorDatabase.host}"
port: ${config.editorDatabase.port}
databaseName: "${config.editorDatabase.databaseName}" 
    `);

    // TODO: yaml to hero_server
});
