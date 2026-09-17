---
title: "Proyecto Integrador 06: Sistema Híbrido Multicapa (JS + N4M + DSP de Alto Rendimiento)"
description: "Proyecto integrador Módulo 6: sistema híbrido multicapa con Node for Max para red asíncrona, JavaScript para lógica generativa y MSP para síntesis DSP de alto rendimiento."
---


Bienvenidos al proyecto cumbre del **Módulo 6**. En este proyecto integramos todas las capas de extensibilidad de Max en una sola arquitectura modular de grado industrial:
1. **Capa de Red Asíncrona (Node for Max)**: Ingesta de telemetría y control remoto mediante API REST / HTTP en un proceso aislado libre de bloqueos.
2. **Capa de Lógica Generativa (JavaScript [js])**: Motor combinatorio de secuencias musicales y permutaciones algorítmicas ejecutadas sincrónicamente en el Scheduler de Max.
3. **Capa de Síntesis DSP Nativa en C (MSP)**: Motor sonoro polifónico desarrollado con el Max C SDK (`mi_objeto_msp~`) con procesamiento de 64 bits en coma flotante y headroom dinámico protegido.

---

## 1. Arquitectura del Sistema: Separación Estricta de Hilos

Para construir sistemas musicales de nivel profesional, el mayor error consiste en sobrecargar un único hilo con tareas dispares. Este proyecto divide las responsabilidades en 3 capas de ejecución independientes:

![FIG 6.4 · End-to-End Hybrid Architecture Pipeline](/assets/diagrams/diagrama_sistema_integrado_sdk.svg)

### 1.1. Capa 1: Ingesta y Red Asíncrona (Node for Max)
- **Tecnología**: Node.js (`servidor_analisis.js`) corriendo como proceso hijo independiente de Max.
- **Protocolo**: Servidor HTTP REST en loopback (`127.0.0.1:3000`) con endpoints `/sensor` y `/health`.
- **Aislamiento de Cuelgues**: Si una petición externa envía un payload malformado o sufre alta latencia, el event loop de `libuv` absorbe la carga sin comprometer el Scheduler de Max ni provocar un solo glitch de audio.

### 1.2. Capa 2: Orquestación Algorítmica (JavaScript Core `[js]`)
- **Tecnología**: Motor SpiderMonkey embebido en Max (`algoritmo_euclidiano.js`).
- **Función**: Recibe las coordenadas y métricas normalizadas del proceso de Node.js y calcula patrones rítmicos euclidianos ($E(k, n)$) en tiempo sincrónico gobernado por el Scheduler de Max.
- **Rampas de Control**: Los parámetros resultantes se envían a generadores de envolvente (`line~`) para evitar transiciones instantáneas que introduzcan artefactos audibles.

### 1.3. Capa 3: Motor Nativo DSP en C (`mi_objeto_msp~`)
- **Tecnología**: Librería compilada en C nativo con vectorización de 64 bits (`perform64`).
- **Garantías de Audio**: Cero llamadas a `malloc()` o bloqueos en el Audio Thread. Las lecturas de wavetable se ejecutan en $O(1)$ con interpolación fraccionaria lineal y protecciones anti-denormales estrictas.

---

## 2. Flujo de Datos End-to-End y Garantías de Estabilidad

```text
[ Cliente Externo / Web ]
           │ HTTP POST /sensor
           ▼
[ Node for Max: servidor_analisis.js ] ── (IPC max-api)
                                                │
                                                ▼
[ JavaScript: algoritmo_euclidiano.js ] ── (Scheduler Events)
                                                │
                                                ▼
[ External C: mi_objeto_msp~ ] ────────── (Audio Thread 64-bit) ──> [ dac~ ]
```

1. **Zero Audio Drops**: La variabilidad de latencia de paquetes de red queda totalmente confinada en el subproceso de Node.js.
2. **Despacho Atómico a la GUI**: Las métricas de pico calculadas en C se transmiten de vuelta al hilo de control mediante `t_qelem`, garantizando que la visualización gráfica jamás interfiera con el cómputo de señal.
3. **Control de Amplitud**: Toda la mezcla pasa por una etapa de saturación suave protegida con un headroom nominal de $-12\text{ dBFS}$.

---

## 3. Laboratorio Práctico del Proyecto: `proyecto_06_sistema_hibrido.maxpat`

Para inspeccionar y poner en marcha el sistema integrado completo:
- Parche ejecutable maestro: [`book/patches/modulo-06/proyecto_06_sistema_hibrido.maxpat`](/patches/modulo-06/proyecto_06_sistema_hibrido.maxpat)
- Código fuente C del external MSP: [`book/patches/modulo-06/mi_objeto_msp.c`](/patches/modulo-06/mi_objeto_msp.c)
- Servidor asíncrono de Node.js: [`book/patches/modulo-06/servidor_analisis.js`](/patches/modulo-06/servidor_analisis.js)
- Módulo algorítmico JavaScript: [`book/patches/modulo-06/algoritmo_euclidiano.js`](/patches/modulo-06/algoritmo_euclidiano.js)

### Instrucciones de Operación:
1. Abrir `proyecto_06_sistema_hibrido.maxpat` y hacer clic en el mensaje `script start` para inicializar el servidor de Node for Max.
2. Activar el motor de audio de Max mediante el botón de encendido (`ezdac~`).
3. Enviar una petición HTTP de prueba desde una terminal:
   ```bash
   curl -X POST http://127.0.0.1:3000/sensor -H "Content-Type: application/json" -d '{"x": 0.8, "y": 0.4, "z": 0.9}'
   ```
4. Observar en la consola y en el osciloscopio cómo los datos de red mutan la distribución rítmica y modulan la síntesis de audio nativa a 48 kHz sin fluctuaciones temporales.
