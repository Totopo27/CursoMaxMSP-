---
title: "Lección 5.1: Gen~ y el Paradigma JIT: Compilación en Tiempo Real, Bucles Muestra a Muestra y LLVM"
description: "Capítulo del curso universitario de Max/MSP"
---

# Lección 5.1: Gen~ y el Paradigma JIT: Compilación en Tiempo Real, Bucles Muestra a Muestra y LLVM

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

```
MSP Tradicional (Por Bloques):
Entrada: [ x0, x1, x2, ... x63 ] ---> perform64() ---> Salida: [ y0, y1, y2, ... y63 ]
¡Cualquier realimentación debe esperar al siguiente bloque de 64 muestras!

Gen~ (Muestra a Muestra Nativo JIT):
Bucle C++ compilado:
for (int n = 0; n < vectorsize; n++) {
    y[n] = x[n] + a * y_prev;  // y_prev es y[n-1] EXACTO
    y_prev = y[n];             // Retroalimentación de 1 muestra (history)
}
```

Si intentás construir un filtro IIR analógico de saturación no lineal con diodos o un oscilador caótico de Lorenz en MSP normal, el retardo de 64 muestras en el lazo de feedback destruye la estabilidad matemática de la ecuación diferencial. **En `gen~`, el retardo de feedback es de 1 sola muestra ($z^{-1}$), permitiendo modelado físico y DSP analógico virtual (VA) con precisión matemática absoluta.**

---

## 2. La Cadena de Compilación JIT (Just-In-Time)

Cuando cerrás la ventana de un objeto `[gen~]`, no se interpreta nada:

```
[ Patcher gen~ / Código GenExpr ]
               |
               v
 [ Generador de AST (Abstract Syntax Tree) ]
               |
               v
 [ Emisión de Código Intermedio C++ ]
               |
               v
   [ Compilador JIT / LLVM Engine ]
               |
               v
[ Código de Máquina Binario x86-64 / ARM64 ]
               |
               v
   [ Enlace Directo a RAM de Audio ]
```

- **Cero Overhead de Mensajería**: Dentro de `gen~` no existen los objetos Obex de Max ni el scheduler de eventos. Todas las operaciones matemáticas (`+`, `*`, `sin`, `tanh`) se compilan como instrucciones de ensamblador directas en la CPU (`fadd`, `fmul`, registros SSE/AVX o NEON).
- **Parámetros Flotantes en el Hilo de Audio**: Los objetos `[param]` se actualizan en memoria atómica en cada muestra sin provocar *zipper noise*.

---

## 3. El Operador Fundamental: `history` ($z^{-1}$)

En `gen~`, el operador `[history]` define una celda de memoria que almacena el valor de la muestra anterior:

$$y[n] = x[n] + g \cdot y[n-1]$$

En el lienzo de `gen~`:
- La salida de un operador se conecta a la entrada de `[history mi_memoria]`.
- La salida de `[history]` se realimenta a la suma de entrada.
- Al compilarse, `[history]` se convierte simplemente en una variable flotante local en C++: `double mi_memoria;`.

```
          in 1 (x[n])
            |
            v
          [ + ] <-------------+
            |                 |
            +---> out 1       |
            |                 |
         [ * 0.95 ]           |
            |                 |
       [ history ] -----------+  (Retardo exacto z^-1)
```

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
