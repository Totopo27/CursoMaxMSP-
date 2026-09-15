---
title: "Proyecto Integrador 03: Sintetizador Híbrido FM-Sustractivo con Procesador de Retardo Analógico"
description: "Proyecto integrador Módulo 3: sintetizador FM híbrido de 2 operadores con envolventes anti-click, filtrado dinámico, delay analógico simulado, buffer~ y mezcla estéreo en MSP."
---


> *"Un sintetizador completo no es un agregado aleatorio de objetos DSP: es una arquitectura balanceada donde la generación de armónicos por modulación no lineal, el filtrado dinámico dependiente de la velocidad y el espacio acústico temporal convergen en un único instrumento expresivo."*  
> — **Jean-Claude Risset**, *Computer Music Pioneer*

---

### Objetivos del Proyecto y Criterios de Evaluación
1. **Arquitectura DSP Cohesiva**: Integrar un motor de 2 Operadores FM (Portadora + Moduladora con cálculo de Bessel e Índice $I$), filtrado sustractivo con `[lores~]` / `[svf~]`, y una línea de retardo con modulador Doppler estéreo (`tapin~` / `tapout~`).
2. **Cero Clipping y Rango Dinámico Seguro**: Implementar escalamiento de ganancia con headroom protegido ($-6\text{ dB}$ nominal), rampas de envolvente anti-clic ($\ge 10\text{ ms}$) y limitador de realimentación de delay.
3. **Control Expresivo y Presets**: Control por teclado MIDI virtual (`kslider`), envolventes dedicadas para modulación FM (timbre dinámico) y amplitud general (`adsr~`), integradas con el sistema `pattr` de morphing.
4. **Verificación de Desempeño**: Carga de CPU estable $< 4\%$ en un solo hilo DSP, sin fugas de memoria ni números desnormalizados (*subnormals*).

---

## 1. Diagrama de Arquitectura del Instrumento

![FIG 3.5 · Arquitectura DSP del Sintetizador Híbrido FM-Sustractivo (Proyecto Integrador 03)](/assets/diagrams/diagrama_proyecto_03_arquitectura.svg)

---

## 2. Especificaciones de Ingeniería

### A. Motor de Frecuencia Modulada (FM Engine)
- **Carrier ($f_c$)**: Rango $20\text{ Hz} \dots 5000\text{ Hz}$, derivado de notas MIDI mediante `mtof`.
- **Modulator ($f_m$)**: Calculado como $f_m = f_c \times R_{\text{harmonicity}}$. Presets:
  - $1:1$ (Armónicos naturales completos, timbre de bronce/trompeta).
  - $1:2$ (Armónicos impares predominantes, madera/clarinete).
  - $1:1.414$ (Inarmónico, campana de vidrio/metal).
- **Índice $I(t)$**: Generado por una envolvente `adsr~` secundaria que escala la desviación $\Delta f = f_m \times I(t)$. Al inicio del ataque $I$ sube a valores altos (espectro brillante) y decae junto con la energía física del instrumento.

### B. Sección de Filtrado Dinámico
- Filtro `lores~` de 2 polos colocado en cascada post-FM para esculpir los armónicos superiores y prevenir aliasing por encima de $16\text{ kHz}$.
- Frecuencia de corte base modulada por un LFO suave ($0.2\text{ Hz}$) para otorgar vida analógica al sonido mantenido (*sustain*).

### C. Procesador de Retardo Analógico (Tape Echo & Spatializer)
- Buffer `tapin~` de $2000\text{ ms}$.
- Dos líneas de lectura `tapout~`:
  - Canal Izquierdo: $250\text{ ms}$ modulado suavemente por LFO senoidal ($\pm 3\text{ ms}$).
  - Canal Derecho: $375\text{ ms}$ (tresillo rítmico cruzado).
- Rama de realimentación con amortiguación de frecuencias altas (`lores~ 2000.`) para simular la pérdida inductiva de un cabezal de cinta magnética.
- Ganancia de feedback restringida por interfaz a $0.85$ máximo para garantizar estabilidad matemática asintótica.

---

## 3. Código y Patch: `proyecto_03_sintetizador_fm.maxpat`

El parche interactivo cuenta con:
1. Teclado visual interactivo de 4 octavas y disparo por mensajes de velocidad.
2. Controles rotatorios para Ratio C:M, Timbre Index, Envolventes de Amplitud y Modulación.
3. Conmutador Dry/Wet del Tape Delay con indicador estéreo en osciloscopio y analizador de espectro en tiempo real.
4. Salida estéreo master protegida con fader de ganancia e interruptor DAC libre de artefactos.
