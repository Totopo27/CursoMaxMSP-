/**
 * @file filtro_va_min.cpp
 * @brief Filtro Virtual Analog (VA) State Variable Filter (SVF) con Zero-Delay Feedback (ZDF)
 *        y Parameter Smoothing en C++17 utilizando Cycling '74 Min-DevKit.
 *
 * Basado en las arquitecturas de:
 * - Will Pirkle (2019): Designing Audio Effect Plugins in C++ (2da Ed., Focal Press).
 * - Vadim Zavalishin (2012): The Art of VA Filter Design.
 */

#include "c74_min.h"
#include <cmath>

using namespace c74::min;

class filtro_va_min : public object<filtro_va_min>, public sample_operator<1, 1> {
public:
    MIN_DESCRIPTION {"Filtro Virtual Analog SVF ZDF con suavizado de parametros en C++17"};
    MIN_TAGS        {"dsp, filter, virtual-analog, va, min-devkit"};
    MIN_AUTHOR      {"Curso Max/MSP - Apendice D (Ref: Will Pirkle)"};
    MIN_RELATED     {"svf~, biquad~, gen~"};

    // Entradas y Salidas de Señal MSP
    inlet<>  in_audio    { this, "(signal) Entrada de audio", "signal" };
    outlet<> out_audio   { this, "(signal) Salida filtrada", "signal" };

    // Atributos de Control (Obex)
    attribute<number> cutoff { this, "cutoff", 1000.0,
        description {"Frecuencia de corte en Hz"},
        range {20.0, 20000.0}
    };

    attribute<number> q { this, "q", 0.7071,
        description {"Factor de resonancia Q"},
        range {0.5, 20.0}
    };

    attribute<symbol> mode { this, "mode", "lowpass",
        description {"Tipo de respuesta: lowpass, highpass, bandpass, notch"}
    };

    attribute<number> smooth_time { this, "smooth_time", 20.0,
        description {"Tiempo de suavizado de parametros en milisegundos (anti zipper-noise)"},
        range {1.0, 200.0}
    };

    // Manejador del cambio de Sample Rate del motor DSP de Max
    message<> dspsetup { this, "dspsetup",
        MIN_FUNCTION {
            sample_rate = args[0];
            reset_states();
            update_coefficients();
            return {};
        }
    };

    // Operador de procesamiento muestra a muestra (inlined por el compilador C++)
    samples<1> operator()(sample input) {
        // 1. Suavizado unipolar de frecuencia de corte (One-Pole Smoother)
        // Evita saltos abruptos de fase y clicks audibles (zipper noise)
        current_cutoff = target_cutoff + smooth_coef * (current_cutoff - target_cutoff);

        // 2. Pre-warping bilineal de la frecuencia angular (Will Pirkle, Ec. 11.4)
        // wa = (2/T) * tan(wd * T / 2)
        double wd = 2.0 * M_PI * current_cutoff;
        double wa = (2.0 * sample_rate) * std::tan(wd / (2.0 * sample_rate));
        double g = wa / (2.0 * sample_rate); // Parametro integrador normalizado
        double R = 1.0 / (2.0 * q);          // Factor de amortiguacion damping

        // 3. Resolucion analitica de realimentacion instantanea Zero-Delay Feedback (ZDF)
        // Evita el delay parasito de 1 muestra en la recursion
        double hpf = (input - (2.0 * R + g) * s1 - s2) / (1.0 + 2.0 * R * g + g * g);
        double bpf = g * hpf + s1;
        double lpf = g * bpf + s2;

        // Saturacion suave no lineal en el lazo resonante (analog saturation model)
        bpf = std::tanh(bpf);

        // Actualizacion de los integradores trapezoidales (variables de estado)
        s1 = g * hpf + bpf;
        s2 = g * bpf + lpf;

        // 4. Seleccion de topologia segun modo
        double output = lpf;
        if (mode == "highpass") {
            output = hpf;
        } else if (mode == "bandpass") {
            output = bpf;
        } else if (mode == "notch") {
            output = hpf + lpf;
        }

        return { output };
    }

private:
    double sample_rate = 44100.0;
    double s1 = 0.0; // Estado integrador 1
    double s2 = 0.0; // Estado integrador 2

    double target_cutoff = 1000.0;
    double current_cutoff = 1000.0;
    double smooth_coef = 0.99;

    void reset_states() {
        s1 = 0.0;
        s2 = 0.0;
    }

    void update_coefficients() {
        target_cutoff = cutoff;
        // Calculo de coeficiente de filtro unipolar: beta = exp(-1 / (tau * fs))
        double tau = (smooth_time / 1000.0);
        smooth_coef = std::exp(-1.0 / (tau * sample_rate));
    }
};

MIN_EXTERNAL(filtro_va_min);
