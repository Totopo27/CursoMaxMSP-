# PLAN MAESTRO DE AUDITORÍA Y OPTIMIZACIÓN INTEGRAL
## Ecosistema CursoMaxMSP bajo Estándares OptimizandoParaMaxSDK & Cycling '74 C/C++ SDK

> **Fecha de Inicio:** Septiembre 2026  
> **Alcance:** Auditoría al 100% de los activos de `CursoMaxMSP`:
> - 46 parches `.maxpat` y scripts auxiliares (`.js`, `.c`, `.cpp`, `.ino`).
> - 94 diagramas técnicos vectoriales de arquitectura (`.svg`).
> - 35+ módulos y apéndices de documentación conceptual y laboratorios (`.md`).
> **Marco de Referencia:** Reglas del C/C++ SDK de Cycling '74, `ersatzben-maxmsp-mcp` y estándares lock-free de audio DSP en tiempo real de `OptimizandoParaMaxSDK`.

---

## 1. Resumen Ejecutivo del Diagnóstico Inicial (Línea Base)

El análisis estático preliminar ejecutado sobre el repositorio arrojó las siguientes métricas objetivas:

* **Parches Max (`.maxpat`):** 46 analizados.
  * **56 hallazgos detectados:**
    * **39 Riesgos Altos de Condición de Carrera (`RACE_CONDITION_RISK`):** Bifurcaciones desde outlets de control o inicialización (`loadbang`, sliders, floats, math) hacia inlets calientes múltiples sin el uso obligatorio de `[trigger]`/`[t]`. Quedan a merced del orden espacial *Right-to-Left* (R-to-L).
    * **12 Antipatrones de Audio MSP (`REDUNDANT_SUM_MSP`):** Uso de objetos `[+~]` redundantes alimentando entradas de señal de objetos que ya cuentan con *auto-summing* nativo (`cycle~`, `lores~`, `tapin~`, `gain~`).
    * **4 Gotchas de Tipos de Datos en JSON (`DATA_TYPE_GOTCHA`):** Desempaquetado con `[unpack]` utilizando enteros crudos sin especificador `"f"`, lo que truncará datos si se reciben números en coma flotante.
    * **1 Advertencia de Persistencia (`PERSISTENCE_WARNING`):** Objeto `[coll]` sin el atributo `@embed 1`.
* **Diagramas Técnicos (`.svg`):** 94 diagramas vectoriales analizados.
  * **0 Huérfanos:** Todos los diagramas están correctamente indexados y referenciados en los documentos Markdown.
  * **Foco de Auditoría:** Verificar correspondencia 1:1 entre los diagramas y los parches reales tras las correcciones de `[trigger]` y auto-summing, además de validar la distinción semántica (cables vectoriales gruesos para señal MSP vs. líneas de eventos discretos).
* **Código SDK / Extensiones (`.c`, `.cpp`, `.js`):**
  * Validación de la rutina `perform64`, manejo de memoria fuera del hilo de audio (`sysmem_newptr`), puentes de hilo con `qelem`, y scripts asíncronos en Node for Max (`n4m`).

---

## 2. Matriz de Fases de Optimización Integral

```
+-------------------------------------------------------------------------------+
| FASE 1: Remediación Crítica de Parches (Módulos 01 a 06 + Apéndices)          |
| -> Refactorizar con [trigger], eliminar [+~] redundantes, fijar tipos/embed  |
+---------------------------------------+---------------------------------------+
                                        |
                                        v
+-------------------------------------------------------------------------------+
| FASE 2: Auditoría y Refinamiento de Diagramas de Arquitectura SVG            |
| -> Sincronizar topología visual con los parches corregidos y rigor semántico |
+---------------------------------------+---------------------------------------+
                                        |
                                        v
+-------------------------------------------------------------------------------+
| FASE 3: Auditoría de Extensiones SDK, C/C++, GenExpr y Node for Max          |
| -> Verificar contratos de tiempo real, seguridad de memoria y callbacks       |
+---------------------------------------+---------------------------------------+
                                        |
                                        v
+-------------------------------------------------------------------------------+
| FASE 4: Sincronización Didáctica en Documentación (Markdown)                 |
| -> Ajustar explicaciones teóricas y llamadas a cajas según parches actualizados|
+-------------------------------------------------------------------------------+
```

---

## 3. Plan de Acción Detallado por Fases

### FASE 1: Remediación de Parches Max (.maxpat)
Se procesará módulo por módulo aplicando transformaciones quirúrgicas a los archivos `.maxpat`:
1. **Módulo 01 (Fundamentos y Secuenciador):**
   * Corregir `proyecto_01_secuenciador.maxpat` (`counter` bifurcado a `% 4` y `% 3`).
   * Limpiar sumas de audio redundantes hacia `*~ 0.7`.
2. **Módulo 02 (Persistencia y Comunicación):**
   * Asegurar `@embed 1` en `coll` (`laboratorio_04_persistencia.maxpat`).
   * Verificar la jerarquía de clientes `pattr` y bind paths.
3. **Módulo 03 (DSP, Modulación y Síntesis FM):**
   * Corregir `laboratorio_10_sintesis_fm.maxpat` y `proyecto_03_sintetizador_fm.maxpat`:
     * Insertar `[t f f]` o `[t b f]` en `flonum`, `kslider` y `loadbang`.
     * Retirar `+~` redundante antes de `cycle~`.
   * Corregir bifurcaciones en `laboratorio_08_osciladores`, `laboratorio_12_filtros` y `laboratorio_13_delays`.
4. **Módulo 04 (Polifonía, Multicore y Abstracciones):**
   * Refactorizar `voz_sintetizador_completo.maxpat`, `laboratorio_15_abstracciones` y `laboratorio_17_multicore.maxpat`:
     * Incorporar `[t]` para distribuir notas a las instancias de `poly~`.
     * Usar `[unpack f f]` explícito para parámetros de frecuencia y amplitud.
5. **Módulo 05 (Gen~, GenExpr y Modelado Físico):**
   * Auditar estabilidad de retrasos y variables `history` en Waveguide y Karplus-Strong.
6. **Módulo 06 y Apéndices:**
   * Sanear bifurcaciones en `lab_apendice_a_jitter.maxpat`, `lab_apendice_b_touchdesigner`, `lab_apendice_h_lom_clip_trigger`.

### FASE 2: Auditoría y Refinamiento de Diagramas de Arquitectura (SVG)
1. **Revisión de Flujo y Orden de Ejecución:**
   * Asegurar que diagramas como `diagrama_right_to_left_trigger.svg`, `diagrama_dag_feedback_delay.svg` y diagramas de arquitectura de proyectos (01 a 06) muestren exactamente la topología real recomendada por el SDK.
2. **Diferenciación de Señales:**
   * Distinción visual inequívoca:
     * Cables de audio MSP: trazo grueso o color distintivo con indicación de vectores de señal.
     * Cables de control: trazo fino con indicación de flujo de eventos.
3. **Validación de Bloques Acústicos:**
   * Comprobar esquemas de filtros en plano Z (`diagrama_plano_z_estabilidad_filtros.svg`), ecuaciones de FM Bessel (`diagrama_funciones_bessel_fm.svg`) y modelos de waveguides.

### FASE 3: Auditoría de Código C/C++ y Extensiones Externas
1. **Auditoría de `mi_objeto_externo.c` y `mi_objeto_msp.c` (Módulo 06):**
   * Comprobar inicialización en `ext_main()`.
   * Verificar que la función `perform64` esté libre de llamadas a `post()`, `sysmem_newptr()`, o accesos a disco/red.
   * Verificar uso de `qelem` o `defer_low()` para cualquier comunicación desde el hilo de audio hacia el hilo principal de Max.
2. **Auditoría de `mi_objeto_min.cpp` y `filtro_va_min.cpp` (Apéndice D - min-devkit):**
   * Verificar uso de atributos declarativos (`attribute<>`).
   * Comprobar el manejo de sobremuestreo y estabilidad de coeficientes de filtro virtual analógico.
3. **Auditoría de `servidor_analisis.js` y `algoritmo_euclidiano.js` (Node for Max y JS v8):**
   * Comprobar manejo de excepciones en handlers de `Max.addHandler()`.
   * Prevenir bloqueos en el hilo UI al calcular matrices o secuencias euclidianas.

### FASE 4: Consistencia y Documentación Técnica (Markdown)
1. Ajustar el texto de las lecciones si algún objeto o conexión cambió durante la remediación.
2. Añadir llamadas explícitas ("Best Practices de Max SDK") en cada capítulo donde se hayan eliminado condiciones de carrera o antipatrones de sumado.

---

## 4. Criterios de Aceptación y "Done"

1. **Parches:** El script de auditoría automatizada debe reportar **0 hallazgos de severidad ALTA (Race Conditions)** y **0 antipatrones de sumado redundante**.
2. **Diagramas:** Todos los diagramas de arquitectura deben reflejar con exactitud la topología y convenciones del SDK.
3. **Código SDK:** Cumplimiento estricto de las directrices de tiempo real y memoria lock-free.
4. **Integridad:** La suite de documentación Astro/Starlight debe compilar sin errores de enlaces ni assets rotos (`npm run build`).
