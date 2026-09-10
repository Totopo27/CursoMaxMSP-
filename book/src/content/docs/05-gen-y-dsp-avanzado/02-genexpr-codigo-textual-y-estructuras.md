---
title: "Lección 5.2: Programación Textual en GenExpr: Funciones, Bucles For/While, Condicionales y Kernels DSP"
description: "Capítulo del curso universitario de Max/MSP"
---

# Lección 5.2: Programación Textual en GenExpr: Funciones, Bucles For/While, Condicionales y Kernels DSP

> *"El parcheo visual es insuperable para la macro-arquitectura de un sintetizador, pero para implementar un algoritmo iterativo, una convolución polinómica o un solver numérico Runge-Kutta, colocar 50 cajas y 80 cables es contraproducente e ilegible. GenExpr ofrece la concisión del texto compilado a máquina con la modularidad del flujo de datos."*  
> — **Gregory Taylor**, *Step by Step: Adventures in Sequencing with Max*

---

### Objetivos Pedagógicos y de Ingeniería
1. **Dominar la sintaxis canónica de GenExpr**: Aprender a programar dentro del operador `[codebox]` utilizando tipado estricto, variables locales, declaración de funciones y constantes matemáticas (`PI`, `TWOPI`, `SAMPLERATE`).
2. **Implementar estructuras de control iterativas de baja latencia**: Utilizar bucles `for`, `while` y condicionales `if/else` calculados **en cada muestra individual** sin interrupciones del hilo de audio.
3. **Desarrollar kernels DSP avanzados en texto**:
   - Oscilador de tabla de ondas con interpolación cúbica programada en GenExpr.
   - Algoritmo de distorsión polinómica Chebyshev para generación armónica selectiva.
   - Envolvente ADSR calculada por máquina de estados finitos (*FSM*) textual.
4. **Analizar la optimización del compilador de GenExpr**: Explicar cómo el parser simplifica operaciones algebraicas redundantes (*constant folding*) y vectoriza bucles internos.

---

## 1. La Transición del Cable al Texto: El Objeto `[codebox]`

Dentro de un subparche `[gen~]`, podés crear el objeto `[codebox]`. Todo el texto dentro de `codebox` se escribe en **GenExpr** (un dialecto de sintaxis basada en C/JavaScript optimizado estrictamente para DSP de coma flotante).

```
[ Entradas in1, in2 ] ---> +-------------------------------+
                           | codebox (GenExpr)             |
                           | Param drive(1.0);             |
                           | History y(0);                 |
                           | x = in1 * drive;              |
                           | y = tanh(x);                  |
                           | out1 = y;                     |
                           +-------------------------------+ ---> [ Salida out1 ]
```

### Reglas Sintácticas Fundamentales
- Cada instrucción termina con punto y coma (`;`).
- Las entradas y salidas estándar del bloque se denominan `in1`, `in2`, ... y `out1`, `out2`, ...
- El operador `History nombre(inicial)` define una celda de retardo de 1 muestra ($z^{-1}$).
- El operador `Param nombre(inicial, min, max)` expone un control en tiempo real hacia el exterior de `gen~`.

---

## 2. Declaración de Funciones y Modularidad en GenExpr

GenExpr permite definir funciones puras reutilizables en la cabecera del `codebox`:

```javascript
// Definición de saturador analógico no lineal por tangente hiperbólica suave
soft_clip(x, threshold) {
    if (abs(x) < threshold) {
        return x;
    } else {
        return sign(x) * (threshold + (1 - threshold) * tanh((abs(x) - threshold) / (1 - threshold)));
    }
}

// Bucle principal muestra a muestra
Param drive(2.0);
Param thresh(0.7);

input_signal = in1 * drive;
out1 = soft_clip(input_signal, thresh);
```

---

## 3. Máquinas de Estado Finito (FSM) y Envolventes en GenExpr

Construir un generador de envolvente ADSR en parches visuales requiere decenas de conexiones lógicas. En GenExpr se resuelve con una **máquina de estados limpia y legible**:

```javascript
// Máquina de estados ADSR en GenExpr
Param attack_ms(10), decay_ms(100), sustain_lvl(0.5), release_ms(300);
History state(0); // 0: Idle, 1: Attack, 2: Decay, 3: Sustain, 4: Release
History env(0);

gate = in1; // Compuerta 1.0 (Note On) / 0.0 (Note Off)

// Detección de flanco ascendente (Note-On)
if (gate > 0 && state == 0) {
    state = 1; // Ir a Attack
} else if (gate == 0 && state != 0) {
    state = 4; // Ir a Release
}

// Procesamiento por estado
if (state == 1) { // ATTACK
    att_inc = 1.0 / (attack_ms * 0.001 * SAMPLERATE);
    env = env + att_inc;
    if (env >= 1.0) {
        env = 1.0;
        state = 2; // Pasar a Decay
    }
} else if (state == 2) { // DECAY
    dec_inc = (1.0 - sustain_lvl) / (decay_ms * 0.001 * SAMPLERATE);
    env = env - dec_inc;
    if (env <= sustain_lvl) {
        env = sustain_lvl;
        state = 3; // Mantener Sustain
    }
} else if (state == 3) { // SUSTAIN
    env = sustain_lvl;
} else if (state == 4) { // RELEASE
    rel_inc = sustain_lvl / (release_ms * 0.001 * SAMPLERATE);
    env = env - rel_inc;
    if (env <= 0.0) {
        env = 0.0;
        state = 0; // Volver a Idle
    }
}

out1 = env;
```

---

## 4. Escenarios Reales de Producción

1. **Generador Armónico Chebyshev**: Usar polinomios ortogonales de Chebyshev ($T_0(x)=1, T_1(x)=x, T_2(x)=2x^2-1, T_3(x)=4x^3-3x$) en un bucle `for` para inyectar armónicos pares o impares exactos a una señal pura.
2. **Modelado de Membrana Circular 2D**: Resolver la ecuación de onda en 2 dimensiones en una matriz discreta utilizando bucles espaciales anidados dentro de GenExpr.
3. **Interpolador Sinc con Ventana de Kaiser**: Implementar filtros de reconstrucción de banda limitada de 32 o 64 taps muestra a muestra para remuestreo de altísima fidelidad.
4. **Secuenciador Estocástico Euclidiano**: Calcular patrones rítmicos euclidianos ($E(k, n)$) directamente en el hilo de audio mediante divisiones enteras en GenExpr para disparo sin jitter.

---

## 5. Desafíos de Ingeniería

### Desafío 1: El Algoritmo Chebyshev de 5º Orden
Escribí en GenExpr una función que reciba una señal senoidal pura y calcule los primeros 5 polinomios de Chebyshev para generar el 2º, 3º, 4º y 5º armónico con controles de mezcla independientes (`Param h2`, `Param h3`, etc.).

### Desafío 2: Filtro de Variable de Estado (Chamberlin) en GenExpr
Implementá la topología del State Variable Filter (SVF) en 8 líneas de código textual dentro de `codebox`, emitiendo simultáneamente las salidas `lowpass`, `highpass` y `bandpass` por `out1`, `out2` y `out3`.

### Desafío 3: El Limitador Lookahead en Buffer GenExpr
Utilizá el operador `Data` de GenExpr para almacenar un retardo de 64 muestras y programá un limitador que calcule el valor pico futuro y aplique una rampa de atenuación suave antes de que el transitorio alcance la salida.

---

## 6. Laboratorio Práctico: `laboratorio_19_genexpr.maxpat`

Abrí el parche de laboratorio para experimentar con:
- Código textual interactivo dentro de `codebox` implementando síntesis no lineal y máquina de estados ADSR muestra a muestra.
- Manipulación en caliente de parámetros (`drive`, `cutoff`, `resonance`) sin interrupción del motor de audio.
- Visualización de la señal en tiempo real mediante osciloscopio y analizador de espectro de alta resolución.
