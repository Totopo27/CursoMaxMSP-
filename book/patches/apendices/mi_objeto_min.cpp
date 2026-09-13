/**
 * @file mi_objeto_min.cpp
 * @brief Objeto externo en C++17 declarativo utilizando Cycling '74 Min-DevKit.
 * Autor: Curso Max/MSP - Apéndice D
 */

#include "c74_min.h"

using namespace c74::min;

class escalador_min : public object<escalador_min> {
public:
    MIN_DESCRIPTION {"Escalador y saturador aritmetico moderno en C++17 con Min-DevKit"};
    MIN_TAGS        {"dsp, math, modern-cpp"};
    MIN_AUTHOR      {"Curso Max/MSP"};
    MIN_RELATED     {"scale, expr, gen~"};

    // Declaración de Inlets (Entradas fuertemente tipadas)
    inlet<>  in_signal_val { this, "(number) Valor de entrada a procesar", "float" };
    inlet<>  in_factor     { this, "(number) Nuevo factor de escala", "float" };

    // Declaración de Outlets
    outlet<> out_resultado { this, "(number) Resultado procesado", "float" };
    outlet<> out_bang_sync { this, "(bang) Disparo de fin de computo", "bang" };

    // Declaración de Atributos configurables con rangos
    attribute<number> factor { this, "factor", 1.5,
        description {"Factor multiplicador de escala"},
        range {0.0, 100.0}
    };

    attribute<bool> saturar { this, "saturar", true,
        description {"Aplica tanh si el valor supera la unidad"}
    };

    // Mensaje para recibir enteros
    message<type::int_number> int_msg { this, "int",
        "Procesa enteros casteando a float",
        MIN_FUNCTION {
            number val = static_cast<double>(args[0]);
            procesar(val);
            return {};
        }
    };

    // Mensaje para recibir flotantes
    message<type::float_number> float_msg { this, "float",
        "Procesa el valor float de entrada",
        MIN_FUNCTION {
            number val = args[0];
            procesar(val);
            return {};
        }
    };

    // Mensaje para modificar el factor directamente
    message<> set_factor { this, "set_factor",
        "Ajusta el factor multiplicador",
        MIN_FUNCTION {
            if (!args.empty()) {
                factor = args[0];
            }
            return {};
        }
    };

private:
    void procesar(number val) {
        number res = val * factor;
        if (saturar && (res > 1.0 || res < -1.0)) {
            res = std::tanh(res);
        }
        out_resultado.send(res);
        out_bang_sync.send();
    }
};

MIN_EXTERNAL(escalador_min);
