const express = require('express');
var bodyParser = require('body-parser');
// NEVER let this service be running on production server due to security - possibly executes untrusted code.

const app = express();
let port = parseInt(process.argv[2]);

app.use(bodyParser.text()); // for parsing application/json
app.listen(port, () => console.log(`:::running:::Typescript service listening on port ${port}!`))

app.post('/', (req, res) => {
    let input = req.body;
    try {
        import(input).then((file: any) => {
            let out;
            if (!file.data) {
                out = "invalid";
            } else {
                out = JSON.stringify(file.data);
            }
            res.send(out); //write a response to the client
        });
    } catch (e) {
        res.send("invalid")
    }
});
