---
title: "Módulo 3.2: Generación de Señales Básicas (`[cycle~]`, `[phasor~]`, `[saw~]`, `[noise~]`), Tablas de Onda y Anti-Aliasing"
description: "Capítulo del curso universitario de Max/MSP"
---

# Módulo 3.2: Generación de Señales Básicas (`[cycle~]`, `[phasor~]`, `[saw~]`, `[noise~]`), Tablas de Onda y Anti-Aliasing

> *"En matemáticas, una onda de diente de sierra tiene un salto instantáneo vertical con infinitos armónicos; en audio digital, los infinitos armónicos rebotan contra el límite de Nyquist y destruyen tu timbre. Quien no comprende el aliasing, programa generadores de ruido en lugar de sintetizadores."*

---

## ️ 1. Fundamento Acústico: Series de Fourier y el Espectro Armónico

*(Inspirado en Miller Puckette, *Theory and Technique of Electronic Music*, y Cipriani & Giri, *Electronic Music and Sound Design*, Vol. 1)*

Jean-Baptiste Joseph Fourier demostró en 1822 que cualquier señal periódica continua puede descomponerse en una suma de funciones sinusoidales puras cuyas frecuencias son múltiplos enteros ($k \cdot f_0$) de la frecuencia fundamental ($f_0$):

$$x(t) = \sum_{k=1}^{\infty} A_k \sin(2\pi k f_0 t + \phi_k)$$

### El ADN Espectral de las Formas de Onda Clásicas:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       ORGANOLOGÍA ESPECTRAL DE ONDAS                        │
├─────────────────────────────────────────────────────────────────────────────┤
│ 1. SINUSOIDE PURA ([cycle~])                                                │
│    • Contiene ÚNICAMENTE el primer armónico (la fundamental f0).            │
│    • Espectro: Una sola línea vertical en f0. Cero distorsión armónica.     │
│                                                                             │
│ 2. DIENTE DE SIERRA / SAWTOOTH ([saw~])                                     │
│    • Contiene TODOS los armónicos (pares e impares: 1, 2, 3, 4, 5...).      │
│    • Amplitud del k-ésimo armónico: A_k = 1 / k                             │
│    • Timbre brillante, cortante y rico (ideal para bajos y leads).          │
│                                                                             │
│ 3. ONDA CUADRADA / SQUARE ([rect~])                                         │
│    • Contiene ÚNICAMENTE armónicos IMPARES (1, 3, 5, 7, 9...).              │
│    • Amplitud del k-ésimo armónico: A_k = 1 / k                             │
│    • Timbre hueco, nasal y metálico (similar al clarinete).                 │
│                                                                             │
│ 4. RUIDO BLANCO ([noise~])                                                  │
│    • Densidad espectral plana: todas las frecuencias con energía aleatoria. │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. El Peligro del Aliasing y Osciladores con Banda Limitada (Band-Limited)

En el mundo matemático analógico, las ondas cuadradas y de sierra tienen esquinas infinitamente afiladas. En el dominio digital, una discontinuidad vertical infinita genera armónicos que sobrepasan con creces la frecuencia de Nyquist ($f_N = f_s / 2 = 24.000\text{ Hz}$).

### ¿Qué pasa cuando un armónico supera a Nyquist?
Si tocas una nota aguda de sierra a $5.000\text{ Hz}$:
* 1º armónico: $5.000\text{ Hz}$ (OK)
* 2º armónico: $10.000\text{ Hz}$ (OK)
* 3º armónico: $15.000\text{ Hz}$ (OK)
* 4º armónico: $20.000\text{ Hz}$ (OK)
* 5º armónico: $25.000\text{ Hz}$  **¡SUPERA NYQUIST!**

En lugar de desaparecer, esa energía **rebota como un espejo**:
$$f_{\text{aliased}} = |48.000 - 25.000| = 23.000\text{ Hz}$$
Y el 6º armónico ($30.000\text{ Hz}$) rebotará en $18.000\text{ Hz}$. 
El resultado son decenas de frecuencias espurias **inarmónicas** que suenan como chirridos metálicos sucios y desagradables.

```
                  Límite de Nyquist (24 kHz)
                              │
     f0    2f0   3f0   4f0    │   5f0 (25 kHz)
     │      │     │     │     │    │
    ─┴──────┴─────┴─────┴─────┼────┴────────► Frecuencia
                              │   /
                  ◄───────────┼──┘  (Rebota a 23 kHz como Aliasing)
```

### La Diferencia Crucial entre `[phasor~]` y `[saw~]`:
- **`[phasor~]` NO TIENE BANDA LIMITADA (Naive Sawtooth):** Es una rampa matemática lineal de $0.0$ a $1.0$ que se reinicia abruptamente a $0.0$. Es el mejor reloj de fase del mundo para modular buffers o síntesis granular, pero **si lo escuchas directamente como oscilador sonoro en notas medias/altas, destruirá tus agudos con aliasing masivo**.
- **`[saw~]` y `[rect~]` SÍ TIENEN BANDA LIMITADA:** Utilizan algoritmos de atenuación armónica (como tablas de ondas de múltiples resoluciones o algoritmos PolyBLEP) para eliminar los armónicos que exceden Nyquist antes de que reboten.

---

## ️ 3. Under the Hood (Max C SDK): Tablas de Onda y Acumuladores de Fase

*(Basado en `simpwave~.c` del Max SDK)*

¿Cómo genera `[cycle~]` una sinusoide continua con costo computacional mínimo?

En lugar de llamar a la costosa función trascendente matemática `sin()` de la librería de C 48.000 veces por segundo, Max utiliza una **Wavetable (Tabla de Onda)** precalculada de 512 o 4096 puntos en memoria RAM estática.

```c
// Lógica interna de simpwave~ en el Max SDK
typedef struct _simpwave {
    t_pxobject ob;
    double     phase;        // Acumulador de fase normalizado (0.0 a 1.0)
    double     phase_step;   // Salto de fase por muestra: (frecuencia / samplerate)
    double     table[512];   // Muestras precalculadas de un ciclo de onda
} t_simpwave;

void simpwave_perform64(t_simpwave *x, t_object *dsp64, 
                        double **ins, long numins, 
                        double **outs, long numouts, 
                        long sampleframes, long flags, void *userparam) 
{
    t_double *out = outs[0];
    int n = sampleframes;
    double ph = x->phase;
    double step = x->phase_step;

    while (n--) {
        // 1. Interpolar valor en la tabla
        int index = (int)(ph * 512.0);
        *out++ = x->table[index]; // Lectura directa en O(1) de memoria RAM

        // 2. Avanzar el acumulador de fase
        ph += step;
        if (ph >= 1.0) ph -= 1.0; // Envolver de 1.0 a 0.0 (Wrap)
    }
    x->phase = ph; // Guardar fase para el siguiente bloque
}
```

### El Acumulador de Fase: El Motor Universal de Síntesis
El salto de fase por muestra está gobernado por una fórmula fundamental:
$$\text{phase\_step} = \frac{f_0}{f_s}$$
Si $f_0 = 440\text{ Hz}$ y $f_s = 48.000\text{ Hz}$, en cada muestra la fase avanza:
$$\text{phase\_step} = \frac{440}{48000} \approx 0.009166$$

---

### Gotchas Críticos de los Foros Oficiales de Cycling '74

1. **`[cycle~]` arranca en Fase de Coseno (1.0, no 0.0):**
   - Históricamente en Max, `[cycle~]` es un **coseno**: su fase $0.0$ equivale a amplitud $+1.0$. Si disparas audio desde silencio absoluto reseteando la fase a 0, producirás un **click instantáneo**. Para arrancarlo en cero de fase seno, debes desfasarlo un cuarto de ciclo ($0.75$).
2. **Uso Erróneo de `[phasor~]` como Audio Audible:**
   - La comunidad insiste: `[phasor~]` es un **generador de tiempo/fase**, no un oscilador para los parlantes. Úsalo para indexar tablas (`[2d.wave~]`, `[wave~]`), disparar ventanas granulares o modular filtros, pero usa `[saw~]` para escuchar timbres de sierra limpios.
3. **Hard-Sync y Clicks en Cosenos:**
   - Reiniciar la fase de `[cycle~]` abruptamente con un pulso de sincronía provoca una discontinuidad vertical que genera ruido armónico. Para hard-sync limpio se requieren ventanas de suavizado o técnicas PolyBLEP en `[gen~]`.

---

## ️ 4. 4 Escenarios del Mundo Real

Abre el parche interactivo complementario:
[`book/patches/modulo-03/laboratorio_08_osciladores.maxpat`](file:///d:/DocumentosDiscoD/CursoMaxMSP/book/patches/modulo-03/laboratorio_08_osciladores.maxpat)

### Escenario 1: El Test Auditivo de Aliasing (`[phasor~]` vs `[saw~]`)
* **El Problema:** Quieres demostrar experimentalmente por qué el aliasing destruye la música.
* **La Solución:** Conectar un barrido de frecuencias de $100\text{ Hz}$ a $12.000\text{ Hz}$ a un `[phasor~]` y a un `[saw~]`. Con `[phasor~]`, al subir la frecuencia se escucha claramente cómo armónicos fantasma descienden en sentido contrario (aliasing). Con `[saw~]`, el sonido permanece puro y brillante.

### Escenario 2: Generación de Pulso Variable (PWM) con `[phasor~]` y comparador
* **El Problema:** Quieres el sonido clásico de sintetizador de los 80 (Pulse Width Modulation) modulando el ancho de pulso de una onda cuadrada.
* **La Solución:** Conectar `[phasor~]` a un operador de umbral `[>~ 0.5]`. Modulando el valor de comparación de $0.01$ a $0.99$ con un LFO lento, el ancho de pulso muta continuamente de agudo y nasal a grueso.

### Escenario 3: Síntesis de Percusión (Snare Drum) con `[noise~]` y Envolvente
* **El Problema:** Crear el sonido de redoblante de una caja de ritmos analógica tipo TR-808 sin usar samples en disco.
* **La Solución:** Ráfagas de ruido blanco `[noise~]` multiplicadas por una envolvente exponencial rápida `[line~]` de 150 ms, mezcladas con un golpe de seno grave descendente (`[cycle~]`).

### Escenario 4: Tabla de Onda Personalizada con `[cycle~ mi_buffer]`
* **El Problema:** La sinusoide estándar de `[cycle~]` es demasiado simple y no tiene armónicos.
* **La Solución:** Cargar un ciclo de forma de onda rica en un `[buffer~ mi_onda]` y llamar a `[cycle~ mi_onda]`. El objeto adopta inmediatamente el nuevo timbre sin consumo adicional de CPU.

---

## 5. 3 Desafíos de Ingeniería de Laboratorio

Realiza estos ejercicios utilizando el parche interactivo [`laboratorio_08_osciladores.maxpat`](file:///d:/DocumentosDiscoD/CursoMaxMSP/book/patches/modulo-03/laboratorio_08_osciladores.maxpat):

### ️ Ejercicio 1: El Generador PWM Libre de Discontinuidades
* **Objetivo:** Construye un oscilador de pulso con modulación de ancho (PWM).
* **Desafío:** Usa dos ondas `[saw~]` en desfase relativo restadas entre sí (`[-~]`), o modula el atributo de ciclo de `[rect~]`. Compara el resultado espectral contra el PWM naive hecho con `[>~]`.

### ️ Ejercicio 2: El Sintetizador de Viento / Mar con Ruido Filtrado
* **Objetivo:** Simula el sonido del oleaje del mar.
* **Desafío:** Toma `[noise~]` y pásalo a través de un filtro resonante `[reson~]` o `[lores~]`. Modula la frecuencia de corte muy lentamente (0.1 Hz) usando un `[cycle~ 0.1]` escalado entre $200\text{ Hz}$ y $1500\text{ Hz}$.

### ️ Ejercicio 3: Fase Cero Senoidal vs Cosenoidal
* **Objetivo:** Demuestra la fase inicial de `[cycle~]`.
* **Desafío:** Conecta `[cycle~]` a un `[scope~]`. Envía un mensaje `0.` al inlet derecho de fase y observa dónde arranca la onda. Luego envía `0.75` y observa cómo se convierte en una onda senoidal pura que nace en cero sin producir click de inicio.

---

## Resumen de Principios Arquitectónicos
1. **Fourier Gobierna la Síntesis:** Toda forma de onda compleja es una suma de sinusoides. El timbre depende de qué armónicos existen y con qué amplitud relativa ($1/k$ en sierra y cuadrada).
2. **Aliasing es Inevitable si no hay Banda Limitada:** Las esquinas matemáticas perfectas no existen en digital; usa `[saw~]` y `[rect~]` para audio y reserva `[phasor~]` para modulación y fase.
3. **Wavetables en RAM para Alta Velocidad:** Los osciladores en C recorren buffers indexados por un acumulador de fase `step = f0 / fs`.
4. **Cuidado con la Fase Inicial:** `[cycle~]` es un coseno (amplitud 1.0 en $t=0$); compensa con fase $0.75$ para arranques suaves desde cero.
