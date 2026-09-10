# Protocolo Dinámico de Ingesta y Consulta Bibliográfica Continua

Este protocolo rige la metodología de trabajo para la redacción de todas las unidades, capítulos y proyectos del curso de Max/MSP.

---

## 🎯 1. Principio Rector: "El Triángulo del Conocimiento"
Cada lección del curso debe construirse cruzando obligatoriamente tres perspectivas:

```
                      [ LA VISIÓN TEÓRICA / ACADÉMICA ]
                      (Literatura en referenciasbibliograficas/)
                      • Acústica, teoría musical, algoritmos y diseño.
                                      ▲
                                     / \
                                    /   \
                                   /     \
                                  ▼       ▼
        [ LA API OFICIAL / WEB ] ◄─────────► [ LA VERDAD BAJO EL CAPÓ ]
        (docs.cycling74.com)                  (Cycling74/max-sdk C/C++)
        • Objetos, mensajes,                 • Hilos, memoria RAM, buffers
          atributos, help patches.             y rutinas perform64.
```

---

## 🔄 2. Procedimiento de Ingesta Continua (Nuevos Libros y Materiales)

El usuario agregará progresivamente nuevos libros, artículos y documentos en diferentes formatos (`.pdf`, `.epub`, `.mobi`, `.txt`, `.maxpat`) dentro de la carpeta:
📁 `D:\DocumentosDiscoD\CursoMaxMSP\referenciasbibliograficas\`

### Pasos automáticos ante nuevo material:
1. **Escaneo Automático:**
   - Correr los analizadores dedicados (`pipeline/scripts/analyze_pdfs.py` y `analyze_ebooks.py`).
   - Extraer tablas de contenido, tópicos clave y muestras de texto.
2. **Actualización del Inventario:**
   - Incorporar la nueva obra a [`BIBLIOGRAFIA_LOCAL.md`](file:///d:/DocumentosDiscoD/CursoMaxMSP/BIBLIOGRAFIA_LOCAL.md).
3. **Mapeo Conceptual al Módulo Correspondiente:**
   - Actualizar [`MAPEO_CONCEPTUAL_BIBLIO.md`](file:///d:/DocumentosDiscoD/CursoMaxMSP/MAPEO_CONCEPTUAL_BIBLIO.md) indicando exactamente qué capítulo del curso se beneficia de la nueva referencia.
4. **Persistencia en Engram:**
   - Guardar el nuevo conocimiento en la memoria persistente para asegurar su uso en futuras sesiones.

---

## 📝 3. Estructura Estándar Obligatoria por Capítulo
Para mantener el nivel de calidad inspirado en `rust-course`:
1. **Introducción Conceptual:** Fundamento teórico acústico/musical citando la literatura canónica.
2. **La Arquitectura en Max:** Explicación de los objetos oficiales involucrados.
3. **Bajo el Capó (Max SDK Deep Dive):** Qué ocurre en el código C/C++ (memoria, punteros, scheduler, vectores de audio).
4. **Múltiples Escenarios Reales (Mínimo 3 a 4 casos de estudio prácticos).**
5. **Laboratorio de Desafíos (3 Ejercicios de ingeniería).**
6. **Parche Reproducible `.maxpat` listo para abrir y sonar con FlexASIO.**
