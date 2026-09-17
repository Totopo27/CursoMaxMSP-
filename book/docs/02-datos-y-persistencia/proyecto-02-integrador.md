---
title: "Proyecto Integrador 2: Motor de Presets Jerárquico con Morphing por Interpolación Multidimensional"
description: "Proyecto integrador Módulo 2: motor de presets jerárquico con morphing por interpolación multidimensional, serialización JSON con [dict] y recuperación determinista de estados complejos."
---


> *"Un sintetizador profesional no es solo un conjunto de osciladores y filtros; es un gestor de estados capaz de viajar fluidamente por un hiperespacio de timbres sin artefactos, caídas de audio ni saltos espurios."*

---

## 1. Visión y Objetivos del Proyecto

Este proyecto corona el **Módulo 2 (Estructuras de Datos, Persistencia y Comunicación Remota)**, sintetizando en un sistema de producción real todos los pilares arquitectónicos aprendidos:
1. **Persistencia Estructurada con `[dict]`:** Almacenamiento jerárquico de metadatos de sesión (autor, BPM, clave de escala, comentarios) exportables a archivos JSON estándar.
2. **Espacio de Estados Continuo con `[pattrstorage]`:** Almacenamiento y recuperación instantánea de snapshots tímbricos para un motor sonoro completo.
3. **Morphing Multidimensional Fluido:** 
   - Transiciones temporales lineales programadas (`recall A B duracion_ms`).
   - Navegación espacial 2D continua con `[nodes]` (`recall multi`), interpolando los pesos de 4 presets en tiempo real.
4. **Desacoplamiento UI sin Cables:** Uso riguroso de `[autopattr]` con *Scripting Names* para vincular controles sin polución de cables ("Zero Spaghetti").
5. **Comunicación Remota Limpia:** Uso de `[forward]` para ruteo dinámico de señales de control y un bus global de seguridad (`[send global_panic]`).
6. **Motor DSP Polifónico / Multi-modo Integrado:** Un sintetizador de síntesis sustractiva/FM con filtro resonante y envolvente percusiva para escuchar el morphing tímbrico en tiempo real con headroom anti-clipping garantizado.

---

##  2. Diagrama de Arquitectura del Sistema

![FIG 2.4 · Arquitectura del Motor de Morphing y Presets (Proyecto Integrador 02)](/assets/diagrams/diagrama_proyecto_02_arquitectura.svg)

---

##  3. Desglose de Subsistemas

### A. Subsistema de Espacio de Estados (`[pattrstorage]` + `[nodes]`)
* **`lab02_storage`:** Nombre del gestor central. Almacena en memoria RAM 4 presets fundamentales:
  - **Preset 1 (Sub-Bass Sólido):** Frecuencia fundamental baja, filtro cerrado, resonancia moderada, modulación FM cero.
  - **Preset 2 (Vocal Lead Brillante):** Frecuencia media-alta, modulación FM intensa, filtro semi-abierto con $Q$ alto.
  - **Preset 3 (Bells / Metálico):** Relación armónica no entera en FM, filtro abierto, caída percusiva rápida.
  - **Preset 4 (Atmósfera Oscura):** Frecuencia ultra-grave, filtro resonante en barrido lento.
* **Pad 2D `[nodes]`:** Ubica los 4 presets en las cuatro esquinas $[(0.1, 0.9), (0.9, 0.9), (0.1, 0.1), (0.9, 0.1)]$. Al mover el nodo central, calcula los pesos relativos y los despacha como `recall multi w1 w2 w3 w4`.

### B. Subsistema de Persistencia en Disco (`[dict]`)
* Un botón **"Exportar Snapshot de Sesión"** toma el estado activo de `[pattrstorage]` y los metadatos globales (BPM, clave tonal, usuario) y los guarda en un archivo `sesion_modulo2.json`.

### C. Motor Acústico FM Sustractivo (DSP)
* Para que la interpolación no sea un ejercicio abstracto en pantalla, el sistema genera sonido real:
  - **Carrier Oscillator (`[cycle~]`):** Frecuencia base determinada por la melodía.
  - **Modulator Oscillator (`[cycle~]`):** Modula en frecuencia al carrier. El índice de modulación es un parámetro continuo enlazado a `[pattr]` (`mod_depth`).
  - **Filtro Resonante (`[lores~]`):** Frecuencia de corte (`cutoff`) y factor de amortiguamiento (`resonancia`) enlazados a `[pattr]`.
  - **Headroom Seguro:** La señal pasa por un escalado atenuador lineal `*~ 0.4` antes del control `[gain~]`, haciendo físicamente imposible que la suma de armónicos FM clipee contra el límite digital de $\pm 1.0$.

---

##  4. Guía de Operación y Validación

1. **Apertura:** Abre [`book/patches/modulo-02/proyecto_02_morphing.maxpat`](/patches/modulo-02/proyecto_02_morphing.maxpat).
2. **Encendido DSP:** Activa el botón de encendido del `[ezdac~]` y sube moderadamente el fader de `[gain~]`.
3. **Escuchar Presets Discretos:** Presiona `recall 1`, `recall 2`, `recall 3` y `recall 4` para familiarizarte con los 4 extremos acústicos.
4. **Validar Morphing Temporal:** Dispara el mensaje `recall 1 2 5000.` y observa cómo todas las perillas numéricas se mueven suavemente a 60 fps durante 5 segundos sin saltos tímbricos ni ruidos digitales.
5. **Validar Morphing Espacial:** Arrastra el cursor con el mouse dentro del pad `[nodes]` para explorar el universo continuo de timbres intermedios generados por la interpolación ponderada.
6. **Validar Parada de Emergencia:** Presiona el botón rojo **PANIC** y verifica que el bus `[send global_panic]` silencie inmediatamente el audio.
