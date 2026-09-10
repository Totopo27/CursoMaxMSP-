---
title: "Módulo 1.2: El Scheduler de Max, Jerarquía Temporal y Psicoacústica del Ritmo"
description: "Capítulo del curso universitario de Max/MSP"
---


> *"El tiempo en la música por computadora no es una línea uniforme; es una jerarquía de velocidades que va desde el micro-tiempo del timbre hasta el macro-tiempo de la forma musical."*

---

##  1. Fundamento Psicoacústico: Las Tres Escalas del Tiempo Sonoro

*(Inspirado en los tratados de David Creasey y Miller Puckette)*

En la computación musical clásica y la ingeniería de audio, el tiempo no se procesa como un único continuo. El oído y el cerebro humano perciben los intervalos temporales de maneras radicalmente distintas según su escala de magnitud:

```
┌────────────────────────────────────────────────────────────────────────┐
│                   LAS TRES ESCALAS TEMPORALES                          │
├────────────────────────────────────────────────────────────────────────┤
│ 1. MICRO-TIEMPO (< 20 ms)  DOMINIO DEL TIMBRE Y LA FASE               │
│    • El cerebro no distingue eventos separados.                        │
│    • Las oscilaciones se perciben como ALTURA (Pitch) o COLOR TIMBRAL. │
│    • Es el territorio exclusivo del AUDIO THREAD (MSP a 48 kHz).       │
│                                                                        │
│ 2. MESO-TIEMPO (20 ms a 100 ms)  RETARDOS Y ESPACIALIDAD              │
│    • Efecto Haas, ecos tempranos, flanging y transitorios de ataque.   │
│    • Límite perceptivo del retraso táctil en teclados MIDI.            │
│                                                                        │
│ 3. MACRO-TIEMPO (> 100 ms)  DOMINIO DEL RITMO Y LA FORMA              │
│    • Sucesión de pulsos perceptibles como eventos musicales discretos. │
│    • Es el territorio del SCHEDULER THREAD ([metro], [delay], [pipe]). │
└────────────────────────────────────────────────────────────────────────┘
```

> **La Consecuencia Arquitectónica:** Intentar procesar el *micro-tiempo* con objetos de control (`[metro]`, `[delay]`) genera **Jitter masivo y distorsión**, porque el sistema operativo no puede despachar interrupciones de software a 48.000 veces por segundo sin colapsar. Para el micro-tiempo existe **MSP** y **`gen~`**. Para el macro-tiempo existe el **Scheduler**.

---

##  2. El Problema del Jitter Temporal y la Percepción Rítmica Humana

*(Inspirado en Geoffrey Kidde, "Learning Music Theory with Max", Routledge)*

El oído humano es extraordinariamente sensible a la regularidad de los pulsos rítmicos. En un compás a 120 BPM:
* Una semicorchea dura exactamente **125 ms**.
* Una fluctuación de solo **3 a 5 ms** (Jitter) en un golpe de bombo o caja es detectada por el oyente como una interpretación "descuidada", "inestable" o fuera de groove.
* Si el Jitter supera los **10 ms**, la ilusión de sincronía polirrítmica se destruye por completo.

En un sistema operativo de propósito general como Windows o macOS, la CPU está constantemente ocupada atendiendo procesos en segundo plano (el antivirus, las pestañas del navegador, el dibujado de pantallas a 60/144 Hz). Si Max corriera todo en un solo hilo, **cada vez que el usuario mueve una ventana, el metrónomo se retrasaría 30 ms**.

---

##  3. La Arquitectura Tripartita de Hilos en Max

Para garantizar determinismo rítmico inmutable frente a la carga del sistema operativo, Cycling '74 diseñó una arquitectura estricta de **tres hilos concurrentes**:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        ARQUITECTURA DE HILOS                           │
├────────────────────────────────────────────────────────────────────────┤
│ 1. MAIN THREAD (Baja Prioridad / Cola de Eventos de la UI)             │
│    • Tareas lentas y no deterministas: dibujo de ventanas, inspectores,│
│      sliders, botones, renderizado web ([jweb]).                       │
│    • Operaciones con disco duro: carga de archivos ([coll], [dict]).   │
│                                                                        │
│ 2. SCHEDULER THREAD (Alta Prioridad / Temporizador del Sistema)        │
│    • Manejo de eventos en tiempo real: [metro], [delay], [pipe].       │
│    • Mensajes de control MIDI y protocolos de red rápida (OSC).        │
│    • Con Overdrive [X], este hilo interrumpe forzosamente al Main Thread│
│                                                                        │
│ 3. AUDIO THREAD (MSP / DSP en Bloques de Muestras a 64-bit)            │
│    • Procesa vectores fijos de audio (ej. 64 muestras) a 48.000 Hz.   │
│    • Es el hilo más crítico del sistema; si se demora, ocurre un click │
│      o 'dropout' audible de audio.                                     │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 4. Modos de Operación: Overdrive y Scheduler in Audio Interrupt (SIAI)

En **Options  Audio Status**, estas dos opciones configuran el comportamiento del planificador de tareas:

### Overdrive
* **Desactivado (Off):** El Scheduler corre dentro del Main Thread. Compartir el tiempo con la interfaz gráfica significa que cualquier dibujo pesado en pantalla introduce *Jitter* y destruye el tempo.
* **Activado (On):** Max le pide al kernel del sistema operativo un **hilo de temporizador multimedia de alta prioridad**. Cada vez que vence un tick de reloj milimétrico, el sistema suspende momentáneamente el redibujado de la pantalla para calcular el evento musical.

### Scheduler in Audio Interrupt (SIAI)
* El Scheduler se vincula directamente a la **interrupción de hardware de la tarjeta de sonido** (el driver ASIO/CoreAudio).
* En lugar de usar el reloj de la placa madre de la PC, los eventos de Max se calculan en el instante exacto en que la tarjeta de sonido solicita el siguiente bloque de muestras de audio.
* **Beneficio:** Cero desviación de reloj entre eventos MIDI/control y señales continuas de audio de MSP.

> **Gotcha Crítico de los Foros Oficiales (JavaScript y UI Timing):**
> Un error clásico debatido en la comunidad es programar secuenciadores rítmicos dentro de objetos `[js]` (JavaScript) o disparar metros a través de botones de UI. 
> - **El motor de JavaScript (`[js]`) y la Live API corren obligatoriamente en el Main Thread (baja prioridad).**
> - Aunque tengas `Overdrive` y `SIAI` activados, si el pulso pasa por código JS o depende de un elemento de interfaz, sufrirá jitter inmediato cada vez que muevas el mouse o abras un menú.
> - **Solución de arquitectura:** La generación del pulso temporal debe residir 100% en objetos nativos del Scheduler (`[metro]`, `[delay]`, `[transport]`, `[phasor~]`), relegando JS solo a tareas de cómputo analítico o manipulación de datos en reposo.

---

##  5. Bajo el Capó: `t_clock` y el Mecanismo de Cola `t_qelem` (Max SDK)

Mirando las entrañas del Max SDK en [`sources/max-sdk/source/advanced/simplethread/simplethread.c`](https://github.com/Cycling74/max-sdk/blob/main/source/advanced/simplethread/simplethread.c) y [`delay2.c`](https://github.com/Cycling74/max-sdk/blob/main/source/basics/delay2/delay2.c):

### 1. El Reloj de Alta Prioridad (`t_clock`)
```c
x->d_clock = clock_new((t_object*)x, (method)delay_callback);
clock_delay(x->d_clock, 500); // Encola un evento en el Scheduler para dentro de 500 ms
```
`t_clock` vive y despierta en el **Scheduler Thread**. Si adentro de `delay_callback` ejecutas una función que tarda 50 ms (como escribir un archivo JSON en disco o actualizar 1000 píxeles), **congelas el Scheduler** y todo el tiempo del parche colapsa.

### 2. El Puente Salvador: `t_qelem` (Queue Element)
Para evitar que una tarea pesada o gráfica destruya el reloj de alta prioridad, Cycling '74 creó la estructura **`t_qelem`**:
```c
qelem_set(x->x_qelem); // "Main Thread: añade esta tarea a tu cola de baja prioridad"
```
En el lenguaje visual de Max, este mecanismo en C se materializa a través de dos objetos esenciales:
* **`[defer]`:** Si el mensaje proviene del Scheduler de alta prioridad, lo traslada ordenadamente a la cola del Main Thread de baja prioridad.
* **`[deferlow]`:** Coloca el mensaje siempre al final absoluto de la cola de eventos del sistema operativo.

---

##  4 Escenarios de la Vida Real (Casos de Estudio)

Abre el parche interactivo:
[`book/patches/modulo-01/laboratorio_02_timing.maxpat`](/patches/modulo-01/laboratorio_02_timing.maxpat)

### Escenario 1: Medición de Jitter Rítmico con `[timer]`
* **El Problema:** ¿Cómo verificar empíricamente si tu configuración de audio es sólida o si tu sistema sufre de fluctuaciones de reloj?
* **La Arquitectura:** Conectamos un `[metro 100]` a un objeto `[timer]`. `[timer]` mide los microsegundos transcurridos entre dos pulsos consecutivos.
  - Con Overdrive activado: la lectura es estable en $100.0 \pm 0.3$ ms.
  - Con Overdrive desactivado y arrastrando ventanas: la lectura salta erráticamente entre $70$ y $140$ ms.

### Escenario 2: La Batalla de los Delays: `[delay]` vs `[pipe]` (Buffer de Notas)
* **El Problema:** Al tocar una ráfaga rápida de 4 notas en un controlador MIDI y enviarlas a un `[delay 1000]`:
  - `[delay]` **solo recuerda el último evento entrante**; los 3 eventos anteriores son sobrescritos y se pierden en el olvido.
* **La Solución con `[pipe]`:**
  - `[pipe]` implementa internamente una cola de memoria dinámica FIFO (First-In, First-Out). Admite múltiples argumentos (`[pipe 0 0 1000]` para nota y velocidad).
  - Almacena cada nota con su marca de tiempo exacta y las reproduce todas 1 segundo después, preservando la duración y la interpretación rítmica original.

### Escenario 3: Desacople de UI Pesada con `[deferlow]` para Prevenir Clicks de Audio
* **El Problema:** Cada vez que cargas un preset de 500 parámetros desde un `[dict]` o redibujas una matriz visual de gran tamaño, el Scheduler se detiene a pintar la pantalla. Si estás reproduciendo audio con MSP, escucharás un chasquido (*dropout* o click).
* **La Solución Arquitectónica:**
  ```
       [ Disparo de Preset / UI ]
                   │
              [ deferlow ]  <-- Traslada la ejecución a la cola baja (qelem)
                   │
         [ Carga Pesada / Dibujo ]
  ```

### Escenario 4: Reloj Polirrítmico Puro por Subdivisión de Módulo
* **El Problema:** Si usamos dos objetos `[metro]` independientes para ritmos compuestos (ej. `metro 333.33` para tresillos y `metro 250` para semicorcheas), los errores de redondeo de coma flotante en milisegundos hacen que ambos ritmos se desfasen con el paso de los compases (*drift* temporal).
* **La Solución Determinista:** Un solo **Master Clock** rápido conectado a un contador `[counter]`, dividiendo los pulsos mediante aritmética de módulo (`[% 3]` y `[% 4]`). La fase rítmica permanece matemáticamente perfecta indefinidamente.

---

## 3 Ejercicios Prácticos de Laboratorio

Realiza estos ejercicios en tu copia de Max utilizando el parche [`laboratorio_02_timing.maxpat`](/patches/modulo-01/laboratorio_02_timing.maxpat):

###  Ejercicio 1: El Cuantizador de Rebotes (Debouncer de Hardware)
* **Objetivo:** Cuando un botón físico o pedal se presiona, las vibraciones mecánicas de los contactos generan múltiples `bang`s falsos en menos de 10 ms.
* **Desafío:** Construye un subcircuito con `[delay]` y `[gate]` que deje pasar el primer `bang`, cierre la compuerta inmediatamente durante 50 ms y luego la vuelva a abrir automáticamente.

###  Ejercicio 2: El Tap Tempo con Detección de Inactividad
* **Objetivo:** Calcula los milisegundos entre dos pulsaciones seguidas de una tecla para sincronizar el tempo musical.
* **Desafío:** Si el usuario no presiona nada durante más de 2000 ms, el sistema debe resetear el cálculo para no promediar tiempos absurdamente lentos.
* **Requisito:** Utiliza `[timer]` para medir el delta y `[delay 2000]` para disparar el reset por inactividad.

###  Ejercicio 3: Eco MIDI con Desvanecimiento Exponencial de Velocidad
* **Objetivo:** Construye una máquina de delay MIDI de 3 repeticiones utilizando `[pipe]`.
* **Desafío:** Cada repetición debe ocurrir a 250 ms y su velocidad MIDI debe multiplicarse por `0.7` (haciendo que el eco suene cada vez más suave hasta extinguirse de forma natural).

---

## Resumen de Principios Arquitectónicos
1. **El micro-tiempo (<20 ms) pertenece al Audio Thread; el macro-tiempo (>100 ms) pertenece al Scheduler.**
2. **El Jitter rítmico destruye el groove musical:** activa siempre *Overdrive* en entornos de producción y en vivo.
3. **`[delay]` reemplaza eventos; `[pipe]` encola estructuras FIFO completas.**
4. **Protege el Scheduler con `[deferlow]`:** nunca ejecutes dibujo pesado ni lecturas de disco directamente sobre el hilo de alta prioridad.
5. **Relojes polirrítmicos por subdivisión entera:** utiliza siempre un reloj maestro con el operador módulo `%` para eliminar el desfase temporal acumulativo.
