---
title: "Módulo 3.3: Aritmética de Audio, Modulación en Anillo (Ring Modulation) y Modulación de Amplitud (AM)"
description: "Aritmética de audio en MSP: escalamiento de señal, Ring Modulation (RM) y Amplitude Modulation (AM). Espectros laterales, síntesis tímbrica y el operador multiplicador [*~]."
---


> *"Multiplicar dos señales de audio no es un simple control de volumen; es una colisión trigonométrica que crea nuevas frecuencias que jamás existieron en los osciladores originales."*

---

##  1. Fundamento Matemático: Trigonometría de la Multiplicación de Señales

*(Inspirado en Miller Puckette, *Theory and Technique of Electronic Music*, y Cipriani & Giri, *Electronic Music and Sound Design*, Vol. 1)*

En el dominio analógico y digital, existen dos operaciones fundamentales entre señales:
1. **Suma (`[+~]`):** Superposición lineal. Mezcla dos sonidos sin alterar su contenido espectral individual.
2. **Multiplicación (`[*~]`):** Interacción no lineal que engendra **Bandas Laterales (Sidebands)**.

### Identidad Trigonométrica del Producto de Cosenos:
Cuando multiplicas dos ondas continuas con frecuencias $f_c$ (Portadora / Carrier) y $f_m$ (Moduladora / Modulator):

$$\cos(2\pi f_c t) \cdot \cos(2\pi f_m t) = \frac{1}{2}\cos\big(2\pi (f_c + f_m) t\big) + \frac{1}{2}\cos\big(2\pi (f_c - f_m) t\big)$$

![FIG 3.2 · Modulación en Anillo (Bipolar) vs. Modulación de Amplitud (Unipolar)](/assets/diagrams/diagrama_rm_vs_am.svg)


---

##  3. Bajo el Capó (Max C SDK): Vectorización SIMD con SSE (`times~.c`)

*(Basado en `times~.c` del Cycling '74 Max SDK)*

¿Cómo multiplica Max millones de muestras por segundo entre dos canales estéreo sin derretir el procesador?

Max implementa optimizaciones **SIMD (Single Instruction, Multiple Data)** a nivel de ensamblador y C intrinsics en Windows y macOS:

```c
// times~.c del Max SDK (Optimización SIMD para procesadores x86_64)
#if defined(WIN_VERSION) && defined(WIN_SSE_INTRINSICS)
    __m128d mm_in1, mm_in2, mm_val;
    mm_val = _mm_set1_pd(aligned_val); // Carga el escalar en los registros SSE

    for (i = 0; i < sampleframes; i += 4) {
        mm_in1 = _mm_load_pd(in + i);
        mm_out1[i / 2] = _mm_mul_pd(mm_in1, mm_val); // Multiplica 2 dobles en 1 ciclo
        mm_in2 = _mm_load_pd(in + i + 2);
        mm_out2[i / 2 + 1] = _mm_mul_pd(mm_in2, mm_val); // Multiplica otros 2
    }
#endif
```

### Lección de Rendimiento:
- Una multiplicación escalar ingenua muestra por muestra tardaría 64 ciclos de reloj para un vector de 64 muestras.
- Las instrucciones vectoriales `_mm_mul_pd` calculan pares de muestras de 64 bits en paralelo, reduciendo el consumo de CPU a una fracción imperceptible.

---

### Comportamientos Críticos en Modulación y Aritmética de Audio

1. **Bandas Laterales Negativas y Aliasing Espectral (Foldover):**
   - Cuando $f_m > f_c$, la banda lateral inferior arroja un valor algebraico negativo: por ejemplo, $440\text{ Hz} - 600\text{ Hz} = -160\text{ Hz}$.
   - En el dominio de señales reales, una componente de frecuencia negativa no desaparece: **se refleja en el espectro positivo con inversión de fase de $180^\circ$ como $+160\text{ Hz}$**. Si no se calculan analíticamente las relaciones armónicas, estos componentes reflejados introducen frecuencias espurias en el registro grave.
2. **Multiplicación Escalar vs. Multiplicación Señal a Señal:**
   - Al multiplicar una señal de audio por un valor de control en el inlet derecho de `[*~ 0.]`, Max conmuta internamente a la rutina `scale_perform64_method` (aplicando un único escalar invariable a todo el vector). No obstante, si dicho valor cambia abruptamente desde la interfaz gráfica, cada bloque de 64 muestras sufrirá una discontinuidad escalonada que introduce **ruido de cremallera (*zipper noise*)**. Para transiciones continuas sin artefactos audibles, la modulación debe modularse siempre a tasa de audio mediante rampas suavizadas con `[line~]`.

---


---

## 4. Modulación de Banda Lateral Única (SSB) y Desplazamiento de Frecuencia (*Frequency Shifter*)

*(Inspirado en Miller Puckette, *Theory and Technique of Electronic Music*, y Cipriani & Giri, *Electronic Music and Sound Design*, Vol. 2)*

Uno de los errores más extendidos en la producción musical y el diseño de audio consiste en confundir **Pitch Shifting** (transposición de tono) con **Frequency Shifting** (desplazamiento de frecuencia de Bode):

| Parámetro | Transposición de Tono (*Pitch Shifting*) | Desplazamiento de Frecuencia (*Frequency Shifting*) |
| :--- | :--- | :--- |
| **Operación Matemática** | Multiplicación escalar: $f_n' = k \cdot f_n$ | Suma aditiva constante: $f_n' = f_n + \Delta f$ |
| **Relación Armónica** | **Se preserva**: $100, 200, 300 \rightarrow 200, 400, 600\text{ Hz}$ | **Se destruye**: $100, 200, 300 \rightarrow 150, 250, 350\text{ Hz}$ |
| **Percepción Acústica** | Mismo instrumento en distinta nota musical | Sonido inarmónico alienígena, campanas, timbres metálicos |

### 4.1. La Señal Analítica en Cuadratura y el Objeto `[hilbert~]`
En la Modulación en Anillo clásica (`*~`), multiplicar una señal $x(t)$ por una portadora de frecuencia $f_c$ genera inevitablemente **dos bandas laterales**: la suma ($f_s + f_c$) y la diferencia ($f_s - f_c$).

Para aislar una sola banda lateral (Single Sideband / SSB) y lograr un auténtico *Frequency Shifter*, debemos transformar la señal de audio real en una **señal analítica compleja**:
$$z(t) = x(t) + j \cdot \mathcal{H}\{x(t)\}$$
Donde $\mathcal{H}\{x(t)\}$ es la **Transformada de Hilbert**, que desfasa exactamente $90^\circ$ todas las frecuencias componentes sin alterar sus amplitudes.

```text
                 ┌── Real (0°)  ──────> [*~] ──┐
[ audio in ] ──> [ hilbert~ ]                   ├── [-~] ──> Banda Lateral Superior (fc + fs)
                 └── Imag (-90°) ────> [*~] ──┤
                                        ▲   ▲   └── [+~] ──> Banda Lateral Inferior (|fc - fs|)
                 [ cycle~ fc (cos) ] ───┘   │
                 [ cycle~ fc (sin) ] ───────┘ (desfase 0.25)
```

### 4.2. Cancelación Trigonométrica de Bandas en Max
1. El objeto `[hilbert~]` descompone la entrada en dos señales: salida izquierda (en fase) y salida derecha ($90^\circ$ en cuadratura).
2. Modulamos ambas señales con dos osciladores en cuadratura de frecuencia $\Delta f$ (un `[cycle~]` en fase cero evaluando coseno y otro con fase $0.25$ evaluando seno).
3. Restando los productos (`[-~]`), la banda inferior se cancela matemáticamente por interferencia destructiva, dejando únicamente la banda lateral superior ($f + \Delta f$).
4. Sumando los productos (`[+~]`), se cancela la banda superior, aislando el espectro desplazado hacia abajo.

---

##  4. 4 Escenarios del Mundo Real

Abre el parche interactivo complementario:
[`book/patches/modulo-03/laboratorio_09_modulacion_am_rm.maxpat`](/patches/modulo-03/laboratorio_09_modulacion_am_rm.maxpat)

### Escenario 1: La Voz de Dalek (Efecto Sci-Fi Clásico)
* **El Problema:** Lograr la clásica voz robótica y deshumanizada de la serie *Doctor Who*.
* **La Solución:** Ring Modulation puro entre la voz de un micrófono (o un oscilador rico en armónicos) y una onda sinusoidal pura `[cycle~]` a $30\text{ Hz} - 50\text{ Hz}$. Las bandas laterales rompen la formante vocal humana produciendo el característico timbre metálico.

### Escenario 2: De Trémolo Acústico a Tímbrica Metálica Continua
* **El Problema:** Explicar sensorialmente cómo la percepción humana cambia al acelerar un LFO.
* **La Solución:** A $4\text{ Hz}$, la modulación de amplitud se percibe como una fluctuación periódica de volumen (Trémolo). Al subir la frecuencia a $150\text{ Hz}$, el oído humano deja de distinguir los pulsos individuales y fusiona las bandas laterales en un nuevo timbre acampanado.

### Escenario 3: Síntesis de Campanas Inarmónicas (Chimes)
* **El Problema:** Crear campanas de iglesia o gongs orientales que no suenen a notas afinadas tradicionales.
* **La Solución:** Multiplicar una portadora a $500\text{ Hz}$ por una moduladora a $357\text{ Hz}$ (relación irracional). Las frecuencias resultantes ($143\text{ Hz}$ y $857\text{ Hz}$) no guardan relación de octava ni quinta, generando una inarmonicidad metálica perfecta.

### Escenario 4: Escalamiento y Normalización Bipolar a Unipolar
* **El Problema:** La salida de `[cycle~]` oscila entre $-1.0$ y $+1.0$. Si la usamos directamente para modular el volumen, la fase se invertirá en el semiciclo negativo produciendo RM en lugar de AM.
* **La Solución:** Usar la fórmula matemática de acondicionamiento:
  $$\text{Unipolar} = (\text{Bipolar} \cdot 0.5) + 0.5$$
  Con `[*~ 0.5]` y `[+~ 0.5]`, la señal oscila estrictamente entre $0.0$ y $+1.0$, logrando AM limpio.

---

## 5. 3 Desafíos de Ingeniería de Laboratorio

Realiza estos ejercicios utilizando el parche interactivo [`laboratorio_09_modulacion_am_rm.maxpat`](/patches/modulo-03/laboratorio_09_modulacion_am_rm.maxpat):

###  Ejercicio 1: El Conmutador Morfológico RM / AM
* **Objetivo:** Diseña un control continuo que permita pasar de Ring Modulation puro (bipolar) a Amplitude Modulation (unipolar) mediante un solo slider.
* **Pista:** Usa un multiplicador para atenuar o inyectar el offset de corriente continua con `[+~]`.

###  Ejercicio 2: El Generador de Campana con Decaimiento Tímbrico
* **Objetivo:** Modula la profundidad de las bandas laterales en el tiempo.
* **Desafío:** Haz que el índice de modulación comience muy alto al presionar una tecla (produciendo un impacto metálico muy brillante) y decaiga rápidamente a cero con una envolvente `[line~]`, dejando únicamente la frecuencia portadora pura en el sustain.

###  Ejercicio 3: Detección y Escucha de Frecuencias Negativas (Foldover)
* **Objetivo:** Comprueba auditivamente el rebote de frecuencias negativas.
* **Desafío:** Fija la portadora en $300\text{ Hz}$ y sube la moduladora lentamente de $200\text{ Hz}$ a $500\text{ Hz}$. Escucha con atención cómo la banda inferior desciende hasta $0\text{ Hz}$ y luego, al pasar los $300\text{ Hz}$, vuelve a subir como frecuencia positiva rebotada.

---

## Resumen de Principios Arquitectónicos
1. **Suma = Superposición, Multiplicación = Creación:** Multiplicar dos señales en MSP genera dos nuevas frecuencias: la suma ($f_c + f_m$) y la resta ($f_c - f_m$).
2. **El Offset DC define el Régimen:** Bipolar (sin offset) produce Ring Modulation (la fundamental desaparece); Unipolar (con offset $>0$) produce Amplitude Modulation (la fundamental se conserva).
3. **Optimización SIMD Automática:** Max compila los bloques de `[*~]` utilizando instrucciones vectoriales SSE/AVX en bloques de $n$ muestras.
4. **Cuidado con el Zipper Noise:** Nunca modules una multiplicación con números de control abruptos; interpola siempre con `[line~]` para evitar clicks entre vectores.
