---
title: "Módulo 6.1: JavaScript en Max: Arquitectura de los Motores `[js]` y `[v8]`"
description: "JavaScript en Max con [js] y el motor V8: scripting de lógica generativa, acceso a la Live API, limitaciones de hilo principal y mejores prácticas para código seguro en el Scheduler."
---


A lo largo de los módulos anteriores cubrimos exhaustivamente el paradigma de flujo de datos síncrono (Max Control), el paradigma asíncrono de colas/prioridades (Scheduler vs Low-priority Queue), la computación vectorial en DSP (MSP) y el procesamiento compilado muestra a muestra (`gen~`).

Sin embargo, hay problemas donde la programación visual mediante cajas y cables resulta engorrosa, poco legible o derechamente ineficiente: algoritmos generativos combinatorios, estructuras de grafos complejas, análisis de árboles JSON arbitrarios, cálculos recursivos y la instanciación programática de objetos sobre el canvas (Scripting the Patcher). Para este dominio, Cycling '74 integró el soporte de **JavaScript nativo**.

---

## 1. La Dualidad de Motores: `[js]` Tradicional vs. `[v8]` (Max 9)

Históricamente, Max integró el motor **SpiderMonkey** (Mozilla) en el objeto `[js]`. Con la llegada de Max 9, Cycling '74 dio el salto al motor **V8** de Google a través del nuevo objeto nativo `[v8]`. Comprender la diferencia arquitectónica entre ambos es vital para no cometer errores de compatibilidad:

| Característica | Objeto Tradicional `[js]` | Objeto Moderno `[v8]` (Max 9) |
| :--- | :--- | :--- |
| **Motor Subyacente** | Mozilla SpiderMonkey 1.8.5 (Legacy) | Google V8 Engine |
| **Estándar ECMAScript** | ECMAScript 5 (ES5 - sin `const`/`let`, ni clases nativas) | ECMAScript 2024 (ES2024+ completo, `async`/`await`, ES Modules) |
| **Rendimiento JIT** | Intérprete moderado con optimizaciones limitadas | Compilación JIT de alto rendimiento a código máquina x86/ARM |
| **Hilos y Bloqueos** | Ejecuta estrictamente en el hilo que lo invoca (Main o Scheduler) | Soporta Web Workers y tareas asíncronas no bloqueantes |
| **Acceso a la API Max** | Objeto global `max`, clases `Patcher`, `Maxobj`, `Task` | API moderna `max-api` unificada y bindings V8 de ultra-baja latencia |

---

## 2. Anatomía del Objeto JavaScript en Max

Cuando Max carga un script `.js`, crea una instancia del intérprete vinculada al entorno del patcher. Existen variables globales reservadas inyectadas por Max en el scope global del script:

![FIG 6.1 · SpiderMonkey [js] vs Google V8 [v8] & max-api](/assets/diagrams/diagrama_js_v8_arquitectura.svg)

### 2.1. Puertos de Entrada y Salida Dinámicos

En la cabecera de todo script para Max definimos la topología del objeto:

```javascript
// Definición de topología
inlets = 2;   // Inlet 0 (izquierdo): disparador principal. Inlet 1 (derecho): configuración
outlets = 2;  // Outlet 0: datos procesados. Outlet 1: status o bangs de sincronía

// Opcional: configurar tooltips de ayuda para los inlets
setinletassist(0, "(bang/list) Entrada de disparo y datos");
setinletassist(1, "(int) Ajuste de longitud de paso");
setoutletassist(0, "(list) Salida del patrón generado");
setoutletassist(1, "(bang) Fin de ciclo");
```

### 2.2. Manejadores de Mensajes Especiales

Max mapea los tipos de mensajes estándar a funciones con nombres reservados:
- `bang()`: Se ejecuta al recibir un `bang` en el inlet izquierdo.
- `msg_int(v)` y `msg_float(v)`: Capturan números simples. Para saber qué inlet recibió el mensaje, se consulta la variable global `inlet`.
- `list()`: Se dispara cuando entra una lista de argumentos (`arguments` contiene el array).
- `anything()`: Captura cualquier selector arbitrario que no coincida con una función explícita del script (`messagename` contiene el selector).

---

## 3. Scripting the Patcher: Modificación Algorítmica del Canvas

Una de las capacidades más asombrosas del motor JavaScript en Max es la capacidad de **crear, conectar y destruir objetos del canvas en tiempo de ejecución**. Esto se logra mediante el objeto `this.patcher`:

```javascript
// Generación dinámica de una cadena de filtros en el patcher
function instanciar_cadena(num_filtros) {
    var p = this.patcher;
    var prev_obj = null;

    for (var i = 0; i < num_filtros; i++) {
        var x_pos = 100 + (i * 120);
        var y_pos = 200;
        
        // Creamos un nuevo objeto [lores~] con parámetros iniciales
        var freq = 200 * Math.pow(1.5, i);
        var new_filter = p.newdefault(x_pos, y_pos, "lores~", freq, 0.75);
        
        // Si no es el primero, conectamos la salida del anterior al inlet de este
        if (prev_obj) {
            p.connect(prev_obj, 0, new_filter, 0);
        }
        prev_obj = new_filter;
    }
    post("Cadena de " + num_filtros + " filtros generada dinámicamente.\n");
}
```

> [!WARNING]
> **El Gran Peligro de Scripting en Tiempo Real**:
> Modificar la estructura del patcher (`newdefault`, `connect`, `remove`) altera el grafo de audio y fuerza a Max a reconstruir la tabla de señales en el Audio Thread. **NUNCA ejecutes scripting de patcher a frecuencias altas (e.g. desde un metro a 10 ms)**, ya que causará cuelgues o cortes inmediatos (*audio dropouts*). El scripting de canvas debe reservarse para inicialización, macros y configuración de presets.

---

## 4. Limitaciones Temporales de `[js]`: Recolección de Basura (Iain Duncan, 2021)

Como demuestra Iain Duncan (*Scheduling Musical Events in Max/MSP with Scheme For Max*, Univ. de Victoria), el objeto `[js]` presenta un límite arquitectónico estricto para la música algorítmica en vivo:

1. **Pausas de Recolección de Basura (*Stop-the-World GC*)**: El motor V8 de JavaScript crea y destruye objetos constantemente en el *heap*. Cuando el recolector de basura se activa, congela la ejecución del script durante 5 a 40 ms. En un contexto rítmico a 120 BPM, un retraso de 10 ms destruye el groove y desincroniza la polifonía.
2. **Confinamiento al Main Thread**: `[js]` se ejecuta fuera del Scheduler de alta prioridad. Si el usuario mueve un slider en la interfaz gráfica o abre un menú en el sistema operativo, los eventos de JavaScript se encolan y sufren *jitter* masivo.
3. **Criterio de Diseño Senior**: Utilizá `[js]` exclusivamente para **manipulación de estructuras complejas en reposo, transformaciones de partituras y lógica de control asíncrona**. Para secuenciación musical determinista a prueba de balas, la temporización debe residir en objetos nativos de Max (`[metro]`, `[transport]`), extensiones C/C++ (`Min-DevKit`) o entornos funcionales sin pausas de GC como Scheme For Max (`s7`).

---

## 5. Laboratorio Práctico: Generador de Ritmos Euclidianos

Para poner en práctica JavaScript dentro de Max con una aplicación musical compleja, implementaremos el **Algoritmo de Bjorklund (Ritmos Euclidianos)**. Este algoritmo distribuye $K$ pulsos (golpes) lo más uniformemente posible a lo largo de un ciclo de $N$ subdivisiones, resolviendo el problema de la misma forma que el algoritmo de Euclides halla el máximo común divisor (MCD).

El código modular se escribe en `algoritmo_euclidiano.js` y se comunica de forma transparente con `laboratorio_22_javascript_max.maxpat`.
