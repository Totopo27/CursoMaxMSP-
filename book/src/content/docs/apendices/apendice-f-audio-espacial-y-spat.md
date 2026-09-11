---
title: "Apéndice F: Espacialización Sonora y Audio Inmersivo 3D (`IRCAM Spat5` y `Ambisonics`)"
description: "Capítulo del curso universitario de Max/MSP"
---


El sonido en el mundo físico no es un fenómeno estéreo ni una línea que sale de dos monitores de estudio: es un campo de presión acústica tridimensional continuo que interactúa con la geometría del espacio, los materiales y la fisionomía de nuestra cabeza y pabellón auditivo.

En la música electroacústica, los conciertos multicanal, el diseño sonoro de videojuegos y la realidad virtual, **Max/MSP es el estándar de facto a nivel mundial para el procesamiento y espacialización de audio 3D**. En este apéndice abordamos los dos paradigmas matemáticos y acústicos fundamentales: **IRCAM Spat5** y **Ambisonics de Orden Superior (HOA)**.

---

## 1. Los Paradigmas de Espacialización 3D

![FIG F.1 · VBAP, HOA Ambisonics & Binaural HRTF (Spat5)](/assets/diagrams/diagrama_spat_audio_espacial.svg)

### 1.1. VBAP (Vector Base Amplitude Panning - Ville Pulkki)
- Divide el espacio tridimensional de parlantes en triángulos (o pares en 2D).
- Calcula la ganancia de cada altavoz como una combinación lineal de vectores de base en coordenadas cartesianas. Si la fuente virtual coincide con un parlante, solo ese parlante suena; si se mueve entre ellos, la energía se reparte preservando la potencia acústica total.

### 1.2. Ambisonics de Orden Superior (HOA - Gerzon / Daniel / Di Liscia)
- **Desacoplamiento Total**: En lugar de mezclar para un número fijo de parlantes, se codifica la direccionalidad de la onda en una serie de **armónicos esféricos** independientes de la disposición física de los altavoces.

#### Ecuaciones Canónicas de Codificación FuMa (Oscar Pablo Di Liscia / Mariano Cura)
En el tratado *Síntesis Espacial de Sonido (UNQ / CMMAS)*, Oscar Pablo Di Liscia y Mariano Martín Cura detallan la síntesis de señales formato B a partir de coordenadas espaciales normalizadas en una esfera unitaria: azimut $\theta$ (plano horizontal), elevación $\phi$ (plano vertical) y distancia $r$:

1. **Primer Orden (4 Canales: $W, X, Y, Z$):**
   $$W = \frac{1}{\sqrt{2}} \cdot S, \quad X = \cos(\theta) \cos(\phi) \cdot S$$
   $$Y = \sin(\theta) \cos(\phi) \cdot S, \quad Z = \sin(\phi) \cdot S$$

   donde $W$ es el componente omnidireccional de presión de referencia y $X, Y, Z$ son los componentes dipolares ortogonales correspondientes a los ejes adelante/atrás, izquierda/derecha y arriba/abajo.

2. **Segundo Orden (9 Canales: suma de $R, S, T, U, V$):**
   Añade armónicos esféricos cuadrupolares para mayor selectividad direccional y resolución angular en recintos amplios:
   $$R = \sin(2\phi) \cdot S, \quad S = \cos(\theta) \sin(2\phi) \cdot S, \quad T = \sin(\theta) \sin(2\phi) \cdot S$$
   $$U = \cos(2\theta) \cos^2(\phi) \cdot S, \quad V = \sin(2\theta) \cos^2(\phi) \cdot S$$

#### Decodificación de Fase Corregida / Control de Opuestos (Gordon Monro / Malham)
La decodificación directa general recrea un frente de onda ideal en un punto central infinitesimal (*sweet spot*), pero genera altavoces que emiten señales en contrafase respecto a los opuestos. Como documenta Di Liscia, en una sala de conciertos esto degrada severamente la localización para los oyentes periféricos. 
Para resolverlo, se aplican **ponderaciones en fase (*in-phase decoding*)** donde la ganancia de cada altavoz $k$ ubicado en $(\theta_k, \phi_k)$ garantiza que todos los parlantes colaboren constructivamente sin cancelaciones destructivas:
$$P_k = \frac{1}{N} \left( W \sqrt{2} + \frac{2}{3}(X \cos \theta_k + Y \sin \theta_k) \right)$$

---

## 2. Espacialización Multicanal Nativa: De la Cuadrafonía al Paneo Cúbico 3D (Christopher Dobrian)

Mientras que las librerías avanzadas como Spat5 dependen de arquitecturas externas complejas, **Christopher Dobrian** (*University of California, Irvine*) demostró en sus tratados para *PdMaxCon* y *Computer Music Programming (CMP)* que la espacialización multicanal de calidad profesional puede implementarse íntegramente con **objetos nativos estándar de Max/MSP**.

![FIG F.2 · Radial Azimuth, Cubic 3D & Air Absorption](/assets/diagrams/diagrama_dobrian_multichannel_panning.svg)

### 2.1. Paneo Radial por Ángulo de Acimut ($\theta \in [0.0, 1.0]$)
En lugar de depender de coordenadas cartesianas $(X, Y)$ independientes para cada eje, Dobrian formaliza el paneo radial dividiendo el círculo de altavoces en una escala normalizada de $0.0$ a $1.0$ (donde $0.0$ y $1.0$ corresponden al frente-centro, a las 12 en punto):
- **Cuadrafonía (4 canales)**: Altavoces ubicados en $0.875$ (Front-Left), $0.125$ (Front-Right), $0.625$ (Rear-Left) y $0.375$ (Rear-Right).
- **Hexafonía (6 canales)**: Separados a intervalos angulares exactos de $60^\circ$ ($1/6 \approx 0.1667$).
- **Octofonía (8 canales)**: Separados a $45^\circ$ ($1/8 = 0.125$).

Dobrian introduce el parámetro de **Dispersión (*Spread*)**: al reducir el spread, el sonido se confina estrictamente al par de altavoces adyacentes; al aumentarlo hacia $1.0$, la energía se desparrama gradualmente por todos los altavoces del recinto, creando campos difusos inmersivos con preservación de la potencia constante por pares.

### 2.2. Paneo Cúbico Tridimensional en 8 Altavoces (`pan3D8~`)
Para salas con altavoces en altura (4 en el suelo y 4 en el techo formando un cubo acústico), Dobrian calcula la matriz tridimensional mediante la multiplicación combinada de tres proyecciones ortogonales de potencia constante:
$$A_{x,y,z} = \cos(X) \cdot \cos(Y) \cdot \cos(Z)$$
Esto permite que una fuente sonora navegue libremente por el interior del cubo virtual en coordenadas cartesianas $[-1.0, 1.0]$ o esféricas sin saltos de fase ni discontinuidades espectrales.

### 2.3. Psicoacústica de la Distancia y Localización (Dobrian CMP)
El paneo de amplitud por sí solo no transmite la sensación de lejanía. El cerebro humano localiza fuentes en el espacio evaluando cuatro fenómenos físicos simultáneos:

1. **Ley del Cuadrado Inverso e Intensidad ($A \propto 1/d$)**:
   La intensidad acústica decrece con el cuadrado de la distancia ($I \propto 1/d^2$). Como la intensidad es proporcional al cuadrado de la amplitud ($I \propto A^2$), la amplitud debe atenuarse de forma estrictamente inversamente proporcional a la distancia:
   $$A = \frac{A_0}{d}$$
2. **Absorción Atmosférica de Altas Frecuencias (*Air Absorption*)**:
   El aire disipa la energía térmica de las ondas sonoras, afectando con mucha mayor severidad a las longitudes de onda cortas (agudas). Dobrian implementa este fenómeno insertando un filtro pasa-bajos de un polo (`[onepole~]`) cuya frecuencia de corte desciende logarítmicamente conforme la fuente se distancia del oyente.
3. **Relación Directo / Reverberado (*Direct-to-Reverberant Ratio*)**:
   Una fuente cercana emite sonido predominantemente directo. Al alejarse, la energía directa cae rápidamente, mientras que el campo reverberado difuso de la sala se mantiene casi constante. Modulando la proporción *Dry/Wet* en función de $d$, el cerebro deduce instantáneamente la profundidad espacial de la escena sonora.
4. **Diferencias Interaurales de Tiempo e Intensidad (ITD / IID & Efecto Haas)**:
   Las diferencias temporales de llegada entre ambos oídos (menores a $1\text{ ms}$) dominan la percepción de acimut en frecuencias graves (< $1.5\text{ kHz}$), mientras que la sombra acústica de la cabeza (IID) domina en frecuencias agudas.

---

## 3. La Suite IRCAM Spat5: Acústica y Percepción

El paquete **Spat5** (desarrollado por el equipo de Representaciones Musicales del IRCAM) no solo posiciona el sonido en el espacio, sino que modela la **acústica perceptiva de recintos**:

1. **Sonido Directo (*Direct Sound*)**: Retardo temporal por distancia ($\Delta t = d / c$) y atenuación por ley del cuadrado inverso de la distancia ($1/d^2$).
2. **Reflexiones Tempranas (*Early Reflections*)**: Ecos discretos generados por las paredes que informan al cerebro sobre el tamaño aparente de la habitación.
3. **Reverberación Tardía (*Late Reverberation*)**: Redes de retardo con retroalimentación (FDN - *Feedback Delay Networks*) densas, homogéneas y libres de coloración tímbrica.
4. **Control Perceptivo**: En lugar de ajustar coeficientes biquad abstractos, Spat5 te permite automatizar atributos psicoacústicos: *Source Presence* (presencia de la fuente), *Warmth* (calidez acústica), *Envelopment* (envolvimiento del oyente) y *Room Size* (volumen del espacio).

---

## 4. Laboratorio Práctico: Panner Circular 3D con Simulación de Distancia y Headroom

En el parche interactivo `lab_apendice_f_audio_espacial.maxpat`:
- Implementamos una fuente sonora en órbita tridimensional circular continua.
- Calculamos el retardo temporal variable de propagación del aire con `delay~`.
- Modulamos la atenuación de alta frecuencia dependiente de la distancia del aire mediante un filtro pasa-bajos dinámico.
- Distribuimos la energía sonora a un sistema de 4 cuadrantes (cuadrafónico simulado) con atenuación de headroom nominal de -12 dB.
