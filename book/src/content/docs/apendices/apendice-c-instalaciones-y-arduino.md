---
title: "Apéndice C: Computación Física: Arduino, Sensores e Instalaciones Interactivas 24/7"
description: "Max/MSP e instalaciones físicas interactivas: comunicación serial con Arduino a 115200 baudios, sensores analógicos, Firmata y sistemas tolerantes a fallos para uso 24/7 en museo."
---


Llevar Max/MSP fuera de la pantalla de la computadora hacia el espacio arquitectónico, museos, escenarios y galerías de arte requiere dominar la **Computación Física (*Physical Computing*)**.

En una instalación interactiva, el sistema sonoro no reacciona a un teclado o mouse, sino a la presencia del público, sensores de distancia por ultrasonido (HC-SR04), acelerómetros I2C (MPU-6050), sensores capacitivos táctiles o barreras infrarrojas. El microcontrolador por excelencia para esta tarea es la familia **Arduino / ESP32 / Teensy**, comunicándose con Max a través del objeto `[serial]` o redes inalámbricas.

*(Inspirado en Tom Igoe, *Physical Computing*, y Todd Winkler, *Composing Interactive Music*).*

---

## 1. El Protocolo Serial: Anatomía de la Comunicación Robusta

Muchos programadores cometen el error de enviar números simples separados por comas y leerlos a ciegas. En un entorno de instalación real, si se pierde un solo byte en el puerto USB por interferencia electromagnética o ruido estático, todos los valores subsiguientes quedan desplazados indefinidamente (*framing error*).

![FIG C.1 · Protocolo Robusto & Framing Delimiter](/assets/diagrams/diagrama_arduino_serial_pipeline.svg)

### 1.1. Las Cuatro Reglas de Oro de una Trama Serial
1. **Delimitador de Fin de Línea (*Line Delimiter*)**: Cada paquete de sensores debe terminar obligatoriamente con `\r\n` (ASCII 13 y 10). En Max se parsea con el objeto `[zl.slice]` o `[itoa]` tras agrupar bytes con `[zl.group]`.
2. **Alta Velocidad de Baudios**: Abandoná los obsoletos 9600 baudios. Configurá el puerto serial a **115200 baudios** para minimizar la latencia de transmisión a menos de 1 ms.
3. **Mapeo y Normalización en el Microcontrolador**: Leé a 10 bits ($0 \dots 1023$) y enviá datos enteros formateados. No satures el bus serial con operaciones de punto flotante innecesarias.
4. **Debouncing y Filtrado Analógico**: Suavizá las lecturas analógicas mediante un promedio móvil simple en C antes de transmitir.

---

## 2. Filtrado de Ruido y Acondicionamiento Gestual en Max

Las lecturas analógicas de sensores reales sufren de ruido electromagnético de alta frecuencia (interferencia por luces fluorescentes, fuentes conmutadas y cables largos). 

### 2.1. El Filtro de Promedio Móvil Exponencial (EMA)
Para estabilizar un potenciómetro o sensor capacitivo sin introducir latencia perceptible, implementamos en Max la fórmula del filtro **EMA (Exponential Moving Average)**:
$$y[n] = \alpha \cdot x[n] + (1 - \alpha) \cdot y[n-1]$$

Donde $\alpha \in (0.0, 1.0)$ determina el factor de suavizado:
- $\alpha = 0.8$: Respuesta ultrarrápida (ideal para transitorios rítmicos).
- $\alpha = 0.1$: Inercia suave y libre de temblores (ideal para modular filtros o volumen master).

```text
[ sensor_in ] ──> [* 0.2] ───┐
                             ├── [+] ───┬──> [ out_filtrado ]
      ┌── [ f ] ── [* 0.8] ──┘          │
      │                                 │
      └─────────────────────────────────┘ (feedback previo z^-1)
```

---

## 3. Redes Inalámbricas para Museos: ESP32 + OSC sobre Wi-Fi

El mayor problema físico en exposiciones y galerías es el **cable USB**:
- La especificación USB 2.0 tiene un límite físico estricto de 5 metros sin repetidores activos.
- Los cables expuestos en el piso sufren tropiezos del público, desconexiones mecánicas y bucles de masa (*ground loops*).

### La Solución Industrial: Microcontroladores ESP32 con OSC UDP
Utilizando un módulo **ESP32**, el microcontrolador lee los sensores analógicos y empaqueta las lecturas directamente en datagramas **UDP / OSC** transmitidos por la red Wi-Fi local hacia la IP de la computadora de Max:
- **Cero Cables de Conexión**: Solo requiere alimentación local (batería LiPo o transformador de pared).
- **Aislamiento Galvánico Total**: Elimina cualquier interferencia eléctrica o zumbido de 50/60 Hz inducido por la tierra del recinto.
- **Topología Multi-Sensor**: Max puede recibir simultáneamente telemetría de 20 microcontroladores independientes en el mismo puerto UDP (`[udpreceive 9000]`) enrutando por dirección de mensaje (`/sensor/sala1/presencia`, `/sensor/sala2/movimiento`).

---

## 4. Estrategias para Instalaciones Interactivas 24/7 (Alta Resiliencia)

Una instalación en un museo o espacio público no puede colgarse al tercer día. Principios arquitectónicos clave:

1. **Watchdog de Reconexión Automática**: Si un sensor USB se desconecta por vibración, el objeto `[serial]` falla. Implementá un circuito que verifique periódicamente el estado del puerto mediante `print`; si se detecta desconexión, envía repetidamente el mensaje `open` hasta reestablecer el enlace sin intervención humana.
2. **Prevención de Acumulación de Memoria**: Jamás acumules datos continuos en listas infinitas (`coll`, `dict`). Empleá buffers circulares de tamaño fijo.
3. **Standby y Modos de Ahorro Térmico**: Si los sensores no registran actividad durante 5 minutos, programá a Max para apagar el motor DSP (`[dspstate~]` a 0 o `poly~ @mute 1`) para enfriar el procesador y extender la vida útil del hardware.

---

## 5. Laboratorio Práctico: `lab_apendice_c_arduino.maxpat`

Para probar la comunicación física y la resiliencia en instalaciones:
- Parche interactivo de Max: [`book/patches/apendices/lab_apendice_c_arduino.maxpat`](/patches/apendices/lab_apendice_c_arduino.maxpat)
- Firmware Arduino listo para flashear: [`book/patches/apendices/firmware_sensores.ino`](/patches/apendices/firmware_sensores.ino)
