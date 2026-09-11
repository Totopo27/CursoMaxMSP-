---
title: "Módulo 2.2: Gestión de Presets Globales, Morphing de Parámetros e Interpolación con el Ecosistema `[pattr]`"
description: "Capítulo del curso universitario de Max/MSP"
---


> *"Un preset no es una fotografía estática del pasado; es un punto vectorial en un espacio n-dimensional por el que podemos viajar continuamente."*

---

##  1. Fundamento Teórico: El Espacio de Estados y la Interpolación N-Dimensional

*(Inspirado en Todd Winkler, *Composing Interactive Music*, MIT Press, y Cipriani & Giri, *Electronic Music and Sound Design*, Vol. 2)*

En la música acústica tradicional, un instrumento cambia su tímbrica de forma **continua**: la presión del arco sobre una cuerda de violín no salta abruptamente de *pianissimo* a *fortissimo*; se desliza a través de una trayectoria continua en un espacio físico.

En la música por computadora tradicional, en cambio, el concepto de "preset" surgió como una instantánea discreta: el sintetizador carga el parche 1, luego salta abruptamente al parche 2. Los parámetros saltan en $t=0$, produciendo discontinuidades acústicas (clicks, saltos de fase o artefactos tímbricos desagradables).

### El Espacio de Estados N-Dimensional ($\mathbb{R}^N$)

Imagina un sintetizador o procesador de efectos que tiene $N$ parámetros continuos:
* Frecuencia del filtro ($f_c$)
* Resonancia ($Q$)
* Tiempo de ataque ($t_a$)
* Nivel de modulación ($M$)
* Posición panorámica ($P$)

Cada estado o preset $P_k$ es un vector en un espacio euclidiano $\mathbb{R}^N$:
$$\vec{P}_k = \begin{bmatrix} p_{1,k} \\ p_{2,k} \\ \vdots \\ p_{N,k} \end{bmatrix}$$

```
   Parámetro 2 (Resonancia)
        ▲
        │          Preset 2 [P2] (0.8, 0.9)
        │             ●
        │            /
        │           /  ◄── Trayectoria de Interpolación (Morphing continuo)
        │          /
        │         ● 
        │     Preset 1 [P1] (0.2, 0.3)
        └────────────────────────► Parámetro 1 (Cutoff)
```

Si queremos viajar suavemente del **Preset 1** al **Preset 2**, no saltamos: aplicamos una función de **interpolación lineal** (Lerp) gobernada por una variable escalar continua $\alpha \in [0.0, 1.0]$:

$$\vec{P}(\alpha) = (1 - \alpha)\vec{P}_1 + \alpha \vec{P}_2$$

Cuando $\alpha = 0.0$, el sistema suena exactamente como el Preset 1. Cuando $\alpha = 0.5$, estamos en un estado tímbrico híbrido que ningún preset definió explícitamente: **un nuevo timbre matemáticamente coherente**. Cuando $\alpha = 1.0$, alcanzamos el Preset 2.

El ecosistema **`[pattr]`** de Max/MSP fue creado precisamente para resolver este problema a nivel de sistema operativo del parche: desacoplar la interfaz gráfica (UI) de los datos y permitir que cientos de parámetros se almacenen, consulten, jerarquicen e interpongan en tiempo real sin tirar un solo cable entre ellos.

---

##  2. La Anatomía del Ecosistema `[pattr]`

El sistema `pattr` no es un único objeto; es un protocolo distribuido compuesto por cuatro pilares fundamentales:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           ARQUITECTURA PATTR                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   [pattrstorage mi_banco] ◄──── Memoria Central, Morphing, Guardado en JSON │
│              ▲                                                              │
│              │ (Protocolo de Binding Interno - Sin cables)                  │
│              ▼                                                              │
│      [autopattr] ─────────► Escanea automáticamente el patcher              │
│         │     │             y expone sliders, dials y números con script-name│
│         ▼     ▼                                                             │
│      [pattr cutoff] ──────► Enlace bidireccional explícito a UI             │
│         │                                                                   │
│         ▼                                                                   │
│      [live.dial] o [flonum]                                                 │
└─────────────────────────────────────────────────────────────────────────────┘
```

### A. `[pattr]`: El Agente de Enlace Bidireccional
* **Propósito:** Asocia un valor o interfaz a un nombre identificable único (ej: `[pattr cutoff @bindto dial_filtro]`).
* **Bidireccionalidad:** Si el usuario mueve el dial en pantalla, `[pattr]` notifica al sistema. Si el sistema envía un nuevo valor al `[pattr]`, la perilla se mueve sola sin entrar en loops infinitos de retroalimentación gracias al filtrado de redundancia interno.
* **Tipado e Interpolación:** Permite definir si un parámetro debe o no interpolarse (`@interp 1` o `@interp 0`). Por ejemplo, un selector de forma de onda discreto (0 = Seno, 1 = Sierra) **no debe** interpolarse con decimales; un filtro, sí.

### B. `[pattrstorage]`: El Gestor Central de Presets
* Es el cerebro de la persistencia y del morphing.
* **Almacenamiento indexado:** Guarda slots numéricos de presets (`store 1`, `store 2`, `recall 1`, `recall 2`).
* **Interpolación en punto flotante:** Si le enviamos `recall 1 2 0.35`, mezcla un 65% del preset 1 con un 35% del preset 2.
* **Morphing temporal automático:** El mensaje `recall 1 2 4000.` interpola gradualmente del preset 1 al 2 a lo largo de 4000 milisegundos (4 segundos), enviando actualizaciones fluidas a cada objeto del patch.
* **Exportación Universal:** Guarda y lee bancos enteros en formato XML o JSON (`write banco.json`, `read banco.json`).

### C. `[autopattr]`: Automatización y Cero Configuración
* En parches masivos con decenas de controles, agregar un `[pattr]` individual a cada slider sería tedioso y propenso a errores.
* `[autopattr]` examina automáticamente el patcher (y sub-patchers si se activa `@autoname 1`) y registra cualquier objeto que tenga un **Scripting Name** asignado en su Inspector.

### D. `[pattrhub]`: El Enrutador de Mensajes Remotos
* Permite inyectar o consultar valores de cualquier cliente `pattr` del sistema usando sintaxis de ruta: `cutoff 440.`, `mi_subpatch::resonancia 0.8`.

---

### Consideraciones Críticas en la Gestión de Estados (Arquitectura de Pattr)

Tres factores determinantes en el diseño de arquitecturas con `pattr` que condicionan la estabilidad del sistema:

1. **Recursión Infinita por Auto-vinculación (Stack Overflow):**
   - Si un elemento de interfaz (como un dial o caja numérica) que despacha comandos `recall $1` hacia `[pattrstorage]` posee un `varname` y es registrado como cliente por `[autopattr]`, se genera un ciclo de retroalimentación inmediata: al restaurar el preset, `pattrstorage` actualiza el elemento, este reenvía un nuevo `recall`, y el hilo de ejecución colapsa por desbordamiento de pila en $t=0$.
   - **Criterio de diseño:** El objeto emisor del comando de restauración (`recall`) debe excluirse rigurosamente de la lista de clientes del almacén de estados.

2. **Secuencia Determinista de Carga y Atributo `priority`:**
   - En estructuras donde existen dependencias de inicialización (por ejemplo, definir la dimensión de una matriz antes de inyectar los coeficientes en sus celdas), no es viable asumir un orden arbitrario o alfabético.
   - En la interfaz de gestión (`clientwindow`) de `[pattrstorage]`, debe configurarse explícitamente el atributo **Priority** (los valores numéricos menores se restauran de manera prioritaria; por ejemplo, prioridad `0` para dimensiones y `1` para parámetros dependientes).

3. **Sobrecarga de Despacho en Morphing Multivariable y Max for Live (M4L):**
   - La interpolación simultánea de cientos de parámetros con generadores de rampa de alta frecuencia (`[line]`) puede saturar la cola de eventos del hilo principal (*Main Thread*).
   - En entornos como **Max for Live**, cuando los objetos tienen habilitado *Parameter Mode Enabled*, las variaciones continuas de alta tasa interfieren con el motor de automatización y el búfer de deshacer/rehacer del DAW anfitrión. En estos contextos se recomienda desacoplar la interpolación continua interna respecto a los controles directamente expuestos al host.

---

##  3. Under the Hood (Max C SDK): Obex, Notificaciones y Attributes

*(Basado en el análisis de `ext_obex.h` y `shepherd.c` en `Cycling74/max-sdk`)*

¿Por qué `pattr` no congela el procesador ni genera cables cruzados cuando interpola 500 parámetros simultáneamente a 60 Hz?

### El Sistema Obex (Object Extensions) y la Tabla de Símbolos

En las primeras versiones de Max (Max 1 a 4), los objetos se comunicaban exclusivamente pasando punteros por inlets y outlets. Con la llegada de Max 5 y la arquitectura **Obex** (`ext_obex.h`), Cycling '74 dotó a todo objeto de una estructura extensible de **atributos registrados**:

```c
// En el SDK de Max (ext_obex.h):
t_max_err object_attr_register(t_object *x, t_object *attr);
t_max_err object_attr_getvalueof(t_object *x, t_symbol *s, long *argc, t_atom **argv);
t_max_err object_attr_setvalueof(t_object *x, t_symbol *s, long argc, t_atom *argv);
```

Cuando un objeto de UI (como `flonum`, `slider` o `live.dial`) se instancia en el patcher, implementa dos métodos especiales del protocolo Obex:
1. **`getvalueof`**: Devuelve su estado actual serializado como una lista de átomos (`t_atom`).
2. **`setvalueof`**: Recibe una lista de átomos y actualiza su estado interno **sin volver a disparar eventos de notificación redundantes** que provocarían rebotes infinitos.

### El Patrón Observer / Notification (`object_attach_byptr`)

`[pattrstorage]` y `[pattr]` funcionan utilizando el patrón de diseño **Observer** a nivel del kernel de C (tal como lo demuestra el ejemplo `shepherd.c` del SDK oficial):

```c
// shepherd.c del Max SDK
void shepherd_notify(t_shepherd *x, t_symbol *s, t_symbol *msg, void *sender, void *data) {
    if (msg == gensym("attr_modified")) {
        // Notificación de cambio de estado recibida desde el cliente
    }
}
```

1. Cuando `[pattr]` se enlaza a un objeto con `@bindto`, llama internamente a `object_attach_byptr()`.
2. El cliente pasa a estar en la tabla de observación hash (`t_hashtab`) del gestor.
3. Cuando modificas el dial, el objeto cliente emite una notificación ligera (`object_notify()`).
4. `[pattrstorage]` intercepta la notificación y actualiza su matriz interna en RAM en $O(1)$.

Durante el **morphing**, `[pattrstorage]` calcula los valores intermedios en memoria y llama directamente a `object_attr_setvalueof()` sobre los punteros de los objetos de destino. Esto ocurre en el **Main Thread** (a la tasa de refresco del scheduler gráfico), garantizando que el audio thread (DSP) no sufra interrupciones ni bloqueos de memoria.

---

##  4. 4 Escenarios del Mundo Real

Abre el parche interactivo complementario:
[`book/patches/modulo-02/laboratorio_05_pattr.maxpat`](/patches/modulo-02/laboratorio_05_pattr.maxpat)

### Escenario 1: Sistema de Snapshots y Presets para un Sintetizador
* **El Problema:** Un sintetizador sustractivo tiene 12 parámetros (formas de onda, cutoff, resonancia, ADSR). El músico necesita cambiar de un sonido de "Bajo Agresivo" a un "Pad Celestial" en pleno concierto con un solo comando MIDI o botón.
* **La Solución:** Conectar todos los controles a `[pattrstorage]` mediante scripting names. Con los mensajes `store 1` y `store 2` se guardan instantáneas completas en memoria; con `1` o `2` se restauran instantáneamente todos los controles en pantalla de forma coherente.

### Escenario 2: Morphing Temporal entre Estados Timbrales
* **El Problema:** Pasar abruptamente de un preset a otro rompe la continuidad tímbrica de la interpretación musical.
* **La Solución:** En lugar de enviar un número entero a `[pattrstorage]`, se envía un mensaje de interpolación temporizada: `recall 1 2 5000.`. A lo largo de 5 segundos, el sintetizador transmuta suavemente todos sus filtros, mezclas y envolventes de un estado al otro.

### Escenario 3: Interpolación Espacial 2D con `[nodes]`
* **El Problema:** En una instalación interactiva o en directo, el músico quiere mover un cursor en una superficie bidimensional $(X, Y)$ y que la posición física relative pondere la influencia de 4 presets simultáneos (Presets en las cuatro esquinas).
* **La Solución:** Conectar la salida multicanal de pesos ponderados de `[nodes]` al inlet de `[pattrstorage]` usando el modo de interpolación multivariable (`recall multi`).

### Escenario 4: Persistencia y Exportación a JSON
* **El Problema:** Al cerrar Max o reiniciar la computadora, todas las programaciones tímbricas creadas durante la sesión se perderían si no están guardadas en un archivo físico.
* **La Solución:** El comando `write mi_banco.json` de `[pattrstorage]` serializa el estado completo en un archivo JSON estructurado y portable que se puede versionar en Git o compartir con otros usuarios.

---

## 5. 3 Desafíos de Ingeniería de Laboratorio

Realiza estos ejercicios utilizando el parche interactivo [`laboratorio_05_pattr.maxpat`](/patches/modulo-02/laboratorio_05_pattr.maxpat):

###  Ejercicio 1: El Conmutador Inmune al Morphing (`@interp 0`)
* **Objetivo:** Configura un sintetizador donde los filtros y frecuencias se interpolen continuamente durante un morphing de 3 segundos, pero el selector de forma de onda (que conmuta entre Sine = 0, Saw = 1, Square = 2) cambie de forma discreta sin pasar por valores fraccionarios intermedios (como 0.45 o 1.7).
* **Pista:** Investiga el atributo `@interp` dentro del inspector de `[pattr]` o a través de la ventana `clientwindow` de `[pattrstorage]`.

###  Ejercicio 2: Automatización LFO de Morphing
* **Objetivo:** Conecta un oscilador de baja frecuencia (`[phasor~]` o un `[metro]` con `[line]`) a la entrada de interpolación continua de `[pattrstorage]` para crear un timbre que respire cíclicamente entre el Preset 1 y el Preset 2 cada 8 segundos.
* **Pista:** Escala una señal normalizada de 0.0 a 1.0 al mensaje `recall 1 2 $1`.

###  Ejercicio 3: Serializador y Restaurador Automático de Sesión
* **Objetivo:** Configura `[pattrstorage]` con los atributos `@savemode 2` y `@autorestore 1`.
* **Desafío:** Comprueba que al modificar sliders en el parche y guardar el archivo `.maxpat`, al cerrarlo y volverlo a abrir, Max reconstruye con precisión quirúrgica el último preset activo sin necesidad de presionar ningún botón manual.

---

## Resumen de Principios Arquitectónicos
1. **Desacoplamiento UI / Lógica:** Los controles gráficos no deben comunicarse punto a punto con cables hacia el motor de almacenamiento; deben unirse a través del protocolo Obex de `[pattr]`.
2. **Espacio de Estados Vectorial:** Los presets son coordenadas $\mathbb{R}^N$. La interpolación lineal (Lerp) permite navegar infinitos estados intermedios imposibles de diseñar a mano uno por uno.
3. **Control de Interpolación Selectiva:** No todos los parámetros son continuos. Los conmutadores lógicos, modos discretos y rutas deben protegerse con `@interp 0`.
4. **Gestión de Hilos Limpia:** Las lecturas y escrituras de `[pattrstorage]` ocurren en el Main Thread para mantener los buffers del Audio Thread (DSP) 100% libres de colisiones y glitches.
