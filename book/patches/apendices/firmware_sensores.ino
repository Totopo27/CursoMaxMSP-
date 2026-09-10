// firmware_sensores.ino
// Firmware de lectura y transmisión serial determinista para Max/MSP
// Autor: Curso Universitario Max/MSP - Apéndice C

const int PIN_SENSOR_A = A0;
const int PIN_SENSOR_B = A1;
const int PIN_SENSOR_C = A2;

unsigned long prevMillis = 0;
const long sampleIntervalMs = 20; // Tasa de muestreo de 50 Hz

void setup() {
  // Comunicación serial a alta velocidad (115200 baudios)
  Serial.begin(115200);
}

void loop() {
  unsigned long currentMillis = millis();
  
  if (currentMillis - prevMillis >= sampleIntervalMs) {
    prevMillis = currentMillis;

    // Lectura de los convertidores analógico-digitales (10-bit: 0 - 1023)
    int rawA = analogRead(PIN_SENSOR_A);
    int rawB = analogRead(PIN_SENSOR_B);
    int rawC = analogRead(PIN_SENSOR_C);

    // Transmisión de trama delimitada: "A B C\r\n"
    Serial.print(rawA);
    Serial.print(" ");
    Serial.print(rawB);
    Serial.print(" ");
    Serial.println(rawC); // println incluye \r\n obligatorios para [sel 13 10]
  }
}
