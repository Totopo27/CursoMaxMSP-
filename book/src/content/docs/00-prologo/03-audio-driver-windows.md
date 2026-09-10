---
title: "Guía de Configuración de Audio en Windows para Max/MSP"
description: "Capítulo del curso universitario de Max/MSP"
---


En Windows, la arquitectura de audio es muy diferente a la de macOS (CoreAudio). Si no configuras el driver adecuado, vas a sufrir de **alta latencia, ruidos (clicks/pops) o bloqueos del hilo de audio**.

---

## 1. Los Tres Tipos de Drivers en Windows: Comparativa Real

| Driver | Latencia típica | Estabilidad | Recomendación |
| :--- | :--- | :--- | :--- |
| **ASIO Nativo** (Focusrite, Motu, Behringer, etc.) | Ultra baja (3 a 8 ms) | ***** Máxima | **La mejor opción indiscutible** si tienes una interfaz de audio dedicada. |
| **FL Studio ASIO** | Baja/Media (10 a 20 ms) | **** Muy buena | **La mejor opción si NO tienes interfaz externa** y usas los parlantes de la PC. Permite audio compartido. |
| **ASIO4ALL** | Muy baja (5 a 12 ms) | *** Buena | Emula ASIO sobre WDM. La desventaja es que suele tomar **control exclusivo** de la tarjeta (si abres YouTube o Spotify, se silencia o crashea). |
| **MME / DirectSound** | Altísima (50 a 150 ms) | * Inutilizable para sintes | **Evitar a toda costa.** Solo para pruebas sin audio en tiempo real. |

---

## 2. Recomendación de Instalación (Paso a Paso)

### Opción A: Si tienes Interfaz de Audio Externa (USB/Thunderbolt)
1. Conecta tu interfaz.
2. Instala el driver **ASIO oficial** de la página del fabricante (ej. Focusrite Scarlett Control, Universal Audio, MOTU, etc.).
3. No necesitas instalar nada más.

### Opción B: Si estás usando la tarjeta integrada de la PC (Parlantes / Auriculares de la laptop)
Te recomiendo instalar **FL Studio ASIO** o **FlexASIO**:
* **FL Studio ASIO:** Es el más estable en Windows para compartir audio. Te permite tener Max abierto generando sonido y al mismo tiempo escuchar un tutorial en YouTube sin que Windows se bloquee.
* **Alternativa: FlexASIO** ([github.com/dechamps/FlexASIO](https://github.com/dechamps/FlexASIO)), un driver ASIO open-source universal basado en WASAPI.

---

## 3. Configuración dentro de Max (Audio Status)

Para configurar el driver en Max:

1. Abre Max.
2. En el menú superior, ve a: **Options**  **Audio Status...** (o atajo `Ctrl + Shift + A`).
3. Verás la ventana de **Audio Status**. Configura los siguientes parámetros:

```
┌────────────────────────────────────────────────────────┐
│                   AUDIO STATUS (MAX)                   │
├────────────────────────────────────────────────────────┤
│  Driver:               [ ASIO ]                        │
│  Device:               [ Tu Driver ASIO / FL ASIO ]    │
│  Input Device:         [ Tu Entrada de Mic ]           │
│  Output Device:        [ Tus Parlantes / Auriculares ] │
│  Sampling Rate:        48000 Hz (o 44100 Hz)           │
│  I/O Vector Size:      256 o 512                       │
│  Signal Vector Size:   64                              │
│  Scheduler in Overdrive:  [X] Activado                 │
│  Audio Interrupt:         [X] Activado                 │
└────────────────────────────────────────────────────────┘
```

### Explicación de los Parámetros Críticos:
* **Driver:** Selecciónalo en **ASIO**.
* **I/O Vector Size:** Es el buffer de la tarjeta física. 
  * `256 muestras`: Excelente equilibrio entre latencia casi imperceptible y bajo consumo de CPU.
  * `512 muestras`: Si tu computadora es más modesta o empieza a crujir el audio, sube a 512.
* **Signal Vector Size:** Es el tamaño de bloque interno que procesa MSP. **Déjalo siempre en 64**. En Max, el cálculo es más eficiente cuando el Signal Vector es 64 y el I/O Vector es un múltiplo (ej. 128, 256, 512).
* **Scheduler in Overdrive:** Déjalo **activado (Checked)**. Esto hace que el reloj de Max corra en un hilo de alta prioridad y no se desincronice si la pantalla se satura.

---

## 4. Test Rápido de Audio: ¿Cómo saber si suena?

1. En la ventana **Audio Status**, verás un interruptor arriba a la izquierda que dice **Audio: On / Off** (o el icono de parlante abajo a la derecha de cualquier patcher).
2. Haz clic para ponerlo en **On** (se pondrá azul/verde).
3. En cualquier patch vacío, crea un objeto: `[cycle~ 440]` conectado a `[ezdac~]`.
4. Si haces clic en `[ezdac~]` (el icono de los dos parlantes), deberías escuchar un tono puro de 440 Hz (la nota La).
