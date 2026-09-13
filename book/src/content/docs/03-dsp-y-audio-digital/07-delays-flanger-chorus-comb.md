---
title: "Lección 3.7: Delays, Buffers Circulares y Modulación Temporal: tapin~, tapout~, Comb Filters, Flanger y Chorus"
description: "Capítulo del curso de Max/MSP"
---


> *"El tiempo en audio no es una constante inmutable; es una cinta elástica. Si retrasás una señal unos pocos milisegundos y la sumás consigo misma, obtenés un filtro peine. Si modulás ese tiempo con un LFO, hacés cantar a la física mediante el efecto Doppler."*  
> — **Curtis Roads**, *The Computer Music Tutorial*

---

### Objetivos Pedagógicos y de Ingeniería
1. **Comprender la arquitectura de memoria de un Ring Buffer Circular**: Explicar los punteros de lectura y escritura (`write_ptr`, `read_ptr`), el operador módulo ($\%$) y por qué no se reasigna memoria en tiempo real durante la ejecución de audio.
2. **Dominar la física del Comb Filter (Filtro Peine)**: Deducir por qué una cancelación de fase periódica a intervalos $\Delta t$ produce una serie armónica de muescas infinitas espaciadas por $f = \frac{1}{\Delta t}$.
3. **Desentrañar la modulación temporal continua**:
   - **Flanger**: Tiempos ultracortos ($0.1\text{ ms} \dots 10\text{ ms}$) con realimentación intensa (*feedback*).
   - **Chorus**: Tiempos intermedios ($10\text{ ms} \dots 35\text{ ms}$) con múltiples líneas de retardo desfasadas.
   - **Echo / Delay Estándar**: Tiempos rítmicos perceptibles ($> 50\text{ ms}$).
4. **Dominar la interpolación no entera y el Efecto Doppler**: Explicar por qué modular el tiempo de retardo en `[tapout~]` produce variaciones de afinación proporcionales a la derivada temporal $\frac{d\tau}{dt}$.

---

## 1. Fundamentos Teóricos: El Buffer Circular (Ring Buffer)

En DSP en tiempo real, almacenar audio para retrasarlo no puede hacerse desplazando todo un arreglo de memoria (lo cual tendría un costo $\mathcal{O}(N)$ por muestra y destruiría la caché de la CPU). En su lugar, se reserva un bloque fijo de memoria contigua en RAM y se emplean punteros rotativos:

$$\text{index\_read} = (\text{index\_write} - D) \pmod N$$

donde $N$ es la capacidad máxima del buffer en muestras y $D$ es el retardo deseado en muestras:

$$D = \frac{\tau_{\text{ms}}}{1000} \cdot f_s$$

![FIG 3.8 · Arquitectura de Memoria Temporal: Buffer Circular (Ring Buffer)](/assets/diagrams/diagrama_buffer_circular_delays.svg)

---

## 2. La Ecuación Matemática del Comb Filter (Filtro Peine)

### A. Filtro Peine Feedforward (FIR)
$$y[n] = x[n] + b \cdot x[n - D]$$
- Si $b = 1$, se producen cancelaciones completas (muescas) en:
  $$f_{\text{notch}} = \frac{(2k + 1)}{2 \Delta t} = \frac{f_s}{2D}, \frac{3f_s}{2D}, \frac{5f_s}{2D}, \dots$$

### B. Filtro Peine Feedback (IIR)
$$y[n] = x[n] + g \cdot y[n - D]$$
- Produce resonancias agudas (*peaks*) en frecuencias múltiplos enteros exactos:
  $$f_{\text{res}} = \frac{k}{\Delta t} = \frac{k \cdot f_s}{D}$$
- **Condición Estricta de Estabilidad**: El coeficiente de realimentación debe cumplir estrictamente $|g| < 1.0$. Si $|g| \ge 1.0$, el buffer acumula energía infinita en cada ciclo, colapsando el sistema en saturación permanente.

---

## 3. La Tríada Temporal: Flanger, Chorus y Echo

| Efecto | Rango de Retardo ($\tau$) | Feedback ($g$) | Modulación LFO | Fenómeno Acústico |
| :--- | :--- | :--- | :--- | :--- |
| **Flanger** | $0.5\text{ ms} \dots 10\text{ ms}$ | Alto ($0.7 \dots 0.95$) | LFO senoidal $0.1 \dots 1\text{ Hz}$ | Efecto "jet plane", barrido armónico resonante |
| **Chorus** | $10\text{ ms} \dots 35\text{ ms}$ | Moderado / Nulo ($0 \dots 0.3$) | LFO multi-fase $1 \dots 3\text{ Hz}$ | Desdoblamiento de voces, desafinación natural |
| **Delay / Echo**| $> 50\text{ ms}$ | Variable ($0 \dots 0.8$) | Generalmente estático o wow/flutter | Repeticiones rítmicas discretas separadas del sonido directo |

### El Efecto Doppler y la Interpolación Hermite en `tapout~`
Cuando el tiempo de retardo $\tau(t)$ cambia dinámicamente:
- Si $\tau$ se acorta ($\frac{d\tau}{dt} < 0$), las muestras se leen más rápido de lo que entran $\implies$ **el tono sube**.
- Si $\tau$ se alarga ($\frac{d\tau}{dt} > 0$), las muestras se leen más despacio $\implies$ **el tono baja**.

`[tapout~]` realiza internamente una interpolación polinómica de 4 puntos (cúbica/Hermite) entre muestras discretas para permitir valores no enteros de retardo sin generar distorsión granular de redondeo.

---

## 4. Bajo el Capó: Análisis en C del Par `tapin~` y `tapout~`

En el SDK de Max (`ext_obex.h` y `z_dsp.h`), `tapin~` actúa como el dueño del bloque de memoria (`t_delayline`), mientras que múltiples `tapout~` se enlazan como lectores concurrentes de ese mismo puntero de memoria compartida:

```c
// Modelo conceptual de cómo tapout~ lee de tapin~ con interpolación
typedef struct _delayline {
    double *buffer;
    long size;         // Tamaño máximo en muestras
    long write_ptr;     // Puntero de escritura global
} t_delayline;

double read_tapout(t_delayline *dl, double delay_samples) {
    long w = dl->write_ptr;
    double r = (double)w - delay_samples;
    while (r < 0.0) r += dl->size;
    
    long r_int = (long)r;
    double frac = r - (double)r_int;
    
    // Interpolación lineal básica (tapout~ usa cúbica para fidelidad de 64 bits)
    long idx1 = r_int % dl->size;
    long idx2 = (idx1 + 1) % dl->size;
    
    return dl->buffer[idx1] * (1.0 - frac) + dl->buffer[idx2] * frac;
}
```

---

## 5. Escenarios Reales de Producción y Modelado Acústico

1. **Ping-Pong Delay Estéreo**: Dos líneas de `tapin~` cruzadas con retroalimentación alternada de canal izquierdo a derecho para ensanchamiento psicoacústico.
2. **Emulador de Cinta Analógica (Tape Delay)**: Un delay con un filtro paso-bajo (`lores~ 2500.`) en la rama de realimentación y una micro-modulación aleatoria (`noise~` pasado por filtro lento) para simular el estiramiento mecánico de la cinta (*wow & flutter*).
3. **Flanger Thru-Zero (Modelado de Jean-Michel Réveillac)**: Retrasar la señal directa por un tiempo estático $\tau_0 = 5\text{ ms}$ mientras la línea modulada oscila entre $0\text{ ms}$ y $10\text{ ms}$. Cuando ambos retardos coinciden exactamente en $\tau(t) = \tau_0$, la resta de señales en contrafase produce una **cancelación destructiva absoluta en todas las frecuencias** ($y[n] = x[n - \tau_0] - x[n - \tau_0] \equiv 0$). Este "paso por el cero absoluto" es la firma acústica inimitable del flanger de cinta analógico clásico de Abbey Road.
4. **Simulación Física del Altavoz Rotativo Leslie (Efecto Doppler + Difracción AM)**:
   Como detalla Réveillac en *Musical Sound Effects*, un altavoz Leslie no es un simple vibrato:
   - **Modulación de Frecuencia (FM por Efecto Doppler):** El giro de la bocina respecto al oyente provoca un corrimiento de frecuencia continuo:
     $$f_{aparente} = f_0 \cdot \left( \frac{c}{c \pm v_{rotor}} \right)$$
     Esto se modela en Max modulando el tiempo de retardo de un `[tapout~]` mediante un oscilador senoidal `[cycle~]`.
   - **Modulación de Amplitud (Tremolo por Difracción):** Simultáneamente, el patrón de radiación direccional del rotor atenúa la señal cuando la bocina apunta hacia la parte trasera del gabinete. En Max se multiplica la señal por un segundo `[cycle~]` desfasado $90^\circ$ respecto al modulador de retardo.
5. **Resonador Karplus-Strong Básico**: Un `tapin~` de 5 ms excitado con una ráfaga de 5 ms de `noise~` y realimentado con $g = 0.98$ produce una cuerda pulsada acústica convincente.

---

## 6. Desafíos de Ingeniería

### Desafío 1: El Limitador de Seguridad Anti-Explosión
Diseñá una subpatch en la ruta de realimentación de `[tapout~]` que utilice `[clip~ -0.99 0.99]` o `[tanh~]` para garantizar que, incluso si el usuario sube el deslizador de feedback a $1.2$, el sistema jamás sature al punto de mandar valores infinitos a los parlantes.

### Desafío 2: Chorus Estéreo Cuádruple con LFO en Cuadratura
Construí un procesador de Chorus con 4 `[tapout~]` conectados a un único `[tapin~]`, modulados por dos LFOs de $0.5\text{ Hz}$ con un desfase de $90^\circ$ y $180^\circ$ para lograr una imagen estéreo ultradensa sin cancelaciones de fase al colapsar a mono.

### Desafío 3: Karplus-Strong con Damping de Cerdas
Implementá el algoritmo Karplus-Strong afinado con un `tapout~` de tiempo $T = \frac{1000}{f_0}\text{ ms}$ y colocá un filtro paso-bajo de un polo ($y[n] = 0.5 x[n] + 0.5 x[n-1]$) en el lazo para simular el decaimiento natural más rápido de los armónicos agudos respecto a los graves.

---

## 7. Laboratorio Práctico: `laboratorio_13_delays.maxpat`

Abrí el parche interactivo para explorar:
- Matriz completa de retardo conmutable en tiempo real: Comb Filter Resonante, Flanger con modulación LFO senoidal y Stereo Tape Delay con feedback filtrado.
- Visualización en osciloscopio dual de señal seca vs señal procesada modulada.
- Control de seguridad con headroom protegido para evitar explosiones acústicas.
