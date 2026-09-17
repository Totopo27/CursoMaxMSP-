---
title: "Módulo 6.3: El SDK de C de Max: Anatomía de un Objeto Externo Nativo"
description: "El SDK de C de Cycling '74 y Eric Lyon: ciclo de vida de un external MSP (t_pxobject, dsp64, perform64), atributos Obex, gestión de memoria con sysmem y thread-safety estricto."
---


Llegamos a la capa más profunda, potente y fundamental de toda la plataforma: **el Cycling '74 Max C SDK**.
Todos los objetos que usamos habitualmente en Max (`[cycle~]`, `[metro]`, `[biquad~]`, `[dict]`) no son magia negra: son librerías dinámicas (`.mxe64` en Windows, `.mxo` bundle en macOS) compiladas en C o C++ que implementan una interfaz binaria de aplicación (ABI) estricta contra el motor central de Max.

Aprender a programar objetos externos (*externals*) en C te da control absoluto sobre los ciclos de CPU, vectorización SIMD nativa, bindings directos con hardware y bibliotecas científicas o de audio en C/C++ o Rust.

*(Fundamentado en el tratado canónico de **Eric Lyon**, Designing Audio Objects for Max/MSP and Pd, y en la documentación oficial del Cycling '74 Max SDK).*

---

## 1. Arquitectura de Clases: Control (`t_object`) vs. Audio MSP (`t_pxobject`)

En la API de C de Max, la orientación a objetos se implementa mediante herencia binaria en C99 basada en la alineación estricta de estructuras (`structs`):

```c
// 1. Objeto de Control Puro (Max Core)
typedef struct _mi_control {
    t_object ob;          // Cabecera base obligatoria de Max
    long     contador;
} t_mi_control;

// 2. Objeto de Audio DSP (MSP)
typedef struct _mi_audio {
    t_pxobject ob;        // Cabecera obligatoria de MSP (incluye t_object + estado DSP)
    double     phase;
    double     *wavetable;
    long       table_length;
} t_mi_audio;
```

> [!CRITICAL]
> **Herencia Binaria por Puntero**: El primer campo de la estructura de un objeto MSP **debe ser obligatoriamente `t_pxobject`**. Esto permite al motor de Max castear libremente un puntero `t_mi_audio *` hacia `t_pxobject *` o `t_object *` sin desplazamiento de memoria (*zero pointer offset*).

---

## 2. El Ciclo de Vida: `ext_main`, Registro de Clase e Inicialización DSP

Toda librería dinámica exporta una función obligatoria denominada `ext_main(void *r)`, la cual se ejecuta una única vez cuando Max carga el objeto en memoria:

```c
#include "ext.h"
#include "z_dsp.h"
#include "ext_obex.h"

static t_class *mi_objeto_class = NULL;

void ext_main(void *r) {
    t_class *c = class_new("mi_objeto_msp~",
                           (method)mi_objeto_new,
                           (method)mi_objeto_free,
                           sizeof(t_mi_objeto),
                           0L,
                           A_GIMME,
                           0);

    // 1. Registrar metodos de despacho
    class_addmethod(c, (method)mi_objeto_dsp64,  "dsp64",  A_CANT, 0);
    class_addmethod(c, (method)mi_objeto_assist, "assist", A_CANT, 0);

    // 2. Inicializar el subsistema MSP (vital para vincular inlets de senal)
    class_dspinit(c);

    // 3. Declarar atributos Obex inspeccionables
    CLASS_ATTR_DOUBLE(c, "frequency", 0, t_mi_objeto, a_frequency);
    CLASS_ATTR_LABEL(c, "frequency", 0, "Frecuencia Base (Hz)");

    class_register(CLASS_BOX, c);
    mi_objeto_class = c;
}
```

---

## 3. El Grafo de Procesamiento: El Método `dsp64`

A diferencia de los objetos de control que procesan eventos bajo demanda, los objetos MSP deben integrarse dentro del **árbol de compilación de audio**. Cuando el usuario enciende el audio (`startwindow`) o cambia la frecuencia de muestreo, Max invoca la función `dsp64`:

```c
void mi_objeto_dsp64(t_mi_objeto *x, t_object *dsp64, short *count, 
                     double sr, long n, long flags) 
{
    x->samplerate = sr;
    x->phase_step = x->a_frequency / sr;

    // El array count[] indica si hay cables de senal conectados:
    if (count[0]) {
        // Inlet 0 tiene un cable de senal conectado (frecuencia modulada continua)
        object_method(dsp64, gensym("dsp_add64"), x, mi_objeto_perform64, 0, NULL);
    } else {
        // Inlet 0 solo recibe floats de control (ahorro de CPU)
        object_method(dsp64, gensym("dsp_add64"), x, mi_objeto_perform_nosig64, 0, NULL);
    }
}
```

### La Optimización de Eric Lyon: Conmutación de `perform` por Conectividad
Como formaliza Eric Lyon en *Designing Audio Objects*, evaluar una señal de audio cuando el usuario no conectó ningún cable es un desperdicio inaceptable de ciclos de reloj. Inspeccionando el array `count[]` en `dsp64`, registramos dinámicamente una rutina de ejecución optimizada (`perform_nosig64`) que saltea la lectura de buffers en memoria caché.

---

## 4. El Corazón del Rendimiento: La Rutina `perform64`

La función `perform64` se ejecuta ininterrumpidamente dentro del **Audio Thread** a la tasa fijada por el Signal Vector Size (por ejemplo, cada 64 muestras):

```c
void mi_objeto_perform64(t_mi_objeto *x, t_object *dsp64, 
                         double **ins, long numins, 
                         double **outs, long numouts, 
                         long sampleframes, long flags, void *userparam) 
{
    t_double *in_freq = ins[0];
    t_double *out     = outs[0];
    long n            = sampleframes;
    double ph         = x->phase;
    double sr_inv     = 1.0 / x->samplerate;
    double *table     = x->wavetable;
    long tbl_len      = x->table_length;

    while (n--) {
        // 1. Lectura interpolada en wavetable O(1)
        double findex = ph * (double)tbl_len;
        long idx = (long)findex;
        *out++ = table[idx];

        // 2. Modulacion y avance del acumulador de fase
        double f = *in_freq++;
        ph += (f * sr_inv);
        if (ph >= 1.0) ph -= 1.0;
        else if (ph < 0.0) ph += 1.0;
    }
    x->phase = ph;
}
```

---

## 5. Las Cuatro Leyes Sagradas del Audio Thread ("La Zona de Muerte")

El hilo de procesamiento de audio opera con la prioridad más alta del sistema operativo. Si tu función `perform64` se demora más tiempo del asignado por el buffer vector ($64 / 48.000 \approx 1.33\text{ ms}$), el conversor digital se queda sin datos y se produce un **dropout** (*buffer underrun / click*).

1. **PROHIBIDO alocar o liberar memoria dinámica**:
   Jamas ejecutes `malloc()`, `free()`, `new`, `sysmem_newptr()` ni `sysmem_freeptr()` dentro de `perform64`. Estas llamadas solicitan memoria al kernel del sistema operativo, lo que puede provocar un bloqueo de hilo (*priority inversion*). Toda la memoria debe pre-alocarse en el constructor `_new` o en `_dsp64`.
2. **PROHIBIDO realizar operaciones de E/S bloqueantes**:
   Nada de `printf()`, `fopen()`, lecturas de disco, sockets de red ni llamadas a bases de datos.
3. **PROHIBIDO bloquear mutexes sin try-lock**:
   Si el Main Thread tiene bloqueado un mutex para actualizar la interfaz gráfica y el Audio Thread intenta adquirirlo, el audio se congelará instantáneamente.
4. **Saneamiento de Números Desnormalizados (*Denormals / Underflow*)**:
   Cuando una señal de audio dentro de un filtro o delay exponencial decae hacia cero absoluto, los valores flotantes caen en el rango subnormal ($< 10^{-38}$ en IEEE 754). El procesador entra en un modo de emulación por microcódigo que **puede multiplicar el uso de CPU por un factor de 50x**.
   *Solución en C:*
   ```c
   // Anti-denormal macro de Eric Lyon
   #define FIX_DENORM_DOUBLE(v) if((*(unsigned long long*)&(v)&0x7fe0000000000000ULL)==0) (v)=0.0
   ```

---

## 6. Gestión de Memoria en Max: La Familia `sysmem`

En Max no se utiliza `malloc()` ni `free()` de la biblioteca estándar de C. Cycling '74 provee su propio subsistema de gestión de memoria:
- **`sysmem_newptr(tamano_bytes)`**: Aloca bloques de memoria alineados a nivel de palabra para aceleración SIMD/AVX2.
- **`sysmem_resizeptr(puntero, nuevo_tamano)`**: Redimensiona el bloque preservando el contenido previo.
- **`sysmem_freeptr(puntero)`**: Libera la memoria de forma segura.

---

## 7. Comunicación Segura hacia la Interfaz: El Objeto `qelem`

¿Cómo enviamos datos desde el Audio Thread (como el nivel de pico de un medidor RMS) hacia la interfaz gráfica de Max sin violar las leyes de tiempo real?

Max provee el mecanismo **`t_qelem`** (*Queue Element*):

```
[ perform64 (Audio Thread) ] ──> qelem_set(x->qelem_gui)
                                            │
                                            ▼
                           [ Event Loop de Max (Main Thread) ]
                                            │
                                            ▼
                          mi_objeto_qelem_callback() ──> outlet_float(out, peak)
```

1. En el Audio Thread, cuando calculamos un nuevo valor de pico, ejecutamos `qelem_set(x->qelem_gui)`. Esta llamada es atómica, libre de bloqueos y toma menos de 10 nanosegundos.
2. Si el Audio Thread llama a `qelem_set` 100 veces por segundo, `qelem` **colapsa los eventos redundantes**, ejecutando el callback en el hilo principal solo cuando la GUI está libre para refrescar pantalla.

---

## 8. Laboratorio Práctico: Compilación y Uso de `mi_objeto_msp~`

En los archivos complementarios de este módulo proveemos la implementación profesional completa:
- Código fuente C de referencia: [`book/patches/modulo-06/mi_objeto_msp.c`](/patches/modulo-06/mi_objeto_msp.c)
- Parche interactivo de prueba: [`book/patches/modulo-06/laboratorio_24_c_sdk_concept.maxpat`](/patches/modulo-06/laboratorio_24_c_sdk_concept.maxpat)

### Pasos para Compilar con CMake y Visual Studio / Xcode:
1. Clonar el repositorio oficial: `git clone --recursive https://github.com/Cycling74/max-sdk.git`
2. Copiar `mi_objeto_msp.c` dentro de `max-sdk/source/audio/`.
3. Generar el proyecto de compilación:
   ```bash
   mkdir build && cd build
   cmake .. -G "Visual Studio 17 2022" -A x64   # En Windows
   cmake .. -G "Xcode"                          # En macOS
   ```
4. Compilar en modo Release: obtendrás el archivo binario `mi_objeto_msp~.mxe64` (Windows) o `mi_objeto_msp~.mxo` (macOS) listo para ser arrastrado al lienzo de Max.
