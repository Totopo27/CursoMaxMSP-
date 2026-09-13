---
title: "Proyecto Integrador 05: Sintetizador de Modelado Físico Digital en Gen~ (Guía de Onda / Waveguide Mesh)"
description: "Capítulo del curso de Max/MSP"
---


Bienvenidos al proyecto cumbre del **Módulo 5**. Aquí abandonamos definitivamente las limitaciones del procesamiento por bloques vectoriales ($N = 64$) de MSP y consolidamos la potencia del paradigma JIT de `gen~`.

Diseñaremos e implementaremos un **Sintetizador Acústico de Modelado Físico basado en Guías de Onda Digitales Bidireccionales (Digital Waveguides - Smith 1992)** acoplado a un resonador no lineal tipo excitador de caña / arco con dispersión dependiente de la frecuencia.

---

## 1. Especificación Teórica y Arquitectura Física

Una guía de onda acústica unidimensional (como una cuerda o tubo de aire cilíndrico) modela la ecuación de onda de D'Alembert resolviendo la propagación de dos ondas viajeras en direcciones opuestas:

$$\psi(x, t) = \psi^+(t - x/c) + \psi^-(t + x/c)$$

En tiempo discreto, esto se sintetiza mediante dos líneas de retardo acopladas con reflexión en los extremos, filtros de dispersión y pérdidas de energía acústica:

![FIG 5.2 · Karplus-Strong Extendido & Bucle No Lineal](/assets/diagrams/diagrama_waveguide_gen.svg)

### 1.1. Los Módulos del Algoritmo en GenExpr

1. **Excitador (Pluck / Bow / Strike)**:
   - Disparo impulsivo generado mediante derivación de un pulso rectangular o ráfaga de ruido blanco con envolvente exponencial ultra-rápida.
2. **Línea de Retardo Fraccional**:
   - Para afinar la cuerda a notas musicales exactas (afinación por temperamento igual o microtonal), el retardo debe admitir números no enteros de muestras:
     $$D = \frac{f_s}{f_0} - \Delta_{filtros}$$
   - Implementado en `gen~` mediante el operador `delay` con interpolación `spline` o `linear`.
3. **Filtro de Pérdidas de Alta Frecuencia (Loss Filter)**:
   - La disipación del aire y la fricción interna de los materiales atenúan los armónicos agudos más rápido que los graves. Un filtro FIR de un polo o promedio de dos puntos $y[n] = 0.5 (x[n] + x[n-1])$ modela esta física.
4. **Dispersión por Rigidez (Stiffness Allpass Filter)**:
   - En cuerdas de piano o barras de metal reales, las frecuencias más altas viajan más rápido que las fundamentales. Un filtro Allpass de primer orden en el bucle introduce un retardo de grupo dependiente de la frecuencia, produciendo la inarmonicidad metálica característica.

---

## 2. Código GenExpr Completo del Resonador (`waveguide_core`)

Fijate en la elegancia del código fuente GenExpr que compilará el núcleo JIT:

```javascript
// Parámetros accesibles desde Max
Param freq(220, min=20, max=5000);
Param damping(0.985, min=0.5, max=0.9999);
Param brightness(0.5, min=0.01, max=0.99);
Param stiffness(0.2, min=-0.8, max=0.8);
Param pickup_pos(0.3, min=0.05, max=0.95);

// Registros de retroalimentación de muestra unitaria
History d_right_hist(0);
History d_left_hist(0);
History loss_hist(0);
History ap_x1(0);
History ap_y1(0);

// Entrada 1: Señal de excitación (plucked impulse o arco)
in_signal = in1;

// Cálculo del retardo total en muestras según la frecuencia fundamental
sr = samplerate();
period_samples = sr / freq;

// Reservamos delay lines fraccionales
// Usamos operador delay con interpolación spline (4 muestras)
delay_len = max(2, period_samples * 0.5);

// Propagación hacia adelante
right_wave = delay(in_signal + d_left_hist, delay_len, interp="spline");

// Reflexión y filtro de pérdidas en extremo derecho
loss_filter = right_wave * (1 - brightness) + loss_hist * brightness;
loss_hist = loss_filter;

// Allpass de dispersión (rigidez de la cuerda)
// H(z) = (stiffness + z^-1) / (1 + stiffness * z^-1)
ap_in = loss_filter * damping;
ap_out = (ap_in * stiffness) + ap_x1 - (stiffness * ap_y1);
ap_x1 = ap_in;
ap_y1 = ap_out;

// Propagación hacia atrás con inversión de fase (reflexión rígida)
left_wave = delay(-ap_out, delay_len, interp="spline");

// Inyección al registro de historia con saturación analógica suave
d_right_hist = right_wave;
d_left_hist = tanh(left_wave);

// Pick-up posicional: sumamos la onda izquierda y derecha en un punto del espacio
out1 = (right_wave * pickup_pos) + (left_wave * (1 - pickup_pos));
out2 = (right_wave * (1 - pickup_pos)) + (left_wave * pickup_pos);
```

---

## 3. Parche de Control Max y Protocolo Anti-Clipping

El parche principal `proyecto_05_waveguide_gen.maxpat`:
- Genera el pulso de excitación libre de DC.
- Convierte frecuencias MIDI a valores hercios con redondeo seguro.
- Protege la salida acústica con atenuación de -12 dB y limitador de picos suave `peakamp~` / `atan`.
- Brinda interfaz gráfica intuitiva con controles deslizantes para cambiar rigidez, brillo, amortiguación y posición de micrófono.
