import * as express from 'express';
import * as path from 'path';
import * as proxy from 'http-proxy-middleware';
import * as fs from 'fs';
import * as http from "http";
import {makeAddress} from '../libs/network';
import {
    BoardytaleConfiguration,
    FrontEndDevelopment,
    ServerConfiguration
} from '../core/lib/configuration/configuration';

let isMocked = false;

process.argv.forEach((val) => {
    if (val === 'mocked') {
        isMocked = true;
    }
});

let config: BoardytaleConfiguration = JSON.parse(fs.readFileSync('../config.g.json').toString());

const app = express();
app.use((req, res, next) => {
    req.url = req.url.replace('//', '/');
    // req.url = req.url.replace('/csobimp-api/', '/fm-api/');
    // req.url = req.url.replace('/demo/fm-api/', '/fm-api/');
    // res.set({
    //     'X-XSRF-TOKEN': '123456789'
    // });
    next();
});

runProxy(config.userServer);
runProxy(config.editorServer);

proxyStaticDev(config.editorStaticDev);
proxyStaticDev(config.gameStaticDev);

app.get('/', (req, res) => {
    return res.sendFile(path.resolve(__dirname, '../www/index.html'));
});

app.use(express.static(path.resolve(__dirname, '../www'), {
    index: path.resolve(__dirname, '../www/index.html')
}));

app.listen(config.proxyServer.uris[0].port, () => {
    console.log('Proxy server is listening to http://localhost:' + config.proxyServer.uris[0].port);
});

function proxyStaticDev(settings: FrontEndDevelopment) {
    if (settings.port) {
        let pathRewrite = {};
        pathRewrite[`^${settings.route}`] = '/';
        let apiProxy = proxy({
            target: 'http://localhost:' + settings.port,
            pathRewrite,
            changeOrigin: true,
        });
        app.use(settings.route, apiProxy);
        console.log(`running proxy from ${settings.route} to ${'http://localhost:' + settings.port}`);
    }
}

function runProxy(server: ServerConfiguration) {
    if (server.route) {
        let pathRewrite = {};
        pathRewrite[`^${server.route}`] = '/';

        let apiProxy = proxy({
            target: makeAddress(server.uris[0]),
            pathRewrite,
            changeOrigin: true
        });
        app.use(server.route, apiProxy);
        console.log(`running proxy from ${server.route} to ${makeAddress(server.uris[0])}`);
    }
}
