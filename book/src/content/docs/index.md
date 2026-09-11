---
title: Max/MSP — Del Concepto al Motor Nativo
description: Curso universitario integral de Max/MSP, MSP Audio, Gen~, C SDK y Sistemas Multimedia.
template: splash
hero:
  tagline: De los fundamentos del paradigma Dataflow y el Scheduler temporal al desarrollo de DSP en C++ y modelos neuronales en tiempo real.
  actions:
    - text: Comenzar con el Módulo 0
      link: /00-prologo/03-audio-driver-windows/
      icon: right-arrow
      variant: primary
    - text: Repositorio en GitHub
      link: https://github.com/Totopo27/CursoMaxMSP-
      icon: github
---

## Pilares de la Arquitectura

<div class="landing-cards-grid not-content">
  <div class="landing-card">
    <div class="card-header">
      <span class="card-badge">01</span>
      <h3>Conceptos sobre Código</h3>
    </div>
    <p>Comprensión rigurosa de la computación en tiempo real, el Scheduler determinista, colas de baja prioridad y el Audio Thread antes de interconectar objetos.</p>
  </div>
  <div class="landing-card">
    <div class="card-header">
      <span class="card-badge">02</span>
      <h3>Bajo Nivel (C Engine)</h3>
    </div>
    <p>Análisis del motor en C de Cycling '74, estructuras de memoria, punteros a buffers de señal y funciones de procesamiento vectorial SIMD (<code>perform64</code>).</p>
  </div>
  <div class="landing-card">
    <div class="card-header">
      <span class="card-badge">03</span>
      <h3>Laboratorios</h3>
    </div>
    <p>Cada lección incluye parches interactivos reproducibles (<code>.maxpat</code>) para comprobar experimentalmente cada concepto en tiempo real.</p>
  </div>
  <div class="landing-card">
    <div class="card-header">
      <span class="card-badge">04</span>
      <h3>Ecosistema de Extensibilidad</h3>
    </div>
    <p>Integración multiplataforma con C++ moderno (Min-DevKit), Shaders en GPU (Jitter), microcontroladores (Arduino), TouchDesigner e Inteligencia Artificial (FluCoMa / nn~).</p>
  </div>
</div>

---

## Contenido del Programa

- [**Módulo 0: Entorno, Interfaz y Flujo de Trabajo**](/00-prologo/01-anatomia-de-la-interfaz-y-modos-de-operacion/) — Anatomía del Patcher, Inspector, Packages, Global Transport y Audio ASIO.
- [**Módulo 1: Fundamentos y Paradigma Dataflow**](/01-fundamentos/01-dataflow-y-inlets/) — Orden de Ejecución, Semántica de Inlets y el Scheduler Temporal.
- [**Módulo 2: Datos, Persistencia y Comunicación**](/02-datos-y-persistencia/01-estructuras-de-datos-y-dict/) — Estructuras en RAM, Presets y Morphing (`dict` y `pattr`).
- [**Módulo 3: El Universo DSP y Audio Digital**](/03-dsp-y-audio-digital/01-signal-vs-control-y-audio-thread/) — Señal vs. Control, Wavetables, Filtros, Delays y Buffers (MSP).
- [**Módulo 4: Abstracciones y Polifonía Avanzada**](/04-polifonia-y-modularidad/01-abstracciones-subparches-y-namespace/) — Modularidad, Subparches y Computación Paralela Multicore (`poly~`).
- [**Módulo 5: Gen~ y DSP de Bajo Nivel**](/05-gen-y-dsp-avanzado/01-gen-paradigma-jit-y-compilacion/) — Procesamiento Muestra a Muestra, GenExpr y Modelado Físico JIT.
- [**Módulo 6: Extensiones, Node for Max y C SDK**](/06-extensiones-sdk-y-sistemas/01-javascript-en-max-js-v8/) — Del Patch al Código Nativo (JavaScript V8, Node for Max y C SDK).
- [**Apéndices Especializados**](/apendices/apendice-a-jitter-matrices-y-jit-gen/) — Computación Visual (Jitter), TouchDesigner, Arduino, Min-DevKit C++, IA y Audio Espacial 3D.
- [**Referencias Bibliográficas y Tratados Académicos**](/referencias-bibliograficas/) — Fuentes primarias, investigación latinoamericana (CMMAS/UNAM/UNQ) y tratados de conservatorio.


