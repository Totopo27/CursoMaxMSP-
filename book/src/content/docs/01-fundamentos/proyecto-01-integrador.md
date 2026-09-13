---
title: "Proyecto Integrador 1: Secuenciador Polirrítmico Diatónico Autónomo"
description: "Capítulo del curso de Max/MSP"
---


> *"La robustez de un sistema en Max se demuestra cuando el parche es capaz de generar procesos musicales complejos a partir de reglas arquitectónicas mínimas, deterministas y matemáticamente estables."*

---

## 1. Visión y Objetivos del Proyecto

Este proyecto integra **la totalidad de los conceptos teóricos y prácticos desarrollados a lo largo del Módulo 1**:
1. **Computación Dataflow determinista:** Orden de ejecución inmutable orquestado con `[trigger]`, previniendo cualquier condición de carrera visual o recursión en $t=0$.
2. **Jerarquía Temporal y Overdrive:** Generación de pulsos en el macro-tiempo sin jitter, sincronizada al motor del Scheduler.
3. **Estructura de Sistema Interactivo (Todd Winkler, MIT Press):** Desacople riguroso entre el subsistema de reloj y escucha (*Listener*) y el motor de toma de decisiones armónicas (*Composer*).
4. **Teoría Musical y Armonización Diatónica (Geoffrey Kidde & V.J. Manzo):** Cuantización de notas aleatorias a una escala definida (Pentatónica Menor / Modo Dórico) y permutación circular de patrones melódicos con `[zl.rot]`.
5. **Autonomía Sonora Completa:** Incorpora un motor de síntesis percusivo en MSP con envolventes libres de clicks para sonar inmediatamente a través del driver **FlexASIO**.

---

##  2. Diagrama de Arquitectura del Sistema

![FIG 1.3 · Arquitectura del Sistema - Secuenciador Polirrítmico Diatónico](/assets/diagrams/diagrama_proyecto_01_arquitectura.svg)

---

##  3. Desglose de Componentes

### Componente A: El Master Clock y el Generador Polirrítmico
* En lugar de usar dos metrónomos desincronizados, usamos un **reloj maestro único** a 125 ms (equivalente a semicorcheas a 120 BPM).
* Un contador de 12 pasos (`[counter 0 11]`) alimenta dos operadores aritméticos de módulo:
  - `[% 4] == 0`: Dispara cada 4 ticks (el pulso rítmico a tierra).
  - `[% 3] == 0`: Dispara cada 3 ticks (la síncopa polirrítmica de tresillo).
* **Resultado:** Sincronización matemática inquebrantable que nunca se desfasa.

### Componente B: El Cuantizador Diatónico y Permutador Melódico
* Usamos una lista de alturas pertenecientes a la **Escala Pentatónica Menor de La** (La, Do, Re, Mi, Sol):
  `MIDI: 57 60 62 64 67 69 72`
* El pulso polirrítmico selecciona una nota de la escala usando `[zl.lookup]`.
* Cada 12 compases, un pulso ejecuta un `[zl.rot 1]`, haciendo que la escala rote circularmente. Las mismas notas se ejecutan con una sensación armónica renovada e hipnótica.

> **Fundamentación Teórica (Edmar Soria / Francisco Colasanto):**
> En *Procedural / Sonora*, Edmar Soria formaliza la **transducción rítmica y modal** a través de la teoría de conjuntos y grupos de permutaciones: las rotaciones circulares mediante `[zl.rot]` representan acciones de un grupo cíclico $C_n$ sobre el conjunto discreto de alturas, preservando la consonancia interválica mientras generan variación temporal continua sin recurrir al azar destructivo.
> Asimismo, como demuestra Francisco Colasanto en su investigación doctoral sobre la herramienta *AMI (UNAM / CMMAS)*, la estructuración de colecciones simbólicas en memoria mediante tablas indexadas (`coll` y matrices probabilísticas) permite desacoplar el motor generativo de la síntesis final, garantizando reproducibilidad y calificación analítica de los parámetros generados en tiempo real.

### Componente C: La Voz de Sintetizador Percusivo (MSP)
* **Bombo / Sub-Bass:** Un oscilador `[cycle~]` modulado con una caída rápida de frecuencia (de 150 Hz a 40 Hz en 80 ms con `[line~]`) y una envolvente de amplitud exponencial para dar pegada contundente.
* **Lead / Pluck FM:** Un oscilador sinusoidal portador modulado en frecuencia con una envolvente percusiva metálica y brillante.
* Ambos sintetizadores se suman y se conectan a un control de volumen `[gain~]` y a la salida `[ezdac~]`.

---

## 4. Guía de Interacción con el Parche

Abre el parche en Max:
[`book/patches/modulo-01/proyecto_01_secuenciador.maxpat`](/patches/modulo-01/proyecto_01_secuenciador.maxpat)

1. **Encender el Motor de Audio:**
   - Haz clic en el botón de parlantitos `[ezdac~]` abajo a la derecha para encender el DSP (debe estar en azul/verde).
   - Sube ligeramente el fader vertical de volumen `[gain~]`.
2. **Iniciar la Secuencia:**
   - Activa el interruptor principal **Start / Stop** arriba a la izquierda.
   - Verás los contadores numéricos y los bangs parpadeando con la cadencia de la polirritmia 3 contra 4.
3. **Escuchar la Evolución Armónica:**
   - Observa cómo la caja de mensaje de la escala va rotando con `[zl.rot]` mientras las notas van fluyendo y sonando de forma perfectamente afinada y musical.
4. **Experimentar con el Tempo:**
   - Modifica la caja numérica de milisegundos del `[metro]` (por defecto en `125`). Cámbiala a `90` para mayor velocidad o `180` para un ritmo más pausado.

---

## 5. Conclusiones del Módulo 1
Has construido un sistema donde:
- No hay condiciones de carrera visuales: todo pulso se bifurca deterministamente con `[trigger]`.
- No hay bucles infinitos en $t=0$: la retroalimentación está gobernada por el Scheduler.
- Los datos viajan en arrays de átomos `t_atom` contiguos en memoria, manipulados a alta velocidad con `[zl]`.
- La música está fundamentada en la relación entre acústica física, teoría musical modal y teoría de grafos.
