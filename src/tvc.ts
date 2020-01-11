let ws = new WebSocket("ws://192.168.74.143:8888");
ws.binaryType = "arraybuffer";
ws.onmessage = event => {};
ws.onopen = event => {
    ws.send("boot");
};
