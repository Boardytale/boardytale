import * as express from 'express';
import * as path from 'path';
import * as bodyParser from 'body-parser';
import * as proxy from 'http-proxy-middleware';
import { config } from '../dev-config';

let isMocked = false;

process.argv.forEach((val) => {
    if (val === 'mocked') {
        isMocked = true;
    }
});

const app = express();
app.use(bodyParser.json());

app.use((req, res, next) => {
    req.url = req.url.replace('//', '/');
    // req.url = req.url.replace('/csobimp-api/', '/fm-api/');
    // req.url = req.url.replace('/demo/fm-api/', '/fm-api/');
    // res.set({
    //     'X-XSRF-TOKEN': '123456789'
    // });
    next();
});
if (config.gameServer.uri) {
    let apiProxy = proxy(config.gameServer.route, {target: config.gameServer.uri});
    app.use(apiProxy);
    console.log(`running proxy from ${config.gameServer.route} to ${config.gameServer.uri}`);
}
if (config.gameStaticDev.active) {
    let apiProxy = proxy(config.gameStaticDev.route, {target: config.gameStaticDev.proxyPass});
    app.use(apiProxy);
    console.log(`running proxy from ${config.gameStaticDev.route} to ${config.gameStaticDev.proxyPass}`);
}

app.use(express.static(path.resolve(__dirname, '../www')));

app.listen(80, () => {
    console.log('Proxy server is listening to http://localhost:80');
});
