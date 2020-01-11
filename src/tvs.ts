import * as fs from "fs";
import * as http from "http";
import * as url from "url";
import * as ws from "ws";
import * as path from "path";
import * as son from "./son";

let Module = require("./bridge_tvs.js");

const wss = new ws.Server({ noServer: true });
wss.on("connection", ws => {
    ws.on("message", msg => {
        console.log("recv:", msg);
        switch (msg) {
            case "boot": {
                console.log(Module);
                break;
            }
        }
    });
});

const server = http.createServer((req, resp) => {
    let pathname = url.parse(req.url!).pathname!;
    fs.readFile(path.join(__dirname, pathname), (err, data) => {
        if (null === err) {
            resp.write(data);
        } else {
            resp.statusCode = 404;
        }
        resp.end();
    });
});
server.on("upgrade", (request, socket, head) => {
    wss.handleUpgrade(request, socket, head, ws => {
        wss.emit("connection", ws, request);
    });
});
server.listen(8888);
console.log("web server inited!!");
