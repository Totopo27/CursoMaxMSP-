---
title: "Lección 4.3: Paralelismo y Concurrencia Real: El Atributo @parallel 1, Hilos del Sistema Operativo y Afinidad de CPU"
description: "Capítulo del curso universitario de Max/MSP"
---

# Lección 4.3: Paralelismo y Concurrencia Real: El Atributo @parallel 1, Hilos del Sistema Operativo y Afinidad de CPU

> *"El aumento de frecuencia de reloj en los procesadores tocó un muro térmico hace más de dos décadas. El poder de cálculo contemporáneo no reside en hacer una tarea más rápido en un hilo, sino en distribuir el trabajo simultáneamente en 8, 16 o 32 núcleos de hardware. Si tu motor DSP corre en un solo hilo, estás desperdiciando el 85% de tu silicio."*  
> — **Herb Sutter**, *The Free Lunch Is Over: A Fundamental Turn Toward Concurrency in Software*

---

### Objetivos Pedagógicos y de Ingeniería
1. **Comprender el modelo de ejecución monohilo de MSP vs. Multiprocesamiento Simétrico (SMP)**: Explicar por qué, por defecto, toda la cadena DSP de Max se calcula secuencialmente en un único hilo de audio del sistema operativo.
2. **Dominar el atributo `@parallel 1` en `poly~`**: Deducir la partición de voces en un *thread pool* de subprocesos paralelos gestionados por el despachador de tareas de Max.
3. **Analizar la Ley de Amdahl aplicada a la síntesis de audio**: Demostrar los límites teóricos de aceleración ($S_{\text{latency}}$) frente a la sobrecarga de sincronización de memoria (*mutexes, context switches y cache coherency*).
4. **Inspeccionar la concurrencia en C del SDK de Max**: Comprender el acceso a memoria compartida (`t_buffer_ref`, tablas de ondas) y cómo evitar condiciones de carrera (*race conditions*) y bloqueos mutuos (*deadlocks*) entre hilos paralelos de DSP.

---

## 1. El Dilema del Hilo Único en Max/MSP

En una configuración estándar de Max:
- **Hilo Principal (Main/UI Thread)**: Dibuja las ventanas, responde al mouse y actualiza sliders a $\sim 30\text{--}60\text{ fps}$.
- **Hilo de Scheduler (Priority/Overdrive)**: Procesa eventos MIDI, `metro` y lógica temporal con precisión de microsegundos.
- **Hilo de Audio (Audio Processing Thread)**: Ejecuta el bucle `perform64` de **todos los objetos de audio en serie**, un bloque tras otro.

Si creás un sintetizador de 16 voces con filtros de modelado físico pesados que consume el $110\%$ de un núcleo, **el audio crujirá y caerá en dropouts inmediatos**, incluso si tenés un procesador moderno con 12 núcleos completamente ociosos al $0\%$.

```
[ Sin @parallel: Cuello de Botella Monohilo ]
Core 0: [ Voz 1 ][ Voz 2 ][ Voz 3 ][ Voz 4 ] ... [ Voz 16 ] ---> ¡100% SATURADO!
Core 1: [ OCIOSO 0% ]
Core 2: [ OCIOSO 0% ]
Core 3: [ OCIOSO 0% ]

[ Con @parallel 1: Distribución Simétrica ]
Core 0: [ Voz 1 ][ Voz 2 ][ Voz 3 ][ Voz 4 ] ---> 25%
Core 1: [ Voz 5 ][ Voz 6 ][ Voz 7 ][ Voz 8 ] ---> 25%
Core 2: [ Voz 9 ][ Voz 10][ Voz 11][ Voz 12] ---> 25%
Core 3: [ Voz 13][ Voz 14][ Voz 15][ Voz 16] ---> 25%
```

---

## 2. Activación del Multiprocesamiento: `@parallel 1`

Al declarar el objeto `[poly~]` con el atributo `@parallel 1`:
`[poly~ voz_dsp_pesada 16 @parallel 1]`

Max delega la ejecución de cada voz a un **Thread Pool interno** que asigna hilos de trabajo a los distintos núcleos lógicos disponibles en el procesador del sistema operativo (Intel, AMD o Apple Silicon).

### El Parámetro `@threadcount`
Por defecto, Max asigna un hilo por cada núcleo lógico detectado. Sin embargo, podés forzar la cantidad exacta de hilos según la carga de trabajo:
`[poly~ mi_modulo 8 @parallel 1 @threadcount 4]`

---

## 3. Límites Teóricos: La Ley de Amdahl y el Costo del Context Switch

La **Ley de Amdahl** establece la aceleración teórica máxima $S$ que puede obtenerse paralelizando un programa cuya fracción paralelizable es $P$:

$$S(N) = \frac{1}{(1 - P) + \frac{P}{N}}$$

donde $N$ es el número de núcleos de ejecución.

### Por qué el paralelismo no es gratis
1. **Suma Vectorial Final (Sección Serial no paralelizable)**: Todas las salidas de audio de las voces individuales deben sumarse antes de enviarse al DAC master. Esa suma es necesariamente secuencial.
2. **Latencia de Sincronización (Barriers)**: El hilo maestro de audio no puede enviar el vector actual a la tarjeta de sonido hasta que **la última voz paralela** haya terminado de computar sus muestras.
3. **Destrucción de la Caché L1/L2 (Cache Thrashing)**: Si las voces son muy livianas (un simple `*~`), el costo en ciclos de CPU de despertar hilos y sincronizar memorias supera ampliamente el tiempo de cálculo del audio.

> [!TIP]
> **Regla de Oro de Ingeniería**: Solo activá `@parallel 1` en parches donde cada voz individual sea computacionalmente costosa (filtros complejos, síntesis granular masiva, reverberaciones por convolución, modelos físicos). Para sintetizadores simples de un oscilador, el modo monohilo estándar suele ser más eficiente.

---

## 4. Bajo el Capó: Concurrencia y Sincronización en el SDK de Max C

Cuando múltiples hilos de audio acceden concurrentemente a recursos comunes, la arquitectura debe garantizar la seguridad de memoria (*thread safety*):

```c
// Protocolo de acceso concurrente a buffers compartidos en C SDK
void parallel_voice_perform64(t_parallel_voice *x, t_object *dsp64, 
                              double **ins, double **outs, long frames) {
    // Lectura de memoria compartida (Wavetable global)
    t_buffer_obj *buf = buffer_ref_get_object(x->buffer_ref);
    
    // Múltiples hilos pueden LEER concurrentemente sin bloqueo mutuo
    float *tab = buffer_locksamples(buf);
    
    if (tab) {
        // Cálculo de muestras en núcleo local independiente
        for (int i = 0; i < frames; i++) {
            outs[0][i] = tab[x->phase_index];
            x->phase_index = (x->phase_index + x->step) % x->tab_size;
        }
        buffer_unlocksamples(buf);
    }
}
```

### Reglas Críticas para Evitar Caídas del Sistema
- **Jamás escribir en variables globales compartidas desde hilos de audio paralelos**. Dos voces escribiendo a la vez en la misma dirección de memoria provocarán corrupción de datos o un cuelgue inmediato.
- **Utilizar aislamiento estricto `#0`** dentro de las voces para que los buses locales queden totalmente desacoplados entre hilos.

---

## 5. Escenarios Reales de Producción

1. **Sintetizador Granular de 64 Voces Simultáneas**: Cada voz lee granos de audio con envolventes gaussianas individuales. Distribuido en 8 núcleos, el CPU total no supera el $15\%$.
2. **Banco de Modelado Físico de Cuerdas Resonantes**: 24 cuerdas Karplus-Strong calculadas en paralelo para emular la resonancia simpática de un piano de cola completo.
3. **Procesador de Espacialización Ambisónica 3D**: Decodificación de audio de 3er orden (16 canales) dividida por bloques espaciales en núcleos dedicados.
4. **Matriz de Reverbs por Convolución**: Cuatro convolucionadores IIR de respuesta al impulso larga repartidos simétricamente entre núcleos lógicos.

---

## 6. Desafíos de Ingeniería

### Desafío 1: Benchmark Comparativo Monohilo vs. Multihilo
Creá un parche de prueba con 16 voces pesadas (cada una con 8 filtros `biquad~` en serie). Medí el porcentaje de CPU del sistema sin `@parallel` vs con `@parallel 1`. Demostrá la reducción drástica de tiempo por vector.

### Desafío 2: Monitoreo de Balance de Carga por Núcleo
Utilizando herramientas del sistema operativo (Administrador de Tareas en Windows o `htop` / Activity Monitor), observá la distribución de carga uniforme entre todos los núcleos cuando se toca un acorde de 16 notas.

### Desafío 3: El Limitador de Hilos para Sistemas Embebidos
Diseñá una lógica de configuración que detecte la cantidad de núcleos disponibles en la máquina y envíe el mensaje `@threadcount N/2` para reservar núcleos libres para el procesamiento de gráficos o video Jitter.

---

## 7. Archivos del Laboratorio

1. [`voz_dsp_pesada.maxpat`](/patches/modulo-04/voz_dsp_pesada.maxpat): Subparche con carga computacional densa (banco de 4 filtros resonantes en serie + distorsión no lineal polinómica) optimizado para poner a prueba el paralelismo.
2. [`laboratorio_17_multicore.maxpat`](/patches/modulo-04/laboratorio_17_multicore.maxpat): Banco de pruebas comparativo A/B que permite conmutar en caliente entre ejecución monohilo tradicional y multiprocesamiento paralelo `@parallel 1`.
