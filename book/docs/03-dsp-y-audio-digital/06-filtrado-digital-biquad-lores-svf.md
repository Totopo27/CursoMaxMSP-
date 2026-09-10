# Lección 3.6: Filtrado Digital: Polos, Ceros, biquad~, lores~ y State Variable Filters (svf~)

> *"Un filtro digital no elimina frecuencias de forma mágica: retrasa la señal de entrada, la multiplica por coeficientes algebraicos cuidadosamente calibrados y la realimenta sobre sí misma. La diferencia de fase resultante cancela destructivamente ciertas frecuencias y refuerza constructivamente otras."*  
> — **Richard Boulanger**, *The Audio Programming Book*

---

### Objetivos Pedagógicos y de Ingeniería
1. **Comprender la Transformada Z y la Ecuación en Diferencias de Segundo Orden (Biquad)**: Deducir cómo una combinación de 2 muestras de retardo de entrada ($z^{-1}, z^{-2}$) y 2 de salida produce un filtro bicuadrático universal.
2. **Dominar la física del Plano Complejo Z**: Analizar el círculo unitario, los ceros (que introducen muescas de atenuación) y los polos (que generan resonancia y picos selectivos).
3. **Mapear la estabilidad de los filtros**: Demostrar matemáticamente por qué un polo con magnitud $|p| \ge 1$ causa inestabilidad asintótica y explosión numérica a $\pm \infty$ (NaN).
4. **Implementar los 3 paradigmas de filtrado en Max/MSP**:
   - `[biquad~]` + `[filtergraph~]`: Precisión quirúrgica paramétrica.
   - `[lores~]`: Filtro resonante paso-bajo optimizado de 2 polos con auto-oscilación analógica.
   - `[svf~]` (State Variable Filter): Topología de Chamberlin con salidas simultáneas Lowpass, Highpass, Bandpass y Notch.

---

## 1. Fundamentos Matemáticos: La Ecuación en Diferencias Canónica

El filtro bicuadrático (IIR de 2º orden) responde a la siguiente ecuación en diferencias direct-form II:

$$y[n] = b_0 x[n] + b_1 x[n-1] + b_2 x[n-2] - a_1 y[n-1] - a_2 y[n-2]$$

Aplicando la transformada $\mathcal{Z}$, la función de transferencia en el plano $z$ es:

$$H(z) = \frac{b_0 + b_1 z^{-1} + b_2 z^{-2}}{1 + a_1 z^{-1} + a_2 z^{-2}}$$

### El Plano Z y el Círculo Unitario
- Las raíces del numerador son los **ceros** del filtro ($H(z) = 0$).
- Las raíces del denominador son los **polos** del filtro ($H(z) \to \infty$).
- **Criterio Estricto de Estabilidad BIBO (Bounded-Input Bounded-Output)**: Todos los polos deben residir **estrictamente en el interior del círculo unitario**:
  $$|p_k| < 1 \quad \forall k$$
  Si un polo toca el círculo ($|p| = 1$), el sistema se convierte en un oscilador senoidal puro no amortiguado (auto-oscilación). Si cruza hacia afuera ($|p| > 1$), los valores de amplitud crecen exponencialmente hasta saturar los registros flotantes de 64 bits en `+inf` o `NaN`, silenciando el motor de audio de Max.

```
       Im(z)
         |     x (Polo fuera: ¡EXPLOSIÓN!)
      1.0|   .---.
         |  /  x  \  (Polo dentro: Estable y resonante)
   ------+-(---+---)+------ Re(z)
         |  \     /
     -1.0|   '---' (Círculo Unitario |z|=1)
         |
```

---

## 2. Los Tres Sabores de Filtros en Max/MSP

### A. `biquad~` y su Interfaz `filtergraph~`
`[biquad~]` es un ejecutor bruto de la ecuación de diferencias. Recibe 5 coeficientes directos `b0 b1 b2 a1 a2`.
- En lugar de calcular a mano los coeficientes de Robert Bristow-Johnson (Cookbook Formulae), utilizamos la interfaz visual `[filtergraph~]`.
- Modos estándar: `lowpass`, `highpass`, `bandpass`, `bandstop` (notch), `peaknotch`, `lowshelf`, `highshelf`.

### B. `lores~` (Lowpass Resonante Estilo Sintetizador Analógico)
- **Sintaxis**: `lores~ [frecuencia_corte] [resonancia_0_a_1]`
- Emula la caída de 12 dB/octava de un filtro analógico ladder básico.
- Cuando la resonancia se acerca a `0.999`, el filtro entra en **auto-oscilación**, actuando como un oscilador senoidal puro que puede ser afinado cromáticamente por su frecuencia de corte.

### C. `svf~` (State Variable Filter de Chamberlin)
- Estructura topológica basada en integradores acoplados.
- **Outlet 1**: Lowpass (paso-bajo)
- **Outlet 2**: Highpass (paso-alto)
- **Outlet 3**: Bandpass (paso-banda)
- **Outlet 4**: Notch (rechazo de banda)
- **Propiedad única**: Permite barrer el espectro de un sintetizador mientras se conserva la energía simultánea en múltiples bandas sin recalcular matrices de coeficientes completas.

---

## 3. Bajo el Capó: Análisis en C del Bucle de Filtrado (`biquad~`)

Observemos cómo el objeto nativo del SDK procesa la memoria de retardo en cada vector de audio de 64 bits:

```c
// Modelo conceptual del algoritmo de biquad en z_dsp.h
void biquad_perform64(t_biquad *x, t_object *dsp64, double **ins, long numins,
                      double **outs, long numouts, long sampleframes,
                      long flags, void *userparam) {
    double *in = ins[0];
    double *out = outs[0];
    double b0 = x->b0, b1 = x->b1, b2 = x->b2;
    double a1 = x->a1, a2 = x->a2;
    double x1 = x->x1, x2 = x->x2;
    double y1 = x->y1, y2 = x->y2;
    
    for (int i = 0; i < sampleframes; i++) {
        double current_in = in[i];
        
        // Ecuación en diferencias directa
        double current_out = b0 * current_in + b1 * x1 + b2 * x2 - a1 * y1 - a2 * y2;
        
        // Prevención de Denormals (subnormal floats que liquidan el CPU)
        if (fabs(current_out) < 1.0e-20) current_out = 0.0;
        
        // Desplazamiento de registros de estado
        x2 = x1;
        x1 = current_in;
        y2 = y1;
        y1 = current_out;
        
        out[i] = current_out;
    }
    
    x->x1 = x1; x->x2 = x2;
    x->y1 = y1; x->y2 = y2;
}
```

### El Asesino Oculto del CPU: *Denormal Numbers*
Cuando un filtro IIR decae hacia el infinito con una entrada cero, el valor de $y[n]$ se vuelve infinitamente pequeño ($10^{-308}$). Los procesadores x86/ARM caen en un modo de microcódigo de hardware extremadamente lento para calcular números desnormalizados (*subnormals*), incrementando el uso de CPU de un $2\%$ a un $80\%$ de golpe. Max implementa internamente `FIX_DENORM_NAN` para mandar a cero magnitudes menores al umbral térmico.

---

## 4. Escenarios Reales de Producción

1. **Subtractive Synth Lead**: Una onda de sierra rica en armónicos (`saw~`) pasada por un `lores~` con frecuencia modulada por un LFO o una envolvente `curve~` exponencial.
2. **Eliminador de Hum de 50/60 Hz (Notch Filter)**: Usar `[filtergraph~]` en modo `bandstop` con una $Q$ muy estrecha ($Q = 20$) centrado en 50 Hz o 60 Hz para limpiar grabaciones de guitarra sin degradar el cuerpo de graves.
3. **Crossover de Audio de 2 Vías**: Utilizar un `[svf~]` para dividir una señal de master en frecuencias graves (subwoofer) por el outlet Lowpass y agudos (satélites) por el outlet Highpass.
4. **Resonador Tonal de Ruido**: Excitar un filtro resonante de banda estrecha con `noise~` blanco para crear emulaciones físicas de viento, flautas o cuerdas frotadas.

---

## 5. Desafíos de Ingeniería

### Desafío 1: El Generador de Auto-Oscilación Afinado
Configurá `[lores~]` con resonancia en `0.9995`. Desconectá cualquier entrada de audio y utilizá la frecuencia de corte como tono melódico afinado en semitonos MIDI ($f = 440 \cdot 2^{(m-69)/12}$). Demostrá cómo se comporta como un oscilador senoidal sinusoidal autónomo.

### Desafío 2: Matriz de Formantes Vocales
Diseñá un banco de 3 filtros de banda en paralelo (`[biquad~]`) con frecuencias y ganancias sintonizadas para las formantes $F_1, F_2, F_3$ de la vocal humana "/a/" (aprox. 800 Hz, 1200 Hz, 2500 Hz). Excitá el banco con un tren de pulsos ricos de `saw~`.

### Desafío 3: El Detector de NaN y Auto-Reset
Creá un circuito lógico en Max con `[isnan~]` o comparadores de umbral que detecte si un filtro explota a valores no numéricos y envíe automáticamente el mensaje `clear` a `[biquad~]` para vaciar sus registros de memoria de retardo.

---

## 6. Laboratorio Práctico: `laboratorio_12_filtros.maxpat`

El laboratorio interactivo incluye:
- Banco conmutador en tiempo real entre `biquad~` (con interfaz gráfica completa `filtergraph~`), `lores~` analógico resonante y `svf~` de 4 salidas simultáneas.
- Excitadores duales: Onda de Sierra analógica rica en armónicos y generador de Ruido Blanco.
- Espectrograma FFT en cascada para visualizar las pendientes de atenuación en dB/octava y los picos de resonancia $Q$.
