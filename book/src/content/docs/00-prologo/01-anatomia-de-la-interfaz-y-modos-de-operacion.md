---
title: "01. Anatomía de la Interfaz y Modos de Operación"
description: "Fundamentos del entorno de desarrollo visual en Max/MSP: modos de ejecución, presentación, inspector y atajos esenciales."
---

El entorno de desarrollo interactivo de Max/MSP está fundamentado en un lienzo gráfico (*patcher canvas*) diseñado para prototipar, programar y ejecutar algoritmos en tiempo real. Antes de estudiar el flujo de datos o la matemática de señales, es indispensable dominar las dinámicas operativas de su interfaz de usuario.

---

## 1. Los Tres Modos de Operación del Lienzo

La interacción con cualquier documento en Max oscila entre tres estados fundamentales:

<div class="editorial-diagram-container not-content">
  <div class="diagram-header">
    <span class="diagram-title">MÁQUINA DE ESTADOS DEL LIENZO</span>
    <span class="diagram-tag">FIG 0.1 · CONTROL DE FLUJO Y VISTAS</span>
  </div>
  <svg viewBox="0 0 860 260" xmlns="http://www.w3.org/2000/svg" style="font-family: var(--sl-font-system, -apple-system, sans-serif);">
    <defs>
      <!-- Marcador de flecha neutral -->
      <marker id="arr-neutral" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
        <path d="M 0 1.5 L 8 5 L 0 8.5 z" fill="#71717a"/>
      </marker>
      <!-- Marcador de flecha de acento (coral) -->
      <marker id="arr-accent" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
        <path d="M 0 1.5 L 8 5 L 0 8.5 z" fill="#eb6c36"/>
      </marker>
    </defs>

    <!-- NODO 1: MODO EDICIÓN (Focal inicial: borde solido e icono) -->
    <g transform="translate(30, 45)">
      <rect width="230" height="120" rx="6" fill="#18181b" stroke="#3f3f46" stroke-width="1.5" />
      <rect width="230" height="28" rx="6" fill="#27272a" />
      <rect y="22" width="230" height="6" fill="#27272a" />
      <text x="14" y="19" fill="#a1a1aa" font-family="var(--sl-font-mono, monospace)" font-size="10" font-weight="700" letter-spacing="0.06em">ESTADO 01 · UNLOCKED</text>
      <text x="14" y="58" fill="#f4f4f5" font-size="16" font-weight="700">Modo Edición</text>
      <text x="14" y="80" fill="#a1a1aa" font-size="12">Construcción y cableado</text>
      <text x="14" y="100" fill="#71717a" font-family="var(--sl-font-mono, monospace)" font-size="11">Candado abierto · Puntero libre</text>
      <!-- Tag shortcut -->
      <rect x="145" y="44" width="72" height="20" rx="4" fill="#27272a" stroke="#52525b" stroke-width="1" />
      <text x="181" y="58" fill="#e4e4e7" font-family="var(--sl-font-mono, monospace)" font-size="10" font-weight="600" text-anchor="middle">Ctrl + E</text>
    </g>

    <!-- NODO 2: MODO BLOQUEADO / EJECUCIÓN -->
    <g transform="translate(315, 45)">
      <rect width="230" height="120" rx="6" fill="#18181b" stroke="#3f3f46" stroke-width="1.5" />
      <rect width="230" height="28" rx="6" fill="#27272a" />
      <rect y="22" width="230" height="6" fill="#27272a" />
      <text x="14" y="19" fill="#a1a1aa" font-family="var(--sl-font-mono, monospace)" font-size="10" font-weight="700" letter-spacing="0.06em">ESTADO 02 · LOCKED</text>
      <text x="14" y="58" fill="#f4f4f5" font-size="16" font-weight="700">Modo Ejecución</text>
      <text x="14" y="80" fill="#a1a1aa" font-size="12">Interacción en tiempo real</text>
      <text x="14" y="100" fill="#71717a" font-family="var(--sl-font-mono, monospace)" font-size="11">Topología fija · Controles activos</text>
      <!-- Tag shortcut -->
      <rect x="145" y="44" width="72" height="20" rx="4" fill="#27272a" stroke="#52525b" stroke-width="1" />
      <text x="181" y="58" fill="#e4e4e7" font-family="var(--sl-font-mono, monospace)" font-size="10" font-weight="600" text-anchor="middle">Ctrl + E</text>
    </g>

    <!-- NODO 3: MODO PRESENTACIÓN (Nodo focal con acento coral) -->
    <g transform="translate(600, 45)">
      <rect width="230" height="120" rx="6" fill="#1c1613" stroke="#eb6c36" stroke-width="1.5" />
      <rect width="230" height="28" rx="6" fill="rgba(235, 108, 54, 0.18)" />
      <rect y="22" width="230" height="6" fill="rgba(235, 108, 54, 0.18)" />
      <text x="14" y="19" fill="#eb6c36" font-family="var(--sl-font-mono, monospace)" font-size="10" font-weight="700" letter-spacing="0.06em">ESTADO 03 · GUI FINAL</text>
      <text x="14" y="58" fill="#f4f4f5" font-size="16" font-weight="700">Presentación</text>
      <text x="14" y="80" fill="#d4d4d8" font-size="12">Panel limpio desacoplado</text>
      <text x="14" y="100" fill="#eb6c36" font-family="var(--sl-font-mono, monospace)" font-size="11">Cables y cómputo ocultos</text>
      <!-- Tag shortcut -->
      <rect x="135" y="44" width="82" height="20" rx="4" fill="rgba(235, 108, 54, 0.25)" stroke="#eb6c36" stroke-width="1" />
      <text x="176" y="58" fill="#ffedd5" font-family="var(--sl-font-mono, monospace)" font-size="10" font-weight="700" text-anchor="middle">Ctrl+Alt+E</text>
    </g>

    <!-- CONEXIONES ORTOGONALES CON MÁSCARA -->
    <!-- Transición 1: Edición <-> Bloqueado (Ida superior) -->
    <path d="M 260 85 L 315 85" fill="none" stroke="#71717a" stroke-width="1.5" marker-end="url(#arr-neutral)" />
    <!-- Transición 2: Bloqueado <-> Edición (Vuelta inferior) -->
    <path d="M 315 125 L 260 125" fill="none" stroke="#71717a" stroke-width="1.5" marker-end="url(#arr-neutral)" />

    <!-- Transición hacia Presentación (Conector focal coral) -->
    <path d="M 545 105 L 600 105" fill="none" stroke="#eb6c36" stroke-width="1.5" marker-end="url(#arr-accent)" />

    <!-- Ciclo inferior de retorno desde Presentación a Edición -->
    <path d="M 715 165 L 715 215 L 145 215 L 145 165" fill="none" stroke="#eb6c36" stroke-dasharray="4,4" stroke-width="1.2" marker-end="url(#arr-accent)" />
    <rect x="360" y="205" width="160" height="20" rx="3" fill="#121318" stroke="#3f3f46" stroke-width="1" />
    <text x="440" y="219" fill="#a1a1aa" font-family="var(--sl-font-mono, monospace)" font-size="10" font-weight="600" text-anchor="middle">Reanudar edición: Ctrl+Alt+E</text>

    <!-- Rótulo de la transición bidireccional Edición/Bloqueo -->
    <rect x="270" y="96" width="36" height="18" rx="2" fill="#121318" />
    <text x="288" y="109" fill="#71717a" font-family="var(--sl-font-mono, monospace)" font-size="9" text-anchor="middle">toggle</text>
  </svg>
</div>

### 1.1. Modo Edición (*Unlocked Mode*)
* **Atajo de conmutación:** `Ctrl + E` (Windows) / `Cmd + E` (macOS).
* **Indicador visual:** El icono de candado en la esquina inferior izquierda de la ventana permanece **abierto**; el cursor del ratón adopta la forma de flecha estándar o cruz de selección.
* **Comportamiento:**
  * Permite crear, mover, redimensionar y eliminar objetos.
  * Habilita el trazado de cables (*patchcords*) entre puertos de entrada (*inlets*) y salida (*outlets*).
  * No responde a la manipulación interactiva de sliders, botones o cajas de número mediante arrastre estándar (al hacer clic sobre un objeto, este se selecciona para edición).

### 1.2. Modo Bloqueado o Ejecución (*Locked Mode*)
* **Atajo de conmutación:** `Ctrl + E`.
* **Indicador visual:** El icono de candado inferior se encuentra **cerrado**.
* **Comportamiento:**
  * La topología gráfica queda fija e inmutable (no es posible mover cajas ni desconectar cables por accidente).
  * Los controles interactivos cobran vida: los botones disparan eventos (*bang*), los conmutadores (*toggles*) alternan entre 0 y 1, y los sliders o campos numéricos modifican su valor al arrastrar el ratón.
  * **Técnica de Bloqueo Temporal (*Temporary Lock*):** Estando en Modo Edición, es posible interactuar momentáneamente con un objeto sin cambiar de modo manteniendo presionada la tecla `Ctrl` (Windows) o `Cmd` (macOS) y haciendo clic sobre el control.

### 1.3. Modo Presentación (*Presentation Mode*)
* **Atajo de conmutación:** `Ctrl + Alt + E`.
* **Inclusión de objetos:** `Ctrl + Alt + P` (*Add to Presentation* / *Remove from Presentation*).
* **Propósito:** Separar la lógica computacional del diseño de usuario. Permite construir una interfaz gráfica limpia (GUI) exhibiendo únicamente faders, medidores y perillas, mientras que la compleja red de cables, operaciones lógicas y objetos auxiliares permanece oculta en el fondo.

<div class="editorial-diagram-container not-content">
  <div class="diagram-header">
    <span class="diagram-title">ARQUITECTURA DE VISTAS · PATCHING VS. PRESENTACIÓN</span>
    <span class="diagram-tag">FIG 0.3 · DESACOPLAMIENTO DE LÓGICA Y GUI</span>
  </div>
  <svg viewBox="0 0 860 280" xmlns="http://www.w3.org/2000/svg" style="font-family: var(--sl-font-system, -apple-system, sans-serif);">
    <!-- PANEL IZQUIERDO: VISTA DE PARCHEO -->
    <g transform="translate(15, 15)">
      <rect width="405" height="250" rx="6" fill="#18181b" stroke="#3f3f46" stroke-width="1.5" />
      <rect width="405" height="32" rx="6" fill="#27272a" />
      <rect y="26" width="405" height="6" fill="#27272a" />
      <text x="16" y="21" fill="#f4f4f5" font-family="var(--sl-font-mono, monospace)" font-size="11" font-weight="700">VISTA DE PARCHEO (PATCHING)</text>
      <text x="310" y="21" fill="#a1a1aa" font-family="var(--sl-font-mono, monospace)" font-size="10">Ctrl + E</text>

      <!-- Simulación de Red de Cables Compleja -->
      <!-- Objeto r freq -->
      <rect x="25" y="55" width="80" height="24" rx="3" fill="#27272a" stroke="#52525b" stroke-width="1" />
      <text x="65" y="71" fill="#e4e4e7" font-family="var(--sl-font-mono, monospace)" font-size="10" text-anchor="middle">r freq</text>

      <!-- Objeto mtof -->
      <rect x="130" y="55" width="60" height="24" rx="3" fill="#27272a" stroke="#52525b" stroke-width="1" />
      <text x="160" y="71" fill="#e4e4e7" font-family="var(--sl-font-mono, monospace)" font-size="10" text-anchor="middle">mtof</text>

      <!-- Objeto cycle~ -->
      <rect x="215" y="55" width="75" height="24" rx="3" fill="#27272a" stroke="#52525b" stroke-width="1" />
      <text x="252" y="71" fill="#e4e4e7" font-family="var(--sl-font-mono, monospace)" font-size="10" text-anchor="middle">cycle~</text>

      <!-- Cables -->
      <path d="M 65 79 L 65 110 L 140 110 L 140 125" fill="none" stroke="#71717a" stroke-width="1.5" />
      <path d="M 160 79 L 160 125" fill="none" stroke="#71717a" stroke-width="1.5" />
      <path d="M 252 79 L 252 110 L 180 110 L 180 125" fill="none" stroke="#71717a" stroke-width="1.5" />

      <!-- Objeto lores~ -->
      <rect x="120" y="125" width="130" height="26" rx="3" fill="#27272a" stroke="#52525b" stroke-width="1" />
      <text x="185" y="142" fill="#e4e4e7" font-family="var(--sl-font-mono, monospace)" font-size="10" text-anchor="middle">lores~ 1200 0.8</text>

      <!-- Cable hacia salida -->
      <path d="M 185 151 L 185 180" fill="none" stroke="#3b82f6" stroke-width="1.8" />

      <!-- Objeto ezdac~ -->
      <rect x="145" y="180" width="80" height="32" rx="3" fill="#27272a" stroke="#3b82f6" stroke-width="1.5" />
      <circle cx="165" cy="196" r="4" fill="#3b82f6" />
      <circle cx="205" cy="196" r="4" fill="#3b82f6" />
      <text x="185" y="200" fill="#93c5fd" font-family="var(--sl-font-mono, monospace)" font-size="9" text-anchor="middle">ezdac~</text>

      <!-- Leyenda descriptiva -->
      <text x="202" y="235" fill="#71717a" font-size="11" text-anchor="middle">Cables de señal, control y lógica computacional expuestos</text>
    </g>

    <!-- PANEL DERECHO: VISTA DE PRESENTACIÓN (GUI FOCAL) -->
    <g transform="translate(440, 15)">
      <rect width="405" height="250" rx="6" fill="#1c1613" stroke="#eb6c36" stroke-width="1.5" />
      <rect width="405" height="32" rx="6" fill="rgba(235, 108, 54, 0.18)" />
      <rect y="26" width="405" height="6" fill="rgba(235, 108, 54, 0.18)" />
      <text x="16" y="21" fill="#eb6c36" font-family="var(--sl-font-mono, monospace)" font-size="11" font-weight="700">VISTA DE PRESENTACIÓN (GUI)</text>
      <text x="290" y="21" fill="#fed7aa" font-family="var(--sl-font-mono, monospace)" font-size="10">Ctrl + Alt + E</text>

      <!-- Control Dial 1 (Corte) -->
      <g transform="translate(60, 65)">
        <circle cx="35" cy="35" r="28" fill="#27272a" stroke="#eb6c36" stroke-width="2" />
        <line x1="35" y1="35" x2="52" y2="20" stroke="#ffedd5" stroke-width="2.5" stroke-linecap="round" />
        <text x="35" y="85" fill="#ffedd5" font-family="var(--sl-font-mono, monospace)" font-size="10" font-weight="700" text-anchor="middle">CORTE</text>
        <text x="35" y="100" fill="#fed7aa" font-family="var(--sl-font-mono, monospace)" font-size="9" text-anchor="middle">1.200 Hz</text>
      </g>

      <!-- Control Dial 2 (Resonancia) -->
      <g transform="translate(170, 65)">
        <circle cx="35" cy="35" r="28" fill="#27272a" stroke="#eb6c36" stroke-width="2" />
        <line x1="35" y1="35" x2="20" y2="22" stroke="#ffedd5" stroke-width="2.5" stroke-linecap="round" />
        <text x="35" y="85" fill="#ffedd5" font-family="var(--sl-font-mono, monospace)" font-size="10" font-weight="700" text-anchor="middle">RESONANCIA</text>
        <text x="35" y="100" fill="#fed7aa" font-family="var(--sl-font-mono, monospace)" font-size="9" text-anchor="middle">0.80 Q</text>
      </g>

      <!-- Fader de Salida Master -->
      <g transform="translate(295, 60)">
        <rect x="0" y="0" width="40" height="110" rx="4" fill="#27272a" stroke="#52525b" stroke-width="1" />
        <!-- Barra de nivel verde/naranja -->
        <rect x="6" y="30" width="28" height="74" rx="2" fill="#10b981" />
        <rect x="6" y="20" width="28" height="8" rx="1" fill="#eb6c36" />
        <text x="20" y="130" fill="#ffedd5" font-family="var(--sl-font-mono, monospace)" font-size="10" font-weight="700" text-anchor="middle">MASTER</text>
        <text x="20" y="145" fill="#fed7aa" font-family="var(--sl-font-mono, monospace)" font-size="9" text-anchor="middle">-6.0 dB</text>
      </g>

      <!-- Leyenda descriptiva -->
      <text x="202" y="235" fill="#fed7aa" font-size="11" text-anchor="middle">Interfaz de usuario depurada: cero cables a la vista para el intérprete</text>
    </g>
  </svg>
</div>

---

## 2. Topología Perimetral de la Ventana

El marco de trabajo de Max organiza sus herramientas en cuatro barras perimetrales que rodean el lienzo central:

<div class="editorial-diagram-container not-content">
  <div class="diagram-header">
    <span class="diagram-title">TOPOLOGÍA PERIMETRAL DEL PATCHER</span>
    <span class="diagram-tag">FIG 0.2 · DISTRIBUCIÓN DE HERRAMIENTAS</span>
  </div>
  <svg viewBox="0 0 860 380" xmlns="http://www.w3.org/2000/svg" style="font-family: var(--sl-font-system, -apple-system, sans-serif);">
    <!-- Marco Exterior de la Ventana -->
    <rect x="15" y="15" width="830" height="350" rx="8" fill="#18181b" stroke="#3f3f46" stroke-width="1.5" />

    <!-- BARRA SUPERIOR (TOP TOOLBAR) -->
    <rect x="15" y="15" width="830" height="50" rx="8" fill="#27272a" />
    <rect x="15" y="55" width="830" height="10" fill="#27272a" />
    <line x1="15" y1="65" x2="845" y2="65" stroke="#3f3f46" stroke-width="1" />
    <text x="35" y="44" fill="#f4f4f5" font-family="var(--sl-font-mono, monospace)" font-size="12" font-weight="700">TOP TOOLBAR</text>
    <text x="160" y="44" fill="#a1a1aa" font-size="12">Paleta de Creación Rápida: [ N ] Objeto · [ M ] Mensaje · [ C ] Comentario · [ B ] Bang · [ T ] Toggle</text>

    <!-- BARRA LATERAL IZQUIERDA (LEFT TOOLBAR) -->
    <rect x="15" y="65" width="160" height="250" fill="#202024" />
    <line x1="175" y1="65" x2="175" y2="315" stroke="#3f3f46" stroke-width="1" />
    <text x="30" y="95" fill="#a1a1aa" font-family="var(--sl-font-mono, monospace)" font-size="11" font-weight="700">LEFT TOOLBAR</text>
    <g transform="translate(30, 115)">
      <circle cx="6" cy="6" r="3" fill="#71717a" />
      <text x="18" y="10" fill="#d4d4d8" font-size="12">Explorador de Archivos</text>
    </g>
    <g transform="translate(30, 145)">
      <circle cx="6" cy="6" r="3" fill="#71717a" />
      <text x="18" y="10" fill="#d4d4d8" font-size="12">Package Manager</text>
    </g>
    <g transform="translate(30, 175)">
      <circle cx="6" cy="6" r="3" fill="#71717a" />
      <text x="18" y="10" fill="#d4d4d8" font-size="12">Snippets de Código</text>
    </g>
    <g transform="translate(30, 205)">
      <circle cx="6" cy="6" r="3" fill="#71717a" />
      <text x="18" y="10" fill="#d4d4d8" font-size="12">Plugins de Audio VST</text>
    </g>

    <!-- LIENZO CENTRAL (CANVAS - ZONA FOCAL) -->
    <rect x="195" y="80" width="460" height="220" rx="6" fill="#121316" stroke="#27272a" stroke-width="1.5" />
    <!-- Marca de agua de fondo del lienzo -->
    <text x="425" y="150" fill="#27272a" font-family="var(--sl-font-mono, monospace)" font-size="18" font-weight="700" text-anchor="middle" letter-spacing="0.1em">PATCHER CANVAS</text>
    <text x="425" y="175" fill="#52525b" font-size="12" text-anchor="middle">Área interactiva de programación visual</text>
    <!-- Miniatura de objeto simulación en lienzo -->
    <rect x="365" y="205" width="120" height="32" rx="4" fill="#18181b" stroke="#eb6c36" stroke-width="1.5" />
    <circle cx="377" cy="221" r="3" fill="#eb6c36" />
    <text x="425" y="226" fill="#ffedd5" font-family="var(--sl-font-mono, monospace)" font-size="11" font-weight="700" text-anchor="middle">cycle~ 440</text>

    <!-- BARRA LATERAL DERECHA (RIGHT TOOLBAR) -->
    <rect x="675" y="65" width="170" height="250" fill="#202024" />
    <line x1="675" y1="65" x2="675" y2="315" stroke="#3f3f46" stroke-width="1" />
    <text x="695" y="95" fill="#eb6c36" font-family="var(--sl-font-mono, monospace)" font-size="11" font-weight="700">RIGHT TOOLBAR</text>
    <g transform="translate(695, 115)">
      <rect x="0" y="0" width="135" height="28" rx="4" fill="#27272a" stroke="#eb6c36" stroke-width="1" />
      <text x="12" y="18" fill="#f4f4f5" font-size="11" font-weight="600">Inspector (Ctrl+I)</text>
    </g>
    <g transform="translate(695, 155)">
      <text x="6" y="12" fill="#d4d4d8" font-size="12">Referencia de Objeto</text>
      <text x="6" y="28" fill="#71717a" font-family="var(--sl-font-mono, monospace)" font-size="10">Atributos y mensajes</text>
    </g>
    <g transform="translate(695, 195)">
      <text x="6" y="12" fill="#d4d4d8" font-size="12">Ayuda Integrada</text>
      <text x="6" y="28" fill="#71717a" font-family="var(--sl-font-mono, monospace)" font-size="10">Manuales oficiales</text>
    </g>

    <!-- BARRA INFERIOR (BOTTOM TOOLBAR) -->
    <rect x="15" y="315" width="830" height="50" rx="8" fill="#27272a" />
    <rect x="15" y="315" width="830" height="10" fill="#27272a" />
    <line x1="15" y1="315" x2="845" y2="315" stroke="#3f3f46" stroke-width="1" />
    <text x="35" y="344" fill="#f4f4f5" font-family="var(--sl-font-mono, monospace)" font-size="12" font-weight="700">BOTTOM TOOLBAR</text>
    <text x="180" y="344" fill="#a1a1aa" font-size="12">Candado (Lock) · Modo Presentación · Zoom · Audio DSP On/Off · Indicador CPU</text>
    <rect x="740" y="328" width="85" height="24" rx="4" fill="#18181b" stroke="#52525b" stroke-width="1" />
    <circle cx="754" cy="340" r="4" fill="#10b981" />
    <text x="765" y="344" fill="#e4e4e7" font-family="var(--sl-font-mono, monospace)" font-size="10" font-weight="700">DSP ON</text>
  </svg>
</div>

1. **Barra Superior (*Top Toolbar*):** Acceso rápido para la inserción de objetos canónicos, alineación geométrica, segmentación y opciones de formateo de texto.
2. **Barra Inferior (*Bottom Toolbar*):**
   - Conmutador de bloqueo (*Lock/Unlock*).
   - Selector de Modo Presentación.
   - Conmutador maestro de audio DSP (icono de altavoz) y medidor porcentual de carga de CPU en el hilo de audio (*Audio Thread*).
3. **Barra Lateral Izquierda (*Left Toolbar*):**
   - Explorador de archivos del proyecto.
   - Gestor de fragmentos de código (*Snippets*).
   - Acceso al Package Manager y plugins externos.
4. **Barra Lateral Derecha (*Right Toolbar*):**
   - **El Inspector:** Configuración exhaustiva de propiedades.
   - **Diccionario de Referencia:** Acceso instantáneo a mensajes, argumentos y atributos del objeto seleccionado.
   - Navegador de ayuda oficial (*Max Documentation*).

---

## 3. El Inspector de Objetos (`Ctrl + I`)

Todo objeto instanciado en Max posee una tabla de propiedades internas administrada mediante el **Inspector** (`Ctrl + I` en Windows / `Cmd + I` en macOS).

Al seleccionar un objeto y presionar `Ctrl + I`, se despliega una ventana dividida en categorías funcionales:

| Categoría | Descripción Técnica | Ejemplos de Parámetros |
| :--- | :--- | :--- |
| **Basic** | Parámetros que definen el comportamiento algorítmico y memoria. | Nombres de scripting (`varname`), argumentos iniciales, paso de señal. |
| **Value** | Rango numérico, escala y restricciones de datos. | `Minimum Value`, `Maximum Value`, `Clip Mode`, tipo (`float`/`int`). |
| **Appearance** | Estilizado visual en el lienzo y en presentación. | Color de fondo, color de señal de audio, grosor de línea, visibilidad. |
| **Behavior** | Modos de interacción frente a eventos del ratón o teclado. | `Ignore Click`, `Parameter Mode Enabled` (para presets y M4L). |
| **Presentation** | Posicionamiento relativo exclusivo para la GUI desacoplada. | `Include in Presentation`, coordenadas rectangulares de presentación. |

---

## 4. Atajos de Teclado Universales para Construcción Rápida

En lugar de arrastrar elementos desde los menús con el ratón, el flujo de trabajo estándar en Max se basa en la pulsación de una única tecla al hacer clic en el lienzo (Modo Edición activo):

| Tecla | Objeto Resultante | Descripción Funcional |
| :---: | :--- | :--- |
| `N` | `[object]` | Caja de objeto vacía. Permite escribir el nombre de cualquier clase (`cycle~`, `metro`, `trigger`, etc.). |
| `M` | `[message]` | Caja de mensaje. Almacena texto o números estáticos que se despachan al recibir un estímulo. |
| `C` | `[comment]` | Texto explicativo o documentación en el lienzo (no ejecuta computación). |
| `B` | `[button]` | Botón pulsador (*Bang*). Convierte cualquier evento entrante en un estímulo instantáneo. |
| `I` | `[number]` | Caja de número entero (*Integer*). Visualiza y modula valores numéricos sin decimales. |
| `F` | `[flonum]` | Caja de número en coma flotante (*Float*). Visualiza y modula valores fraccionarios con precisión decimal. |
| `T` | `[toggle]` | Conmutador biestable. Alterna entre `0` (apagado) y `1` (encendido) ante cada bang. |

---

## 5. Higiene Visual y Enrutamiento de Conexiones

En parches de mediana y gran envergadura, la acumulación desordenada de cables compromete la legibilidad y el mantenimiento. Max incorpora herramientas de higiene visual indispensables:

### 5.1. Segmentación y Alineación Automática de Cables (`Ctrl + Y`)
* Seleccionar dos o más objetos conectados y presionar `Ctrl + Y` (Windows) o `Cmd + Y` (macOS).
* Max redibuja los cables con ángulos rectos de $90^\circ$ estructurados, eliminando diagonales que crucen otras cajas.

### 5.2. Alineación de Objetos
* **Alinear Horizontalmente:** Seleccionar las cajas y presionar `Ctrl + Shift + H`.
* **Alinear Verticalmente:** Seleccionar las cajas y presionar `Ctrl + Shift + V`.

### 5.3. Cables Rectilíneos vs. Curvos
En el menú **Options**  **Preferences**  **Patcher Windows**, es posible seleccionar el estilo de cable predeterminado (*Patchcord Style*):
* **Segmented:** Conexiones con esquinas ortogonales estables.
* **Curved:** Conexiones mediante splines Bezier continuas.

---

## 6. Resumen de Operaciones Esenciales

```
ACCIONES CLAVE EN EL LIENZO:
1. Alternar Edición / Bloqueado   -> Ctrl + E
2. Bloqueo temporal interactivo   -> Mantener Ctrl + Clic en objeto
3. Abrir Inspector de Propiedades -> Ctrl + I
4. Modo Presentación              -> Ctrl + Alt + E
5. Añadir a Presentación          -> Ctrl + Alt + P
6. Segmentar cables enredados     -> Ctrl + Y
7. Crear Objeto / Mensaje         -> N / M
```
