# Módulo 3.1: Señal vs. Control (`~`), Anatomía del Audio Thread y la Función `perform64` en C

> *"En el mundo del control, el tiempo avanza a saltos cuando un evento ocurre; en el mundo de la señal, el tiempo es un río inmutable de 48.000 muestras por segundo que jamás puede detenerse."*

---

## ️ 1. Fundamento Acústico y Computacional: De Eventos Discretos al Continuo Numérico

*(Inspirado en Miller Puckette, *Theory and Technique of Electronic Music*, y Alessandro Cipriani & Maurizio Giri, *Electronic Music and Sound Design*, Vol. 1)*

Para entender el procesamiento digital de señales (DSP) en Max, debemos comprender la fractura ontológica entre dos reinos temporales:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       LOS DOS REINOS TEMPORALES DE MAX                      │
├─────────────────────────────────────────────────────────────────────────────┤
│ 1. EL REINO DEL CONTROL (Eventos Asíncronos / Macro-tiempo)                 │
│    • Objetos estándar de Max (sin tilde: [metro], [+], [counter]).          │
│    • Los mensajes viajan por cables finos solo cuando algo cambia.          │
│    • Si no tocas una tecla, la tasa de cómputo es CERO (CPU en reposo).     │
│    • Resolución temporal típica: ~1 milisegundo (1.000 Hz).                 │
│                                                                             │
│ 2. EL REINO DEL AUDIO / MSP (Señales Síncronas / Micro-tiempo)              │
│    • Objetos con tilde (~): [cycle~], [+~], [lores~], [ezdac~].             │
│    • Cables amarillos/negros rayados que transportan un flujo continuo.     │
│    • La CPU calcula valores ininterrumpidamente, haya o no sonido.          │
│    • A 48.000 Hz (Sample Rate), cada muestra dura apenas 20.83 microsegundos│
└─────────────────────────────────────────────────────────────────────────────┘
```

### El Teorema de Muestreo de Nyquist-Shannon

Para representar una onda sonora continua en el dominio digital sin pérdida de información, la frecuencia de muestreo $f_s$ debe ser estrictamente mayor al doble de la frecuencia máxima contenida en la señal ($f_{max}$):

$$f_s > 2 \cdot f_{max}$$

Para el espectro audible humano (aproximadamente $20\text{ Hz} - 20.000\text{ Hz}$):
$$f_s \ge 44.100\text{ Hz} \quad \text{o} \quad 48.000\text{ Hz}$$

Si intentamos representar una señal por encima de la frecuencia de Nyquist ($f_N = f_s / 2 = 24.000\text{ Hz}$ a 48 kHz), ocurre el fenómeno de **Aliasing (Plegamiento Espectral)**: las frecuencias inaudibles se reflejan matemáticamente hacia abajo en el espectro audible como tonos espurios y disonantes.

---

## ️ 2. Anatomía del Audio Thread: Vector Sizes y Latencia

El procesador de tu computadora no puede interrumpir sus registros 48.000 veces por segundo para calcular una muestra a la vez; el costo de cambio de contexto (*context switching*) consumiría el 100% de la CPU.

Por ello, MSP procesa el audio en **bloques o vectores de muestras** (*Sample Frames*):

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    I/O VECTOR SIZE VS. SIGNAL VECTOR SIZE                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Tarjeta de Sonido (Hardware Driver ASIO / CoreAudio):                      │
│  [ I/O Vector Size = 256 muestras ] ──► Latencia = 256 / 48000 = 5.33 ms    │
│  │                                                                          │
│  │ (Subdividido internamente en MSP)                                        │
│  ▼                                                                          │
│  [ Signal Vector Size = 64 muestras ] ◄── Bloque de cómputo en C (perform64)│
│  [ 64 muestras ] [ 64 muestras ] [ 64 muestras ] [ 64 muestras ]            │
│                                                                             │
│  Regla: Signal Vector Size <= I/O Vector Size (Siempre en potencias de 2)   │
└─────────────────────────────────────────────────────────────────────────────┘
```

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

¿Cómo se ejecuta físicamente un objeto de audio en el kernel de Max? Mirá el código fuente real del SDK:

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

### Gotchas Críticos de los Foros Oficiales de Cycling '74

1. **Jitter en Disparos de Audio desde el Macro-tiempo:**
   - Si disparas un grano o envolvente con un botón de control o un `[metro]` normal, el instante exacto en que comienza el sonido se alinea con el inicio del próximo bloque I/O. 
   - Con un I/O Vector de 512 muestras, hay una incertidumbre temporal (jitter) de hasta $10.6\text{ ms}$.
   - **Solución:** Si requieres precisión de muestra (*sample-accurate*), la rampa o disparo debe generarse con señales continuas (`[phasor~]`, `[click~]`, `[line~]`).

2. **La Regla de las Potencias de 2:**
   - Configurar buffers que no sean potencias de 2 (como 300 o 500 muestras) desestabiliza los drivers ASIO y provoca caídas de sincronización. Usa siempre $64, 128, 256, 512, 1024$.

3. **Demora de Feedback en `send~` / `receive~`:**
   - Todo bucle de retroalimentación cerrado sin cables directos añade exactamente **1 Signal Vector Size de retraso** (a 64 muestras, $1.33\text{ ms}$ de desfase).

---

## ️ 4. 4 Escenarios del Mundo Real

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

### ️ Ejercicio 1: Eliminación de Zipper Noise con `[line~]`
* **Objetivo:** Conecta un generador sinusoidal continuo a un control de volumen.
* **Desafío:** Compara dos métodos de atenuación: mover un slider directamente conectado a `[sig~]` vs. pasar el valor por un mensaje `$1 20` hacia `[line~]`. Observa en el osciloscopio `[scope~]` cómo el escalón discontinuo desaparece convirtiéndose en una rampa continua.

### ️ Ejercicio 2: El Sonda de Muestreo Cuántico con `[snapshot~]`
* **Objetivo:** Captura el estado de un LFO de audio ultra-lento (`[cycle~ 0.5]`).
* **Desafío:** Usa un `[metro 50]` para muestrear la señal con `[snapshot~]` y muestra el valor en pantalla. Comprueba matemáticamente que los valores capturados oscilan exactamente entre $-1.0$ y $+1.0$.

### ️ Ejercicio 3: Prueba de Esfuerzo Vectorial
* **Objetivo:** Experimenta con la carga de CPU y la latencia.
* **Desafío:** Abre la ventana Audio Status. Cambia el I/O Vector Size de 64 a 1024 muestras y observa cómo cambia el tiempo de respuesta y el indicador de CPU en Max.

---

## Resumen de Principios Arquitectónicos
1. **Control es Discreto, Audio es Continuo:** Los cables normales transportan eventos bajo demanda; los cables con tilde transportan bloques contiguos de 64 muestras a la frecuencia de muestreo.
2. **El Audio Thread es Sagrado:** En `perform64` no se imprime, no se aloca memoria y no se interactúa con el sistema operativo para evitar dropouts.
3. **I/O Vector manda en la Latencia Externa:** Signal Vector manda en el cálculo interno y la resolución de feedback.
4. **Barrera de Contención de Frecuencias:** Todo diseño en MSP debe respetar el límite de Nyquist ($f_s / 2$) para evitar el aliasing inarmónico.
