# Registro de Referencias Bibliográficas Locales (`referenciasbibliograficas/`)

Este inventario clasifica las obras maestras incorporadas al proyecto, detallando su enfoque pedagógico, su valor técnico y a qué módulo del curso aportarán directamente.

---

## 🏛️ 1. Obras Canónicas de Síntesis y Acústica (Max/MSP Core)

### 📘 *Electronic Music and Sound Design (Vol. 1 y Vol. 2)* — Alessandro Cipriani & Maurizio Giri
* **Archivos:** 
  * `Electronic Music and Sound Design - Theory and Practice with Max_MSP - volume 1.pdf`
  * `pdfcoffee.com_musica-elettronica-e-sound-design-vol-ii-pdf-free.pdf`
* **Valor para el Curso:**
  * **Vol 1:** La base rigurosa de teoría de señales, acústica, síntesis aditiva/sustractiva, modulación de amplitud y sampling en MSP.
  * **Vol 2:** Procesamiento dinámico (compresores, limitadores, gates), líneas de retardo complejas, reverberación, filtros de estado variable y control MIDI avanzado.
* **Módulos Impactados:** **Módulo 1** (Control), **Módulo 2** (Estado) y **Módulo 3** (MSP & Audio Digital).

---

## ⚡ 2. La Biblia del DSP de Muestra por Muestra (`gen~`)

### 📘 *Generating Sound & Organizing Time: Thinking with gen~ Book 1* — Graham Wakefield & Gregory Taylor (Cycling '74)
* **Archivo:** `Generating Sound & Organizing Time_ Thinking with gen~ Book -- Graham Wakefield & Gregory Taylor...mobi`
* **Valor para el Curso:**
  * **La joya de la corona del DSP moderno en Max.** Escrito por los propios diseñadores de `gen~` en Cycling '74.
  * Enseña a programar DSP muestra por muestra sin la latencia de bloques de MSP, utilizando operadores y código textual **GenExpr**.
  * Modelado de osciladores analógicos anti-aliasing, phasors no lineales, wavefolders y filtros con realimentación instantánea ($z^{-1}$).
* **Módulos Impactados:** **Módulo 5** (DSP a Nivel de Muestra con `gen~`).

---

## 🎹 3. Composición Interactiva, Sistemas y Dataflow

### 📘 *Composing Interactive Music: Techniques and Ideas Using Max* — Todd Winkler (The MIT Press)
* **Archivo:** `Composing Interactive Music_ Techniques and Ideas Using Max -- Todd Winkler...pdf`
* **Valor para el Curso:**
  * Un clásico absoluto del MIT Media Lab.
  * Aborda cómo estructurar sistemas musicales que "escuchan" y responden en tiempo real: mapeo de controladores gestuales, algoritmos de probabilidad de notas, cadenas de Markov y seguimiento de partituras/tempo.
* **Módulos Impactados:** **Módulo 1** (Timing & Secuenciación) y **Módulo 4** (Modularidad).

### 📘 *The Art and Technique of Electroacoustic Music* — Peter Elsea
* **Archivo:** `The Art and Technique of Electroacoustic Music (Computer -- Peter Elsea...pdf`
* **Valor para el Curso:**
  * Peter Elsea (pionero de Max en la UC Santa Cruz) desarrolló objetos icónicos de la librería de Max.
  * Explica la teoría electroacústica pura y la síntesis con un nivel de claridad matemática excepcional.
* **Módulos Impactados:** **Módulo 3** (MSP y Síntesis Avanzada).

### 📘 *Interactive Composition: Strategies Using Ableton Live and Max for Live* — V.J. Manzo & Will Kuhn (Oxford University Press)
* **Archivo:** `Interactive Composition _ Strategies Using Ableton Live and -- V_J_ Manzo...pdf`
* **Valor para el Curso:**
  * Puente directo entre Max y producción comercial en Ableton Live (Live Object Model / LOM).
* **Módulos Impactados:** **Módulo 4** (M4L y Control de Dispositivos).

---

## 🌐 4. Multimedia, Jitter e Instalaciones Interactivas

### 📘 *Multimedia Programming Using Max/MSP and TouchDesigner*
* **Archivo:** `Multimedia Programming Using Max_MSP and TouchDesigner.pdf`
* **Valor para el Curso:**
  * Comunicación inter-aplicación en tiempo real: protocolos OSC, Spout/Syphon (compartición de texturas de video en GPU a 60 fps) y WebSockets.
* **Módulos Impactados:** **Módulo 2** (Comunicación) y Módulo Jitter/Video.

### 📘 *Digital Interactive Installations: Programming Interactive Systems Using Max/MSP* — Frank Blum
* **Archivo:** `Digital interactive installations _ programming interactive -- Blum, Frank...pdf`
* **Valor para el Curso:**
  * Arquitectura para sistemas que deben correr 24/7 sin colgarse: robustez, tolerancia a fallos, monitores de latencia y gestión de memoria.
* **Módulos Impactados:** **Módulo 4** y mejores prácticas de producción.

---

## 🎧 5. Procesos de Audio y Teoría de Señales

### 📘 *Audio Processes: Musical Analysis, Modification, Synthesis* — David Creasey (Routledge)
* **Archivo:** `Audio Processes _ Musical Analysis...David Creasey...epub`
* **Valor para el Curso:**
  * Análisis espectral formal, transformada de Fourier (FFT), filtrado digital y análisis psicoacústico.
* **Módulos Impactados:** **Módulo 3.7 y 3.8** (Filtros y Procesamiento Espectral).

### 💾 6. Carpeta de Código y Patches: `DAOCD_Update_2016`
* **Contenido:** Contiene implementaciones reales en `.maxpat`, subpatchers y ejemplos listos para abrir en Max de sistemas interactivos completos.
