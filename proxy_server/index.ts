import * as express from 'express';
import * as path from 'path';
import * as bodyParser from 'body-parser';
import * as proxy from 'http-proxy-middleware';
import { config } from '../dev-config';
import {makeAddress} from '../libs/network';

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
if (config.gameServer.route) {
    let apiProxy = proxy(config.gameServer.route, {target: makeAddress(config.gameServer.uris[0])});
    app.use(apiProxy);
    console.log(`running proxy from ${config.gameServer.route} to ${makeAddress(config.gameServer.uris[0])}`);
}
if (config.gameStaticDev.active) {
    let apiProxy = proxy(makeAddress(config.gameStaticDev), {target: config.gameStaticDev.target});
    app.use(apiProxy);
    console.log(`running proxy from ${makeAddress(config.gameStaticDev)} to ${config.gameStaticDev.target}`);
}

app.use(express.static(path.resolve(__dirname, '../www')));

app.listen(80, () => {
    console.log('Proxy server is listening to http://localhost:80');
});
