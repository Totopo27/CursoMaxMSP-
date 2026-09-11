---
title: Referencias Bibliográficas y Tratados Académicos
description: Compendio catalográfico de las fuentes primarias, tratados de conservatorio, tesis doctorales y manuales de ingeniería de audio que fundamentan el curso.
---

Este curso fundamenta cada decisión de diseño, algoritmo de procesamiento y paradigma de control en la literatura canónica de la música por computadora, la acústica física, la ingeniería de audio y la investigación académica contemporánea. 

A continuación se presenta el corpus bibliográfico estructurado por áreas de conocimiento, con sus fichas catalográficas y los módulos del curso donde se integran sus postulados.

---

## 1. Arquitectura de DSP, Síntesis y Computación de Audio (Bajo Nivel)

### Curtis Roads — *The Computer Music Tutorial (Second Edition)*
- **Editorial:** The MIT Press (Cambridge, Massachusetts / London, England)
- **Año:** 2023 | **Páginas:** 1000+ | **ISBN:** 978-0-262-04494-3
- **Aporte al Curso:** Obra cumbre de la disciplina. Fundamenta la teoría formal de acumuladores de fase, interpolación de tablas de ondas (lineal, cúbica y hermite), procesamiento vectorial SIMD (perform64), síntesis por pulsáres (*pulsar synthesis*), síntesis concatenativa y técnicas de *Virtual Analog* sin aliasing.
- **Módulos Vinculados:** Módulo 3 (Lecciones 02, 03, 04), Módulo 5 (Lecciones 01, 04) y Módulo 6 (Lección 03).

### Curtis Roads — *Microsound*
- **Editorial:** The MIT Press (Cambridge, Massachusetts)
- **Año:** 2001 | **Páginas:** 423 | **ISBN:** 978-0-262-18215-7
- **Aporte al Curso:** Tratado fundacional sobre la física y psicoacústica de la escala micro-temporal (1 a 100 ms). Define la descomposición de Gabor, la morfología de envolventes de grano (Gaussiana, Von Hann, Blackman) y la estructuración de *grain streams* continuos y sincrónicos.
- **Módulos Vinculados:** Módulo 3 (Lección 08: Muestras, RAM, Buffers y Granulación) y Módulo 5 (Gen~).

### Graham Wakefield & Gregory Taylor — *Generating Sound & Organizing Time: Thinking with gen~ (Book 1)*
- **Editorial:** Cycling '74 (San Francisco, California)
- **Año:** 2022 | **Páginas:** 300+ | **ISBN:** 978-1-7325903-2-8
- **Aporte al Curso:** El texto definitivo para el diseño de algoritmos DSP muestra a muestra y computación temporal dentro del entorno nativo [gen~]. Aporta patrones de diseño de osciladores no lineales, moduladores complejos, buffers circulares y traducción mental del paradigma de flujo de datos a código compilado JIT.
- **Módulos Vinculados:** Módulo 5 (Lecciones 01, 02, 03, 04 y Proyecto Integrador).

### Juan R. Aguilar & Renato Salinas — *New Trends in Sound Synthesis and Automatic Tuning of Electronic Musical Instruments*
- **Publicación:** Revista Facultad de Ingeniería, Universidad de Tarapacá (Chile), Vol. 11 Nº 2
- **Año:** 2003 | **Páginas:** 17–23
- **Aporte al Curso:** Métodos numéricos para la resolución de ecuaciones de onda mediante esquemas en diferencias finitas de cuarto orden en los dominios espacial y temporal, aplicados al modelado físico de cuerdas y membranas percutidas.
- **Módulos Vinculados:** Módulo 5 (Lección 03: Modelado Físico y DSP no lineal en Gen~).

---

## 2. Pedagogía de Conservatorio, Tratamiento de Señal y Diseño Sonoro

### Alessandro Cipriani & Maurizio Giri — *Música Electrónica y Diseño Sonoro: Teoría y Práctica con Max 8 (Volumen 1)*
- **Editorial:** ConTempoNet (Roma, Italia / Edición en Español)
- **Año:** 2020 | **Páginas:** 550+ | **ISBN:** 978-88-99212-17-9
- **Aporte al Curso:** El estándar pedagógico europeo de conservatorio. Establece la metodología sistemática de la síntesis aditiva y sustractiva, la relación analítica entre frecuencia y pitch, el diseño de envolventes, la gestión de audio multicanal (mc.*) y pautas rigurosas de calibración de ganancia en parches de Max.
- **Módulos Vinculados:** Módulo 0 (Prólogo), Módulo 1 (Dataflow) y Módulo 3 (Lecciones 01, 02, 03, 05).

### Jean-Michel Réveillac — *Musical Sound Effects: Analog and Digital Sound Processing*
- **Editorial:** ISTE Ltd & John Wiley & Sons, Inc. (Hoboken, New Jersey)
- **Año:** 2018 | **Páginas:** 364 | **ISBN:** 978-1-119-46701-4
- **Aporte al Curso:** Tratamiento exhaustivo de ingeniería sobre topologías de procesamiento de efectos analógicos y digitales. Modela matemáticamente filtros biquad, el efecto Doppler y modulación AM en altavoces rotativos (*Leslie*), cancelaciones de fase absoluta en *Thru-Zero Flanging*, y líneas de retardo interpoladas con saturación analógica simulada.
- **Módulos Vinculados:** Módulo 3 (Lecciones 06: Filtrado Digital y 07: Delays, Flanger, Chorus y Comb).

### Francesco Bianchi, Alessandro Cipriani & Maurizio Giri — *Pure Data: Electronic Music and Sound Design (Theory and Practice - Vol. 1)*
- **Editorial:** ConTempoNet (Roma, Italia)
- **Año:** 2020 | **Páginas:** 500+ | **ISBN:** 978-88-992122-1-6
- **Aporte al Curso:** Enfoque comparativo entre Max y Pure Data (desarrollado por Miller Puckette). Aporta ecuaciones matemáticas analíticas explícitas para filtros digitales (lop~, hip~, p~, cf~) y cálculos en diferencias finitas para la arquitectura de procesamiento de audio en tiempo real.
- **Módulos Vinculados:** Módulo 3 (Lección 06: Filtrado Digital) y Módulo 4 (Modularidad).

### Peter Elsea — *The Art and Technique of Electroacoustic Music*
- **Editorial:** A-R Editions, Inc. (Middleton, Wisconsin)
- **Año:** 2013 | **Páginas:** 450+ | **ISBN:** 978-0-89579-741-4
- **Aporte al Curso:** Compendio riguroso de técnicas clásicas de síntesis electroacústica, comportamiento de transitorios, envolventes acústicas y la traducción de conceptos de estudio analógico al dominio digital modular.
- **Módulos Vinculados:** Módulo 3 (DSP y Audio Digital) y Módulo 4 (Polifonía).

---

## 3. Investigación Académica, Composición Algorítmica y Audio Espacial

### Francisco Colasanto — *AMI: Herramienta para la composición algorítmica y clasificación de datos simbólicos*
- **Institución:** Universidad Nacional Autónoma de México (UNAM) / Centro Mexicano para la Música y las Artes Sonoras (CMMAS)
- **Año:** 2025 | **Páginas:** 319 | **ISBN:** 978-607-99502-3-1
- **Aporte al Curso:** Tesis doctoral orientada a la arquitectura de software en Max para la generación algorítmica y clasificación en tiempo real de datos simbólicos (alturas, densidades, dinámicas y duraciones). Define patrones avanzados de matrices de transición, cadenas de Markov y serialización de presets para sistemas musicales complejos.
- **Módulos Vinculados:** Módulo 1 (Lecciones 02, 03), Módulo 2 (Persistencia con dict y coll) y Módulo 6 (JavaScript en Max).

### Oscar Pablo Di Liscia (Compilador) — *Síntesis Espacial de Sonido (Segunda Edición)*
- **Institución:** Universidad Nacional de Quilmes (UNQ) / CMMAS (Morelia, México)
- **Año:** 2018 | **Páginas:** 182 | **ISBN:** 978-607-99502-1-7
- **Aporte al Curso:** El tratado canónico en lengua española sobre espacialización electroacústica. Fundamenta las ecuaciones de codificación Furse/Malham (FuMa) para formato B en primer orden (, X, Y, Z$) y segundo orden (, X, Y, Z, R, S, T, U, V$), y formaliza los algoritmos de decodificación en fase con control de altavoces opuestos (Gordon Monro / Malham) para sistemas pantofónicos (2D) y perifónicos (3D).
- **Módulos Vinculados:** Apéndice F (Audio Espacial y SPAT) y Módulo 3 (Audio Multicanal mc.*).

### Edmar Soria — *Procedural / Sonora: Lo algorítmico y lo procedural en el arte*
- **Institución:** Escuela Nacional de Estudios Superiores (ENES Morelia, UNAM) / CMMAS
- **Año:** 2022 | **Páginas:** 208 | **ISBN:** 978-607-99502-1-7
- **Aporte al Curso:** Fundamentación matemática rigurosa para el arte procedural y la música por computadora: teoría de conjuntos y su transducción al ritmo, teoría de grupos de permutación, variables aleatorias continuas y discretas, dinámica no lineal y la relación con la Tesis de Church-Turing.
- **Módulos Vinculados:** Módulo 1 (Proyecto Integrador) y Módulo 5 (Gen~: Dinámica No Lineal).

### Daniel Quaranta (Coordinador) — *Creación musical, investigación y producción académica*
- **Institución:** Universidade Federal de Juiz de Fora (UFJF, Brasil) / CMMAS
- **Año:** 2021 | **Páginas:** 137
- **Aporte al Curso:** Reflexión crítica sobre la práctica de *live electronics*, la interacción humano-máquina en concierto, el diseño de partituras interactivas y criterios de robustez técnica para obras mixtas.
- **Módulos Vinculados:** Módulo 4 (Modularidad y Concierto) y Apéndice C (Instalaciones Interactivas).

### Scott Wilson, David Cottle & Nick Collins — *The SuperCollider Book (Second Edition)*
- **Editorial:** The MIT Press (Cambridge, Massachusetts)
- **Año:** 2024 | **Páginas:** 1054 | **ISBN:** 978-0-262-04856-9
- **Aporte al Curso:** Análisis comparativo del paradigma computacional. Establece la distinción arquitectónica entre el modelo reactivo guiado por mensajes de Max (Dataflow) frente al motor cliente-servidor basado en grafos de unidades generadoras (scsynth UGens) y la programación Just-In-Time.
- **Módulos Vinculados:** Módulo 1 (Lección 01: Paradigma Dataflow) y Módulo 6 (Node for Max).

### Sir George Biddell Airy — *On Sound and Atmospheric Vibrations with the Mathematical Elements of Music*
- **Institución:** University of Cambridge / Macmillan and Co. (London & Cambridge)
- **Año:** 1871 | **Páginas:** 308
- **Aporte al Curso:** Tratado histórico fundacional de física ondulatoria clásica. Provee la deducción analítica de la propagación del sonido en medios atmosféricos elásticos, la formación de ondas estacionarias en tubos resonantes y la fundamentación físico-mecánica de los armónicos naturales, estableciendo la base sobre la cual opera todo el muestreo y la síntesis digital.
- **Módulos Vinculados:** Módulo 3 (Lección 01: El Dominio Físico y Matemático del Audio Digital).
