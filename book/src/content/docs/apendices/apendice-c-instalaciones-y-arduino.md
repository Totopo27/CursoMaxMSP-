---
title: "Apéndice C: Computación Física: Arduino, Sensores e Instalaciones Interactivas 24/7"
description: "Capítulo del curso universitario de Max/MSP"
---


Llevar Max/MSP fuera de la pantalla de la computadora hacia el espacio arquitectónico, museos, escenarios y galerías de arte requiere dominar la **Computación Física (*Physical Computing*)**.

En una instalación interactiva, el sistema sonoro no reacciona a un teclado o mouse, sino a la presencia del público, sensores de distancia por ultrasonido (HC-SR04), acelerómetros I2C (MPU-6050), sensores capacitivos táctiles o barreras infrarrojas. El microcontrolador por excelencia para esta tarea es la familia **Arduino / ESP32 / Teensy**, comunicándose con Max a través del objeto `[serial]`.

---

## 1. El Protocolo Serial: Anatomía de la Comunicación Robusta

Muchos programadores cometen el error de enviar números simples separados por comas y leerlos a ciegas. En un entorno de instalación real, si se pierde un solo byte en el puerto USB por interferencia electromagnética, todos los valores subsiguientes quedan desplazados indefinidamente (*framing error*).

![FIG C.1 · Protocolo Robusto & Framing Delimiter](/assets/diagrams/diagrama_arduino_serial_pipeline.svg)

### 1.1. Las Cuatro Reglas de Oro de una Trama Serial
1. **Delimitador de Fin de Línea (*Line Delimiter*)**: Cada paquete de sensores debe terminar obligatoriamente con `\r\n` (ASCII 13 y 10).
2. **Alta Velocidad de Baudios**: Abandoná los obsoletos 9600 baudios. Configurá el puerto serial a **115200 baudios** para minimizar la latencia de transmisión a menos de 1 ms.
3. **Mapeo y Normalización en el Microcontrolador**: Leé a 10 bits ($0 \dots 1023$) y enviá datos enteros formateados. No satures el bus serial con operaciones de punto flotante innecesarias.
4. **Debouncing y Filtrado Analógico**: Suavizá las lecturas analógicas mediante un promedio móvil simple en C antes de transmitir.

---

## 2. Código Firmware para Arduino: `firmware_sensores.ino`

El firmware provisto en este apéndice implementa una transmisión determinista a 50 Hz (cada 20 ms):

```cpp
// firmware_sensores.ino
// Lectura de 3 sensores analógicos y transmisión formateada con delimitador \r\n

const int SENSOR_PIN_1 = A0;
const int SENSOR_PIN_2 = A1;
const int SENSOR_PIN_3 = A2;

unsigned long previousMillis = 0;
const long interval = 20; // 50 Hz

void setup() {
  Serial.begin(115200);
}

void loop() {
  unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;

    int val1 = analogRead(SENSOR_PIN_1);
    int val2 = analogRead(SENSOR_PIN_2);
    int val3 = analogRead(SENSOR_PIN_3);

    // Formato de trama: V1 V2 V3\n
    Serial.print(val1);
    Serial.print(" ");
    Serial.print(val2);
    Serial.print(" ");
    Serial.println(val3); // println agrega automáticamente \r\n
  }
}
```

---

## 3. Estrategias para Instalaciones Interactivas 24/7 (Alta Resiliencia)

Una instalación en un museo o espacio público no puede colgarse al tercer día. Principios arquitectónicos clave:

1. **Watchdog de Reconexión Serial**: Si alguien desconecta el cable USB del sensor, el objeto `[serial]` de Max se cerrará. Usá un mecanismo con `[serial]` enviando el mensaje `print` periódicamente y verificando el estado del puerto; si falla, enviá `open` para reintentar la conexión automáticamente.
2. **Prevención de Acumulación de Memoria**: Evitá almacenar listas infinitas en memoria (`coll`, `dict`). Cualquier búfer temporal debe tener un tamaño fijo o circular.
3. **Standby y Modos de Energía**: Si los sensores no detectan público durante 5 minutos, programá a Max para apagar los motores DSP (`[poly~]` a 0 o `dsp state 0`) para reducir la carga de CPU y enfriar el hardware.
