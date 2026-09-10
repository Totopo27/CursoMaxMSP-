# Mapeo Integral de Libros Electrónicos (EPUB / MOBI) al Curso de Max/MSP

Este documento complementa el análisis de los PDFs incorporando la disección de los archivos `.epub` y `.mobi` de `referenciasbibliograficas/`.

---

## 1. *Learning Music Theory with Logic, Max, and Finale* — Geoffrey Kidde (Routledge, 2020)
* **Formato:** EPUB (432 archivos internos, 60 capítulos y secciones).
* **El Enfoque Pedagógico del Libro:**
  * Enseña la **teoría musical formal** (tempo, compases compuestos, síncopas, intervalos diatónicos/cromáticos, tríadas, acordes con séptima y tensiones armónicas) no mediante partituras secas, sino **construyendo algoritmos interactivos en Max**.
* **Patches de Max Analizados en el Libro:**
  * `Max Patcher 0`: Ruteo MIDI entre aplicaciones con `[midiin]`, `[midiout]`, `[send]` y `[receive]`.
  * `Max Patcher 1 (Drum Pattern)`: Secuenciador rítmico con duraciones de notas, notas con puntillo y tresillos.
  * `Max Patcher 2 (Rhythm Generator)`: Generador de polirritmias, tuplas anidadas y modulación métrica.
  * `Max Patcher 4 & 5 (Pitch & Scale Generator)`: Generador de escalas diatónicas y modos modernos (Dórico, Frigio, Lidio, Mixolidio) mediante matemáticas de semitonos.
  * `Max Patcher 6 (Interval Identifier)`: Analizador de intervalos musicales a partir de dos notas MIDI entrantes.
* **Aporte Crítico para el Curso:**
  * **Módulo 1 (Secuenciación y Proyecto Integrador):** Adoptamos la metodología de Kidde para el motor de generación musical. El alumno no solo aprende qué es un `[metro]` o un `[%]`, sino cómo construir un secuenciador rítmico que entiende figuras musicales (negras, corcheas, tresillos) y genera progresiones armónicas coherentes.

---

## 2. *Audio Processes: Musical Analysis, Modification, Synthesis* — David Creasey (Routledge, 2017)
* **Formato:** EPUB (960 archivos internos, tratado enciclopédico de audio digital).
* **El Enfoque Pedagógico del Libro:**
  * Puente entre la **acústica física, el cálculo numérico y los algoritmos en tiempo real**.
  * Desglosa de forma milimétrica:
    * **Dominio del Tiempo:** Análisis de envolventes de instrumentos acústicos reales (oboe, piano, campanas tubulares, consonantes vocálicas) para replicarlas en sintetizadores.
    * **Dominio de la Frecuencia:** Descomposición espectral por sinusoides, análisis FFT tridimensional (tiempo, frecuencia y amplitud en espectrogramas).
    * **Modulación Periódica:** Diferenciación matemática estricta entre *Tremolo* (AM), *Autopan*, *Vibrato* (modulación de delay time), *Flanger*, *Phaser* y *Chorus*.
* **Aporte Crítico para el Curso:**
  * **Módulo 3 (MSP & Audio Digital):** Incorporamos los datos acústicos reales de Creasey para el diseño de filtros y la modelación de instrumentos en MSP.
  * **Módulo 3.8 (Efectos de Modulación y Delays):** Tabla de diseño matemático para construir efectos de modulación temporal (Flanger/Chorus/Phaser) con los offsets de milisegundos exactos que propone el autor.

---

## 3. *Generating Sound & Organizing Time: Thinking with gen~ Book 1* — Graham Wakefield & Gregory Taylor (Cycling '74, 2022)
* **Formato:** MOBI (35.01 MB, la obra cumbre de los desarrolladores de Max).
* **El Enfoque Pedagógico del Libro:**
  * La transición mental de **"Bloques de audio en MSP"** a **"Muestra a Muestra en `gen~`"**.
  * Desglose de operadores fundamentales: `history` ($z^{-1}$), `delta`, `accum`, `phasor`, `sah` (Sample and Hold), `wrap`, `clip`, `train`.
  * Creación de osciladores no lineales (Triangle, Sawtooth, Pulse) sin aliasing, modelando el reset de fase y la integración numérica.
  * Bucles de retroalimentación (*feedback loops*) que en MSP requieren un buffer de 64 muestras, pero en `gen~` tienen latencia cero (1 sola muestra de retardo).
* **Aporte Crítico para el Curso:**
  * **Módulo 5 (`gen~`):** Estructurado 100% en base a los principios de Wakefield y Taylor. Este módulo colocará al estudiante en el nivel más avanzado de desarrollo DSP dentro del ecosistema de Cycling '74.
