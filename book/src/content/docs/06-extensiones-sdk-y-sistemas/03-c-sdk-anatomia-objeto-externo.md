---
title: "Módulo 6.3: El SDK de C de Max: Anatomía de un Objeto Externo Nativo"
description: "El SDK de C de Cycling '74: ciclo de vida de un external (ext_main, new, free), tabla de despacho, tipos de argumentos A_LONG/A_FLOAT/A_GIMME y thread-safety elemental."
---


Llegamos a la capa más profunda y fundamental de toda la plataforma: **el Cycling '74 Max C SDK**.
Todos los objetos que usamos habitualmente en Max (`[cycle~]`, `[metro]`, `[biquad~]`, `[dict]`) no son magia negra: son librerías dinámicas (`.mxe64` en Windows, `.mxo` bundle en macOS) compiladas en C o C++ que implementan una interfaz binaria de aplicación (ABI) estricta contra el motor central de Max.

Aprender a programar objetos externos (*externals*) en C te da control total sobre la memoria, vectorización SIMD nativa, bindings directos con hardware, GPU y bibliotecas científicas en C/C++ o Rust.

---

## 1. El Ciclo de Vida de un External en C

Un objeto de Max en C sigue una arquitectura clásica orientada a objetos en C puro mediante structs opacos y tablas de despacho:

![FIG 6.3 · ext_main, class_new & Tabla de Despacho en Memoria](/assets/diagrams/diagrama_c_sdk_ciclo_vida.svg)

### 1.1. Los Cuatro Elementos del Código Fuente C

1. **Estructura del Objeto (`t_object`)**:
   Todo external debe comenzar obligatoriamente con el struct base `t_object` (para objetos de control) o `t_pxobject` (para objetos de audio MSP). Esto garantiza la herencia binaria por puntero:
   ```c
   typedef struct _mi_objeto {
       t_object ob;          // Cabecera obligatoria de Max (debe ser el primer campo)
       long valor_interno;   // Estado interno del objeto
       void *salida_bang;    // Puntero opaco al outlet
       void *salida_datos;
   } t_mi_objeto;
   ```
2. **El Punto de Entrada: `ext_main`**:
   Es la función exportada que Max busca cuando encuentra la caja en el patcher. Inicializa la clase en el registro global:
   ```c
   void *mi_objeto_class;

   void ext_main(void *r) {
       t_class *c;
       c = class_new("mi_objeto", (method)mi_objeto_new, (method)mi_objeto_free,
                     (long)sizeof(t_mi_objeto), 0L, A_GIMME, 0);
       
       // Enlazamos mensajes a funciones de C
       class_addmethod(c, (method)mi_objeto_bang, "bang", 0);
       class_addmethod(c, (method)mi_objeto_int, "int", A_LONG, 0);
       
       class_register(CLASS_BOX, c);
       mi_objeto_class = c;
   }
   ```
3. **Constructor `mi_objeto_new` y Destructor `mi_objeto_free`**:
   - `object_alloc(mi_objeto_class)` aloca la memoria inicial.
   - Se crean los outlets usando `outlet_new()` o `bangout()`.
   - En el destructor, se libera cualquier memoria dinámica alocada con `sysmem_freeptr()`.

---

## 2. Tipos de Argumentos de la API de Max (`A_LONG`, `A_FLOAT`, `A_GIMME`)

Max provee un sistema de tipado dinámico para la firma de métodos:
- `A_LONG`: Entero de 32 o 64 bits (`long`).
- `A_FLOAT`: Punto flotante (`double`).
- `A_SYM`: Puntero a símbolo único interning de Max (`t_symbol *`).
- `A_GIMME`: Permite recibir una lista arbitraria de argumentos como una tupla `(short argc, t_atom *argv)`. Un `t_atom` es una unión etiquetada que representa un entero, flotante, símbolo u objeto.

---

## 3. Código Fuente Educativo: `mi_objeto_externo.c`

En esta lección proveemos el archivo de referencia completo `mi_objeto_externo.c` listo para ser compilado con CMake y el SDK oficial, ilustrando:
- Manejo correcto de `A_GIMME` y átomos.
- Comprobación de tipos en runtime con `atom_gettype()`.
- Thread-safety elemental: evitar llamar funciones de interfaz gráfica desde el Scheduler thread.

---

## 4. Laboratorio Práctico: `laboratorio_24_c_sdk_concept.maxpat`

Para inspeccionar la interacción entre el patcher y los objetos externos en C:
- Abrir el parche conceptual: [`book/patches/modulo-06/laboratorio_24_c_sdk_concept.maxpat`](/patches/modulo-06/laboratorio_24_c_sdk_concept.maxpat)
- Código fuente C descargable: [`book/patches/modulo-06/mi_objeto_externo.c`](/patches/modulo-06/mi_objeto_externo.c)
