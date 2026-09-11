---
title: "Módulo 3.1: Señal vs. Control (`~`), Anatomía del Audio Thread y la Función `perform64` en C"
description: "Capítulo del curso universitario de Max/MSP"
---


> *"En el mundo del control, el tiempo avanza a saltos cuando un evento ocurre; en el mundo de la señal, el tiempo es un río inmutable de 48.000 muestras por segundo que jamás puede detenerse."*

---

##  1. Fundamento Acústico y Computacional: De Eventos Discretos al Continuo Numérico

*(Inspirado en Miller Puckette, *Theory and Technique of Electronic Music*, y Alessandro Cipriani & Maurizio Giri, *Electronic Music and Sound Design*, Vol. 1)*

Para entender el procesamiento digital de señales (DSP) en Max, debemos comprender la fractura ontológica entre dos reinos temporales:

![FIG 3.0 · Los Dos Reinos Temporales de Max: Control vs. Señal MSP](/assets/diagrams/diagrama_reinos_control_audio.svg)

### El Teorema de Muestreo de Nyquist-Shannon

Para representar una onda sonora continua en el dominio digital sin pérdida de información, la frecuencia de muestreo $f_s$ debe ser estrictamente mayor al doble de la frecuencia máxima contenida en la señal ($f_{max}$):

$$f_s > 2 \cdot f_{max}$$

Para el espectro audible humano (aproximadamente $20\text{ Hz} - 20.000\text{ Hz}$):
$$f_s \ge 44.100\text{ Hz} \quad \text{o} \quad 48.000\text{ Hz}$$

Si intentamos representar una señal por encima de la frecuencia de Nyquist ($f_N = f_s / 2 = 24.000\text{ Hz}$ a 48 kHz), ocurre el fenómeno de **Aliasing (Plegamiento Espectral)**: las frecuencias inaudibles se reflejan matemáticamente hacia abajo en el espectro audible como tonos espurios y disonantes.

> **Fundamento Físico Histórico (Sir George Biddell Airy, 1871):**
> Mucho antes de la discretización digital, Sir George Biddell Airy demostró en su célebre tratado *On Sound and Atmospheric Vibrations with the Mathematical Elements of Music (Cambridge)* que el sonido en el aire no es un transporte de materia, sino una **propagación de estados de presión y deformación elástica infinitesimal** en un medio continuo gobernada por la ecuación diferencial de onda unidimensional:
> $$\frac{\partial^2 y}{\partial t^2} = c^2 \frac{\partial^2 y}{\partial x^2}$$
> En el procesamiento digital contemporáneo con MSP, sustituimos la elasticidad continua del aire por arreglos numéricos contiguos de punto flotante (`t_double*`) muestreados a intervalos regulares $T = 1/f_s$. La fidelidad con la que el motor en C reproduce las ondas mecánicas deducidas por Airy depende de respetar la tasa de Nyquist y evitar discontinuidades en el Audio Thread.

---

##  2. Anatomía del Audio Thread: Vector Sizes y Latencia

El procesador de tu computadora no puede interrumpir sus registros 48.000 veces por segundo para calcular una muestra a la vez; el costo de cambio de contexto (*context switching*) consumiría el 100% de la CPU.

Por ello, MSP procesa el audio en **bloques o vectores de muestras** (*Sample Frames*):

![FIG 3.1 · I/O Vector, Signal Vector & perform64](/assets/diagrams/diagrama_perform64_vectores.svg)

### La Física de la Latencia Hardware vs. Latencia de Cómputo:

1. **I/O Vector Size (Buffer de Hardware):**
   - Es el paquete de muestras que el driver (FlexASIO, ASIO4ALL, CoreAudio) intercambia con el conversor digital-analógico (DAC).
   - Determina la **latencia física de entrada/salida**:
     $$\text{Latencia (segundos)} = \frac{\text{I/O Vector Size}}{f_s}$$
   - A $256$ muestras y $48\text{ kHz}$, la latencia es de $5.33\text{ ms}$. Si reduces a $64$, baja a $1.33\text{ ms}$ (mayor carga de interrupciones para la CPU).

2. **Signal Vector Size (Buffer Interno de MSP):**
   - Es la cantidad de muestras que cada objeto procesa en una sola llamada a su bucle en C.
   - **No afecta la latencia directa de salida al hardware**, pero determina la resolución de modulación interna y el retraso mínimo en bucles de feedback de audio (`tapin~` / `tapout~`).

---

##  3. Bajo el Capó (Max C SDK): La Función `perform64`

*(Basado en el análisis de `simplemsp~.c` en `Cycling74/max-sdk`)*

La ejecución física de un objeto de audio en el núcleo de Max queda determinada por su función de procesamiento vectorial en el SDK:

```c
// simplemsp~.c del Cycling '74 Max SDK
void simplemsp_perform64(t_simplemsp *x, t_object *dsp64, 
                         double **ins, long numins, 
                         double **outs, long numouts, 
                         long sampleframes, long flags, void *userparam) 
{
    t_double *inL  = ins[0];        // Puntero al array de audio de entrada
    t_double *outL = outs[0];       // Puntero al array de audio de salida
    int n = sampleframes;          // Tamaño del Signal Vector (ej. 64)

    // Bucle DSP de alta velocidad a 64-bit (Audio Thread)
    while (n--) {
        *outL++ = *inL++ + x->offset; // Suma aritmética muestra a muestra
    }
}
```

### Lecciones de Arquitectura en C:
1. **Punteros Directos a Memoria:** `ins[0]` y `outs[0]` son arreglos contiguos en memoria RAM de números en coma flotante de doble precisión (`double`, 64 bits).
2. **Cero Alojamientos Dinámicos (`malloc`):** Dentro de `perform64` **está estrictamente prohibido llamar a `malloc()`, `free()` o imprimir texto con `post()`**. El Audio Thread tiene tiempo real duro; si se detiene a pedir memoria al sistema operativo, se produce un **dropout** (chasquido/pop audible).
3. **Desenrollado y SIMD:** Los procesadores modernos vectorizan este bucle `while (n--)` usando instrucciones AVX/SSE para procesar 4 o 8 muestras simultáneamente por ciclo de instrucción.

---

### Consideraciones Críticas de Rendimiento y Sincronización en MSP

1. **Incertidumbre Temporal (Jitter) en Disparos de Audio desde el Dominio de Control:**
   - Si se dispara un grano o envolvente mediante un mensaje de control o un objeto `[metro]`, el instante temporal exacto de inicio se alinea necesariamente con el límite del próximo bloque I/O.
   - Con un I/O Vector de 512 muestras a 48 kHz, existe una ventana de incertidumbre de hasta $10.6\text{ ms}$.
   - **Solución técnica:** Para garantizar sincronía a nivel de muestra individual (*sample-accurate*), la activación y las curvas temporales deben modularse exclusivamente mediante señales de audio continuas (`[phasor~]`, `[click~]`, `[line~]`).

2. **Alineamiento en Potencias de 2:**
   - La asignación de tamaños de búfer que no sigan potencias exactas de base 2 (como 300 o 500 muestras) introduce inestabilidad en las capas de controladores ASIO/CoreAudio y provoca desincronización en las rutinas SIMD. Deben emplearse siempre valores de la serie $64, 128, 256, 512, 1024$.

3. **Latencia de Retroalimentación en Enlaces Remotos (`send~` / `receive~`):**
   - Cualquier topología de bucle cerrado de retroalimentación resuelta sin conexiones explícitas directas incorpora un retardo fijo inherente de **un Signal Vector Size** ($1.33\text{ ms}$ a 64 muestras y 48 kHz).

---

## 4. La Señal de Audio como Función de Control Continuo (El Enfoque Dobrian & AlgoComp)

Como documenta Christopher Dobrian en su tratado *Computer Music Programming (CMP)* y en los ensayos de *Algorithmic Composition*, uno de los saltos epistemológicos más potentes en la programación musical con Max consiste en **desmitificar la señal de audio como mero material audible**.

Un cable de audio (`~`) no es necesariamente sonido que deba salir a los altavoces; es un **flujo de control continuo a resolución de microsegundos**:

1. **Osciladores de Baja Frecuencia (LFO) como Formas de Onda de Control**:
   - Una onda senoidal generada con `[cycle~ 0.2]` (un ciclo cada 5 segundos) no produce un tono perceptible por el oído humano, pero provee una trayectoria continua perfecta e inmune al jitter del sistema operativo.
   - Mientras que un temporizador de control (`[metro]`) está sujeto a las interrupciones del hilo de la interfaz gráfica, un LFO generado en el Audio Thread evalúa 48.000 puntos de modulación por segundo con precisión matemática absoluta.

2. **Modulación de Moduladores (*Modulating the Modulators*)**:
   - En *Algorithmic Composition*, Dobrian plantea que las curvas musicales orgánicas surgen cuando la frecuencia, amplitud o fase de un oscilador de control es modulada a su vez por un segundo oscilador de frecuencia aún menor:

![FIG 3.1B · Composición Algorítmica: Modulación de Moduladores en Audio Thread](/assets/diagrams/diagrama_modulacion_moduladores_dobrian.svg)

   - Esta técnica rompe la predictibilidad mecánica de los LFOs cíclicos simples, produciendo evoluciones tímbricas continuas cuasi-periódicas que emulan el comportamiento dinámico de los instrumentos acústicos.

3. **Mapeo No Lineal e Interpolación en Audio**:
   - El objeto `[scale~]` permite trasladar el rango bipolar natural de los osciladores de MSP ($-1.0$ a $+1.0$) a cualquier dominio físico continuo (por ejemplo, frecuencias de corte de filtros entre $80\text{ Hz}$ y $12.000\text{ Hz}$ o posiciones espaciales), aplicando curvaturas exponenciales y logarítmicas en tiempo real muestra a muestra.

---

##  5. 4 Escenarios del Mundo Real

Abre el parche interactivo complementario:
[`book/patches/modulo-03/laboratorio_07_audio_basics.maxpat`](/patches/modulo-03/laboratorio_07_audio_basics.maxpat)

### Escenario 1: Conversión de Macro a Micro-tiempo con `[sig~]`
* **El Problema:** Tienes un slider de control (0 a 127) que envía mensajes esporádicos. Si conectas ese slider directamente a un multiplicador de señal `[*~]`, el volumen cambia en saltos bruscos que generan zumbidos y clicks de cuantización (zipper noise).
* **La Solución:** Pasar el valor por `[sig~]` o `[line~]`. `[sig~]` repite el número 48.000 veces por segundo, convirtiendo el evento estático en un flujo continuo de señal.

### Escenario 2: Inspección y Monitoreo con `[number~]` y `[scope~]`
* **El Problema:** Un cable de señal transporta 48.000 números por segundo. Si conectas una caja numérica normal `[number]`, la interfaz intenta redibujarse miles de veces y congela Max.
* **La Solución:** Usar `[number~]` (que sub-muestrea la señal a 20 Hz para la pantalla) o `[scope~]` (osciloscopio gráfico en tiempo real que sincroniza el barrido visual).

### Escenario 3: Diagnóstico de Latencia de Hardware
* **El Problema:** Un baterista toca un pad electrónico y siente que el sonido sale "tarde", arruinando su sincronía rítmica.
* **La Solución:** Rediseñar el Audio Status. Reducir el I/O Vector Size de 512 a 128 muestras reduce la latencia de $10.6\text{ ms}$ a $2.6\text{ ms}$, situándola por debajo del umbral de percepción humana.

### Escenario 4: Lectura Muestra a Muestra con `[snapshot~]`
* **El Problema:** Necesitas extraer el valor actual de una onda sinusoidal de audio para disparar una decisión lógica en el reino del control.
* **La Solución:** `[snapshot~]`. Al recibir un `bang`, congela la muestra instantánea que viaja por el cable de audio en ese microsegundo y la emite como un número float hacia el reino de control.

---

## 5. 3 Desafíos de Ingeniería de Laboratorio

Realiza estos ejercicios utilizando el parche interactivo [`laboratorio_07_audio_basics.maxpat`](/patches/modulo-03/laboratorio_07_audio_basics.maxpat):

###  Ejercicio 1: Eliminación de Zipper Noise con `[line~]`
* **Objetivo:** Conecta un generador sinusoidal continuo a un control de volumen.
* **Desafío:** Compara dos métodos de atenuación: mover un slider directamente conectado a `[sig~]` vs. pasar el valor por un mensaje `$1 20` hacia `[line~]`. Observa en el osciloscopio `[scope~]` cómo el escalón discontinuo desaparece convirtiéndose en una rampa continua.

###  Ejercicio 2: El Sonda de Muestreo Cuántico con `[snapshot~]`
* **Objetivo:** Captura el estado de un LFO de audio ultra-lento (`[cycle~ 0.5]`).
* **Desafío:** Usa un `[metro 50]` para muestrear la señal con `[snapshot~]` y muestra el valor en pantalla. Comprueba matemáticamente que los valores capturados oscilan exactamente entre $-1.0$ y $+1.0$.

###  Ejercicio 3: Prueba de Esfuerzo Vectorial
* **Objetivo:** Experimenta con la carga de CPU y la latencia.
* **Desafío:** Abre la ventana Audio Status. Cambia el I/O Vector Size de 64 a 1024 muestras y observa cómo cambia el tiempo de respuesta y el indicador de CPU en Max.

---

## Resumen de Principios Arquitectónicos
1. **Control es Discreto, Audio es Continuo:** Los cables normales transportan eventos bajo demanda; los cables con tilde transportan bloques contiguos de 64 muestras a la frecuencia de muestreo.
2. **El Audio Thread es Sagrado:** En `perform64` no se imprime, no se aloca memoria y no se interactúa con el sistema operativo para evitar dropouts.
3. **I/O Vector manda en la Latencia Externa:** Signal Vector manda en el cálculo interno y la resolución de feedback.
4. **Barrera de Contención de Frecuencias:** Todo diseño en MSP debe respetar el límite de Nyquist ($f_s / 2$) para evitar el aliasing inarmónico.
