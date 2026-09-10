---
title: "Módulo 2.1: Memoria Persistente, Estructuras de Datos (`[table]`, `[coll]`, `[dict]`) y Manejo de Estado"
description: "Capítulo del curso universitario de Max/MSP"
---

# Módulo 2.1: Memoria Persistente, Estructuras de Datos (`[table]`, `[coll]`, `[dict]`) y Manejo de Estado

> *"Un algoritmo sin memoria es solo una función reactiva; con memoria se convierte en un sistema musical vivo."*

---

## ️ 1. Fundamento Teórico: Los Tres Niveles de Persistencia en Computación Musical

*(Inspirado en Todd Winkler, MIT Press y Cipriani & Giri, Vol. 2)*

En la interacción en tiempo real, un sistema musical no puede depender únicamente de los datos que viajan volátiles por los cables. Necesitamos almacenar **tres categorías de información**:

```
┌────────────────────────────────────────────────────────────────────────┐
│                   JERARQUÍA DE MEMORIA EN MAX                          │
├────────────────────────────────────────────────────────────────────────┤
│ 1. MEMORIA DE ÍNDICES DIRECTOS (Numérica / Arrays)  [table]           │
│    • Mapeo estricto Entero  Entero. Complejidad O(1).                 │
│    • Tablas de ondas (Wavetables), curvas de velocidad, escalas.       │
│                                                                        │
│ 2. MEMORIA ASOCIATIVA Y TABLAS DE SÍMBOLOS  [coll]                    │
│    • Mapeo Clave (Int o Símbolo)  Lista heterogénea de átomos.        │
│    • Secuencias polifónicas, eventos con timestamp, bases de datos CSV.│
│                                                                        │
│ 3. MEMORIA JERÁRQUICA Y ÁRBOLES JSON  [dict]                          │
│    • Árboles anidados (Key-Value Trees), arrays heterogéneos y objetos.│
│    • Estado global de sintetizadores, configuraciones de sesión, REST. │
└────────────────────────────────────────────────────────────────────────┘
```

---

##  2. Objetos de Almacenamiento Clásicos: `[value]`, `[table]` y `[coll]`

### A. Memoria Global Compartida: `[value]` (`[v]`)
* Almacena un único valor (número o lista corta) asociado a un **nombre global inmutable**.
* `[v mi_tempo]`: Cualquier objeto en cualquier subpatch o ventana que se llame `[v mi_tempo]` comparte el **mismo puntero de memoria**. Modificarlo en un extremo lo actualiza instantáneamente en el otro sin tirar cables.

### B. Arreglos Indexados: `[table]`
* Almacena pares `(índice, valor)` de números enteros.
* Posee una ventana gráfica nativa para dibujar curvas de transferencia matemática (curvas de respuesta de pedales, mapeos de sensores, tablas armónicas).
* **Acceso $O(1)$:** Enviar un índice al inlet izquierdo devuelve el valor correspondiente en un solo ciclo de reloj.

### C. La Base de Datos Clásica: `[coll]` (Collection)
* Es la navaja suiza histórica de Max para composiciones complejas.
* Cada fila tiene una **clave única** (número o símbolo) y un **vector de datos**:
  ```text
  1, 60 100 250;     // Clave 1: Nota 60, Vel 100, Dur 250ms
  2, 64 90 500;      // Clave 2: Nota 64, Vel 90, Dur 500ms
  intro, 120 4 4;    // Clave simbólica "intro": 120 BPM, 4/4
  ```
* Admite modos de búsqueda directa, lectura secuencial automática (`next`, `prev`), ordenamiento por clave o por valores, y persistencia directa en archivos de texto legibles.

---

##  3. El Estándar Moderno: Árboles Jerárquicos con `[dict]` y JSON

En aplicaciones de gran escala (como Max for Live o sintetizadores con cientos de parámetros), las listas planas de `[coll]` se quedan cortas.

El ecosistema **`[dict]`** de Cycling '74 introduce **estructuras de datos basadas en JSON nativo** dentro de Max:
* Permite crear diccionarios anidados:
  ```json
  {
    "preset_name": "Ambient Pad 01",
    "filter": {
      "cutoff": 1850.5,
      "resonance": 0.72,
      "mode": "lowpass"
    },
    "lfo": {
      "rate": 0.25,
      "depth": 0.6
    }
  }
```

### La Sintaxis de Rutas (Dot-Notation y Slash-Notation):
Para consultar o modificar datos dentro de `[dict]`, no necesitas recorrer el árbol manualmente. Usas rutas:
* `get filter::cutoff`  Devuelve `1850.5`.
* `set filter::resonance 0.85`  Modifica el valor sin tocar el resto del árbol.

---

##  4. Bajo el Capó: Diccionarios en C y Paso por Referencia (`dict.route.c`)

Mirando las entrañas del Max SDK en [`sources/max-sdk/source/dictionary/dict.route/dict.route.c`](file:///d:/DocumentosDiscoD/CursoMaxMSP/sources/max-sdk/source/dictionary/dict.route/dict.route.c):

### El Problema de la Clonación de Memoria
Si un diccionario contiene 10.000 parámetros o la partitura entera de una sinfonía, **copiar todo el JSON de un objeto a otro a través de un cable congelaría el hilo de audio**.

### La Solución de Cycling '74: Paso por Nombre Registrado
En C, Max no envía el contenido del diccionario por el cable; **envía únicamente el puntero al símbolo del diccionario registrado**:
```c
void dict_route_dictionary(t_dict_route* x, t_symbol* s) {
    // Busca el diccionario en la tabla maestra de memoria global
    t_dictionary* d = dictobj_findregistered_retain(s);
    if (!d) {
        object_error((t_object*)x, "unable to reference dictionary named %s", s);
        return;
    }
}
```

---

### Gotchas de la Comunidad Oficial: Nombres Efímeros y Diccionarios Anónimos

En los foros de Cycling '74, el error más desconcertante con el que tropiezan los desarrolladores es precisamente ese:
`"unable to reference dictionary named u123456789"`.

¿Por qué ocurre y cómo evitarlo?
1. **Diccionarios Anónimos vs. Nombrados:**
   - Si creas un `[dict]` sin argumentos, Max le asigna un nombre efímero generado (`u` seguido de un número hash único).
   - Si ese sub-árbol se crea dinámicamente o se desconecta el cable, el recolector de basura lo destruye y cualquier `[dict.unpack]` o `[dict.view]` aguas abajo arroja el error fatal.
   - **Regla de oro:** En arquitectura de producción, asigna siempre un nombre explícito a tus diccionarios maestros (`[dict mi_sintetizador]`).
2. **Consultas Profundas (`get`) vs. Desempaquetado (`dict.unpack`):**
   - Para consultar una clave anidada muy profunda (ej. `filter::resonance`), los desarrolladores experimentados recomiendan usar **mensajes `get path::to::key`** directos en vez de encadenar múltiples `[dict.unpack]`. Es más rápido, más limpio y no requiere registrar sub-diccionarios intermedios.
3. **Arrays de Diccionarios en JSON:**
   - `[dict.unpack]` no puede extraer directamente una lista de objetos JSON `[ { "id": 1 }, { "id": 2 } ]`.
   - Debes iterar con `[dict.iter]` o consultar por índice directo: `get features[0]::id`.

> **Principio Arquitectónico:** *Cuando conectas un cable entre objetos `dict`, viaja un puntero de 8 bytes, no megabytes de datos. La manipulación de árboles gigantes en Max es instantánea y de costo cero.*

---

##  4 Escenarios de la Vida Real (Casos de Estudio)

Abre el parche interactivo:
[`book/patches/modulo-02/laboratorio_04_persistencia.maxpat`](file:///d:/DocumentosDiscoD/CursoMaxMSP/book/patches/modulo-02/laboratorio_04_persistencia.maxpat)

### Escenario 1: Tabla de Escalamiento No Lineal de Sensibilidad con `[table]`
* **El Problema:** La respuesta de la velocidad de las teclas de un controlador suele ser lineal (0 a 127), pero la audición humana del volumen es logarítmica. Tocando suave casi no se oye y tocando medio ya suena muy fuerte.
* **La Solución:** Una curva de transferencia en `[table]`. Mapeamos la entrada lineal a una curva exponencial dibujada a mano. El acceso es en $O(1)$ sin consumo de CPU.

### Escenario 2: Secuenciador Basado en Base de Datos con `[coll]`
* **El Problema:** Necesitamos almacenar una secuencia polifónica compleja con notas, velocidades y duraciones, y poder reproducirla hacia adelante, hacia atrás o saltar a compases específicos.
* **La Solución:** `[coll]` con claves numéricas indexadas. Con el mensaje `next` recorremos la partitura paso a paso, y con un número saltamos a cualquier evento de inmediato.

### Escenario 3: Base de Datos de Presets Estructurados con `[dict]`
* **El Problema:** Un sintetizador tiene 4 módulos (Oscilador, Filtro, LFO, Efectos). Guardar los parámetros en variables sueltas hace imposible exportar o compartir presets.
* **La Solución:** `[dict]` con jerarquía de claves. Un solo botón `write` exporta el estado completo a un archivo `.json` en disco legible por humanos y compatible con cualquier aplicación externa.

### Escenario 4: Modificación Parcial con Rutas Anidadas (`dict.unpack` y `get`)
* **El Problema:** Solo queremos alterar la frecuencia de corte del filtro sin recargar ni alterar los otros 50 parámetros del sintetizador.
* **La Solución:** Enviar el mensaje `set filter::cutoff 800` directamente al `[dict]`. La memoria interna se actualiza limpiamente sin mutaciones destructivas colaterales.

---

## 3 Ejercicios Prácticos de Laboratorio

Realiza estos ejercicios en tu copia de Max utilizando el parche [`laboratorio_04_persistencia.maxpat`](file:///d:/DocumentosDiscoD/CursoMaxMSP/book/patches/modulo-02/laboratorio_04_persistencia.maxpat):

### ️ Ejercicio 1: El Cuantizador de Escalas con `[table]`
* **Objetivo:** Construye un corrector de afinación MIDI.
* **Desafío:** Llena una tabla de 128 posiciones donde cada nota cromática entrante se redirija a la nota de la escala mayor más cercana (ej. si entra 61, devuelve 60 o 62).
* **Requisito:** Al tocar cualquier teclado MIDI desordenado, la salida debe sonar 100% diatónica en tiempo real.

### ️ Ejercicio 2: Grabador / Reproductor de Eventos en Vivo con `[coll]`
* **Objetivo:** Graba una secuencia de notas improvisada por el usuario con sus marcas de tiempo exactas.
* **Desafío:** Al presionar "Record", utiliza `[timer]` para medir el delta entre notas y guárdalas en `[coll]` con formato `índice, nota vel delta;`. Al presionar "Play", reproduce la secuencia con el timing exacto usando `[pipe]`.

### ️ Ejercicio 3: Serializador JSON de Sesión con `[dict]`
* **Objetivo:** Construye un panel de administración de usuario que guarde: nombre del artista, BPM actual, escala seleccionada y volumen maestro.
* **Desafío:** Implementa botones para "Guardar en Disco" (`write session.json`) y "Cargar desde Disco" (`read session.json`), y verifica que al reabrir el parche los valores se restauren automáticamente.

---

## Resumen de Principios Arquitectónicos
1. **`[table]` para arrays numéricos $O(1)$:** ideal para tablas de ondas, mapeo de curvas y cuantización directa.
2. **`[coll]` para bases de datos relacionales simples:** perfecto para secuencias de partituras, listas de acordes y eventos en el tiempo.
3. **`[dict]` es el estándar de oro de la industria:** maneja árboles JSON anidados legibles, exportables y universales.
4. **Paso por referencia de diccionarios:** los objetos `dict` comparten la memoria de sus datos; solo viajan punteros de 8 bytes, protegiendo al procesador de clonaciones lentas.
