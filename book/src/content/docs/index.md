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
    - text: Ver Repositorio en GitHub
      link: https://github.com/Cycling74/max-sdk
      icon: external
---

## 🎯 Pilares del Curso

### 1. Conceptos > Código
Entender en profundidad la arquitectura de memoria, los árboles de precedencia, el Scheduler y el hilo de audio en tiempo real antes de conectar cables al azar.

### 2. Bajo el Capó (Bajo Nivel)
Cada objeto de Max (`cycle~`, `poly~`, `dict`, `gen~`) se desmitifica analizando cómo opera la memoria en C, los structs de estado de Cycling '74 y la computación vectorial SIMD.

### 3. Laboratorios Interactivos Funcionales
Cada lección cuenta con su propio parche interactivo descargable (`.maxpat`) con protecciones acústicas anti-clipping de grado profesional.

---

## 📚 Estructura de Módulos

- **Módulo 0:** Prólogo, Instalación y Configuración del Entorno de Audio.
- **Módulo 1:** El Paradigma Dataflow y el Motor de Eventos (Max Core).
- **Módulo 2:** Estructuras de Datos, Persistencia y Presets (`dict` y `pattr`).
- **Módulo 3:** El Universo DSP y Audio Digital (MSP).
- **Módulo 4:** Modularidad, Abstracciones y Polifonía Avanzada (`poly~`).
- **Módulo 5:** DSP a Nivel de Muestra (`gen~` y GenExpr).
- **Módulo 6:** Del Patch al Código Nativo (JavaScript, Node for Max y C SDK).
- **Apéndices Especializados:** Jitter 3D, TouchDesigner, Arduino/Instalaciones, Min-DevKit, IA (FluCoMa/nn~) y Audio Espacial 3D (Spat5/Ambisonics).
