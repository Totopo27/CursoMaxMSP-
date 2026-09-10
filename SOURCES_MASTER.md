# Registro Maestro de Fuentes y Bibliografía Canónica (Max/MSP)

Este documento centraliza todas las fuentes de información primarias, secundarias y de código fuente que alimentan el curso, asegurando una cobertura exhaustiva tanto a nivel de usuario como a nivel de arquitectura interna.

---

## 🌐 1. Ecosistema Oficial Web de Cycling '74

### 1.1 Documentación Activa y Tutoriales
* **Documentación Central:** [docs.cycling74.com](https://docs.cycling74.com/)
  * **User Guide:** Fundamentos de arquitectura, scheduler, audio engine, overdrive, vector sizes.
  * **Object & Operator Reference:** [docs.cycling74.com/reference/](https://docs.cycling74.com/reference/) — API exhaustiva de todos los objetos nativos, atributos, mensajes y tipos admitidos.
  * **Max Tutorial Series:** [docs.cycling74.com/learn/series/max-tutorials/](https://docs.cycling74.com/learn/series/max-tutorials/) — Dataflow, lógica, secuenciación, MIDI y timing.
  * **MSP Tutorial Series:** [docs.cycling74.com/learn/series/msp-tutorials/](https://docs.cycling74.com/learn/series/msp-tutorials/) — Síntesis, sampling, envolventes, filtros y efectos DSP.
  * **Jitter Geometry Series:** [docs.cycling74.com/learn/series/jitter_geometry/](https://docs.cycling74.com/learn/series/jitter_geometry/) — Matrices, geometría 3D y manipulación visual.
  * **Learn Portal General:** [cycling74.com/learn](https://cycling74.com/learn) — Recursos de aprendizaje, proyectos destacados y guías.

### 1.2 Artículos Técnicos y Casos de Estudio
* **Cycling '74 Articles:** [cycling74.com/articles](https://cycling74.com/articles) — Entrevistas a artistas, breakdowns de proyectos de grado profesional, optimizaciones y técnicas avanzadas escritas por desarrolladores y usuarios expertos.

### 1.3 El Ecosistema Moderno y Exportable (RNBO)
* **RNBO Documentation:** [rnbo.cycling74.com](https://rnbo.cycling74.com/)
  * Compilación de patches a C++, WebAssembly (Wasm), plugins VST/AU y hardware embebido (Raspberry Pi).
  * Arquitectura sample-accurate sin overhead de UI.

### 1.4 Documentación Histórica y Legacy
* **Legacy Documentation:** [docs.cycling74.com/legacy/](https://docs.cycling74.com/legacy/)
  * Manuales y tutoriales clásicos de Max 4, 5, 6 y 7.
  * Vital para entender el diseño original de objetos históricos, retrocompatibilidad y decisiones de arquitectura del software.

### 1.5 Videografía Oficial
* **Canal Oficial de YouTube de Cycling '74:** [youtube.com/user/cycling74com](https://www.youtube.com/user/cycling74com)
  * Video tutoriales oficiales, demostraciones de nuevas versiones, webinars y masterclasses.

---

## 💻 2. Fuentes de Código Fuente y Arquitectura Interna (Bajo el Capó)

* **Cycling '74 Max SDK:** [github.com/Cycling74/max-sdk](https://github.com/Cycling74/max-sdk) *(Clonado localmente en `sources/max-sdk/`)*
  * Código fuente C de ejemplos oficiales:
    * `basics/plus/plus.c`: Inlets fríos vs calientes, gestión de estructuras en C.
    * `basics/simplethread/`: Multihilo y llamadas al hilo principal con `qelem`.
    * `audio/delay~/delay~.c`: Memoria circular, rutinas de procesamiento de audio en 64 bits (`perform64`).
    * `dictionary/`: Manejo e intercambio interno de JSON.
* **Cycling '74 Min-DevKit:** [cycling74.github.io/min-devkit/](https://cycling74.github.io/min-devkit/) — Framework moderno en C++17 para escribir objetos con metaprogramación y lambdas.
* **Pure Data (Miller Puckette):** Referencia comparativa de código abierto sobre dataflow en tiempo real.

---

## 📖 3. Bibliografía Académica y Tratados Canónicos

* **"Electronic Music and Sound Design" (Vols. 1, 2 y 3) — Alessandro Cipriani & Maurizio Giri:**
  * Fundamento teórico de acústica, matemáticas del audio digital, síntesis interactiva y diseño de sistemas complejos en Max.
* **"The Theory and Technique of Electronic Music" — Miller Puckette:**
  * La teoría matemática y computacional pura detrás de la modulación, delays, filtros y síntesis espectral por el creador original de Max.
* **"Designing Sound" — Andy Farnell:**
  * Principios de síntesis procedural de sonido (ideal para proyectos del curso).

---

## ⚙️ 4. Estrategia de Ingesta Automatizada (Pipeline)

| Módulo de Ingesta | Destino | Herramienta | Contenido Extraído |
| :--- | :--- | :--- | :--- |
| `crawler_tutorials.ts` | `sources/official_docs/tutorials/` | Playwright / Next.js JSON parser | Artículos paso a paso, diagramas de patches, referencias a videos. |
| `crawler_reference.ts` | `sources/official_docs/reference/` | Playwright / XML | Ficha técnica de objetos, argumentos, mensajes, atributos. |
| `extract_sdk.ts` | `sources/internal_sdk/` | Node.js File System Parser | Explicaciones en C de threads, memoria, inlets y audio DSP. |
| `transcribe_videos.ts` | `sources/official_docs/transcripts/` | YouTube Data API / Transcript extract | Subtítulos y transcripciones de los tutoriales en video clave. |
