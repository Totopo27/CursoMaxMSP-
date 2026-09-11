---
title: Referencias Bibliográficas y Tratados Académicos
description: Compendio catalográfico integral de las fuentes primarias, tratados de conservatorio, tesis doctorales y manuales de ingeniería de audio que fundamentan el curso.
---

Este curso fundamenta cada decisión de diseño, algoritmo de procesamiento y paradigma de control en la literatura canónica de la música por computadora, la acústica física, la ingeniería de audio y la investigación académica contemporánea. 

A continuación se presenta el corpus bibliográfico completo (20 obras fundamentales) estructurado en 4 áreas del conocimiento, con sus fichas catalográficas y los módulos del curso donde se integran sus postulados.

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

### David Creasey — *Audio Processes: Musical Analysis, Modification, Synthesis*
- **Editorial:** Routledge (Taylor & Francis Group, London & New York)
- **Año:** 2016 | **Páginas:** 460+ | **ISBN:** 978-1-138-10011-4
- **Aporte al Curso:** Riguroso compendio sobre análisis matemático de señales de audio, síntesis de Fourier, modulación en anillo y en frecuencia, envolventes acústicas y procesamiento dinámico.
- **Módulos Vinculados:** Módulo 3 (Lecciones 03, 04, 05).

### Juan R. Aguilar & Renato Salinas — *New Trends in Sound Synthesis and Automatic Tuning of Electronic Musical Instruments*
- **Publicación:** Revista Facultad de Ingeniería, Universidad de Tarapacá (Chile), Vol. 11 Nº 2
- **Año:** 2003 | **Páginas:** 17–23
- **Aporte al Curso:** Métodos numéricos para la resolución de ecuaciones de onda mediante esquemas en diferencias finitas de cuarto orden en los dominios espacial y temporal, aplicados al modelado físico de cuerdas y membranas percutidas.
- **Módulos Vinculados:** Módulo 5 (Lección 03: Modelado Físico y DSP no lineal en Gen~).

### Sir George Biddell Airy — *On Sound and Atmospheric Vibrations with the Mathematical Elements of Music*
- **Institución:** University of Cambridge / Macmillan and Co. (London & Cambridge)
- **Año:** 1871 | **Páginas:** 308
- **Aporte al Curso:** Tratado histórico fundacional de física ondulatoria clásica. Provee la deducción analítica de la propagación del sonido en medios atmosféricos elásticos, la formación de ondas estacionarias en tubos resonantes y la fundamentación físico-mecánica de los armónicos naturales, estableciendo la base sobre la cual opera todo el muestreo y la síntesis digital.
- **Módulos Vinculados:** Módulo 3 (Lección 01: El Dominio Físico y Matemático del Audio Digital).

---

## 2. Pedagogía de Conservatorio, Tratamiento de Señal y Diseño Sonoro

### Alessandro Cipriani & Maurizio Giri — *Música Electrónica y Diseño Sonoro: Teoría y Práctica con Max 8 (Volumen 1 y Volumen 2)*
- **Editorial:** ConTempoNet (Roma, Italia / Edición en Español e Italiano)
- **Años:** 2013 / 2020 | **Páginas:** 1000+ | **ISBN:** 978-88-99212-17-9
- **Aporte al Curso:** El estándar pedagógico europeo de conservatorio. Establece la metodología sistemática de la síntesis aditiva y sustractiva, la distinción acústica entre parámetros de estado y señales de excitación (inlets fríos vs. calientes), el diseño de envolventes, la gestión de audio multicanal (mc.*) y pautas rigurosas de calibración de ganancia en parches de Max.
- **Módulos Vinculados:** Módulo 0 (Prólogo), Módulo 1 (Dataflow), Módulo 2 (Pattr) y Módulo 3 (Lecciones 01 a 08).

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

### Antonio Grande — *Musica con PD*
- **Institución:** Conservatorio di Musica (Italia)
- **Año:** 2007 | **Páginas:** 147
- **Aporte al Curso:** Enfoque riguroso sobre sintaxis de flujo de datos, sincronización por mensajes y operaciones lógicas fundamentales de control temporal en entornos visuales de síntesis.
- **Módulos Vinculados:** Módulo 1 (Fundamentos Dataflow) y Módulo 2 (Datos).

### Peter Elsea — *The Art and Technique of Electroacoustic Music*
- **Editorial:** A-R Editions, Inc. (Middleton, Wisconsin)
- **Año:** 2013 | **Páginas:** 450+ | **ISBN:** 978-0-89579-741-4
- **Aporte al Curso:** Compendio riguroso de técnicas clásicas de síntesis electroacústica, comportamiento de transitorios, envolventes acústicas y la traducción de conceptos de estudio analógico al dominio digital modular.
- **Módulos Vinculados:** Módulo 3 (DSP y Audio Digital) y Módulo 4 (Polifonía).

---

## 3. Composición Interactiva, Sistemas Musicales y Performance

### Todd Winkler — *Composing Interactive Music: Techniques and Ideas Using Max*
- **Editorial:** The MIT Press (Cambridge, Massachusetts)
- **Año:** 2001 | **Páginas:** 365 | **ISBN:** 978-0-262-73139-3
- **Aporte al Curso:** El clásico absoluto sobre arquitectura de sistemas interactivos en Max. Define la separación epistemológica y computacional entre el módulo de escucha/análisis (*Listener*), el generador de procesos (*Generator*) y el motor de toma de decisiones armónicas/estructurales (*Composer*).
- **Módulos Vinculados:** Módulo 1 (Proyecto Integrador), Módulo 4 (Polifonía y Modularidad) y Apéndice C (Instalaciones Interactivas).

### V.J. Manzo — *Max/MSP/Jitter for Music: A Practical Guide to Developing Interactive Music Systems*
- **Editorial:** Oxford University Press (New York)
- **Año:** 2011 | **Páginas:** 432 | **ISBN:** 978-0-19-977768-6
- **Aporte al Curso:** Guía práctica orientada al desarrollo de herramientas pedagógicas, cuantizadores diatónicos, interfaces modulares de control MIDI y diseño de aplicaciones autónomas interactivas en Max.
- **Módulos Vinculados:** Módulo 1 (Proyecto Integrador) y Módulo 2 (Persistencia con pattr y dict).

### V.J. Manzo & Will Kuhn — *Interactive Composition: Strategies Using Ableton Live and Max for Live*
- **Editorial:** Oxford University Press (New York)
- **Año:** 2015 | **Páginas:** 281 | **ISBN:** 978-0-19-997381-1
- **Aporte al Curso:** Estrategias de composición algorítmica y control por eventos dentro del ecosistema Max for Live (M4L), secuenciadores deterministas y diseño de generadores polirrítmicos.
- **Módulos Vinculados:** Módulo 1 (Proyecto Integrador) y Módulo 4 (Modularidad).

### Geoffrey Kidde — *Learning Music Theory with Logic, Max, and Finale*
- **Editorial:** Routledge / Focal Press (New York & London)
- **Año:** 2015 | **Páginas:** 300+ | **ISBN:** 978-0-415-84244-0
- **Aporte al Curso:** Integración de la teoría musical armónica (escalas diatónicas, modos, conducción de voces e intervalos) con el procesamiento algorítmico de listas simbólicas en Max.
- **Módulos Vinculados:** Módulo 1 (Lección 03: Listas zl y Proyecto Integrador).

---

## 4. Investigación Académica, Composición Algorítmica y Sistemas Multimedia

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

### Patrik Lechner — *Multimedia Programming Using Max/MSP and TouchDesigner*
- **Editorial:** Packt Publishing (Birmingham, UK)
- **Año:** 2014 | **Páginas:** 536 | **ISBN:** 978-1-84969-971-6
- **Aporte al Curso:** Protocolos de comunicación en tiempo real entre Max y TouchDesigner mediante OSC, matrices de textura compartidas en memoria GPU (Spout / Syphon) y diseño de sistemas interactivos audiovisuales.
- **Módulos Vinculados:** Apéndice B (Max y TouchDesigner) y Apéndice A (Jitter).

### Frank Blum — *Digital Interactive Installations: Programming Interactive Installations Using Max/MSP/Jitter*
- **Editorial:** VDM Verlag Dr. Müller (Saarbrücken, Alemania)
- **Año:** 2007 | **Páginas:** 92 | **ISBN:** 978-3-8364-1298-8
- **Aporte al Curso:** Arquitectura de software para instalaciones interactivas de gran escala, procesamiento de sensores físicos, visión artificial por cámara y robustez en entornos de galería y museo.
- **Módulos Vinculados:** Apéndice C (Instalaciones y Arduino) y Apéndice A (Jitter).
---

## 5. Documentación Oficial, Repositorios del Núcleo y SDKs de Cycling '74

### Cycling '74 — *Max Documentation & Reference Manual (Versiones 8 y 9)*
- **Entidad:** Cycling '74 / Ableton (San Francisco, CA & Berlin, Alemania)
- **Recurso:** Documentación Oficial en línea y sistema de ayuda integrado (.maxhelp).
- **Enlace Oficial:** [docs.cycling74.com](https://docs.cycling74.com)
- **Aporte al Curso:** Especificación formal del comportamiento de los objetos nativos, semántica de mensajes, orden de inlets y outlets, atributos de inicialización, gestión del motor de gráficos Jitter y ciclo de vida del Patcher.
- **Módulos Vinculados:** Transversal a todos los módulos y lecciones del curso.

### Cycling '74 — *Max SDK (C API & Headers Reference)*
- **Entidad:** Cycling '74 (San Francisco, California)
- **Repositorio Oficial en GitHub:** [github.com/Cycling74/max-sdk](https://github.com/Cycling74/max-sdk)
- **Aporte al Curso:** El repositorio y juego de cabeceras canónico (ext.h, ext_obex.h, z_dsp.h, jpatcher_api.h). Fundamenta la arquitectura binaria interna: estructuras de memoria (	_object, 	_pxobject, 	_atom, 	_symbol), gestión del Scheduler de alta prioridad, el Audio Thread (perform64) y la creación de objetos externos compilados (.mxe64 / .mxo).
- **Módulos Vinculados:** Módulo 1 (Semántica Dataflow), Módulo 3 (DSP perform64) y Módulo 6 (Lección 03: Anatomía de un External en C).

### Cycling '74 — *Min-DevKit (C++17 Modern SDK Framework)*
- **Entidad:** Cycling '74 / Timothy Place
- **Repositorio Oficial en GitHub:** [github.com/Cycling74/min-devkit](https://github.com/Cycling74/min-devkit)
- **Aporte al Curso:** Framework moderno de desarrollo en C++17 para Max. Introduce metaprogramación con templates, envoltorios de memoria RAII seguros para señales MSP (sample y sample_vector), declaración declarativa de inlets/outlets y compilación multiplataforma automatizada mediante CMake.
- **Módulos Vinculados:** Apéndice D (Min-DevKit C++ Moderno) y Módulo 6.

### Cycling '74 — *Gen Architecture and GenExpr Specification*
- **Entidad:** Cycling '74
- **Recurso:** Especificación técnica del entorno [gen~] y compilador JIT GenExpr.
- **Enlace Oficial:** [docs.cycling74.com](https://docs.cycling74.com)
- **Aporte al Curso:** Especificación de los operadores muestra a muestra, funciones intrínsecas de DSP, resolución de retardos de una sola muestra (history) y exportación automática a código nativo C++ (gen~.translate).
- **Módulos Vinculados:** Módulo 5 (Lecciones 01 a 04).
