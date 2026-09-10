# Mapeo de Integración Bibliográfica al Curso de Max/MSP

A partir del análisis sistemático y exhaustivo de los textos clave en `referenciasbibliograficas/`, este documento define con precisión **qué conceptos, metodologías y arquitecturas incorporamos de cada autor** a lo largo de los módulos del curso.

---

## 1. Aportes de Todd Winkler (*Composing Interactive Music*, MIT Press)
* **Concepto Clave Incorporado: El Paradigma de los "Composer Objects" vs "Listener Objects".**
  * La mayoría de los cursos enseñan a conectar cables de control al azar. Winkler formaliza una arquitectura limpia:
    1. **Listener Objects:** Objetos que reciben, filtran y extraen métricas del mundo exterior (tempo, densidad de notas, registro armónico).
    2. **Composer Objects:** Objetos de toma de decisión algorítmica que reaccionan a esas métricas (generación condicionada de alturas, variaciones de probabilidad, máscaras de ritmo).
  * **Dónde se aplica:** **Módulo 1 (Proyecto Integrador)** y **Módulo 4 (Modularidad)**.

---

## 2. Aportes de Alessandro Cipriani & Maurizio Giri (*Electronic Music and Sound Design*, Vols. 1 y 2)
* **Concepto Clave Incorporado: El "Contrato Formativo" (Teoría Acústica ➔ Práctica Rigurosa en MSP).**
  * En lugar de decir *"conectá cycle~ a *~"*, Cipriani y Giri demuestran la física del sonido:
    * Relación logarítmica entre frecuencia (Hz) y afinación (MIDI/centésimas).
    * Cálculo exacto de las bandas laterales en modulación de amplitud ($f_c \pm f_m$) y modulación de frecuencia ($I = \Delta f / f_m$).
    * Prevención matemática del aliasing digital según el teorema de Nyquist-Shannon.
    * Diferenciación de filtros IIR vs FIR y diagramas de polos y ceros.
  * **Dónde se aplica:** Todo el **Módulo 3 (MSP & Audio Digital)**.

---

## 3. Aportes de Graham Wakefield & Gregory Taylor (*Generating Sound & Organizing Time*, Cycling '74)
* **Concepto Clave Incorporado: DSP sin Vectores con `[gen~]` y GenExpr.**
  * Cómo pensar a nivel de una sola muestra ($z^{-1}$ / `history`).
  * Construcción de osciladores Phasor no lineales, wavefolders basados en trigonometría y saturadores analógicos virtual-analogue (VA) sin latencia de bloques.
  * **Dónde se aplica:** Exclusivamente en el **Módulo 5 (`gen~`)**, convirtiéndolo en un módulo de nivel internacional sin precedentes.

---

## 4. Aportes de Peter Elsea (*The Art and Technique of Electroacoustic Music*)
* **Concepto Clave Incorporado: Matemáticas Musicales y Curvas Perceptuales.**
  * Escalamiento no lineal de envolventes (curvas exponenciales vs logarítmicas con `[curve~]`).
  * Psicofísica de la percepción del volumen (dBFS vs dB SPL vs curvas de Fletcher-Munson).
  * **Dónde se aplica:** **Módulo 3.4 y 3.6 (Envolventes y Escalamiento)**.

---

## 5. Aportes de V.J. Manzo (*Max/MSP/Jitter for Music* y *Interactive Composition*)
* **Concepto Clave Incorporado: Algoritmos de Armonización y Mapeo Diatónico.**
  * Implementación de tablas de cuantización tonal (`[table]` y `[coll]`) para forzar que cualquier nota generada matemáticamente caiga siempre dentro de la tonalidad/modo deseado (Dórico, Frigio, Mayor, etc.).
  * **Dónde se aplica:** **Módulo 1 (Proyecto Integrador)** y **Módulo 2 (Estructuras de Datos)**.

---

## 6. Aportes de Multimedia con TouchDesigner y Frank Blum
* **Concepto Clave Incorporado: Arquitectura de Red Tolerante a Fallos.**
  * Manejo seguro de puertos UDP/OSC (`[udpsend]` y `[udpreceive]`) para evitar memory leaks o buffers saturados cuando se transmiten 60 paquetes por segundo a otras aplicaciones visuales.
  * **Dónde se aplica:** **Módulo 2.4 (Comunicación Inter-Patch)**.
