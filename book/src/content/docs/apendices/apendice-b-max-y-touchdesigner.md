---
title: "Apéndice B: Interoperabilidad Multimedia: Max/MSP y TouchDesigner"
description: "Interoperabilidad Max/MSP y TouchDesigner: integración GPU por Spout de cero latencia, protocolo OSC sobre UDP y arquitecturas multimedia de bajo latencia multiproceso."
---


En la industria de las artes electrónicas, escenografía interactiva e instalaciones a gran escala, la arquitectura más potente consiste en dividir especialidades:
- **Max/MSP**: Como el cerebro central de computación de audio, sincronización rítmica, secuenciación determinista e interfaz con hardware analógico.
- **TouchDesigner (Derivative)**: Como el motor gráfico hiper-escalable de renderizado 3D en tiempo real, mapeo de proyección (*video projection mapping*), shaders complejos y control de pantallas LED masivas.

La comunicación entre ambos entornos debe ser robusta, determinista y de **latencia ultrabaja**. En este apéndice abordamos los dos protocolos estándares de la industria: **Spout (Windows) / Syphon (macOS)** para intercambio de video directo en memoria de video (VRAM), y **OSC (Open Sound Control)** sobre UDP para telemetría de control de alta velocidad.

*(Fundamentado en Frank Blum, *Digital Interactive Installations*, y Derivative TouchDesigner Architecture).*

---

## 1. El Puente de Texturas en GPU: Spout y Syphon (Zero-Copy)

El mayor error de diseño para conectar Max con TouchDesigner es intentar transmitir frames de video por la red local o por el bus PCIe entre CPU y GPU. La solución profesional es el **intercambio directo de texturas en VRAM (Zero-Copy GPU Sharing)**:

![FIG B.1 · Max/MSP + TouchDesigner VRAM Bridge](/assets/diagrams/diagrama_spout_touchdesigner.svg)

### 1.1. Ventajas Arquitectónicas
1. **Zero-Copy Overhead**: Los píxeles jamás bajan a la memoria RAM del sistema operativo. Un frame 4K ($3840 \times 2160$ a 60 fps) se comparte instantáneamente mediante un puntero compartido de DirectX/Metal (`ID3D11Texture2D`) sin consumir ancho de banda de la CPU.
2. **Latencia Sub-Frame**: Menor a 1 milisegundo entre el renderizado en Max y la recepción en TouchDesigner.
3. **Mapeo de Datos No Visuales**: Además de video RGB, podemos enviar **nubes de puntos 3D (*Point Clouds*)** o matrices de audio FFT codificadas en texturas de 32 bits en coma flotante (`RGBA32F`), permitiendo que shaders GLSL en TouchDesigner deformen millones de partículas impulsadas por el análisis espectral de Max.

---

## 2. Telemetría de Control de Alta Velocidad: Open Sound Control (OSC)

Mientras que Spout mueve texturas pesadas por VRAM, **OSC sobre paquetes UDP** transmite el control gestual, disparos rítmicos y parámetros musicales:

![FIG B.2 · Flujo de Telemetría y Control OSC sobre UDP hacia TouchDesigner](/assets/diagrams/diagrama_osc_touchdesigner_pipeline.svg)

### 2.1. Prácticas Profesionales de Enrutamiento OSC
- **Namespaces Jerárquicos**: Utilizá convenciones RESTful (`/audio/track1/volume`, `/audio/master/rms`, `/sensor/touch/state`).
- **Empaquetado (Bundles)**: En lugar de enviar 100 mensajes individuales por frame, agrupá los parámetros en un `OSC Bundle` mediante `[OpenSoundControl]` para garantizar que todos los valores se actualicen en TouchDesigner en el mismo cuadro exacto (*atomic updates*).
- **Puertos UDP**: Puerto 9000 (Max a TouchDesigner) y Puerto 9001 (TouchDesigner a Max para retroalimentación).

---

## 3. El Problema del Desacoplamiento de Relojes (*Frame-Locking*)

Un desafío crítico que la literatura de principiantes ignora es el **desfase de tasas temporales**:
- Max procesa audio a $48.000\text{ Hz}$ y puede emitir paquetes OSC con un `[metro]` a $50\text{ Hz}$ ($20\text{ ms}$).
- TouchDesigner renderiza imágenes a $60\text{ Hz}$ ($16.66\text{ ms}$) o $120\text{ Hz}$ ($8.33\text{ ms}$).

Esta disparidad produce **aliasing temporal (jitter visual)**: en algunos frames de video TouchDesigner recibe dos paquetes OSC y en otros ninguno, provocando animaciones espasmódicas.

### Acondicionamiento de Señal en TouchDesigner (Familia CHOP):
1. **`Lag CHOP`**: Introduce una inercia exponencial calibrada (tiempos de ataque y decaimiento de 10 a 50 ms) para suavizar saltos bruscos.
2. **`Filter CHOP`**: Aplica un filtro IIR paso-bajos o interpolación cúbica (Box, Gaussian) para reconstruir una trayectoria espacial continua en tiempo real.
3. **`Resample CHOP`**: Sincroniza la tasa de muestreo entrante a la frecuencia exacta del renderizador visual ($60\text{ Hz}$), alineando la telemetría con el refresco de pantalla (*V-Sync*).

---

## 4. Laboratorio Práctico: Puente Max a TouchDesigner

En el parche interactivo [`book/patches/apendices/lab_apendice_b_touchdesigner.maxpat`](/patches/apendices/lab_apendice_b_touchdesigner.maxpat):
- Generamos un flujo de control OSC sincronizado con BPM de audio que transmite frecuencias dominantes, transitorios de percusión y energía RMS.
- Preparamos el emisor `udpsend` configurado a `127.0.0.1:9000`.
- Configuramos un contexto Jitter con `jit.gl.spoutsender` para emitir video a TouchDesigner.
- Documentamos la configuración paso a paso del operador `OSC In CHOP` y `Spout In TOP` en TouchDesigner.
