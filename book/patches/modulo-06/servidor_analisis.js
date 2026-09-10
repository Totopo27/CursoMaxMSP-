// servidor_analisis.js
// Servidor de análisis y comunicación IPC asíncrona para Node for Max (N4M)
const maxAPI = require("max-api");
const http = require("http");

let server = null;
let currentPort = 8080;

maxAPI.addHandler("iniciar", (port) => {
    if (server) {
        maxAPI.post("El servidor ya está en ejecución.\n");
        return;
    }
    currentPort = port || 8080;
    server = http.createServer((req, res) => {
        if (req.method === "POST" && req.url === "/sensor") {
            let body = "";
            req.on("data", chunk => { body += chunk; });
            req.on("end", () => {
                try {
                    const data = JSON.parse(body);
                    // Enviamos los datos del sensor directo a Max sin bloquear el hilo
                    maxAPI.outlet("sensor_data", data.x || 0, data.y || 0, data.z || 0);
                    res.writeHead(200, { "Content-Type": "application/json" });
                    res.end(JSON.stringify({ status: "ok" }));
                } catch (e) {
                    res.writeHead(400);
                    res.end("Invalid JSON");
                }
            });
        } else {
            res.writeHead(200, { "Content-Type": "text/plain" });
            res.end("Servidor Node for Max Activo");
        }
    });

    server.listen(currentPort, () => {
        maxAPI.post(`Servidor HTTP N4M escuchando en puerto ${currentPort}\n`);
        maxAPI.outlet("status", "conectado", currentPort);
    });
});

maxAPI.addHandler("detener", () => {
    if (server) {
        server.close(() => {
            maxAPI.post("Servidor detenido exitosamente.\n");
            maxAPI.outlet("status", "detenido");
            server = null;
        });
    }
});

maxAPI.addHandler("ping", () => {
    maxAPI.outlet("pong", Date.now());
});
