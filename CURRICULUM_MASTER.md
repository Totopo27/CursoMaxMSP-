# Malla Curricular: Max/MSP — Del Concepto al Motor Nativo
> *Inspirado en la profundidad y rigor de `rust-course` (course.rs)*

---

## 🎯 Filosofía del Curso
1. **Conceptos > Código:** Entender la computación en tiempo real y el flujo de datos antes de conectar cables al azar.
2. **Bajo el Capó:** Cada módulo conecta la interfaz gráfica de Max con la arquitectura del motor en C (vía `Cycling74/max-sdk`).
3. **Práctica Rigurosa:** Cada lección cuenta con patches `.maxpat` reproducibles, ejercicios de debugging y proyectos finales de módulo.

---

## 📚 Estructura de Módulos (Índice Maestro)

### MÓDULO 0: Prólogo e Instalación del Entorno
* **0.1** ¿Qué es Max/MSP? Historia, filosofía de Dataflow y paradigmas.
* **0.2** Configuración del entorno de trabajo: Max 8/9, extensiones, packages y herramientas.
* **0.3** Anatomía del formato de archivo: Leyendo un `.maxpat` como lo que es: un JSON estructurado.

---

### MÓDULO 1: El Paradigma Dataflow y el Motor de Eventos (Max Core)
* **1.1** Inlets Fríos vs. Inlets Calientes: La regla de oro y su correlato en C (`x->val` vs ejecución).
* **1.2** Orden de Ejecución: La regla de "Derecha a Izquierda, Abajo hacia Arriba" y el rol salvador de `[trigger]`.
* **1.3** Tipos de Datos (Los Átomos de Max): `bang`, `int`, `float`, `symbol` (tabla hash de símbolos) y `list`.
* **1.4** El Scheduler de Max: Eventos discretos, Overdrive, Priority Threads y la cola `qelem`.
* **1.5** Timing y Relojes: `[metro]`, `[delay]`, `[pipe]`, `[tempo]`. Errores comunes de sincronización.
* **1.6** Manipulación avanzada de listas y datos con `[zl]`.
* **🧪 Proyecto Módulo 1:** Construcción de un secuenciador por pasos polirrítmico robusto y determinista.

---

### MÓDULO 2: Estructuras de Datos y Persistencia
* **2.1** Almacenamiento en memoria: `[value]`, `[table]`, `[coll]`.
* **2.2** El estándar moderno: Árboles y diccionarios con `[dict]` (manipulación de JSON en tiempo real).
* **2.3** Gestión de presets y estado: El ecosistema `[pattr]`, `[pattrstorage]` y preset interpolation.
* **2.4** Comunicación inter-patch sin cables: `[send]`/`[receive]`, `[forward]`, `[value]`.
* **🧪 Proyecto Módulo 2:** Motor de presets jerárquico con morphing de parámetros por interpolación.

---

### MÓDULO 3: El Universo DSP y Audio Digital (MSP)
* **3.1** Señal vs Control: ¿Por qué existe la tilde (`~`)? De eventos discretos a 48,000 muestras por segundo.
* **3.2** Anatomía del Audio Thread: Vector Size (I/O vs Signal Vector), latencia y la función `perform64` en C.
* **3.3** Generación de Señales Básicas: `[cycle~]`, `[phasor~]`, `[saw~]`, `[noise~]`.
* **3.4** Aritmética de Audio y Señales de Control: Escalamiento con `[scale~]`, sumadores, multiplicadores y moduladores de amplitud (Ring Mod / AM).
* **3.5** Modulación de Frecuencia (FM) y Síntesis por Fase (`[cos~]`, `[phasor~]`).
* **3.6** Envolventes y Control de Amplitud: `[line~]`, `[curve~]`, `[adsr~]`. Por qué los clicks ocurren y cómo eliminarlos con interpolación.
* **3.7** Filtrado Digital: Filtros biquad, `[lores~]`, `[svf~]`, polos, ceros y respuesta en frecuencia.
* **3.8** Delays, Buffers y Modulación Temporal: `[tapin~]`, `[tapout~]`, `[comb~]`, Flangers, Chorus y Feedback loops.
* **3.9** Manejo de Muestras en RAM: `[buffer~]`, `[play~]`, `[groove~]`, `[wave~]` y windowing.
* **🧪 Proyecto Módulo 3:** Sintetizador FM híbrido completo de 2 operadores con efectos de modulación temporal y delay analógico simulado.

---

### MÓDULO 4: Arquitectura Modular y Polifonía
* **4.1** Subpatchers (`[p]`) vs Abstracciones: Reutilización de código y argumentos dinámicos (`#1`, `#2`).
* **4.2** Interfaces gráficas reutilizables con `[bpatcher]`.
* **4.3** Polifonía escalable con `[poly~]`: Voice allocation, voice stealing, mensajes `target` y `midievent`.
* **4.4** Multiprocesamiento real: El atributo `@parallel 1` en `[poly~]` y cómo balancear la carga de CPU entre núcleos.
* **🧪 Proyecto Módulo 4:** Sintetizador polifónico de 8 voces con multihilo real y control MPE (MIDI Polyphonic Expression).

---

### MÓDULO 5: DSP a Nivel de Muestra (El Mundo de `gen~`)
* **5.1** La limitación del Vector Processing en MSP y la solución de `[gen~]`.
* **5.2** GenExpr: Programación textual de DSP dentro de Max.
* **5.3** Creación de osciladores Anti-Aliasing (Band-Limited Waveforms) con `[gen~]`.
* **5.4** Filtros no lineales y modelos analógicos: Saturación, Wavefolding y Oversampling.
* **🧪 Proyecto Módulo 5:** Filtro ladder virtual-analógico (Moog style) con resonancia no lineal en `[gen~]`.

---

### MÓDULO 6: Del Patch al Código Nativo (Max SDK & Min-DevKit)
* **6.1** Anatomía de un External en C/C++: El ciclo de vida (`main()`, `new()`, `free()`).
* **6.2** Compilación con CMake y Visual Studio / Xcode usando `Cycling74/max-sdk`.
* **6.3** Creando un objeto de control: Registro de métodos y manejo de inlets fríos/calientes.
* **6.4** Creando un objeto MSP: La rutina de audio `perform64` en C.
* **6.5** C++ Moderno con Min-DevKit: Atributos declarativos y lambdas.
* **🧪 Proyecto Módulo 6:** Compilación de un plugin external propio en C++ integrado y funcionando en Max.

---

### APÉNDICES ESPECIALIZADOS DE ALTO RENDIMIENTO
* **Apéndice A:** Computación Visual y Espacial: Jitter, Matrices $N$-dimensionales, Shaders y `jit.gen`.
* **Apéndice B:** Interoperabilidad Multimedia: Max/MSP y TouchDesigner (Spout GPU de Cero Latencia y OSC sobre UDP).
* **Apéndice C:** Computación Física: Arduino, Sensores e Instalaciones Interactivas 24/7 (Lectura Serial a 115200 baudios).
* **Apéndice D:** Desarrollo en C++ Moderno con Min-DevKit (C++17 Declarativo, Lambdas y Metaprogramación).
* **Apéndice E:** Inteligencia Artificial y Machine Learning en Max (`FluCoMa` y Deep Learning con `nn~` / RAVE).
* **Apéndice F:** Espacialización Sonora y Audio Inmersivo 3D (`IRCAM Spat5`, Ambisonics HOA y VBAP).

---

## 🛠️ Arquitectura Técnica del Proyecto

```
CursoMaxMSP/
├── book/                  # Sitio Web Estático (Astro Starlight)
│   ├── src/content/docs/  # Capítulos en Markdown / MDX
│   └── public/patches/    # Parches .maxpat descargables por lección
├── sources/               # Fuentes de conocimiento
│   └── max-sdk/           # Submódulo del repositorio oficial Cycling74/max-sdk
├── pipeline/              # Automatización y Scraping
│   ├── scripts/
│   │   ├── extract_sdk.ts # Lee headers y ejemplos C del SDK
│   │   └── crawler.ts     # Playwright para tutoriales y diagramas web
│   └── raw_corpus/        # JSON intermedio con la metadata procesada
└── package.json           # Dependencias del proyecto
```
