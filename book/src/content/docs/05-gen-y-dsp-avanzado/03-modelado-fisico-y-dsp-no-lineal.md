---
title: "Lección 5.3: Modelado Físico y DSP No Lineal: Cuerdas Karplus-Strong, Waveguides y Ecuaciones Diferenciales"
description: "Capítulo del curso de Max/MSP"
---


> *"La síntesis aditiva y sustractiva parten de formas de onda abstractas y las esculpen. El modelado físico parte de la física del mundo real: la elasticidad de una cuerda de nylon tensada, la fricción no lineal de las cerdas de un arco impregnadas en colofonia, y la pérdida de energía dispersiva en el puente de una guitarra. No sintetizamos el sonido: simulamos el instrumento."*  
> — **Julius O. Smith III**, *Physical Audio Signal Processing*

---

### Objetivos Pedagógicos y de Ingeniería
1. **Comprender la ecuación de onda unidimensional de d'Alembert**: Deducir la descomposición de ondas viajeras progresivas y regresivas ($y(x,t) = y_R(t - x/c) + y_L(t + x/c)$) y su discretización en guías de onda digitales (*Digital Waveguides*).
2. **Dominar el algoritmo clásico de Karplus-Strong con afinación fraccionaria**: Explicar por qué una línea de retardo corta combinada con un filtro paso-bajo de promedio de 2 muestras ($y[n] = 0.5 x[n] + 0.5 x[n-1]$) emula el decaimiento armónico acústico de una cuerda pulsada.
3. **Resolver el error de afinación discreta mediante filtros Allpass**: Demostrar matemáticamente por qué el retardo en muestras enteras $D = \text{round}(f_s / f_0)$ desafina las notas agudas y cómo un interpolador todo-paso de primer orden dentro de `gen~` otorga precisión microtonal de sub-muestra.
4. **Implementar modelos no lineales de excitación continua**:
   - Modelado de arco frotado mediante la curva de fricción de rozamiento estático/dinámico no lineal.
   - Modelado de percusión de membrana mediante waveguides bidimensionales interconectados.

---

## 1. Fundamentos Físicos: La Cuerda Vibrante y la Ecuación de d'Alembert

La vibración transversal de una cuerda elástica ideal sin pérdidas responde a la ecuación diferencial en derivadas parciales de segundo orden:

$$\frac{\partial^2 y}{\partial t^2} = c^2 \frac{\partial^2 y}{\partial x^2}$$

donde $c = \sqrt{T / \rho}$ es la velocidad de propagación de la onda, $T$ es la tensión y $\rho$ es la densidad lineal de masa.

### La Solución de d'Alembert y las Digital Waveguides
Jean le Rond d'Alembert demostró que la solución general es la superposición de dos ondas viajeras en direcciones opuestas:

$$y(x,t) = y^+(t - x/c) + y^-(t + x/c)$$

En el dominio digital, esto se traduce en **dos líneas de retardo acopladas que viajan en sentidos contrarios**, reflejándose en los extremos fijos con inversión de fase (coeficiente de reflexión $R = -1.0$).

![FIG 5.2 · Digital Waveguide: Ondas Viajeras Bidireccionales y Reflexión de Fase](/assets/diagrams/diagrama_digital_waveguide.svg)

---

## 2. El Algoritmo Karplus-Strong Extendido (ESPaR)

El modelo simplificado de Kevin Karplus y Alex Strong colapsa las dos líneas de retardo en una sola línea cerrada con un filtro de amortiguación en el lazo de feedback:

$$y[n] = x[n] + g \cdot \frac{y[n - D] + y[n - D - 1]}{2}$$

1. **Excitación Inicial**: Una ráfaga de ruido blanco corto ($N = D$ muestras) que modela el golpe de la púa o el pellizco del dedo.
2. **Lazo de Realimentación (Feedback Loop)**: El sonido circula indefinidamente por el buffer.
3. **Filtro de Damping**: El promedio entre dos muestras adyacentes es un filtro paso-bajo FIR simple ($H(z) = 0.5 + 0.5 z^{-1}$). En cada vuelta, los armónicos agudos pierden energía más rápido que los graves, **emulando con exactitud la amortiguación física de las cuerdas reales**.

### Esquemas en Diferencias Finitas de Cuarto Orden (Aguilar & Salinas, 2003)
En su investigación sobre síntesis por modelado físico, Juan R. Aguilar y Renato Salinas formalizan la discretización directa de la ecuación de onda sin recurrir a guías de onda simplificadas, transformando la ecuación continua en un **esquema explícito en diferencias finitas de cuarto orden** tanto en el dominio espacial como temporal:

$$y_i^{n+1} = 2 y_i^n - y_i^{n-1} + \left(\frac{c \Delta t}{\Delta x}\right)^2 \left( y_{i+1}^n - 2 y_i^n + y_{i-1}^n \right)$$

Bajo la condición de estabilidad de Courant-Friedrichs-Lewy ($\text{CFL} \le 1$, donde $\Delta t \le \Delta x / c$), este sistema resuelve en cada muestra la aceleración de cada segmento físico de la cuerda o membrana. En `[gen~]`, este esquema se implementa con precisión muestra a muestra utilizando arrays de memoria contiguos indexados en el código de GenExpr.

### Dinámica No Lineal y Atractores Caóticos (Edmar Soria, 2022)
Como expone Edmar Soria en *Procedural / Sonora*, cuando los instrumentos acústicos son forzados a regímenes extremos (sobre-presión del arco sobre la cuerda o membranas con rigidez no lineal), la respuesta deja de ser lineal y entra en el territorio de los **sistemas dinámicos discretos no lineales** gobernados por mapas caóticos (como el mapa logístico o el atractor de Hénon):
$$x_{n+1} = 1 - a x_n^2 + y_n, \quad y_{n+1} = b x_n$$
Al acoplar estos mapas a la excitación de guías de onda dentro de `[gen~]`, el instrumento digital exhibe bifurcaciones periódicas, armónicos sub-graves y comportamientos acústicos orgánicos idénticos a los de instrumentos orquestales reales en manos de músicos virtuosos.

---

## 3. El Problema de la Afinación y el Interpolador Todo-Paso (Allpass)

A una tasa de muestreo de $f_s = 44100\text{ Hz}$, para afinar un $A_4$ ($440\text{ Hz}$):

$$D_{\text{ideal}} = \frac{44100}{440} - 0.5 = 99.727\text{ muestras}$$

(El $-0.5$ compensa el retardo intrínseco de medio sample introducido por el filtro promediador).

Si redondeamos a un número entero de $D = 100$ muestras:
$$f_{\text{real}} = \frac{44100}{100.5} = 438.8\text{ Hz} \implies \text{¡Desafinado por casi 5 cents!}$$

En notas agudas (ej. $2000\text{ Hz}$, $D \approx 21.5$), redondear a 21 o 22 produce desafinaciones intolerables de hasta 40 cents.

### La Solución: Filtro Allpass Fraccionario en `gen~`
Dentro de `gen~`, implementamos un filtro todo-paso de 1 polo ($|H(e^{j\omega})| = 1.0$) cuya fase introduce un retardo puro fraccionario $d_{\text{frac}} \in [0.0, 1.0]$:

$$y_{\text{ap}}[n] = C \cdot x[n] + x[n-1] - C \cdot y_{\text{ap}}[n-1]$$
$$C = \frac{1 - d_{\text{frac}}}{1 + d_{\text{frac}}}$$

Esto permite una afinación analógica continua con precisión de micro-cents en todo el rango melódico.

---

## 4. Implementación en GenExpr

```javascript
// Kernel Karplus-Strong de alta precisión con Allpass Thiran en GenExpr
Param freq(440.0);
Param damping(0.995);
Data buffer_cuerda(2048); // Buffer circular interno en gen~

History write_idx(0);
History ap_x1(0), ap_y1(0);

// Cálculo de retardo con precisión flotante
delay_samples = (SAMPLERATE / freq) - 0.5;
d_int = floor(delay_samples);
d_frac = delay_samples - d_int;

// Coeficiente Allpass
ap_coef = (1.0 - d_frac) / (1.0 + d_frac);

// Lectura de la muestra demorada
read_idx = (write_idx - d_int + 2048) % 2048;
delayed_sig = peek(buffer_cuerda, read_idx);

// Filtro Todo-Paso para afinar el residuo fraccionario
ap_out = ap_coef * delayed_sig + ap_x1 - ap_coef * ap_y1;
ap_x1 = delayed_sig;
ap_y1 = ap_out;

// Filtro de amortiguación (Loss Filter)
History prev_sample(0);
filtered = (ap_out + prev_sample) * 0.5 * damping;
prev_sample = ap_out;

// Inyección de excitación de entrada (Noise Burst)
injected = in1 + filtered;

// Escritura en el buffer circular
poke(buffer_cuerda, injected, write_idx);
write_idx = (write_idx + 1) % 2048;

out1 = filtered;
```

---

## 5. Escenarios Reales de Producción

1. **Guitarra Acústica de 6 Cuerdas Virtual**: 6 instancias `gen~` Karplus-Strong con filtros de puente acoplados que simulan la transmisión de energía entre cuerdas en la caja armónica.
2. **Modelado de Membrana de Bombo (Tympan)**: Dos waveguides circulares con amortiguación dependiente de la tensión que imitan el parche de cuero de un timbal sinfónico.
3. **Instrumento de Cuerda Frotada (Cello/Violín)**: Inyección continua mediante función no lineal de frotamiento de arco:
   $$\mu(v_{\text{rel}}) = \text{sign}(v_{\text{rel}}) \cdot (|v_{\text{rel}}| + 0.1)^{-0.5}$$
4. **Tubos de Viento (Clarinete/Flauta)**: Guía de onda con reflexión positiva en un extremo y saturador no lineal de caña elástica en la boquilla.

---

## 6. Desafíos de Ingeniería

### Desafío 1: Modulación de Tensión No Lineal (Pitch Glissando Acústico)
En una cuerda real, cuando la amplitud es enorme el camino geométrico se alarga y la tensión sube instantáneamente, elevando la afinación en el ataque. Programá en GenExpr una modulación dinámica de la longitud de retardo dependiente de la energía instantánea del buffer:

$$D(t) = D_0 - k \cdot y[n]^2$$

### Desafío 2: Cuerda Silenciada con Palma (Palm Mute)
Agregá un parámetro `Param mute_damping` que varíe suavemente el filtro de feedback entre el promedio suave ($0.5, 0.5$) y una absorción agresiva ($0.2, 0.8$) para emular el amortiguamiento de la palma de la mano sobre el puente.

### Desafío 3: Acoplamiento de Puente (Sympathetic Resonance)
Diseñá dos módulos de cuerda afinados en $440\text{ Hz}$ y $880\text{ Hz}$ que compartan un $2\%$ de su energía de salida a través de una matriz de mezcla, demostrando cómo excitar la primera hace vibrar automáticamente a la segunda por simpatía armónica.

---

## 7. Laboratorio Práctico: `laboratorio_20_karplus_gen.maxpat`

Abrí el parche de laboratorio para explorar:
- Implementación de Karplus-Strong completo dentro de `gen~` con buffer circular dedicado y filtro de afinación fraccionaria.
- Excitador de impulso por ráfaga de ruido blanco con envolvente exponencial.
- Control cromático afinado mediante teclado MIDI `kslider` y respuesta de sonoridad orgánica en analizador FFT.
