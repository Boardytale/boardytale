var fs = require("fs");
console.log(fs.readFileSync(
    __dirname + '\\armor.png',
    'base64'
));
