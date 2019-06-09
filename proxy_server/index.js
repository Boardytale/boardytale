"use strict";
exports.__esModule = true;
var express = require("express");
var path = require("path");
var proxy = require("http-proxy-middleware");
var fs = require("fs");
var http = require("http");
var network_1 = require("../libs/network");
var isMocked = false;
process.argv.forEach(function (val) {
    if (val === 'mocked') {
        isMocked = true;
    }
});
var config = JSON.parse(fs.readFileSync('../config.g.json').toString());
http.get("http://localhost:8083", function (data) {
    console.log(data);
});
// var app = express();
// app.use(function (req, res, next) {
//     req.url = req.url.replace('//', '/');
//     // req.url = req.url.replace('/csobimp-api/', '/fm-api/');
//     // req.url = req.url.replace('/demo/fm-api/', '/fm-api/');
//     // res.set({
//     //     'X-XSRF-TOKEN': '123456789'
//     // });
//     next();
// });
// runProxy(config.userServer);
// runProxy(config.editorServer);
// proxyStaticDev(config.editorStaticDev);
// proxyStaticDev(config.gameStaticDev);
// app.get('/', function (req, res) {
//     return res.sendFile(path.resolve(__dirname, '../www/index.html'));
// });
// app.use(express.static(path.resolve(__dirname, '../www'), {
//     index: path.resolve(__dirname, '../www/index.html')
// }));
// app.listen(config.proxyServer.uris[0].port, function () {
//     console.log('Proxy server is listening to http://localhost:' + config.proxyServer.uris[0].port);
// });
// function proxyStaticDev(settings) {
//     if (settings.port) {
//         var pathRewrite = {};
//         pathRewrite["^" + settings.route] = '/';
//         var apiProxy = proxy({
//             target: 'http://localhost:' + settings.port,
//             pathRewrite: pathRewrite,
//             changeOrigin: true
//         });
//         app.use(settings.route, apiProxy);
//         console.log("running proxy from " + settings.route + " to " + ('http://localhost:' + settings.port));
//     }
// }
// function runProxy(server) {
//     if (server.route) {
//         var pathRewrite = {};
//         pathRewrite["^" + server.route] = '/';
//         var apiProxy = proxy({
//             target: network_1.makeAddress(server.uris[0]),
//             pathRewrite: pathRewrite,
//             changeOrigin: true
//         });
//         app.use(server.route, apiProxy);
//         console.log("running proxy from " + server.route + " to " + network_1.makeAddress(server.uris[0]));
//     }
// }
