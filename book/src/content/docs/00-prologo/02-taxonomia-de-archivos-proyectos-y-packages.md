---
title: "02. Taxonomía de Archivos, Proyectos y Packages"
description: "Estructura de documentos en Max/MSP: patchers (.maxpat), subpatchers [p], abstracciones, proyectos (.maxproj), Packages y Package Manager."
---

En el ecosistema de Max/MSP, un sistema rara vez consiste en un único archivo lineal. A medida que los diseños aumentan en complejidad, la modularización exige comprender la distinción exacta entre documentos locales, encapsulaciones internas, abstracciones reutilizables, proyectos estructurados y paquetes de distribución comunitaria.

---

## 1. Jerarquía de Documentos y Encapsulación

![Taxonomía de Documentos y Encapsulación](/assets/diagrams/diagrama_taxonomia_archivos.svg)

### 1.1. El Patcher Raíz (`.maxpat`)
* **Formato físico:** Archivo de texto plano serializado bajo el estándar **JSON** (JavaScript Object Notation).
* **Atajo de creación:** `Ctrl + N` (Windows) / `Cmd + N` (macOS).
* **Estructura interna:** Contiene un diccionario raíz con la clave `"patcher"`, donde se describen las dimensiones del lienzo (`rect`), la lista de cajas instanciadas (`boxes`) y la matriz de interconexión de cables (`lines`).
* **Comportamiento:** Constituye la unidad de trabajo fundamental que se guarda y abre desde el sistema de archivos del sistema operativo.

### 1.2. El Subpatcher (`[p nombre_subparche]`)
* **Definición:** Encapsulación puramente visual contenida dentro del archivo `.maxpat` padre.
* **Instanciación:** Crear un objeto con la tecla `N` y escribir `p filtro_principal` o `patcher filtro_principal`.
* **Comunicación con el exterior:**
  * Puertos de entrada: Objetos `[inlet]` (control) o `[inlet~]` (audio).
  * Puertos de salida: Objetos `[outlet]` (control) o `[outlet~]` (audio).
* **Ventajas e Inconvenientes:**
  * *Ventaja:* No genera archivos adicionales en disco; mantiene todo el algoritmo unificado en un único `.maxpat`.
  * *Inconveniente:* **No es reutilizable dinámicamente**. Si copias y pegas el subpatcher 10 veces y deseas modificar una línea de código, deberás editar manualmente las 10 copias una por una.

### 1.3. La Abstracción Modular (`.maxpat` independiente)
* **Definición:** Patcher guardado como archivo independiente en disco (ej. `mi_voz_sinte.maxpat`) que se invoca dentro de otro parche como si fuera un objeto nativo de Max: `[mi_voz_sinte]`.
* **Paso de Argumentos Paramétricos (`#1`, `#2`, `#3`):**
  * Dentro del archivo de la abstracción, los símbolos `#1`, `#2` son reemplazados en tiempo de instanciación por los argumentos pasados al objeto.
  * *Ejemplo:* Si en el parche padre escribes `[mi_voz_sinte 440 0.8]`, en el interior de la abstracción `#1` se sustituye por `440` y `#2` por `0.8`.
* **Espacio de Nombres Local (`#0`):**
  * Permite crear canales de comunicación remota locales e inmunes a colisiones: `[send #0_filtro]` y `[receive #0_filtro]`. Max sustituye `#0` por un número entero único para cada instancia activa en memoria.
* **Ventaja fundamental:** Si modificas el archivo `mi_voz_sinte.maxpat`, **todas las instancias abiertas en cualquier proyecto se actualizan simultáneamente**.

---

## 2. Proyectos de Max (`.maxproj`)

Cuando una aplicación integra múltiples abstracciones, muestras de audio (`.wav`, `.aif`), scripts en JavaScript (`.js`), bases de datos JSON y shaders de Jitter, el uso de archivos sueltos genera pérdidas de rutas relativas al compartir el trabajo.

* **Atajo de creación:** Menú **File**  **New Project...**
* **Funciones Técnicas del Proyecto:**
  1. **Consolidación de Rutas (*Search Paths*):** El archivo `.maxproj` añade automáticamente todas las subcarpetas del proyecto al árbol de búsqueda prioritario de Max.
  2. **Gestor de Dependencias:** Examina el grafo de objetos y lista los archivos externos necesarios.
  3. **Exportación Consolidada (*Collectives / Standalone*):** Permite compilar todo el árbol de archivos en un binario colectivo (`.mxf`) o en una aplicación ejecutable autónoma (`.exe` para Windows o `.app` para macOS) que no requiere que el usuario final posea licencia de Max.

---

## 3. El Ecosistema de Packages y el Package Manager

Un **Package** es el estándar canónico de distribución modular establecido por Cycling '74 para bibliotecas de gran escala, colecciones de objetos externos en C/C++, extensiones de Node for Max y frameworks de investigación académica.

### 3.1. Estructura Canónica de un Package
En disco (ubicado en `Documentos/Max 8/Packages/nombre_paquete/`), un paquete debe respetar la siguiente topología de carpetas:

![FIG 0.4 · Topología Canónica de un Package y Librerías Académicas Destacadas](/assets/diagrams/diagrama_package_manager_topologia.svg)

---

## 4. Rutas de Búsqueda del Sistema (*Search Paths*)

Cuando se escribe el nombre de un objeto o se carga un archivo de audio mediante su nombre relativo (`[buffer~ muestra drumloop.wav]`), Max busca el archivo respetando un orden de precedencia estricto:

![Árbol de Resolución de Rutas de Búsqueda](/assets/diagrams/diagrama_search_paths.svg)

### Configuración Manual en *File Preferences*:
Para incorporar directorios personalizados (por ejemplo, una unidad de red o una carpeta compartida de proyectos en Git):
1. Ir a **Options**  **File Preferences...**
2. Hacer clic en el botón `+` para añadir una nueva ruta absoluta.
3. Marcar la casilla **Subfolders** si se desea que Max indexe recursivamente todos los subdirectorios.
