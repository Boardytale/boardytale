import * as fs from 'fs';
import {BoardytaleConfiguration} from './core/lib/configuration/configuration';

let configPath = null;
let targetPath = 'config.g.json';
process.argv.forEach(function (val, index, array) {
    if (val.indexOf('--config=') === 0) {
        configPath = val.replace('--config=', '');
    }
    if (val.indexOf('--target=') === 0) {
        targetPath = val.replace('--target=', '');
    }
});
import('./' + configPath).then((configFile: { config: BoardytaleConfiguration }) => {
    fs.writeFileSync(targetPath, JSON.stringify(configFile.config));
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

    fs.writeFileSync('game_client/lib/project_settings.dart', `
library project_settings;

class ProjectSettings {
  static String gameApiRoute = "${config.gameServer.route}";
  static String gameApiPort = "${config.gameServer.uris[0].port}";
}  
    `);

    fs.writeFileSync('logger_server/lib/project_settings.dart', `
library project_settings;

class ProjectSettings {
  static String loggerServerPort = "${config.loggerServer.uris[0].port}";
}  
    `);

});
