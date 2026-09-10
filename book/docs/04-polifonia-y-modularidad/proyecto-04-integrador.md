# Proyecto Integrador 04: Sintetizador Polifónico Multicore de 8 Voces con Asignación Dinámica y Mute Automático

> *"Un gran sintetizador polifónico no se define únicamente por su sonido solista, sino por la elegancia con la que sus voces coexisten en el espacio armónico. La distribución simétrica de hilos, el apagado instantáneo de la energía cuando una nota concluye y la cohesión de su arquitectura determinan si estamos ante un instrumento o ante un juguete."*  
> — **Curtis Roads**, *The Computer Music Tutorial*

---

### Objetivos del Proyecto y Criterios de Evaluación
1. **Arquitectura Polifónica Multicore Profesional**: Integrar un motor de 8 voces concurrentes ejecutadas mediante `poly~ @parallel 1`, optimizado para multiprocesamiento simétrico (SMP) sin saturar hilos individuales de CPU.
2. **Ciclo de Vida y Protocolo Anti-Desperdicio**: Implementar en cada voz la gestión estricta de `mute 1, 0` y `busy` mediante `[thispoly~]`, garantizando un consumo de CPU del $0\%$ en reposo absoluto.
3. **Motor Timbre-Dual con Filtro Dinámico**: Cada voz cuenta con 2 osciladores desfasados (`saw~` + `rect~` con control de pulso PWM), filtro bicuadrático/resonante `lores~` y doble generador `adsr~` con rampas anti-clipping.
4. **Control Global y Espacialización**: Enrutamiento paramétrico global mediante `target 0` para frecuencia de corte y resonancia, y apertura estéreo automática por voz (*pan spread*).

---

## 1. Diagrama de Arquitectura del Sistema

```
                         +-----------------------+
                         |  MIDI / kslider Note  |
                         +-----------------------+
                                     |
                                     | (note $1 $2)
                                     v
                 +---------------------------------------+
                 | poly~ voz_sintetizador_completo 8     |
                 |             @parallel 1               |
                 +---------------------------------------+
                 | [Voz 1 (Core 0)] ---> thispoly~ (mute)|
                 | [Voz 2 (Core 1)] ---> thispoly~ (mute)|
                 | [Voz 3 (Core 2)] ---> thispoly~ (mute)|
                 | [Voz 4 (Core 3)] ---> thispoly~ (mute)|
                 | [Voz 5 (Core 0)] ---> thispoly~ (mute)|
                 | [Voz 6 (Core 1)] ---> thispoly~ (mute)|
                 | [Voz 7 (Core 2)] ---> thispoly~ (mute)|
                 | [Voz 8 (Core 3)] ---> thispoly~ (mute)|
                 +---------------------------------------+
                        | (Left Sum)       | (Right Sum)
                        v                  v
                 +---------------------------------------+
                 |      Master Headroom Attenuator       |
                 |               (*~ 0.25)               |
                 +---------------------------------------+
                        |                  |
                        v                  v
                 +---------------------------------------+
                 |            ezdac~ Master              |
                 +---------------------------------------+
```

---

## 2. Especificaciones de Ingeniería de la Voz (`voz_sintetizador_completo.maxpat`)

Cada voz instanciada internamente cuenta con los siguientes componentes atómicos:

1. **Osciladores Duales**:
   - Oscilador 1: `saw~` afinado a la frecuencia nominal fundamental $f_0$.
   - Oscilador 2: `cycle~` o pulso desafinado levemente en $+3\text{ cents}$ ($f_0 \cdot 2^{3/1200}$) para generar un efecto analógico de batimiento orgánico (*detuning*).
2. **Filtro Resonante**:
   - `lores~` con corte base modulado por la envolvente de filtro y escalado por velocidad MIDI.
3. **Doble Envolvente ADSR**:
   - Envolvente de Amplitud: $A = 15\text{ ms}, D = 250\text{ ms}, S = 0.6, R = 450\text{ ms}$.
   - Tercer outlet de `adsr~` conectado a la lógica de `thispoly~` para cortar inmediatamente la voz al silenciarse.
4. **Espacialización Estéreo por Número de Voz**:
   - Al instanciarse, `[thispoly~]` reporta su ID ($1 \dots 8$).
   - Las voces impares se envían preferentemente al canal izquierdo y las pares al canal derecho con atenuaciones calculadas por ley de panqueo de potencia constante:
     $$\text{Gain}_L = \cos\left(\frac{\pi}{2} \cdot \text{pan}\right), \quad \text{Gain}_R = \sin\left(\frac{\pi}{2} \cdot \text{pan}\right)$$

---

## 3. Especificaciones del Parche Maestro (`proyecto_04_sintetizador_polifonico.maxpat`)

1. **Teclado de Interpretación**: `kslider` de 49 teclas con empaquetado de mensajes `note [pitch] [velocity]` hacia el inlet 1 de `poly~`.
2. **Control Maestro de Timbre**: Dial flotante con mensaje `target 0, $1` hacia el inlet 2 para barrer la frecuencia de corte de todas las 8 voces a la vez.
3. **Monitoreo de CPU y Espectro**: Visualizador FFT estéreo dual y medidor de CPU en tiempo real que demuestra cómo el motor cae a cero al cesar las notas.
4. **Protección de Salida**: Reducción de headroom a $-12\text{ dB}$ ($*~ 0.25$) para que la suma simultánea de 8 voces resonantes en acordes densos jamás supere $1.0$ (cero distorsión digital no deseada).

---

## 4. Archivos del Proyecto

1. [`voz_sintetizador_completo.maxpat`](file:///d:/DocumentosDiscoD/CursoMaxMSP/book/patches/modulo-04/voz_sintetizador_completo.maxpat): La voz polifónica atómica estéreo con osciladores duales, filtro, envolvente y apagado en `thispoly~`.
2. [`proyecto_04_sintetizador_polifonico.maxpat`](file:///d:/DocumentosDiscoD/CursoMaxMSP/book/patches/modulo-04/proyecto_04_sintetizador_polifonico.maxpat): El instrumento maestro ensamblado listo para tocar.
