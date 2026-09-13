---
title: Glosario Técnico y Léxico Operativo de Max/MSP
description: Guía canónica de terminología computacional, física acústica, arquitectura de bajo nivel y DSP para Max, MSP, Jitter y Gen~.
---

Este glosario condensa la terminología matemática, acústica y de ciencias de la computación que sustenta el entorno de **Max/MSP**. Cada término se presenta bajo el estándar de **4 bloques de rigor operativo**: su definición formal, su criticidad en tiempo real en vivo, la confusión típica que suele inducir a error y los objetos nativos donde se implementa.

---

## 1. Paradigma Dataflow, Control y Scheduler

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Scheduler Thread (Hilo del Planificador)</h3>
    <span class="glossary-badge badge-control">Control / Timing</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Hilo de ejecución de prioridad media-alta encargado de despachar eventos discretos, temporizadores (<code>metro</code>), mensajes de control y tareas programadas en la cola temporal en milisegundos.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Si se activan algoritmos bloqueantes o parsing de texto masivo en este hilo, el tempo fluctúa y se introduce <em>jitter</em> temporal en eventos rítmicos y MIDI.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>No confundir con el <strong>Audio Thread</strong>. El Scheduler mide el tiempo en milisegundos lógicos; el Audio Thread opera a sample-rate continuo (48 kHz) mediante interrupciones de hardware.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>metro</code>, <code>pipe</code>, <code>delay</code>, <code>clocker</code>. Ver <a href="/01-fundamentos/01-dataflow-y-inlets/">Módulo 1.1</a>.</p>
    </div>
  </div>
</div>

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Overdrive</h3>
    <span class="glossary-badge badge-control">Arquitectura</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Modo del motor de Max que otorga al Scheduler Thread prioridad de temporización de interrupción por hardware por encima del hilo de la interfaz gráfica de usuario (GUI).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Debe estar <strong>siempre activado</strong> en directo. Garantiza que mover ventanas o renderizar pantallas no desincronice secuencias MIDI o metrónomos.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>No acelera la CPU ni optimiza el cálculo; simplemente altera la jerarquía de despacho de los hilos del sistema operativo.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p>Configuración en <em>Audio Status</em> y objeto <code>overdrive</code>. Ver <a href="/00-prologo/01-anatomia-de-la-interfaz-y-modos-de-operacion/">Módulo 0.1</a>.</p>
    </div>
  </div>
</div>

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Inlet Caliente vs. Frío (Hot / Cold Inlet)</h3>
    <span class="glossary-badge badge-control">Semántica Dataflow</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Convención del paradigma de mensajes de Max. Un <em>Hot Inlet</em> (generalmente el izquierdo) procesa el dato recibido y dispara inmediatamente el cálculo y salida del objeto; un <em>Cold Inlet</em> únicamente actualiza el estado interno sin disparar emisión.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Ignorar esta semántica provoca orden de ejecución errático, computaciones con parámetros desactualizados y bucles infinitos no deseados.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>En el mundo MSP (señal <code>~</code>), los inlets no son "fríos" ni "calientes": todos los inlets reciben vectores de señal continuos simultáneamente cada $N$ muestras.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>+</code>, <code>pack</code>, <code>trigger</code> (<code>t</code>), <code>float</code> (<code>f</code>). Ver <a href="/01-fundamentos/01-dataflow-y-inlets/">Módulo 1.1</a>.</p>
    </div>
  </div>
</div>

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Orden Derecha a Izquierda (Right-to-Left Rule)</h3>
    <span class="glossary-badge badge-control">Semántica Dataflow</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Regla determinista del evaluador de Max: cuando múltiples patch cords emergen de un mismo outlet hacia varios inlets, o cuando varios objetos son disparados, los mensajes se transmiten en estricto orden de posición espacial (de derecha a izquierda, y de abajo hacia arriba).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Confiar en la posición visual de los objetos en el patcher es frágil. Ante cualquier movimiento accidental de cables, el algoritmo se altera.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>La regla de oro del ingeniero profesional es: <strong>nunca depender de la posición espacial</strong>. Se debe forzar el orden de despacho explícitamente mediante el objeto <code>trigger</code> (<code>t</code>).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>trigger</code> (<code>t b f i s</code>), <code>bang</code>. Ver <a href="/01-fundamentos/01-dataflow-y-inlets/">Módulo 1.1</a>.</p>
    </div>
  </div>
</div>

---

## 2. DSP, Audio Digital y Motor MSP

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Audio Thread (Hilo de Procesamiento de Señal)</h3>
    <span class="glossary-badge badge-dsp">DSP / C Engine</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Hilo de máxima prioridad en el sistema operativo que calcula los vectores de audio muestra a muestra de forma ininterrumpida a la tasa $f_s$ del conversor DA.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Cualquier operación bloqueante en este hilo (acceso a disco, reserva dinámica de memoria con <code>malloc</code>, locks de mutex) causa un <strong>Audio Dropout</strong> (clic / chasquido audible instantáneo).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>No puede pausarse para esperar un mensaje de control. Si no termina a tiempo antes de que el buffer DAC se vacíe, se produce un <em>buffer under-run</em> destructivo.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>dspstate~</code>, <code>perform64</code>, <code>dac~</code>. Ver <a href="/03-dsp-y-audio-digital/01-signal-vs-control-y-audio-thread/">Módulo 3.1</a>.</p>
    </div>
  </div>
</div>

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">I/O Vector Size vs. Signal Vector Size</h3>
    <span class="glossary-badge badge-dsp">Buffers / Hardware</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>El <strong>I/O Vector Size</strong> (iovs) es el tamaño del buffer que intercambia el driver de audio con la tarjeta física (determina la latencia analógica). El <strong>Signal Vector Size</strong> (sigvs) es el número de muestras que los objetos de Max computan internamente en cada iteración del bucle <code>perform64</code>.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Reducir el iovs (ej. de 512 a 64 muestras) disminuye la latencia de latencia de monitoreo a menos de 3 ms, pero eleva la carga de interrupciones de la CPU de forma exponencial.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>El Signal Vector Size jamás puede ser mayor que el I/O Vector Size (debe ser un submúltiplo exacto: $sigvs \le iovs$).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p>Ventana <em>Audio Status</em>, <code>adstatus</code>, <code>dspstate~</code>. Ver <a href="/03-dsp-y-audio-digital/01-signal-vs-control-y-audio-thread/">Módulo 3.1</a>.</p>
    </div>
  </div>
</div>

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Aliasing (Plegamiento Espectral)</h3>
    <span class="glossary-badge badge-dsp">Teoría de Señales</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Artefacto no lineal que ocurre cuando una señal analógica o sintetizada genera componentes con frecuencias superiores al límite de Nyquist ($f_N = f_s / 2$). Esos armónicos se reflejan hacia abajo como frecuencias espurias inarmónicas: $f_{alias} = |f_s - f|$.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>En síntesis por modulación de frecuencia (FM) profunda, distorsión no lineal o síntesis de pulsos duros, el aliasing genera un "barro" metálico disonante que destruye la claridad acústica de la mezcla.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>No se puede eliminar con un filtro pasa-bajos convencional <em>después</em> de que ya ocurrió en el dominio digital: las frecuencias ya se plegaron sobre el espectro audible. Se previene con sobremuestreo (oversampling) o algoritmos anti-aliasing (BLEP / PolyBLEP).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>poly~</code> con atributo <code>@down</code>/<code>@up</code>, <code>gen~</code>. Ver <a href="/03-dsp-y-audio-digital/01-signal-vs-control-y-audio-thread/">Módulo 3.1</a> y <a href="/03-dsp-y-audio-digital/02-sintesis-aditiva-y-tabla-de-ondas/">3.2</a>.</p>
    </div>
  </div>
</div>

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Denormal Numbers (Números Denormalizados)</h3>
    <span class="glossary-badge badge-dsp">Punto Flotante / CPU</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Números en punto flotante IEEE 754 infinitesimalmente cercanos a cero ($< 10^{-38}$ en 32-bit). Cuando un filtro IIR o reverb decae en silencio infinito, la CPU entra en microcódigo para calcularlos, disparando el uso de procesador del 3% al 90%.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Puede congelar repentinamente el parche de audio en pasajes de silencio absoluto (dropouts invisibles que ocurren cuando la música para).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>No se soluciona silenciando la salida. Se resuelve inyectando ruido ultra-bajo de dither analógico o activando los flags de hardware <em>Flush-to-Zero</em> (FTZ) y <em>Denormals-Are-Zero</em> (DAZ).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>biquad~</code>, <code>teeth~</code>, <code>gen~</code>. Ver <a href="/03-dsp-y-audio-digital/06-filtros-iir-fir-y-biquad/">Módulo 3.6</a>.</p>
    </div>
  </div>
</div>

---

## 3. Gen~ y Computación a Nivel de Muestra

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Single-Sample Delay (Retardo de Muestra Única)</h3>
    <span class="glossary-badge badge-gen">Gen~ / DSP Recurrente</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Operación elemental de retardo $z^{-1}$ que permite almacenar el valor de una muestra en el instante $t-1$ para reutilizarlo en el cálculo de la muestra actual $t_0$, resolviendo bucles algebraicos de retroalimentación.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>En el mundo MSP tradicional, un bucle de feedback tiene una latencia mínima forzada de un vector entero ($sigvs$, típicamente 64 muestras). En <code>gen~</code>, el operador <code>history</code> reduce esta latencia a exactamente <strong>1 muestra</strong> ($20.8\,\mu\text{s}$ a 48 kHz), permitiendo modelado físico y filtros auto-oscilantes reales.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>No es una línea de retardo de audio perceptiva (como <code>delay~</code> o <code>tapin~</code>/<code>tapout~</code>), sino una variable de estado de retroalimentación en memoria de registros.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>history</code> (dentro de <code>gen~</code>). Ver <a href="/05-gen-y-dsp-avanzado/01-gen-paradigma-jit-y-compilacion/">Módulo 5.1</a>.</p>
    </div>
  </div>
</div>

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">GenExpr</h3>
    <span class="glossary-badge badge-gen">Sintaxis / Compilador</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Lenguaje textual formal de programación estructurada que opera dentro del objeto <code>codebox</code> en Gen~. Se compila en tiempo real (JIT) a código máquina y admite bucles <code>for</code>, condicionales <code>if/else</code>, y funciones matemáticas sin costo de parcheo gráfico.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Permite condensar algoritmos de filtros no lineales o iteraciones complejas que requerirían cientos de cables en un bloque conciso y optimizado para instrucciones vectoriales de CPU.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>No es JavaScript ni C++. Aunque comparte similitudes sintácticas con C, no admite punteros libres, llamadas a funciones del sistema operativo ni reservas dinámicas de memoria.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>codebox</code> (dentro de <code>gen~</code>). Ver <a href="/05-gen-y-dsp-avanzado/02-genexpr-codigo-textual-dentro-de-gen/">Módulo 5.2</a>.</p>
    </div>
  </div>
</div>

---

## 4. Arquitectura de Bajo Nivel y C SDK

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Función <code>perform64</code></h3>
    <span class="glossary-badge badge-sdk">Max C SDK</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Firma de función en lenguaje C canónica del Max SDK moderno (64 bits) encargada de procesar un vector de muestras de audio: <code>void my_object_perform64(t_my_object *x, t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam)</code>.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Es el corazón del Audio Thread. Toda la lógica de procesamiento DSP debe completarse antes de salir de esta función. Está terminantemente prohibido imprimir en consola (<code>post()</code>) o bloquear el hilo dentro de su cuerpo.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>Reemplaza a la función heredada de 32 bits <code>perform</code>. Opera estrictamente con punteros de precisión doble (<code>double*</code>, 64-bit float).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p>Cabecera <code>z_dsp.h</code>, Max SDK, Min-DevKit. Ver <a href="/06-extensiones-sdk-y-sistemas/03-anatomia-de-un-external-en-c-max-sdk/">Módulo 6.3</a>.</p>
    </div>
  </div>
</div>

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Estructura <code>t_atom</code></h3>
    <span class="glossary-badge badge-sdk">Memoria / C API</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Unión etiquetada fundamental en C utilizada por el núcleo de Max para almacenar cualquier dato elemental homogéneo: enteros (<code>A_LONG</code>), decimales (<code>A_FLOAT</code>), cadenas o selectores (<code>A_SYM</code>) y referencias a objetos (<code>A_OBJ</code>).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>El paso de listas en Max (mensajes entre objetos) consiste en enviar un arreglo contiguo de punteros <code>t_atom*</code> junto con un contador <code>long argc</code>.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>Un atom no almacena buffers de señal de audio (las señales MSP viajan como arreglos puros de <code>double*</code> sin envoltorios de atom para máxima velocidad SIMD).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>atom_getfloat()</code>, <code>atom_getlong()</code>, <code>ext_obex.h</code>. Ver <a href="/06-extensiones-sdk-y-sistemas/03-anatomia-de-un-external-en-c-max-sdk/">Módulo 6.3</a>.</p>
    </div>
  </div>
</div>

---

## 5. Computación Visual y Matrices (Jitter)

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Matriz Jitter (<code>jit.matrix</code>)</h3>
    <span class="glossary-badge badge-jitter">Jitter / GPU</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Estructura de datos multidimensional de memoria contigua caracterizada por 4 parámetros fijos: nombre, plano (canales de datos como ARGB), tipo de dato (<code>char</code>, <code>long</code>, <code>float32</code>, <code>float64</code>) y dimensiones espaciales ($X \times Y \times Z$).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Copiar matrices de video pesadas de CPU a GPU cuadro a cuadro satura el bus PCI Express. Para alta tasa de cuadros (60 fps), se procesa directamente en la textura de video de la GPU mediante texturas OpenGL (<code>jit.gl.texture</code>).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>No transporta video como un flujo codificado h.264 comprimido, sino como arreglos de píxeles o tensores numéricos crudos accesibles celda a celda.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>jit.matrix</code>, <code>jit.gl.texture</code>, <code>jit.world</code>. Ver <a href="/apendices/apendice-a-jitter-matrices-y-jit-gen/">Apéndice A</a>.</p>
    </div>
  </div>
</div>

---

## 6. Audio Espacial e Inteligencia Artificial

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">Formato B Ambisonics (B-Format FuMa / Ambix)</h3>
    <span class="glossary-badge badge-spatial">Espacialización 3D</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Representación matemática jerárquica de un campo sonoro espacial en primer orden descompuesto en 4 señales canónicas: componente omnidireccional $W$ (presión escalar) y componentes en figura de ocho $X, Y, Z$ (gradientes de velocidad en los ejes adelante/atrás, izquierda/derecha y arriba/abajo).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Independiza la composición espacial de la disposición física de altavoces. Una obra mezclada en Ambisonics se decodifica en directo a 4, 8, 16 o 32 canales sin necesidad de volver a mezclar.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>No confundir el orden clásico de ponderación Furse-Malham (FuMa, con factor de escala $1/\sqrt{2}$ en $W$) con el estándar contemporáneo ACN-SN3D (Ambix). Mezclar convenciones invierte las fases acústicas espaciales.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>spat5.pan~</code>, <code>spat5.hoa.*</code>, <code>mc.*</code>. Ver <a href="/apendices/apendice-f-audio-espacial-ambisonics-y-spat/">Apéndice F</a>.</p>
    </div>
  </div>
</div>

<div class="glossary-term-card not-content">
  <div class="glossary-card-header">
    <h3 class="glossary-term-title">RTFx (Real-Time Factor / Factor de Tiempo Real)</h3>
    <span class="glossary-badge badge-spatial">Machine Learning / IA</span>
  </div>
  <div class="glossary-grid-blocks">
    <div class="glossary-block">
      <div class="glossary-block-label label-definition">📌 Definición Operativa</div>
      <p>Métrica de eficiencia computacional que relaciona la duración del fragmento de audio producido con el tiempo que el algoritmo o modelo neuronal tarda en computarlo: $\text{RTFx} = \frac{\text{Duración Audio}}{\text{Tiempo de Cómputo}}$.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-live">⚡ En Vivo y Concierto</div>
      <p>Si $\text{RTFx} \le 1.0$, el modelo no puede operar en tiempo real y causa fallos de búfer inmediatos. Para un concierto seguro en vivo en Max, se exige un margen de $\text{RTFx} > 2.5\times$.</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-confusion">⚠️ Confusión Típica</div>
      <p>Un RTFx alto no implica latencia cero: un modelo puede tener $\text{RTFx} = 10.0$ pero requerir una ventana de lookahead de 2 segundos para inferir (haciéndolo no causal e inviable para interacción instrumental en directo).</p>
    </div>
    <div class="glossary-block">
      <div class="glossary-block-label label-objects">🔗 Objetos & Lecciones</div>
      <p><code>nn~</code>, <code>fluid.bufnmf~</code>, RAVE. Ver <a href="/apendices/apendice-e-ia-y-machine-learning/">Apéndice E</a>.</p>
    </div>
  </div>
</div>
