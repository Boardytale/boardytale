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

    // TODO: yaml to editor_server

    // TODO: yaml to hero_server
});
