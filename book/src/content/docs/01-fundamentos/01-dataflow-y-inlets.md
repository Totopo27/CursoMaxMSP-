---
title: "Módulo 1.1: El Paradigma Dataflow, Semántica de Estado vs. Disparo y Orden de Ejecución"
description: "Capítulo del curso universitario de Max/MSP"
---

# Módulo 1.1: El Paradigma Dataflow, Semántica de Estado vs. Disparo y Orden de Ejecución

> *"En Max, el orden de las cosas no está en las líneas de texto, sino en la teoría de grafos, en la organología acústica y en la pila de llamadas del procesador."*

---

## 🏛️ 1. Fundamento Epistemológico: Ruptura con el Modelo Von Neumann

Para entender Max en profundidad, primero debemos desaprender cómo programan los lenguajes tradicionales.

La computación moderna convencional se rige por la **Arquitectura Von Neumann** (1945):
* Una Unidad Central de Procesamiento (CPU) posee un **Contador de Programa (Program Counter)**.
* El contador avanza secuencialmente instrucción por instrucción (paso 1, paso 2, paso 3).
* El programador controla activamente el flujo temporal mediante bucles (`for`, `while`) y sentencias condicionales (`if/else`).

```
[ Modelo Von Neumann (Python / C++ / Rust) ]
   Instrucción 1 ──► Instrucción 2 ──► Instrucción 3 (Secuencia Forzada)
```

### El Paradigma Dataflow (Dennis, MIT 1974)
Max no es imperativo ni lineal; implementa el modelo de **Computación por Flujo de Datos (Dataflow)**:
* **No existe un Contador de Programa que recorra el parche.**
* El programa es una red de procesadores autónomos (nodos/objetos) interconectados por canales de transmisión (cables).
* Un nodo permanece en **estado de reposo absoluto** hasta que un mensaje llega físicamente a una de sus entradas.
* El cómputo no se ejecuta porque "le toca el turno en el código", sino **únicamente cuando hay datos disponibles para ser transformados**.

```
[ Modelo Dataflow de Max ]
       [ Entrada A ]       [ Entrada B ]
             │                   │
             └────────► ◯ ◄──────┘
                    (Nodo)
             Se activa SOLO cuando
             llega energía de datos.
```

> **Por qué esto importa:** En interacción musical en tiempo real, no puedes congelar la CPU en un bucle `while(true)` esperando a que el músico toque una nota. El sistema debe ser **completamente reactivo y asíncrono**.

---

## 🎻 2. Organología de Sistemas: Estado (State) vs. Excitación (Trigger)

*(Inspirado en la teoría acústica de Alessandro Cipriani & Maurizio Giri)*

En su obra cumbre *Electronic Music and Sound Design*, Cipriani y Giri establecen una distinción fundamental sobre cómo interactúan los seres humanos con los instrumentos musicales físicos, la cual Cycling '74 trasladó directamente a la arquitectura de Max:

### A. Parámetros de Estado (Inlets Fríos / Cold Inlets)
En un violín o una guitarra, colocar un dedo sobre el diapasón cambia la longitud de la cuerda (su afinación). **Hacer eso no produce sonido por sí mismo; solo modifica las propiedades físicas o el estado interno del instrumento.**
* En Max, los **Inlets Fríos** (generalmente del segundo en adelante) son **modificadores de estado**.
* Reciben datos, actualizan variables en memoria RAM, pero **NO producen salida ni alteran el flujo en ese instante**.

### B. Señales de Excitación (Inlets Calientes / Hot Inlets)
Para que la cuerda suene, necesitas aplicar **energía cinética**: frotar el arco o pulsar la cuerda con una púa.
* En Max, el **Inlet Caliente** (generalmente el izquierdo) representa la **excitación del sistema**.
* Al recibir un dato o un mensaje de disparo (`bang`), toma el estado interno actual guardado en los inlets fríos, ejecuta la operación matemática y **dispara inmediatamente el resultado hacia el exterior**.

```
    [ Parámetro de Estado ]          [ Señal de Excitación ]
    (Longitud de la cuerda)          (Golpe del arco / Púa)
               │                                │
               ▼ (Inlet Frío)                   ▼ (Inlet Caliente)
       ┌────────────────────────────────────────────────┐
       │              OBJETO / INSTRUMENTO              │
       └───────────────────────┬────────────────────────┘
                               │
                               ▼
                       [ Salida / Sonido ]
```

---

## ⚡ 3. Teoría de Grafos: Grafos Acíclicos Dirigidos (DAG) y Recursión en $t = 0$

*(Inspirado en los fundamentos de Miller Puckette y Todd Winkler, MIT Press)*

Un parche de Max es, formalmente, un **Grafo Acíclico Dirigido (Directed Acyclic Graph - DAG)**:
* Los objetos son **vértices**.
* Los cables son **aristas dirigidas** que imponen una relación de causalidad ($A \rightarrow B$).

### El Teorema del Bucle Infinito en Tiempo Lógico Cero ($t = 0$)
¿Qué sucede si conectas la salida de un objeto de vuelta a su propio inlet caliente en un ciclo cerrado?

```
          ┌─────────────┐
          │     + 1     │◄──────┐  (Bucle Cerrado en t = 0)
          └──────┬──────┘       │
                 └──────────────┘
```

En física, ningún efecto puede ser su propia causa en el mismo instante temporal. En computación:
1. El objeto emite un valor por su salida.
2. La salida llama inmediatamente a la función de entrada del mismo objeto en C.
3. Esa llamada vuelve a calcular y vuelve a llamar a la función de entrada...
4. **Todo esto ocurre dentro del mismo tick del Scheduler ($t = 0$), sin avance de tiempo.**
5. En menos de 1 milisegundo, la computadora agota la pila de memoria (Stack Overflow) y Max se cuelga.

> **Regla Arquitectónica de Winkler:** *Todo bucle de retroalimentación en Max requiere obligatoriamente un desacoplador temporal (como `[delay]` o `[pipe]`) o una compuerta lógica condicional (`[gate]`)*.

---

## 💻 4. Bajo el Capó: La Verdad Mecánica en C (Cycling '74 Max SDK)

Para un Senior Architect, los conceptos teóricos tienen una implementación física concreta en memoria. Mirá cómo implementa Cycling '74 este diseño en el código fuente de [`sources/max-sdk/source/basics/plussz/plussz.c`](file:///d:/DocumentosDiscoD/CursoMaxMSP/sources/max-sdk/source/basics/plussz/plussz.c):

### 1. La Estructura de Memoria (`struct`)
```c
typedef struct _plussz {
    t_object p_ob;      // Cabecera obligatoria de objeto Max
    long     p_value0;  // Registro de memoria del Inlet Izquierdo (Excitación)
    long     p_value1;  // Registro de memoria del Inlet Derecho (Estado)
    void*    p_outlet;  // Puntero al canal de salida
} t_plussz;
```

### 2. Qué hace el Inlet Frío en C (`plussz_in1`):
```c
void plussz_in1(t_plussz* x, long n) {
    x->p_value1 = n; // ¡ASIGNACIÓN PASIVA DE MEMORIA!
}
```
*No hay llamadas a funciones de salida. La CPU solo escribe 8 bytes en la dirección de memoria `x->p_value1` y retorna inmediatamente.*

### 3. Qué hace el Inlet Caliente en C (`plussz_int` y `plussz_bang`):
```c
void plussz_bang(t_plussz* x) {
    long sum = x->p_value0 + x->p_value1; // Calcula usando el estado almacenado
    outlet_int(x->p_outlet, sum);         // ¡EMISIÓN FORZOSA HACIA EL GRAFO!
}

void plussz_int(t_plussz* x, long n) {
    x->p_value0 = n;   // 1. Guarda el valor entrante
    plussz_bang(x);    // 2. Ejecuta inmediatamente la rutina de salida
}
```

El inlet caliente no es una metáfora; es una invocación directa a la rutina de despacho del grafo (`outlet_int`).

---

## 📐 5. La Regla Espacial vs. El Determinismo de `[trigger]`

Cuando un solo outlet se bifurca hacia múltiples inlets, el compilador dinámico de Max resuelve el orden de ejecución basándose en la posición espacial de los objetos en pantalla:

> **Right-to-Left (Derecha a Izquierda), Bottom-to-Top (Abajo hacia Arriba)**

```
             ┌───────────┐
             │   [bang]  │
             └─────┬─────┘
           ┌───────┴───────┐
           ▼               ▼
      [print Dos]     [print Uno]  <-- [print Uno] está más a la derecha,
                                       por lo tanto se ejecuta PRIMERO.
```

### El Peligro de las "Condiciones de Carrera Visuales" (The "Fragile Patch" Problem)
En los foros de Cycling '74, uno de los errores más recurrentes de programadores novatos se conoce como el **"Fragile Patch Problem"**:
* Un parche funciona perfectamente hoy.
* Mañana el desarrollador decide "embellecerlo", alinea un par de cajas o las mueve unos milímetros en el lienzo.
* **El parche deja de funcionar o produce resultados erráticos.**

¿Por qué ocurre esto? Porque Max resuelve los cables de un mismo outlet ordenando los objetos de destino según sus coordenadas rectangulares (`rect.x` y `rect.y`). Si dos objetos están verticalmente alineados, la regla secundaria es **Bottom-to-Top** (de abajo hacia arriba). Mover un objeto 1 píxel puede invertir la secuencia de ejecución de tus variables.

### El Algoritmo de Despacho: Depth-First Traversal (Búsqueda en Profundidad)
Otro hallazgo vital discutido en la comunidad oficial: **Max NO evalúa el grafo en paralelo (Breadth-First), sino estrictamente en profundidad (Depth-First).**
Cuando un objeto envía un mensaje por su salida hacia el primer destino:
1. Max congela la ejecución del resto de los destinos.
2. Sigue todo el camino del primer mensaje hasta el final de la cadena (incluso si pasa por 50 objetos intermedios).
3. **Solo cuando esa rama completa termina de ejecutarse y retorna en la pila de llamadas (call stack), Max pasa al siguiente objeto conectado.**

### El Salvador: El Objeto `[trigger]` (`[t]`)
Para diseñar software profesional, determinista y mantenible a largo plazo, **la regla de oro de la comunidad es: NUNCA confíes en la posición espacial de los cables**. Usamos **`[trigger]`** (abreviado **`[t]`**):
* Recibe cualquier mensaje de entrada.
* Despacha sus salidas **estrictamente de derecha a izquierda** en una secuencia determinista inmutable y tipada (`b` = bang, `i` = int, `f` = float, `l` = list, `s` = symbol).
* Garantiza que el código no se rompa aunque muevas los objetos por toda la pantalla.

```
               [ 25 ]
                 │
            ┌────┴────┐
            │ t i i   │   <-- trigger int int
            └─┬─────┬─┘
              │     └────────► [Inlet Frío (+)] (1°: Actualiza Estado en RAM)
              └──────────────► [Inlet Caliente (+)] (2°: Dispara la Excitación)
```

> **Consejo Pro de los Foros Oficiales (Debugging):** Si tenés dudas sobre el orden real en que viajan los mensajes en un parche enmarañado, no adivines: abrí el **Max Debugger Window** y agregá **Watchpoints** en los cables. Max pausará la ejecución y te mostrará paso a paso cómo la pila recorre el grafo.

---

## 🔬 4 Escenarios de la Vida Real (Casos de Estudio)

Abre el parche interactivo:
[`book/patches/modulo-01/laboratorio_01.maxpat`](file:///d:/DocumentosDiscoD/CursoMaxMSP/book/patches/modulo-01/laboratorio_01.maxpat)

### Escenario 1: Operaciones Aritméticas Dinámicas (`+`, `-`, `*`, `/`)
* **Problema:** Duplicar una variable ($x + x$) conectando un número a ambos inlets genera resultados corruptos si la excitación caliente ocurre antes de la actualización del estado frío.
* **Solución:** `[t i i]` garantiza que el inlet derecho absorba el valor antes de que el izquierdo dispare la suma.

### Escenario 2: Registros de Estado a Demanda (`[int]` / `[i]`)
* **Problema:** En secuenciación musical, necesitamos almacenar un valor de tono o duración y mantenerlo latente hasta que un pulso rítmico (`bang`) ordene su emisión.
* **Solución:** Enviar valores al inlet derecho (frío) para escribir en memoria sin disparar el sistema; el inlet izquierdo solo se excita con el pulso rítmico.

### Escenario 3: Empaquetado Dinámico de Mensajes MIDI (`[pack]` y `$1`)
* **Problema:** Construir eventos MIDI (`note, velocity`) con `[pack 0 0]`. Como todos los inlets de `pack` a partir del segundo son fríos, mover el control de velocidad no dispara la nota.
* **Solución:** Usar `[t b i]` para actualizar la velocidad en el inlet frío y forzar la emisión mediante un `bang` en el inlet caliente.

### Escenario 4: Puertas Lógicas Condicionales (`[gate]`) — La Excepción Anatómica
* **Problema:** La mayoría de los objetos tienen la excitación a la izquierda y el estado a la derecha. En `[gate]`, la convención está invertida por diseño:
  - **Inlet Izquierdo:** Control de estado (0 = cerrado, 1 = abierto). Cambiar el toggle **no emite datos**.
  - **Inlet Derecho:** Flujo de datos que atraviesa la compuerta cuando está abierta.

---

## 🧪 3 Ejercicios Prácticos de Laboratorio

Realiza estos ejercicios en tu copia de Max utilizando el parche [`laboratorio_01.maxpat`](file:///d:/DocumentosDiscoD/CursoMaxMSP/book/patches/modulo-01/laboratorio_01.maxpat):

### 🏋️ Ejercicio 1: El Divisor Protegido contra División por Cero
* **Objetivo:** Construir una calculadora de división (`/`) que reciba Numerador y Denominador.
* **Desafío:** Si el usuario ingresa un `0` en el denominador, el divisor debe advertir con un mensaje de error en consola y NO ejecutar la división.
* **Requisito:** Utiliza `[trigger]` para evaluar el denominador antes de permitir que el numerador golpee el inlet caliente de `/`.

### 🏋️ Ejercicio 2: El Acumulador Rítmico con Límite (Step Sequencer Core)
* **Objetivo:** Cada vez que pulses una tecla espaciadora (`[key]`), un contador debe sumar `1`.
* **Desafío:** Cuando llegue a `16`, debe resetearse automáticamente a `1`.
* **Requisito:** Orquesta la retroalimentación de la suma con un `[i 0]` y `[t b i]` para evitar el error de recursión infinita (stack overflow en $t=0$) en el scheduler de Max.

### 🏋️ Ejercicio 3: Enrutador A/B con Preservación de Estado
* **Objetivo:** Construir un sistema con 2 potenciómetros y un selector (A o B).
* **Desafío:** Al conmutar entre A y B, la salida debe actualizarse inmediatamente con el último valor conocido del canal seleccionado, sin requerir que muevas de nuevo el potenciómetro.
* **Requisito:** Utiliza dos objetos `[i]` (como memoria de estado para A y B) y conéctalos a un `[gate 2]` o un selector orquestado por `[trigger]`.

---

## 💡 Resumen de Principios Arquitectónicos
1. **Dataflow es reactivo:** no hay bucles bloqueantes; los objetos despiertan solo ante la llegada de mensajes.
2. **Inlet frío = Parámetro de estado (longitud de la cuerda / `x->val = n`).**
3. **Inlet caliente = Excitación cinética (golpe de arco / `outlet_int()`).**
4. **Bucle cerrado en $t=0$ es mortal:** requiere siempre desacoplo temporal (`[delay]`, `[pipe]`) o lógico (`[gate]`).
5. **Determinismo total con `[trigger]`:** prohíbe la ambigüedad de la regla espacial y garantiza portabilidad absoluta del código.
