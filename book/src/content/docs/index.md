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

import { Card, CardGrid } from '@astrojs/starlight/components';

## Pilares de la Arquitectura

<CardGrid stagger>
  <Card title="Conceptos sobre Código" icon="seti:graphql">
    Comprensión rigurosa de la computación en tiempo real, el Scheduler determinista, colas de baja prioridad y el Audio Thread antes de interconectar objetos.
  </Card>
  <Card title="Bajo Nivel (C Engine)" icon="seti:c">
    Análisis del motor en C de Cycling '74, estructuras de memoria, punteros a buffers de señal y funciones de procesamiento vectorial SIMD (`perform64`).
  </Card>
  <Card title="Laboratorios sin Clipping" icon="seti:audio">
    Cada lección incluye parches interactivos reproducibles (`.maxpat`) con márgenes de headroom nominal (-12 dB) y limitadores anti-clipping de grado estudio.
  </Card>
  <Card title="Ecosistema de Extensibilidad" icon="puzzle">
    Integración multiplataforma con C++ moderno (Min-DevKit), Shaders en GPU (Jitter), microcontroladores (Arduino), TouchDesigner e Inteligencia Artificial (FluCoMa / nn~).
  </Card>
</CardGrid>

---

## Contenido del Programa

- **Módulo 0:** Prólogo, Arquitectura del Sistema y Configuración del Driver de Audio.
- **Módulo 1:** El Paradigma Dataflow, Orden de Ejecución y el Scheduler Temporal.
- **Módulo 2:** Estructuras de Datos en RAM, Persistencia y Presets (`dict` y `pattr`).
- **Módulo 3:** Procesamiento de Señal Digital y Audio en Tiempo Real (MSP).
- **Módulo 4:** Modularidad, Abstracciones y Computación Paralela Multicore (`poly~`).
- **Módulo 5:** Procesamiento Muestra a Muestra y Compilación JIT (`gen~`).
- **Módulo 6:** Del Patch al Código de Producción (JavaScript, Node for Max y C SDK).
- **Apéndices Especializados:** Computación Visual (Jitter), TouchDesigner, Computación Física (Arduino), C++17 (Min-DevKit), Machine Learning y Audio Espacial 3D.

