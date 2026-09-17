---
title: "Lección 3.5: Envolventes Temporales: line~, curve~, adsr~ y Control de Amplitud Antialias"
description: "Envolventes temporales en MSP: [line~], [curve~] y [adsr~]. Origen físico de los clicks digitales y su eliminación mediante rampas de interpolación de amplitud anti-alias."
---


> *"Una forma de onda pura sin control dinámico de amplitud no es música: es una señal de prueba de laboratorio. La música vive en la evolución temporal de su energía, en el ataque que define su timbre inicial y en la caída que emula la fricción de la materia."*  
> — **Miller Puckette**, *The Theory and Technique of Electronic Music*

---

### Objetivos Pedagógicos y de Ingeniería
1. **Comprender la disyunción matemática entre rampas de control y rampas de audio**: Explicar por qué `[line]` produce *zipper noise* y cómo `[line~]` y `[curve~]` calculan interpolaciones vectorizadas muestra a muestra.
2. **Dominar la física de las envolventes lineales vs. curvas analógicas**: Demostrar por qué la audición logarítmica humana percibe las rampas lineales como caídas abruptas y cómo las curvas exponenciales emulan la descarga de capacitores ($RC$) en sintetizadores clásicos.
3. **Controlar el ciclo de vida polifónico con `adsr~`**: Implementar los estados Attack, Decay, Sustain y Release, comprendiendo el mecanismo de *legato*, *retriggering* y el mensaje `mute 0/1` para optimización de CPU en voces inactivas.
4. **Inspeccionar las entrañas del SDK de Max C**: Analizar la estructura interna de generación de pendientes flotantes en bloques DSP de 64 bits (`perform64`) y la prevención de discontinuidades de fase (*click prevention*).

---

## 1. Fundamentos Teóricos: El Artefacto de Discontinuidad y el Fenómeno de Gibbs en Amplitud

En procesamiento digital de señales (DSP), multiplicar una señal periódica $x(t) = \sin(\omega t)$ por una función de paso escalón de Heaviside $u(t)$ (es decir, encender o apagar el audio instantáneamente de $0.0$ a $1.0$) es formalmente equivalente a convolucionar en el dominio de la frecuencia el espectro de la senoide con una función Sinc:

$$\mathcal{F}\{x(t) \cdot u(t)\} = X(f) * \left( \frac{1}{2}\delta(f) + \frac{1}{j 2\pi f} \right)$$

Esta convolución desparrama energía hacia todas las frecuencias audibles e inaudibles hasta el límite de Nyquist ($\frac{f_s}{2}$), manifestándose acústicamente como un **clic seco o golpe de transitorio no deseado**. Para evitar esto, toda transición de amplitud debe ser continua y diferenciable, requiriendo un tiempo de subida (*rise time*) y bajada (*fall time*) finito.

![FIG 3.6 · Discontinuidad Escalón (Gibbs) vs. Transición Continua C^1 Anti-click](/assets/diagrams/diagrama_anticlick_envolventes.svg)

---

## 2. Los Generadores de Rampa Canónicos en Max/MSP

Max provee tres herramientas fundamentales para la síntesis de envolventes en el hilo de audio:

### A. `line~` (Interpolador Lineal Muestra a Muestra)
`[line~]` recibe mensajes de control con la sintaxis:
`[destino_amplitud, tiempo_en_ms]` o listas sucesivas `[v1 t1 v2 t2 ...]`.

- En cada bloque vectorial (`perform64`), calcula el incremento constante por muestra:
  $$\Delta = \frac{V_{\text{target}} - V_{\text{current}}}{T_{\text{samples}}}$$
  donde $T_{\text{samples}} = \frac{T_{\text{ms}}}{1000} \cdot f_s$.
- **Limitación acústica**: La respuesta de sonoridad del oído humano es aproximadamente logarítmica (ley de Weber-Fechner). Un decaimiento lineal suena como si el volumen cayera bruscamente al inicio y se arrastrara interminablemente al final.

### B. `curve~` (Interpolador Paramétrico No Lineal)
`[curve~]` añade un tercer parámetro a la lista de mensajes:
`[destino_amplitud, tiempo_ms, factor_curvatura]`

- Si `factor_curvatura == 0`: La rampa es puramente **lineal**.
- Si `factor_curvatura < 0`: Curva **cóncava** (ideal para caídas exponenciales naturales, emulando la descarga de un circuito RC $V(t) = V_0 e^{-t/\tau}$).
- Si `factor_curvatura > 0`: Curva **convexa** (ataque rápido que desacelera o decaimiento lento que colapsa repentinamente).

### C. `adsr~` (Generador de Envolvente Clásico con Retriggering Inteligente)
`[adsr~]` modela el estándar del sintetizador analógico de cuatro etapas.
- **Sintaxis**: `adsr~ [A_ms] [D_ms] [S_ratio 0.-1.] [R_ms]`
- Se dispara con un valor flotante o entero positivo (velocidad MIDI o compuerta $1.0$).
- Al recibir `0.` (Note Off), no cae a cero inmediatamente: inicia la fase de **Release** desde el nivel exacto en el que se encuentre la señal en ese instante, garantizando **cero clics** aun si la nota se suelta en pleno ataque.

---

## 3. Bajo el Capó: Análisis en C de un Generador de Rampa (`line~`)

Para entender cómo se evita el zipper noise sin sobrecargar la CPU, observemos cómo un objeto tipo `line~` gestiona su vector de 64 bits en el SDK de Max (`z_dsp.h`):

```c
// Modelo conceptual simplificado del bucle perform64 de line~
void my_line_perform64(t_my_line *x, t_object *dsp64, double **ins, long numins, 
                       double **outs, long numouts, long sampleframes, 
                       long flags, void *userparam) {
    double *out = outs[0];
    double current_val = x->current_val;
    double target_val = x->target_val;
    double inc = x->inc;
    long samples_left = x->samples_left;
    
    for (int i = 0; i < sampleframes; i++) {
        if (samples_left > 0) {
            current_val += inc;
            samples_left--;
        } else {
            current_val = target_val;
        }
        out[i] = current_val;
    }
    
    x->current_val = current_val;
    x->samples_left = samples_left;
}
```

### El Gotcha del Hilo de Control vs. Audio
Si enviás un mensaje de control a `line~` a la mitad de un vector DSP, el nuevo objetivo se agenda para el **inicio del siguiente vector**. Esto significa que puede haber una latencia de jitter de hasta `Signal Vector Size` muestras (típicamente $64$ muestras $\approx 1.45\text{ ms}$ a $44.1\text{ kHz}$). Para sincronización temporal perfecta a nivel de muestra única, se utiliza `[techno~]` o disparos derivados de phasors de audio (`[edge~]`).

---

## 4. Escenarios Reales de Producción

1. **Anti-Click Mute Master**: Crear un conmutador de silencio de audio que nunca haga clic. Se envía `0. 15` a un `[line~]` que multiplica la salida antes del DAC. 15 ms es imperceptible como retraso pero elimina todo artefacto de continua.
2. **Emulación de Percusión Clásica (808 Bass Drum)**: El cuerpo de una 808 requiere una envolvente doble: una envolvente rápida de frecuencia (pitch drop exponencial con `curve~` de 150 Hz a 45 Hz en 40 ms) y una envolvente lenta de amplitud con decaimiento cóncavo (`factor_curvatura = -0.8`).
3. **Polyphonic Voice Allocation Cleanup**: En un sintetizador polifónico, una voz no debe apagarse hasta que su `[adsr~]` haya completado el Release. Conectar el tercer outlet de `[adsr~]` (salida de estado de activación) hacia `[thispoly~]` asegura que la voz libere ciclos de CPU cuando calla.
4. **Morphing de Modulación LFO**: Usar `[curve~]` para interpolar la velocidad de un LFO de 0.1 Hz a 20 Hz de forma logarítmica sin saltos discontinuos de fase.

---

## 5. Desafíos de Ingeniería

### Desafío 1: El Algoritmo de Curva Personalizada
Diseñá una subpatch que tome una rampa normalizada de `[phasor~]` ($0.0 \to 1.0$) y aplique una función de transferencia de potencia $y = x^\gamma$ usando solo operadores de audio (`[pow~]`). Compará el consumo de CPU y la respuesta tímbrica frente a `[curve~]`.

### Desafío 2: De-Clicker de Retriggering Forzado
Si enviás repetidamente notas rápidas a un `[adsr~]` antes de que termine el Release, observá qué pasa si rearmás la envolvente desde 0. Modificá la arquitectura para que el nuevo ataque arranque desde el nivel actual de amplitud sin resetear a tierra.

### Desafío 3: Envelope Follower Dual
Construí un seguidor de envolvente para una señal externa de micrófono utilizando `[peakamp~]` y `[line~]`, implementando tiempos de Ataque (para seguir transitorios de púa) y Release (para no vibrar en bajas frecuencias) independientes.

---

## 6. Laboratorio Práctico: `laboratorio_11_envolventes.maxpat`

Abrí el parche de laboratorio para experimentar con:
- Comparación en tiempo real entre respuesta lineal (`line~`), exponencial (`curve~`) y ADSR con osciloscopio y visualización espectral.
- Conmutador A/B que demuestra auditivamente la diferencia entre corte discontinuo (con clic) y desvanecimiento anti-aliasing de 10 ms.
