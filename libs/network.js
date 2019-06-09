"use strict";
exports.__esModule = true;
function makeAddress(uri, secured) {
    if (secured === void 0) { secured = false; }
    return (secured ? 'https' : 'http') + '://' + uri.host + ':' + uri.port + '/';
}
exports.makeAddress = makeAddress;
