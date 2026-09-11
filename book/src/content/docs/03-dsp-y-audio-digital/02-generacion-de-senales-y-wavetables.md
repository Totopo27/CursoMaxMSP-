---
title: "Módulo 3.2: Generación de Señales Básicas (`[cycle~]`, `[phasor~]`, `[saw~]`, `[noise~]`), Tablas de Onda y Anti-Aliasing"
description: "Capítulo del curso universitario de Max/MSP"
---


> *"En matemáticas, una onda de diente de sierra tiene un salto instantáneo vertical con infinitos armónicos; en audio digital, los infinitos armónicos rebotan contra el límite de Nyquist y destruyen tu timbre. Quien no comprende el aliasing, programa generadores de ruido en lugar de sintetizadores."*

---

##  1. Fundamento Acústico: Series de Fourier y el Espectro Armónico

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

![FIG 3.2 · Acumulador de Fase & Plegamiento de Nyquist](/assets/diagrams/diagrama_wavetable_aliasing.svg)

### La Diferencia Crucial entre `[phasor~]` y `[saw~]`:
- **`[phasor~]` NO TIENE BANDA LIMITADA (Naive Sawtooth):** Es una rampa matemática lineal de $0.0$ a $1.0$ que se reinicia abruptamente a $0.0$. Es el mejor reloj de fase del mundo para modular buffers o síntesis granular, pero **si lo escuchas directamente como oscilador sonoro en notas medias/altas, destruirá tus agudos con aliasing masivo**.
- **`[saw~]` y `[rect~]` SÍ TIENEN BANDA LIMITADA:** Utilizan algoritmos de atenuación armónica (como tablas de ondas de múltiples resoluciones o algoritmos PolyBLEP) para eliminar los armónicos que exceden Nyquist antes de que reboten.

---

##  3. Under the Hood (Max C SDK): Tablas de Onda y Acumuladores de Fase

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

### Teoría Formal de Interpolación en Tablas de Onda (Curtis Roads, CMT 2023)
En la segunda edición de *The Computer Music Tutorial (The MIT Press, 2023)*, Curtis Roads formaliza por qué el truncamiento entero directo (`(int)index`) es inaceptable en síntesis profesional de estudio: produce **ruido de cuantización de fase** y distorsión armónica espuria.

Para leer una posición fraccionaria $i + \alpha$ (donde $i$ es la parte entera y $\alpha \in [0, 1)$ la fracción de muestra):

1. **Truncamiento (Zero-Order Hold / Vecino más cercano):**
   $$y[n] = x[i]$$
   Genera saltos escalonados que degradan la relación señal-a-ruido (SNR) a menos de 40 dB.
2. **Interpolación Lineal (First-Order):**
   $$y[n] = x[i] + \alpha \cdot (x[i+1] - x[i])$$
   Es el método estándar en objetos como `[cycle~]` (con tabla de 512 puntos). Atenúa significativamente los componentes espurios, elevando el piso de ruido a ~70 dB.
3. **Interpolación Cúbica y Hermite (Splines de Tercer Orden):**
   Utilizada en `[gen~]` y samplers de alta gama, pondera 4 muestras consecutivas ($x[i-1], x[i], x[i+1], x[i+2]$) para asegurar la continuidad de la primera derivada (tangente suave). Elimina virtualmente todo aliasing audible, garantizando un piso dinámico superior a 96 dB (grado CD de 16-bit) incluso con transposiciones extremas.

---

### Consideraciones Técnicas en la Generación de Señales

1. **Fase Inicial Cosenoidal en `[cycle~]` (Amplitud +1.0):**
   - Por definición matemática en la arquitectura de Max, `[cycle~]` evalúa una función **coseno**: una fase de $0.0$ corresponde a una amplitud instantánea de $+1.0$. Si se inicializa la señal desde silencio absoluto reseteando la fase a cero sin rampa, se generará una discontinuidad brusca (*click* transitorio). Para iniciar la oscilación en cruce por cero equivalente a una función seno, debe aplicarse un desfase de tres cuartos de ciclo ($0.75$).
2. **Distinción entre Generadores de Fase y Osciladores de Audio:**
   - Por definición arquitectónica, `[phasor~]` es una señal rampa de control temporal o índice de fase, no un oscilador de audio de banda limitada. Debe emplearse para indexar tablas de ondas (`[2d.wave~]`, `[wave~]`), temporizar ventanas granulares o modular filtros; para reproducción audible de ondas sierra con supresión de aliasing debe utilizarse `[saw~]`.
3. **Discontinuidad por Sincronización Dura (Hard-Sync):**
   - Reiniciar la fase de un oscilador sinusoidal de manera instantánea mediante un pulso de sincronía genera una discontinuidad en la derivada que introduce componentes inarmónicos espurios. La implementación de sincronización dura de alta fidelidad exige el empleo de técnicas de suavizado de bordes o formulaciones PolyBLEP en `[gen~]`.

---

## 4. Leyes de Paneo de Potencia Constante: La Solución Coseno/Seno (Christopher Dobrian)

En la distribución estéreo y multicanal de señales digitales, uno de los errores más extendidos consiste en aplicar un paneo puramente lineal (amplitud constante):
$$A_L = 1.0 - p, \quad A_R = p \quad (p \in [0.0, 1.0])$$

Como formaliza **Christopher Dobrian** en *Techniques and Software for Octophonic Composition* y en *Computer Music Programming (CMP)*:

### El Problema de la Caída de 3 dB en el Centro Estéreo
Cuando una fuente se posiciona en el centro del panorama ($p = 0.5$):
- Cada altavoz recibe una amplitud de $0.5$ (atenuación de $-6\text{ dB}$).
- El oído humano percibe la sonoridad de fuentes acústicas en un recinto según la **suma cuadrática de potencias acústicas** (energía acústica total), no la suma directa de amplitudes:
  $$P_{\text{total}} = A_L^2 + A_R^2 = (0.5)^2 + (0.5)^2 = 0.25 + 0.25 = 0.5$$
- Una potencia acústica de $0.5$ representa una pérdida neta de **$-3\text{ dB}$**. El resultado psicoacústico es que cualquier sonido que viaje de un extremo al otro parece "hundirse" o alejarse en el centro.

### La Ley de Potencia Constante (Constant-Power Law)
Para que la potencia total percibida permanezca matemáticamente inmutable en cualquier posición del panorama ($P_{\text{total}} = 1.0$), Dobrian implementa la relación trigonométrica de cuarto de ciclo:
$$A_L = \cos\left(p \cdot \frac{\pi}{2}\right), \quad A_R = \sin\left(p \cdot \frac{\pi}{2}\right)$$

En el centro exacto ($p = 0.5$, ángulo $\pi/4 = 45^\circ$):
$$A_L = \cos(45^\circ) = \frac{\sqrt{2}}{2} \approx 0.7071 \quad (-3\text{ dB})$$
$$A_R = \sin(45^\circ) = \frac{\sqrt{2}}{2} \approx 0.7071 \quad (-3\text{ dB})$$
$$P_{\text{total}} = (0.7071)^2 + (0.7071)^2 = 0.5 + 0.5 = 1.0 \quad (0\text{ dB})$$

![FIG 3.3 · Constant-Power Law & Compensación de -3 dB](/assets/diagrams/diagrama_panning_constant_power.svg)

### Implementación Óptima en Max (Zero-CPU Overhead)
Calcular funciones trigonométricas trascendentes muestra a muestra consumiría ciclos de CPU innecesarios. Dobrian propone dos arquitecturas canónicas en Max:
1. **Un solo `[cycle~]` en fase fija**: Usar un oscilador `[cycle~]` con frecuencia $0\text{ Hz}$, desplazando su fase de entrada en el rango $[0.75, 1.0]$ para el canal izquierdo y $[0.0, 0.25]$ para el canal derecho.
2. **Tabla de Transferencia Precalculada**: Cargar 512 puntos de un cuarto de onda senoidal en una `[table]` o `[buffer~]`, logrando lecturas instantáneas $O(1)$ en memoria.

---

##  5. 4 Escenarios del Mundo Real

Abre el parche interactivo complementario:
[`book/patches/modulo-03/laboratorio_08_osciladores.maxpat`](/patches/modulo-03/laboratorio_08_osciladores.maxpat)

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

Realiza estos ejercicios utilizando el parche interactivo [`laboratorio_08_osciladores.maxpat`](/patches/modulo-03/laboratorio_08_osciladores.maxpat):

###  Ejercicio 1: El Generador PWM Libre de Discontinuidades
* **Objetivo:** Construye un oscilador de pulso con modulación de ancho (PWM).
* **Desafío:** Usa dos ondas `[saw~]` en desfase relativo restadas entre sí (`[-~]`), o modula el atributo de ciclo de `[rect~]`. Compara el resultado espectral contra el PWM naive hecho con `[>~]`.

###  Ejercicio 2: El Sintetizador de Viento / Mar con Ruido Filtrado
* **Objetivo:** Simula el sonido del oleaje del mar.
* **Desafío:** Toma `[noise~]` y pásalo a través de un filtro resonante `[reson~]` o `[lores~]`. Modula la frecuencia de corte muy lentamente (0.1 Hz) usando un `[cycle~ 0.1]` escalado entre $200\text{ Hz}$ y $1500\text{ Hz}$.

###  Ejercicio 3: Fase Cero Senoidal vs Cosenoidal
* **Objetivo:** Demuestra la fase inicial de `[cycle~]`.
* **Desafío:** Conecta `[cycle~]` a un `[scope~]`. Envía un mensaje `0.` al inlet derecho de fase y observa dónde arranca la onda. Luego envía `0.75` y observa cómo se convierte en una onda senoidal pura que nace en cero sin producir click de inicio.

---

## Resumen de Principios Arquitectónicos
1. **Fourier Gobierna la Síntesis:** Toda forma de onda compleja es una suma de sinusoides. El timbre depende de qué armónicos existen y con qué amplitud relativa ($1/k$ en sierra y cuadrada).
2. **Aliasing es Inevitable si no hay Banda Limitada:** Las esquinas matemáticas perfectas no existen en digital; usa `[saw~]` y `[rect~]` para audio y reserva `[phasor~]` para modulación y fase.
3. **Wavetables en RAM para Alta Velocidad:** Los osciladores en C recorren buffers indexados por un acumulador de fase `step = f0 / fs`.
4. **Cuidado con la Fase Inicial:** `[cycle~]` es un coseno (amplitud 1.0 en $t=0$); compensa con fase $0.75$ para arranques suaves desde cero.
