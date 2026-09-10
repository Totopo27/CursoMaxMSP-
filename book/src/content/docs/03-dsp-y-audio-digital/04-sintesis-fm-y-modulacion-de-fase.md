---
title: "Módulo 3.4: Modulación de Frecuencia (FM), Modulación de Fase (PM) y la Matemática de John Chowning"
description: "Capítulo del curso universitario de Max/MSP"
---


> *"La síntesis FM es la alquimia del audio digital: con solo dos osciladores sinusoidales simples, podemos generar desde la calidez armónica de un clarinete hasta el brillo metálico de un gong tibetano."*

---

##  1. Fundamento Acústico y Matemático: El Descubrimiento de John Chowning (Stanford, 1973)

*(Inspirado en John Chowning, *The Synthesis of Complex Audio Spectra by Means of Frequency Modulation*, y Cipriani & Giri, Vol. 1)*

En la radio analógica clásica, la modulación de frecuencia se usaba a escalas ultrasónicas para transmitir datos. A finales de los años 60 en la Universidad de Stanford, el compositor y pionero **John Chowning** se preguntó: *¿Qué ocurre si modulamos la frecuencia de una onda audible con otra onda también en el rango audible ($20\text{ Hz} - 20.000\text{ Hz}$)?*

El resultado revolucionó la historia de la música electrónica y dio origen al mítico sintetizador Yamaha DX7.

### La Ecuación Universal de la Síntesis FM:

$$y(t) = A \sin\Big(2\pi f_c t + I \cdot \sin(2\pi f_m t)\Big)$$

Donde:
* **$f_c$ (Frecuencia Portadora / Carrier):** Determina el centro tonal o altura fundamental de la nota.
* **$f_m$ (Frecuencia Moduladora / Modulator):** Determina el espaciado o separación entre los armónicos.
* **$I$ (Índice de Modulación):** Representa la profundidad de modulación, definida como:
  $$I = \frac{\Delta f}{f_m}$$
  donde $\Delta f$ es la desviación pico de frecuencia en Hertz.

---

##  2. Las Funciones de Bessel y las Bandas Laterales

A diferencia de la modulación de amplitud (AM) —que solo engendra dos bandas laterales—, la síntesis FM produce **una cantidad infinita de bandas laterales** a ambos lados de la portadora, separadas exactamente por múltiplos de la moduladora:

$$f_{\text{parciales}} = f_c \pm k \cdot f_m \quad (k = 1, 2, 3, 4, \dots)$$

### ¿Qué determina la energía de cada parcial? Las Funciones de Bessel de Primera Especie $J_k(I)$
La amplitud de cada armónico $k$ está gobernada estrictamente por la función matemática $J_k(I)$:

```
Amplitud
  ▲
1.0│  J0(I) [Portadora]
   │  \          J1(I) [1er Parcial]
0.5│   \        /\          J2(I) [2do Parcial]
   │    \      /  \        /\
0.0┼─────\────/────\──────/──\────────► Índice de Modulación (I)
   │      \  /      \    /    \
-0.4│       \/        \  /      \
```

### Principios Espectrales de Bessel:
1. **Con $I = 0$:** $J_0(0) = 1.0$ y todos los demás $J_k(0) = 0$. La señal es una sinusoide pura idéntica a la portadora.
2. **Al aumentar el índice $I$:** La energía de la portadora disminuye ($J_0$ decae e incluso cruza por cero) y se transfiere progresivamente a los parciales laterales ($J_1, J_2, J_3\dots$).
3. **El espectro se ensancha:** Cuanto mayor es el índice de modulación $I$, más brillante, rico y agresivo se vuelve el timbre.

---

##  3. La Relación Armónica (Harmonicity Ratio $C:M$)

La naturaleza tímbrica del sonido final (si suena a un instrumento musical tradicional o a un efecto metálico disonante) está dictada por el cociente entre ambas frecuencias:

$$\text{Harmonicity Ratio} = \frac{f_c}{f_m}$$

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                 GUÍA DE RELACIONES ARMÓNICAS EN SÍNTESIS FM                 │
├─────────────────────────────────────────────────────────────────────────────┤
│ • Relación 1 : 1 (Ej: Carrier 440 Hz, Mod 440 Hz)                           │
│   Parciales: 440, 880, 1320, 1760 Hz (Serie Armónica Completa: Tipo Diente)│
│                                                                             │
│ • Relación 1 : 2 (Ej: Carrier 440 Hz, Mod 880 Hz)                           │
│   Parciales: 440, 1320, 2200, 3080 Hz (Solo Armónicos Impares: Clarinete)  │
│                                                                             │
│ • Relaciones Fraccionarias / Racionales (Ej: 1 : 3.5, 2 : 3)                │
│   Parciales armónicos con sub-armónicos o fondos formánticos cálidos.       │
│                                                                             │
│ • Relaciones Irracionales (Ej: 1 : 1.414, 1 : 2.718)                       │
│   Parciales inarmónicos sin relación de múltiplos enteros: Campanas, gongs. │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

##  4. Bajo el Capó (Max C SDK): FM Verdadera vs. Modulación de Fase (PM)

*(Basado en la arquitectura de `cycle~` en el Max SDK)*

En la industria de sintetizadores (incluido el Yamaha DX7 y el propio Max/MSP), lo que coloquialmente llamamos "FM" en realidad suele implementarse como **Modulación de Fase (Phase Modulation - PM)**:

```c
// Implementación conceptual de PM en C (Dentro de perform64)
double mod_sample = *mod_in++;                    // Salida del modulador
double phase = x->phase + (mod_sample * index);   // ¡Modulación directa de fase!
*out++ = interpolate_wavetable(x->table, phase);
x->phase += x->phase_step;                         // El paso fundamental permanece intacto
```

### ¿Por qué Modulación de Fase (PM) es superior en la práctica?
1. **Estabilidad de Tono:** En FM analógica verdadera, cualquier pequeño offset de corriente continua (DC) en el modulador desplaza la frecuencia fundamental del instrumento desafinándolo. En PM, el desfase modifica el espectro tímbrico **sin alterar la afinación fundamental de la nota**.
2. **Retroalimentación Limpia (Feedback FM):** Permite conectar la salida de un operador de vuelta a su propia entrada de fase para generar timbres de sierra o ruido controlado.

---

### Gotchas Críticos de los Foros Oficiales de Cycling '74

1. **El Desvío hacia Frecuencias Negativas:**
   - Si el índice $I$ es alto o la portadora es grave ($f_c < f_m$), parciales inferiores ($f_c - k \cdot f_m$) caen en números negativos. En el plano complejo, una frecuencia negativa es una rotación en sentido horario: **rebota en $0\text{ Hz}$ como positiva con inversión de fase de $180^\circ$**. Si no controlas el índice, estos parciales rebotados cancelan destructivamente armónicos existentes creando huecos tímbricos misteriosos.
2. **Explosión por Feedback Infinito:**
   - La retroalimentación de un oscilador hacia sí mismo en Max (`cycle~` a través de un cable a su inlet derecho de fase) requiere un escalado cuidadoso ($\le 0.2$). Superar ese umbral convierte inmediatamente la sinusoide en ruido blanco áspero con aliasing destructivo.

---

##  5. 4 Escenarios del Mundo Real

Abre el parche interactivo complementario:
[`book/patches/modulo-03/laboratorio_10_sintesis_fm.maxpat`](/patches/modulo-03/laboratorio_10_sintesis_fm.maxpat)

### Escenario 1: El Clarinete Acústico Dinámico ($C:M = 1:2$)
* **El Problema:** Sintetizar el timbre amaderado de un clarinete que suena puro al tocar piano y se llena de armónicos impares al tocar fuerte.
* **La Solución:** Fijar $f_c = 220\text{ Hz}$ y $f_m = 440\text{ Hz}$ ($1:2$). Mapear la velocidad MIDI al índice de modulación $I$ (de $0.1$ a $2.5$). Al tocar suave suena casi a seno puro; al tocar fuerte emergen el 3º, 5º y 7º armónicos.

### Escenario 2: La Campana Tubular Inarmónica ($C:M = 1:1.414$)
* **El Problema:** Crear el sonido de una campana de bronce que vibra con múltiples modos inarmónicos no enteros.
* **La Solución:** Portadora a $400\text{ Hz}$ y moduladora a $565.6\text{ Hz}$ ($1:\sqrt{2}$). Una envolvente `[line~]` dispara el índice a $I=5.0$ en el ataque (brillo metálico inicial) y decae lentamente a $0.0$ a lo largo de 4 segundos.

### Escenario 3: Bajo Eléctrico "Slap" Sintético ($C:M = 1:1$)
* **El Problema:** Sintetizar el bajo percusivo característico de los sintetizadores FM de los 80.
* **La Solución:** Relación $1:1$ a $55\text{ Hz}$ ($A_1$). Un pico ultrarrápido de modulación ($I=4.0$ decayendo a $0.8$ en 60 ms) simula el golpe metálico de la cuerda contra el traste.

### Escenario 4: Modulación de Fase con Entrada Externa
* **El Problema:** Aplicar FM sobre una señal de audio compleja proveniente de un micrófono o sampler.
* **La Solución:** Conectar la señal externa escalada al inlet de modulación de fase de un `[cycle~]`, logrando distorsión de fase analógica sobre material pregrabado.

---

## 6. 3 Desafíos de Ingeniería de Laboratorio

Realiza estos ejercicios utilizando el parche interactivo [`laboratorio_10_sintesis_fm.maxpat`](/patches/modulo-03/laboratorio_10_sintesis_fm.maxpat):

###  Ejercicio 1: El Calibrador de la Serie Armónica
* **Objetivo:** Experimenta con las relaciones enteras de Chowning.
* **Desafío:** Configura una portadora a $200\text{ Hz}$ y prueba las razones $1:1$, $1:2$, $1:3$ y $1:4$. Comprueba en el osciloscopio y analizador de espectro cómo cada razón genera una familia tímbrica clásica (diente de sierra, clarinete, nasal, hueco).

###  Ejercicio 2: El Envolvente Tímbrico Dinámico
* **Objetivo:** Desacopla la envolvente de amplitud de la envolvente tímbrica.
* **Desafío:** Usa dos objetos `[line~]`: uno para el volumen final y otro para el índice de modulación $I$. Ajusta los tiempos para que el timbre se vuelva más brillante a mitad de la nota (efecto *brass swell*).

###  Ejercicio 3: Diagnóstico de Rebote de Frecuencias Negativas
* **Objetivo:** Visualiza la cancelación de armónicos por frecuencias negativas.
* **Desafío:** Con $f_c = 100\text{ Hz}$ y $f_m = 250\text{ Hz}$, sube el índice $I$ por encima de $4.0$. Observa cómo la banda $-150\text{ Hz}$ rebota como $+150\text{ Hz}$ y genera batimientos acústicos audibles con el resto de parciales.

---

## Resumen de Principios Arquitectónicos
1. **FM no altera la afinación:** La portadora $f_c$ fija la nota musical; la moduladora $f_m$ fija el espaciado espectral.
2. **El Índice $I$ regula el ancho de banda:** Mayor índice = más armónicos según las funciones de Bessel $J_k(I)$.
3. **Relación $C:M$ define el instrumento:** Enteros = Timbres armónicos (trompetas, bajos, clarinetes); Fracciones o Irracionales = Metales y campanas inarmónicas.
4. **PM es más robusto que FM:** Evita el corrimiento de afinación por offsets de corriente continua.
