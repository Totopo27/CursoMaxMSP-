---
title: "Lección 4.2: Polifonía Dinámica con poly~: Asignación de Voces, Enrutamiento (target), mute y thispoly~"
description: "Capítulo del curso universitario de Max/MSP"
---


> *"Un sintetizador monofónico es una línea melódica solitaria; la polifonía es arquitectura armónica en el tiempo. Pero multiplicar 16 voces de síntesis por la fuerza bruta de copiar y pegar parches es la bancarrota del CPU: la polifonía digital profesional exige asignación dinámica, reciclaje de voces y apagado absoluto de hilos inactivos."*  
> — **F. Richard Moore**, *Elements of Computer Music*

---

### Objetivos Pedagógicos y de Ingeniería
1. **Comprender el paradigma de instanciación masiva de `poly~`**: Explicar cómo un único archivo `.maxpat` de voz se replica $N$ veces en memoria sin duplicación visual en el lienzo.
2. **Dominar los algoritmos de asignación de voces**:
   - `midievent`: Enrutamiento automático de Note-On / Note-Off con asignación *voice stealing* (robo de voz inteligente).
   - `target $1`: Direccionamiento explícito a una voz específica ($1 \dots N$) o a todas simultáneamente (`target 0`).
3. **Optimización Radical de CPU mediante `[thispoly~]` y el mensaje `mute`**: Demostrar matemáticamente por qué una voz que terminó su envolvente no debe procesar ceros y cómo `mute 1, 0` desactiva el bucle `perform64` de esa voz en el árbol de DSP.
4. **Analizar la estructura interna de `poly~` en el SDK de Max C**: Inspeccionar cómo el objeto gestor mantiene un arreglo de estructuras `t_patcher*` y conmuta punteros de vector de audio de forma condicional.

---

## 1. La Anatomía del Objeto `poly~`

`[poly~]` recibe dos argumentos fundamentales:
`poly~ [nombre_subparche_voz] [cantidad_de_voces]`
Ejemplo: `poly~ voz_polifonica 8`

```
                      [ Patch Principal ]
                               | (midievent / target)
                               v
                     +-------------------+
                     |      poly~ 8      |
                     +-------------------+
                     | Voz 1 (Activa)    | ---> perform64() (CPU ON)
                     | Voz 2 (Activa)    | ---> perform64() (CPU ON)
                     | Voz 3 (Muteada)   | ---> [Bypass]    (CPU 0%)
                     | Voz 4 (Muteada)   | ---> [Bypass]    (CPU 0%)
                     | ...               |
                     +-------------------+
                               | (Suma de Audio out~)
                               v
                            [out~ 1]
```

### Los Objetos Especiales de Comunicación Interna
Dentro del subparche de voz instanciado por `poly~`, los inlets y outlets estándar se reemplazan por:
- `[in 1]` / `[in 2]`: Inlets de control (mensajes).
- `[in~ 1]` / `[in~ 2]`: Inlets de señal de audio.
- `[out 1]`: Outlets de mensajes de control hacia el padre.
- `[out~ 1]`: Outlets de audio (que `poly~` **suma automáticamente** en su salida correspondiente).

---

## 2. El Ciclo de Vida de una Voz: `thispoly~` y el Protocolo `mute`

Un error recurrente en el diseño de sintetizadores es permitir que la totalidad de las voces (ej. 16 o 32) permanezca activa de forma continua en segundo plano. Aun en ausencia de señal audible, evaluar ecuaciones de diferencias y multiplicar ceros en filtros y osciladores consume la misma cantidad de ciclos de instrucción por muestra que computar un pasaje polifónico completo.

Para mitigar este costo computacional, cada instancia de voz incorpora un objeto `[thispoly~]`:

```
          [adsr~ 10. 150. 0.5 300.]
             |                 | (3er Outlet: Estado de Actividad 1/0)
             v                 v
          [*~ audio]        [!= 0.]  (1 cuando suena, 0 cuando calla)
                               |
                        [message: mute $1, $1]
                               |
                         [thispoly~]
```

### Sintaxis del Mensaje `mute [estado_mute] [estado_busy]`
- `mute 1 0`: **Mute ON, Busy OFF**. La voz se apaga en el motor DSP (consume **0% de CPU**) y se marca como **libre** para que `poly~` pueda asignarle una nueva nota.
- `mute 0 1`: **Mute OFF, Busy ON**. La voz se enciende en el hilo DSP y se marca como **ocupada** para que ninguna otra nota la interrumpa.

---

## 3. Direccionamiento: `midievent`, `target` y `note`

Max ofrece tres métodos de interacción con las voces internas:

### A. Mensaje `midievent [status] [pitch] [velocity]`
El método más eficiente y elegante. `poly~` decodifica internamente los mensajes MIDI:
- Si `velocity > 0` (Note On): Busca la primera voz libre (`busy == 0`), le envía la nota y la marca como ocupada.
- Si `velocity == 0` (Note Off): Busca la voz que está ejecutando ese tono exacto y le envía el Note-Off para disparar la fase de Release.
- Si todas las voces están ocupadas: Aplica *voice stealing* (roba la voz con la nota más antigua o con el nivel de envolvente más bajo).

### B. Mensaje `target $1`
Permite control quirúrgico manual:
- `target 3`: Todos los mensajes subsiguientes irán **exclusivamente a la voz 3**.
- `target 0`: Todos los mensajes subsiguientes irán **en broadcast a todas las voces simultáneamente** (ideal para cambiar el filtro o el ataque de todo el sintetizador al mismo tiempo).

---

## 4. Bajo el Capó: Análisis en C del Bucle de Despacho de `poly~`

En el motor DSP de Max (`ext_obex.h`, `z_dsp.h`), `poly~` administra una lista de instancias de patchers. En cada bloque de procesamiento de audio de 64 bits:

```c
// Modelo conceptual del despachador DSP de poly~
void poly_dsp_chain(t_poly *x, double **ins, double **outs, long frames) {
    // 1. Limpiar el buffer de salida acumulativo
    memset(outs[0], 0, sizeof(double) * frames);
    
    // 2. Iterar sobre cada voz instanciada
    for (int v = 0; v < x->num_voices; v++) {
        t_voice *voice = &x->voices[v];
        
        // EVALUACIÓN DE MUTE: Si está muteada, saltar inmediatamente
        if (voice->is_muted) {
            continue; // ¡Ahorro absoluto de CPU!
        }
        
        // Ejecutar el sub-árbol DSP de esta voz específica
        voice_perform64(voice, ins, voice->temp_out, frames);
        
        // Sumar vectorialmente al master out (SIMD Vector Add)
        for (int i = 0; i < frames; i++) {
            outs[0][i] += voice->temp_out[i];
        }
    }
}
```

---

## 5. Escenarios Reales de Producción

1. **Sintetizador Polifónico de 16 Voces**: Un pad estéreo complejo con 2 osciladores por voz, filtro bicuadrático y generador de ruido que reduce su consumo de CPU del $65\%$ al $4\%$ cuando no hay teclas presionadas.
2. **Generador de Enjambre de Granos (Granular Cloud Engine)**: Un `poly~ 64` donde cada voz reproduce un micro-grano de audio en una posición aleatoria de un buffer, activándose y muteándose en lapsos de 30 ms.
3. **Banco de Filtros Resonadores Modal**: Un objeto `poly~ 32` configurado con `target $1` en tiempo de inicio para cargar 32 modos armónicos de una placa metálica o membrana de tambor.
4. **Procesador Multiefecto con Voces Desfasadas**: Crear un efecto de ensanchamiento estéreo con 6 líneas de delay moduladas, donde cada voz recibe un tiempo de retardo derivado de su ID interno (`[thispoly~] -> outlet de número de voz`).

---

## 6. Desafíos de Ingeniería

### Desafío 1: El Lector de Número de Voz Interno
Utilizá la salida de mensaje de `[thispoly~]` (que emite el número de voz $1 \dots N$ al recibir un bang) para generar una dispersión estéreo automática (*pan spread*), asignando las voces impares a la izquierda y las pares a la derecha.

### Desafío 2: Voice Stealing Manual con umbral de prioridad
Diseñá un mecanismo de control antes de `poly~` que verifique mediante `poly~ 8 args` si hay voces disponibles y, de no haberlas, fuerce el corte inmediato de la nota más baja en lugar de la más antigua.

### Desafío 3: El Medidor de Carga de Voces Activas
Construí una interfaz en el parche principal que consulte periódicamente cuántas voces están activas (`busy`) simultáneamente y grafique el uso porcentual de polifonía en una barra `[live.meter~]` o `[multislider]`.

---

## 7. Archivos del Laboratorio

1. [`voz_polifonica.maxpat`](/patches/modulo-04/voz_polifonica.maxpat): Subparche atómico de voz con oscilador de sierra (`saw~`), filtro resonante, envolvente `adsr~` y conexión al protocolo `mute` / `busy` en `[thispoly~]`.
2. [`laboratorio_16_poly.maxpat`](/patches/modulo-04/laboratorio_16_poly.maxpat): Parche maestro con teclado MIDI `kslider`, instanciación `poly~ voz_polifonica 8`, control de parámetros globales mediante `target 0` y monitoreo del consumo de CPU.
