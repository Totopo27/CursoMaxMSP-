// servidor_analisis.js
// Servidor de análisis y comunicación IPC asíncrona para Node for Max (N4M)
// Versión blindada: control de tamaño de payload, bind loopback, validación de tipos y manejo de errores
const maxAPI = require("max-api");
const http = require("http");

let server = null;
let currentPort = 8080;
const MAX_BODY_BYTES = 64 * 1024; // 64 KiB máximo para prevenir DoS por memoria

maxAPI.addHandler("iniciar", (requestedPort) => {
    if (server) {
        maxAPI.post("El servidor ya está en ejecución.\n");
        return;
    }

    const port = Number(requestedPort) || 8080;
    if (!Number.isInteger(port) || port < 1024 || port > 65535) {
        maxAPI.post(`Puerto inválido: ${requestedPort}. Debe ser un entero entre 1024 y 65535.\n`);
        maxAPI.outlet("error", "puerto_invalido", requestedPort);
        return;
    }
    currentPort = port;

    server = http.createServer((req, res) => {
        // Validación de ruta y método
        if (req.method === "POST" && req.url === "/sensor") {
            const contentType = req.headers["content-type"] || "";
            if (!contentType.includes("application/json")) {
                res.writeHead(415, { "Content-Type": "application/json" });
                res.end(JSON.stringify({ error: "Unsupported Media Type. Se requiere application/json" }));
                return;
            }

            let body = "";
            let receivedBytes = 0;

            req.on("data", chunk => {
                receivedBytes += chunk.length;
                if (receivedBytes > MAX_BODY_BYTES) {
                    // Prevenir ataque DoS cortando inmediatamente la recepción
                    res.writeHead(413, { "Content-Type": "application/json" });
                    res.end(JSON.stringify({ error: "Payload Too Large (Máximo 64 KiB)" }));
                    req.destroy();
                } else {
                    body += chunk;
                }
            });

            req.on("end", () => {
                if (receivedBytes > MAX_BODY_BYTES) return;
                try {
                    const data = JSON.parse(body);
                    // Validar estrictamente que x, y, z sean números finitos
                    const x = (typeof data.x === "number" && Number.isFinite(data.x)) ? data.x : 0;
                    const y = (typeof data.y === "number" && Number.isFinite(data.y)) ? data.y : 0;
                    const z = (typeof data.z === "number" && Number.isFinite(data.z)) ? data.z : 0;

                    // Despacho a Max sin bloquear el hilo
                    maxAPI.outlet("sensor_data", x, y, z);
                    res.writeHead(200, { "Content-Type": "application/json" });
                    res.end(JSON.stringify({ status: "ok" }));
                } catch (e) {
                    res.writeHead(400, { "Content-Type": "application/json" });
                    res.end(JSON.stringify({ error: "Invalid JSON format" }));
                }
            });
        } else if (req.method === "GET" && req.url === "/health") {
            res.writeHead(200, { "Content-Type": "application/json" });
            res.end(JSON.stringify({ status: "healthy", uptime: process.uptime() }));
        } else {
            res.writeHead(404, { "Content-Type": "text/plain" });
            res.end("Ruta no encontrada. Endpoints activos: POST /sensor, GET /health");
        }
    });

    // Manejo robusto de errores del socket/puerto (e.g. EADDRINUSE)
    server.on("error", (err) => {
        maxAPI.post(`Error del servidor HTTP N4M: ${err.message}\n`);
        maxAPI.outlet("error", "server_error", err.message);
        server = null;
    });

    // Escuchar ESTRICTAMENTE en loopback (127.0.0.1) para evitar exposición a LAN no autenticada
    server.listen(currentPort, "127.0.0.1", () => {
        maxAPI.post(`Servidor HTTP N4M escuchando de forma segura en http://127.0.0.1:${currentPort}\n`);
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
    } else {
        maxAPI.post("No hay ningún servidor en ejecución.\n");
    }
});

maxAPI.addHandler("ping", () => {
    maxAPI.outlet("pong", Date.now());
});
