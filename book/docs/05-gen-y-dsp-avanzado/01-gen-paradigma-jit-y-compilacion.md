---
title: "Lección 5.1: Gen~ y el Paradigma JIT: Compilación en Tiempo Real, Bucles Muestra a Muestra y LLVM"
description: "Gen~ y el paradigma JIT: compilación LLVM en tiempo real, el operador history (z^-1), ecuaciones en diferencias muestra a muestra y exportación de código C++ nativo desde Max."
---


> *"En MSP tradicional estás encadenando cajas negras que se comunican mediante vectores de 64 muestras: la retroalimentación de una sola muestra es físicamente imposible sin introducir un retraso de bloque entero. Con `gen~`, el lienzo visual se traduce directamente a código C++ de bajo nivel y se compila a instrucciones de máquina en nanosegundos mediante LLVM: la barrera entre el parcheo visual y la programación nativa ha desaparecido."*  
> — **Graham Wakefield & Gregory Taylor**, *Generating Sound & Organizing Time*

---

### Objetivos Pedagógicos y de Ingeniería
1. **Comprender la limitación fundamental del vector de señal en MSP**: Explicar por qué `[tapin~]/[tapout~]` o bucles de señal en MSP imponen una latencia mínima de $N$ muestras (Signal Vector Size, típicamente 64) y por qué los filtros no lineales y modelos físicos IIR colapsan fuera de `gen~`.
2. **Dominar el compilador JIT (Just-In-Time) y LLVM en Max**: Analizar cómo Max toma el árbol de operadores de `[gen~]` o el código en GenExpr, genera C++ optimizado, invoca el backend LLVM y enlaza el código de máquina ejecutable en memoria RAM en caliente.
3. **El Operador `history` y la Memoria de Muestra Única ($z^{-1}$)**: Deducir la implementación de ecuaciones en diferencias continuas $y[n] = f(x[n], y[n-1])$ con retardo exacto de una muestra ($\Delta t = \frac{1}{f_s} \approx 22.67\ \mu\text{s}$ a $44.1\text{ kHz}$).
4. **Inspeccionar el código C++ generado**: Exportar código fuente mediante el comando `exportcode` de `gen~` y examinar la función `perform()` nativa para entender la vectorización SIMD, el desenrollado de bucles (*loop unrolling*) y la ausencia de overhead de llamadas de función.

---

## 1. El Dilema del Bloque Vectorial vs. Cálculo Muestra a Muestra

En el motor tradicional de MSP (como vimos en las Lecciones 3.1 y 3.6), el procesamiento ocurre en bloques vectoriales de tamaño $V$ (típicamente $64$ muestras):

![FIG 5.0 · Procesamiento por Bloques Vectoriales en MSP vs. Cálculo Muestra a Muestra en gen~](/assets/diagrams/diagrama_bloque_vs_muestra_gen.svg)

Si intentás construir un filtro IIR analógico de saturación no lineal con diodos o un oscilador caótico de Lorenz en MSP normal, el retardo de 64 muestras en el lazo de feedback destruye la estabilidad matemática de la ecuación diferencial. **En `gen~`, el retardo de feedback es de 1 sola muestra ($z^{-1}$), permitiendo modelado físico y DSP analógico virtual (VA) con precisión matemática absoluta.**

---

## 2. La Cadena de Compilación JIT (Just-In-Time)

Cuando cerrás la ventana de un objeto `[gen~]`, no se interpreta nada:

![FIG 5.1 · Pipeline JIT / LLVM y Retardo de Historial (z^-1) en gen~](/assets/diagrams/diagrama_gen_jit_pipeline.svg)

---

## 3. El Operador `history` y la Memoria de Muestra Única ($z^{-1}$)

El operador más poderoso y diferenciador de `gen~` frente al MSP tradicional es **`[history]`**: una celda de memoria que almacena exactamente **una muestra del pasado** y la expone en el instante siguiente.

### La Ecuación en Diferencias Implementable

En el mundo analógico, un filtro de primer orden se describe con la ecuación diferencial:

$$\tau \frac{dy}{dt} + y(t) = x(t)$$

En el dominio digital discreto, discretizada por el método de Euler hacia atrás, se convierte en la **ecuación en diferencias**:

$$y[n] = \alpha \cdot x[n] + (1 - \alpha) \cdot y[n-1]$$

donde $y[n-1]$ es exactamente lo que almacena `[history]` — el valor de salida del tick anterior, con retardo de una sola muestra ($\Delta t = 1/f_s \approx 22.67\ \mu\text{s}$ a $44.1\text{ kHz}$).

### Por qué MSP no puede resolver esto correctamente

En MSP tradicional, `[tapin~]/[tapout~]` tiene una latencia mínima de **$N$ muestras** (el tamaño del Signal Vector, típicamente 64). Intentar construir el lazo $y[n] = f(x[n], y[n-1])$ en MSP introduce un retraso de 64 muestras en el feedback, destruyendo la estabilidad matemática del filtro IIR y cualquier modelo físico que requiera retroalimentación de muestra individual.

En `gen~`, la topología visual se compila a un bucle `while(n--)` donde el valor de `[history]` se actualiza al final de cada iteración — retroalimentación perfecta de 1 muestra con costo computacional cero.

### Diagrama de Implementación

```
[in 1] ──┐
          ├──[*]── coef_a ──────[+]──── y[n] ──[out 1]
[history]─┤                      │         │
          └──[*]── coef_b        │         └──[history]
                                 │
                (y[n] = a*x[n] + b*y[n-1])
```

Este patrón es la piedra angular de **todos los filtros, osciladores y modelos físicos** implementados en `gen~`.

### 3.1. Acumulación Temporal y Generación de Fase (Wakefield & Taylor)

En su tratado fundamental *Generating Sound & Organizing Time: Thinking with gen~* (Cycling '74, 2022), Graham Wakefield y Gregory Taylor establecen que el concepto de "tiempo" en DSP no debe concebirse como una sucesión de eventos disparados por un reloj o metrónomo externo, sino como un **acumulador continuo de fase normalizada**:

$\phi[n] = (\phi[n-1] + \Delta \phi) \pmod 1$

donde el incremento diferencial de fase por muestra $\Delta \phi$ viene dictado por la frecuencia deseada $f$ y la tasa de muestreo $f_s$:

$\Delta \phi = \frac{f}{f_s}$

```text
[in 1: freq] ──> [/ samplerate] ──> [+] ──> [wrap 0 1] ──┬──> [out 1: phasor]
                                     ▲                   │
                                     └─── [history] ─────┘
```

#### Por qué este fasor en `gen~` supera al `[phasor~]` de MSP:
1. **Modulación de Frecuencia Audio-Rate Pura**: En MSP tradicional, modular la frecuencia de un `[phasor~]` con otra señal a frecuencias de audio introduce sutiles discontinuidades y jitter en los bordes de cada bloque vectorial de 64 muestras. En `gen~`, la fase se integra y evalúa muestra por muestra de forma continua y suave.
2. **Sincronización Dura (Hard Sync) y Reseteo Instantáneo**: La fase puede forzarse a cero o a cualquier valor arbitrario en el ciclo exacto de una muestra mediante una condición lógica (`if` o operador `?`), permitiendo osciladores antialiasing tipo PolyBLEP y sincronización maestra/esclava sin dispersión de fase.
3. **Aritmética de Plegado y Deformación Temporal**: Aplicando funciones no lineales a la rampa de fase (como potencias, senos o funciones de conformación de onda *waveshaping*), el tiempo mismo se estira y contrae a nivel de nanosegundos antes de indexar tablas de ondas o secuencias de envolventes.

---

## 4. Bajo el Capó: Análisis del C++ Exportado (`gen_exported.cpp`)


Cuando usamos la función `exportcode` de `gen~`, Max genera código C++ puro compatible con cualquier entorno embebido (VST, AU, Daisy Seed, Bela o Teensy). Observemos la estructura del bucle de procesamiento:

```cpp
// Fragmento real de código C++ generado por gen~
void perform(CommonState *state, double **ins, long numins, 
             double **outs, long numouts, long n) {
    double *in1 = ins[0];
    double *out1 = outs[0];
    double history_1 = state->history_1;
    double param_cutoff = state->param_cutoff;
    
    // Bucle cerrado ultra-optimizado por el compilador LLVM
    while (n--) {
        double x = *in1++;
        // Filtro paso-bajo de 1 polo: y[n] = x[n]*b + y[n-1]*a
        double y = x * param_cutoff + history_1 * (1.0 - param_cutoff);
        history_1 = y; // Actualización z^-1 sin costo
        *out1++ = y;
    }
    
    state->history_1 = history_1;
}
```

### Por qué esto pulveriza en rendimiento al MSP tradicional:
1. **Localidad Espacial en Registro de CPU**: La variable `history_1` vive directamente en un registro de CPU (`xmm0` / `d0`), no en memoria RAM principal.
2. **Auto-Vectorización SIMD**: LLVM desenrolla el bucle automáticamente (`loop unrolling`) y ejecuta hasta 4 u 8 operaciones por ciclo de reloj utilizando extensiones vectoriales de hardware.
3. **Cero Ramificación Condicional**: No hay sentencias `switch` evaluando qué objeto procesar a continuación.

---

## 5. Escenarios Reales de Producción

1. **Filtro Ladder Moog No Lineal con Saturación por Diodos**: Modelar las 4 etapas de un filtro analógico transistorizado con saturación `tanh()` en cada polo dentro de un lazo de realimentación unitario de 1 muestra.
2. **Osciladores Caóticos (Lorenz / Chua / Rössler)**: Resolver ecuaciones diferenciales no lineales numéricas de 3 variables en tiempo real con paso de integración Runge-Kutta a la tasa de muestreo del audio ($44.1\text{ kHz}$ o $96\text{ kHz}$).
3. **Delays Fraccionarios con Interpolación Todo-Paso (Thiran Allpass)**: Ajustar la afinación de un modelo de cuerda con retardos exactos fraccionarios de $0.001$ muestras sin artefactos de fase.
4. **Portabilidad a Hardware Autónomo (Eurorack / Daisy Seed)**: Desarrollar el algoritmo completo en Max visual con `gen~` y exportarlo a C++ con un clic para grabarlo en la memoria flash de un módulo Eurorack de hardware.

---

## 6. Desafíos de Ingeniería

### Desafío 1: El Integrador con Fuga (Leaky Integrator)
Diseñá dentro de `gen~` un filtro paso-bajo de 1 polo utilizando únicamente un operador `[+]`, un `[*]`, un `[param coef 0.1]` y un `[history]`. Demostrá la respuesta en frecuencia alimentándolo con `noise~`.

### Desafío 2: Resonador Senoidal de 2 Polos sin `cycle~`
Construí un oscilador senoidal puro autónomo que no lea tablas de onda en memoria, sino que resuelva la ecuación en diferencias de un oscilador armónico simple utilizando 2 operadores `[history]`:

$$y[n] = 2\cos(\omega) y[n-1] - y[n-2]$$

### Desafío 3: El Detector de Transitorios de Muestra Única
Implementá en `gen~` un detector de picos que compare el valor instantáneo $|x[n]|$ con el valor anterior $|x[n-1]|$ y emita un impulso $1.0$ si la derivada discreta $\Delta x = x[n] - x[n-1]$ supera un umbral de ataque en un lapso de exactamente 1 muestra.

---

## 7. Laboratorio Práctico: `laboratorio_18_gen_basics.maxpat`

Abrí el parche de laboratorio para explorar:
- Objeto `[gen~]` interactivo con circuito de retardo de 1 muestra (`history`) y saturador no lineal polinómico.
- Parámetros dinámicos `param` modulados en tiempo real desde la interfaz de Max.
- Visualización de la forma de onda generada en osciloscopio y analizador de espectro de 64 bits.
