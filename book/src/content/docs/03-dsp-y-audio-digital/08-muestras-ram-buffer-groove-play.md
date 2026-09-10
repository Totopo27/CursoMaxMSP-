---
title: "Lección 3.8: Manejo de Muestras en RAM: buffer~, groove~, play~, index~ y Manipulación Varispeed"
description: "Capítulo del curso universitario de Max/MSP"
---


> *"La grabación en cinta permitía cambiar la velocidad alterando las revoluciones del motor, cambiando tanto la afinación como la duración simultáneamente. En el dominio digital, una muestra cargada en RAM es un arreglo arbitrario de números flotantes que podemos recorrer a cualquier velocidad, en reversa o en fragmentos de microsegundos con precisión de fase perfecta."*  
> — **Curtis Roads**, *Microsound*

---

### Objetivos Pedagógicos y de Ingeniería
1. **Comprender la memoria de muestras en Max (`buffer~`)**: Analizar la reserva de memoria dinámica en RAM, el número de canales (mono/estéreo), la tasa de muestreo nativa del archivo vs. la del DAC (`sr`), y los problemas de aliasing al reproducir a velocidades elevadas.
2. **Dominar los tres lectores canónicos de buffer**:
   - `[play~]`: Reproductor lineal gobernado por tiempo en milisegundos o rampas de `line~`.
   - `[index~]`: Lectura directa por número entero/fraccionario de muestra ($0 \dots N-1$).
   - `[groove~]`: Reproductor varispeed continuo gobernado por una señal de velocidad flotante ($1.0 = \text{normal}$, $-1.0 = \text{reversa}$, $2.0 = \text{octava arriba}$), con bucles (*looping*) y desvanecimiento de bordes (*crossfade windowing*).
3. **Controlar el Aliasing en Varispeed**: Explicar por qué acelerar la reproducción transpone los armónicos por encima de Nyquist ($f_s / 2$) y cómo mitigar los artefactos mediante sobremuestreo o filtrado antialias previo.
4. **Inspeccionar la API de `t_buffer_ref` en el SDK de Max C**: Estudiar la adquisición de bloqueo seguro (`buffer_ref_lock`), los punteros de lectura `t_float*` o `double*`, y la prevención de condiciones de carrera (*race conditions*) cuando el hilo de UI reemplaza un archivo mientras el hilo de audio está leyendo.

---

## 1. Arquitectura de Memoria: El Objeto `buffer~`

Un objeto `[buffer~]` no procesa audio por sí mismo: es un contenedor de datos de memoria compartida identificado por un **nombre simbólico global** dentro del entorno de Max (por ejemplo `buffer~ mi_sample 2000 2`).

```
[ RAM Global de Max ]
+----------------------------------------------------------------+
| buffer~ mi_sample (2 canales, 44100 Hz, 88200 muestras)        |
+----------------------------------------------------------------+
       ^                          ^                       ^
       |                          |                       |
   [play~]                   [groove~]                 [index~]
 (Rampa ms)            (Señal Varispeed 1.0)        (Índice sample)
```

### El Cálculo del Consumo de RAM
Para calcular la memoria requerida por un buffer de audio sin comprimir a 32 bits en coma flotante:

$$\text{Bytes} = \text{Muestras} \times \text{Canales} \times 4\text{ bytes} = \left(\frac{T_{\text{ms}}}{1000} \cdot f_s\right) \times C \times 4$$

*Ejemplo*: Un archivo estéreo de 10 minutos a $48\text{ kHz}$:
$$600\text{ s} \times 48000 \times 2 \times 4 = 230.4\text{ MB de RAM}$$

---

## 2. Los Tres Sabores de Lectura de Muestras

### A. `play~` (Interpolación Basada en Tiempo)
- Recibe un mensaje o una señal con la posición en milisegundos.
- Se combina típicamente con `[line~]` para crear trayectorias lineales o no lineales de reproducción.
- Ideal para síntesis granular donde se dispara un grano desde el punto $A$ al punto $B$ en un lapso exacto de $T$ milisegundos.

### B. `index~` (Acceso Crudo a Muestras Muestra a Muestra)
- Recibe una señal de audio donde el valor instantáneo representa el **índice exacto de la muestra en el arreglo** ($0, 1, 2, \dots, N-1$).
- Si se conecta un `[phasor~]` escalado por el número total de muestras (`*~ total_samples`), `index~` se transforma en un oscilador de tabla de ondas (*wavetable oscillator*) de ultra alta precisión.

### C. `groove~` (El Motor Varispeed con Bucle Integrado)
- **Inlet 1 (Signal)**: Factor de velocidad continuo ($1.0$ = normal, $0.5$ = mitad de velocidad / 1 octava abajo, $-1.0$ = reversa, $0.0$ = pausa).
- **Inlet 2 & 3**: Puntos de inicio y fin de bucle en milisegundos (`loopmin`, `loopmax`).
- Mensaje `loop 1`: Activa el bucle automático continuo.
- **Sincronización de Salida**: El Outlet 2 emite una señal de fase normalizada ($0.0 \to 1.0$) indicando el progreso actual dentro del bucle, ideal para coordinar envolventes de amplitud sincronizadas.

---

## 3. Bajo el Capó: Thread-Safety y Acceso C en `t_buffer_ref`

En el SDK de Max (`ext_buffer.h`), un objeto externo nunca debe acceder directamente a la memoria de un buffer sin solicitar un bloqueo de referencia. Si el usuario carga un nuevo archivo en el hilo principal mientras el motor de audio (`perform64`) intenta leer muestras, se produciría un **cuelgue del sistema por violación de acceso (Segmentation Fault)**.

```c
// Protocolo canónico en C SDK para lectura segura de buffer~
void my_sampler_perform64(t_my_sampler *x, t_object *dsp64, double **ins, long numins,
                          double **outs, long numouts, long sampleframes,
                          long flags, void *userparam) {
    t_buffer_obj *buffer = buffer_ref_get_object(x->buffer_ref);
    double *out = outs[0];
    
    // 1. Verificación de existencia y validez
    if (!buffer) {
        memset(out, 0, sizeof(double) * sampleframes);
        return;
    }
    
    // 2. Bloqueo de memoria (Thread-Safe Lock)
    float *tab = buffer_locksamples(buffer);
    if (!tab) {
        memset(out, 0, sizeof(double) * sampleframes);
        return;
    }
    
    long frames = buffer_getframecount(buffer);
    long chans = buffer_getchannelcount(buffer);
    
    for (int i = 0; i < sampleframes; i++) {
        long idx = (long)x->current_phase;
        if (idx >= 0 && idx < frames) {
            out[i] = (double)tab[idx * chans]; // Lectura de canal 1
        } else {
            out[i] = 0.0;
        }
        x->current_phase += x->speed;
    }
    
    // 3. Desbloqueo obligatorio (Release Lock)
    buffer_unlocksamples(buffer);
}
```

---

## 4. Escenarios Reales de Producción

1. **Scratches Estilo Vinilo**: Conectar un `[flonum]` suavizado con `[line~]` o la salida de una tableta gráfica/mouse hacia el inlet de velocidad de `groove~` para emular el frenado y empuje físico de una bandeja giradiscos.
2. **Repulidor de Bucles con Crossfade**: Eliminar clics en los puntos de unión de un bucle percusivo aplicando una pequeña rampa de ganancia senoidal (`cos~`) en los extremos con ayuda del outlet de sincronía de `groove~`.
3. **Reproductor Polifónico One-Shot (Drum Machine)**: Subpatchers polifónicos con `[play~]` disparados por mensajes de nota MIDI, leyendo de un buffer común cargado con bombos, tambores y platillos.
4. **Sintetizador Granular de Micro-Lazos**: Disparar cientos de lecturas cortas (10 a 50 ms) en posiciones aleatorias de un `buffer~` largo de voz humana para generar un manto ambiental o textura densa (*drone*).

---

## 5. Desafíos de Ingeniería

### Desafío 1: El Transpositor por Semitonos MIDI
Construí un circuito de control que tome un número de semitono relativo (ej. $+7$ para una quinta, $-12$ para una octava abajo) y calcule automáticamente la velocidad exacta requerida por `[groove~]`:

$$\text{Speed} = 2^{(\text{semitonos} / 12)}$$

Conectá un teclado flotante para cambiar la afinación de una muestra en tiempo real.

### Desafío 2: De-Clicker por Detección de Cruce por Cero
Diseñá una lógica con `[peek~]` que busque el cruce por cero ($0.0\text{ V}$) más cercano a un punto de corte deseado antes de definir los límites de bucle en `[groove~]`.

### Desafío 3: Scrubbing de Scrub Wheel Digital
Usá un `[wheel]` o deslizador bidireccional conectado a `[index~]` mediante un interpolador `[line~]` de 5 ms para lograr el efecto de rebobinado manual suave como en un grabador de cinta abierta (Revox).

---

## 6. Laboratorio Práctico: `laboratorio_14_buffer_groove.maxpat`

Abrí el parche interactivo para explorar:
- Carga de archivos de audio mediante `[buffer~]`, visualización de la forma de onda en `[waveform~]` con selección gráfica de región de bucle.
- Control continuo de velocidad varispeed con `[sig~]` y `[groove~]` (avance, retroceso, congelamiento en cero y reproducción a media velocidad).
- Medición en tiempo real del progreso de reproducción mediante osciloscopio y visualización espectral.
