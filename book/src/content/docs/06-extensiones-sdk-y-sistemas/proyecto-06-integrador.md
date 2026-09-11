---
title: "Proyecto Integrador 06: Sistema Híbrido Multicapa (JS + N4M + DSP de Alto Rendimiento)"
description: "Capítulo del curso universitario de Max/MSP"
---


Bienvenidos al proyecto cumbre del **Módulo 6**. En este proyecto integramos todas las capas de extensibilidad de Max en una sola arquitectura modular de grado industrial:
1. **Capa de Red Asíncrona (Node for Max)**: Ingesta de telemetría y control remoto mediante API REST / HTTP en un proceso aislado libre de bloqueos.
2. **Capa de Lógica Generativa (JavaScript [js])**: Motor combinatorio de secuencias musicales y permutaciones algorítmicas ejecutadas sincrónicamente en el Scheduler de Max.
3. **Capa de Síntesis DSP (MSP)**: Motor sonoro polifónico protegido con headroom nominal de -12 dB y atenuación anti-clipping estricta.

---

## 1. Arquitectura del Sistema

![FIG 6.4 · End-to-End Hybrid Architecture Pipeline](/assets/diagrams/diagrama_sistema_integrado_sdk.svg)

---

## 2. Flujo de Datos y Garantías de Estabilidad

- **Zero Audio Drops**: La recepción de paquetes de red se aísla en el proceso de Node.js, garantizando que variaciones en la latencia de red no produzcan interrupciones en el Audio Thread de Max.
- **Rampas de Control**: Los cambios de tono generados por el motor JS pasan a través de generadores de línea (`line~`) para asegurar transiciones suaves de al menos 10 ms, impidiendo clicks digitales.
- **Limitación de Amplitud**: Toda la mezcla pasa por un escalador de ganancia nominal antes del conversor estéreo digital (`ezdac~`).
