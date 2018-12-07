import * as childProcess from 'child_process';

childProcess.execFile('ts-node', [
    'proxy_server/index.ts'
], function(err, stdout, stderr) {
    // Node.js will invoke this callback when the
    console.log(stdout);
});

childProcess.execFile('proxy_server/index.ts', [
], function(err, stdout, stderr) {
    // Node.js will invoke this callback when the
    console.log(stdout);
});