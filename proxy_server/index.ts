import * as express from 'express';
import * as path from 'path';
import * as proxy from 'http-proxy-middleware';
import {config} from '../dev-config';
import {makeAddress} from '../libs/network';

let isMocked = false;

process.argv.forEach((val) => {
    if (val === 'mocked') {
        isMocked = true;
    }
});

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
if (config.userServer.route) {
    let pathRewrite = {};
    pathRewrite[`^${config.userServer.route}`] = '/';

    let apiProxy = proxy({
        target: makeAddress(config.userServer.uris[0]),
        pathRewrite,
        changeOrigin: true,
    });
    app.use(config.userServer.route, apiProxy);
    console.log(`running proxy from ${config.userServer.route} to ${makeAddress(config.userServer.uris[0])}`);
}
if (config.editorStaticDev.port) {
    let pathRewrite = {};
    pathRewrite[`^${config.editorStaticDev.route}`] = '/';
    let apiProxy = proxy({
        target: 'http://localhost:' + config.editorStaticDev.port,
        pathRewrite,

        changeOrigin: true,
    });
    app.use(config.editorStaticDev.route, apiProxy);
    console.log(`running proxy from ${config.editorStaticDev.route} to ${'http://localhost:' + config.editorStaticDev.port}`);
}
// if (config.gameServer.route) {
//     let apiProxy = proxy(config.gameServer.route, {target: makeAddress(config.gameServer.uris[0])});
//     app.use(apiProxy);
//     console.log(`running proxy from ${config.gameServer.route} to ${makeAddress(config.gameServer.uris[0])}`);
// }
// if (config.gameStaticDev.active) {
//     let apiProxy = proxy(makeAddress(config.gameStaticDev), {target: config.gameStaticDev.target});
//     app.use(apiProxy);
//     console.log(`running proxy from ${makeAddress(config.gameStaticDev)} to ${config.gameStaticDev.target}`);
// }

app.get('/', (req, res) => {
    return res.sendFile(path.resolve(__dirname, '../www/index.html'));
});

app.use(express.static(path.resolve(__dirname, '../www'), {
    index: path.resolve(__dirname, '../www/index.html')
}));


app.listen(config.proxyServer.uris[0].port, () => {
    console.log('Proxy server is listening to http://localhost:' + config.proxyServer.uris[0].port);
});

// app.listen(3251, () => {
//     console.log('Proxy server is listening to http://localhost:' + config.proxyServer.uris[0].port);
// });
