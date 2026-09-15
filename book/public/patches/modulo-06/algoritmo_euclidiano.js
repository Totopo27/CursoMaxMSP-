// algoritmo_euclidiano.js
// Implementación del Algoritmo de Bjorklund para Ritmos Euclidianos en Max/MSP [js]
// Versión blindada: control estricto de pasos, pulsos y rotación (prevención de RangeError y bucles infinitos)
// Autor: Curso Max/MSP - Módulo 6

inlets = 2;
outlets = 2;

setinletassist(0, "(bang/list) Bang genera/dispara, Lista [pulsos, pasos, rotacion]");
setinletassist(1, "(int) Ajuste de rotación / offset");
setoutletassist(0, "(list) Patrón binario resultante (0 y 1)");
setoutletassist(1, "(int) Paso actual al avanzar");

var steps = 16;
var pulses = 4;
var rotate = 0;
var current_step = 0;
var pattern = [];

// Algoritmo de Bjorklund (E(k, n)) con validación estricta de límites
function generate_euclidean(k, n) {
    // Normalización de enteros seguros dentro del rango [1, 4096]
    n = Math.max(1, Math.min(4096, Math.floor(Number(n) || 1)));
    k = Math.max(0, Math.min(n, Math.floor(Number(k) || 0)));

    if (k <= 0) return new Array(n).fill(0);
    if (k >= n) return new Array(n).fill(1);

    var sequences = [];
    for (var i = 0; i < n; i++) {
        sequences.push([i < k ? 1 : 0]);
    }

    var divisor = n - k;
    var remainder = k;

    while (remainder > 0 && divisor > 0) {
        var count = Math.min(remainder, divisor);
        for (var j = 0; j < count; j++) {
            sequences[j] = sequences[j].concat(sequences[sequences.length - 1 - j]);
        }
        sequences.splice(sequences.length - count, count);
        if (remainder <= divisor) {
            divisor = divisor - remainder;
        } else {
            var temp = remainder;
            remainder = divisor;
            divisor = temp - divisor;
        }
    }

    // Aplanar el arreglo resultante
    var flat = [];
    for (var s = 0; s < sequences.length; s++) {
        flat = flat.concat(sequences[s]);
    }
    return flat;
}

function update_pattern() {
    // Asegurar parámetros saneados
    steps = Math.max(1, Math.min(4096, Math.floor(Number(steps) || 1)));
    pulses = Math.max(0, Math.min(steps, Math.floor(Number(pulses) || 0)));
    rotate = Math.trunc(Number(rotate) || 0);

    var raw = generate_euclidean(pulses, steps);
    // Aplicar rotación circular segura (shift)
    pattern = [];
    var offset = ((rotate % steps) + steps) % steps;
    for (var i = 0; i < steps; i++) {
        pattern.push(raw[(i + offset) % steps]);
    }
    outlet(0, pattern);
}

// Handler de disparo por pasos sucesivos
function bang() {
    if (inlet === 0) {
        if (pattern.length === 0) update_pattern();
        var val = pattern[((current_step % pattern.length) + pattern.length) % pattern.length];
        outlet(1, val);
        current_step = (current_step + 1) % pattern.length;
    }
}

// Configuración por lista: [pulses, steps, rotate]
function list() {
    if (arguments.length >= 2) {
        pulses = arguments[0];
        steps = arguments[1];
        if (arguments.length >= 3) {
            rotate = arguments[2];
        }
        current_step = 0;
        update_pattern();
    }
}

function msg_int(v) {
    if (inlet === 1) {
        rotate = Math.trunc(Number(v) || 0);
        update_pattern();
    } else {
        // Si entra un entero en inlet 0, lo interpretamos como paso a evaluar
        if (pattern.length > 0) {
            var idx = Math.trunc(Number(v) || 0);
            var safeIdx = ((idx % pattern.length) + pattern.length) % pattern.length;
            outlet(1, pattern[safeIdx]);
        }
    }
}

function reset() {
    current_step = 0;
}
