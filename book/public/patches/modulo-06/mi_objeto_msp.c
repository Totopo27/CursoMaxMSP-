/**
 * @file mi_objeto_msp.c
 * @brief External MSP de Audio en C (64-bit perform64, dsp64, Obex Attributes & sysmem)
 * 
 * Basado en la arquitectura formal de Eric Lyon ("Designing Audio Objects for Max/MSP")
 * y el Cycling '74 Max SDK.
 */

#include "ext.h"
#include "z_dsp.h"
#include "ext_obex.h"
#include <math.h>

#define DEFAULT_TABLESIZE 4096
#define DEFAULT_FREQ 440.0

/**
 * Estructura del Objeto MSP.
 * OBLIGATORIO: El primer miembro debe ser 't_pxobject' para herencia binaria en MSP.
 */
typedef struct _mi_objeto_msp {
    t_pxobject  ob;                 // Cabecera obligatoria de MSP
    double      *wavetable;         // Memoria alocada con sysmem_newptr
    long        table_length;       // Tamano de la tabla
    double      phase;              // Acumulador de fase (0.0 a 1.0)
    double      phase_step;         // Incremento de fase por muestra
    double      samplerate;         // Frecuencia de muestreo actual
    
    // Atributos Obex
    double      a_frequency;        // Atributo @frequency
    double      a_gain;             // Atributo @gain
    t_symbol    *a_waveform;        // Atributo @waveform (sine, saw, tri)
    
    // Cola asincrona para comunicacion segura con la GUI
    void        *qelem_gui;
    double      peak_tracker;
    void        *out_peak;          // Outlet para telemetria de control
} t_mi_objeto_msp;

// Puntero global a la clase registrada
static t_class *mi_objeto_msp_class = NULL;

// Prototipos de funciones
void *mi_objeto_msp_new(t_symbol *s, short argc, t_atom *argv);
void mi_objeto_msp_free(t_mi_objeto_msp *x);
void mi_objeto_msp_assist(t_mi_objeto_msp *x, void *b, long msg, long arg, char *dst);
void mi_objeto_msp_dsp64(t_mi_objeto_msp *x, t_object *dsp64, short *count, double sr, long n, long flags);
void mi_objeto_msp_perform64(t_mi_objeto_msp *x, t_object *dsp64, double **ins, long numins,
                              double **outs, long numouts, long sampleframes, long flags, void *userparam);
void mi_objeto_msp_perform_nosig64(t_mi_objeto_msp *x, t_object *dsp64, double **ins, long numins,
                                   double **outs, long numouts, long sampleframes, long flags, void *userparam);
void mi_objeto_msp_init_table(t_mi_objeto_msp *x);
void mi_objeto_msp_qelem_callback(t_mi_objeto_msp *x);
t_max_err a_frequency_set(t_mi_objeto_msp *x, void *attr, long ac, t_atom *av);

/**
 * ext_main: Punto de entrada exportado de la libreria dinamica (.mxe64 / .mxo)
 */
void ext_main(void *r) {
    t_class *c = class_new("mi_objeto_msp~",
                           (method)mi_objeto_msp_new,
                           (method)mi_objeto_msp_free,
                           sizeof(t_mi_objeto_msp),
                           0L,
                           A_GIMME,
                           0);

    // 1. Vincular metodos estandar
    class_addmethod(c, (method)mi_objeto_msp_dsp64,  "dsp64",  A_CANT, 0);
    class_addmethod(c, (method)mi_objeto_msp_assist, "assist", A_CANT, 0);

    // 2. Inicializar subsistema MSP (vital: registra inlets de senal)
    class_dspinit(c);

    // 3. Declarar Atributos Obex
    CLASS_ATTR_DOUBLE(c, "frequency", 0, t_mi_objeto_msp, a_frequency);
    CLASS_ATTR_ACCESSORS(c, "frequency", NULL, a_frequency_set);
    CLASS_ATTR_LABEL(c, "frequency", 0, "Frecuencia Fundamental (Hz)");

    CLASS_ATTR_DOUBLE(c, "gain", 0, t_mi_objeto_msp, a_gain);
    CLASS_ATTR_LABEL(c, "gain", 0, "Ganancia Lineal (0.0 - 1.0)");

    CLASS_ATTR_SYM(c, "waveform", 0, t_mi_objeto_msp, a_waveform);
    CLASS_ATTR_LABEL(c, "waveform", 0, "Forma de Onda (sine, saw, tri)");

    // Registrar en el namespace CLASS_BOX de Max
    class_register(CLASS_BOX, c);
    mi_objeto_msp_class = c;
    post("mi_objeto_msp~ compilado con arquitectura de 64-bit perform64.");
}

/**
 * Constructor de instancia
 */
void *mi_objeto_msp_new(t_symbol *s, short argc, t_atom *argv) {
    t_mi_objeto_msp *x = (t_mi_objeto_msp *)object_alloc(mi_objeto_msp_class);
    if (!x) return NULL;

    // 1. dsp_setup crea el inlet de senal por defecto (inlet 0)
    dsp_setup((t_pxobject *)x, 1);

    // 2. Crear outlets (de derecha a izquierda segun convencion Max)
    x->out_peak = floatout((t_object *)x);           // Outlet 1: Control (pico RMS asincrono)
    outlet_new((t_pxobject *)x, "signal");            // Outlet 0: Audio de salida

    // 3. Inicializar parametros y defaults
    x->table_length = DEFAULT_TABLESIZE;
    x->phase = 0.0;
    x->samplerate = sys_getsr();
    if (x->samplerate <= 0.0) x->samplerate = 48000.0;

    x->a_frequency = DEFAULT_FREQ;
    x->a_gain = 0.8;
    x->a_waveform = gensym("sine");
    x->phase_step = x->a_frequency / x->samplerate;
    x->peak_tracker = 0.0;

    // 4. Asignar memoria con sysmem (alineada y segura)
    x->wavetable = (double *)sysmem_newptr(sizeof(double) * x->table_length);
    if (!x->wavetable) {
        object_error((t_object *)x, "Fallo al alocar tabla de onda en RAM.");
        return NULL;
    }
    mi_objeto_msp_init_table(x);

    // 5. Crear qelem para despacho seguro a la GUI
    x->qelem_gui = qelem_new((t_object *)x, (method)mi_objeto_msp_qelem_callback);

    // 6. Parsear argumentos pasados en la caja (@frequency 880.)
    attr_args_process(x, argc, argv);

    return x;
}

/**
 * Destructor de instancia: limpieza obligatoria para evitar memory leaks
 */
void mi_objeto_msp_free(t_mi_objeto_msp *x) {
    // 1. Liberar infraestructura DSP
    dsp_free((t_pxobject *)x);

    // 2. Destruir qelem
    if (x->qelem_gui) qelem_free(x->qelem_gui);

    // 3. Liberar memoria alocada con sysmem
    if (x->wavetable) sysmem_freeptr(x->wavetable);
}

/**
 * Inicializacion de la Wavetable
 */
void mi_objeto_msp_init_table(t_mi_objeto_msp *x) {
    const double two_pi = 8.0 * atan(1.0);
    for (long i = 0; i < x->table_length; i++) {
        x->wavetable[i] = sin(two_pi * ((double)i / (double)x->table_length));
    }
}

/**
 * Setter de atributo para @frequency
 */
t_max_err a_frequency_set(t_mi_objeto_msp *x, void *attr, long ac, t_atom *av) {
    if (ac && av) {
        double f = atom_getfloat(av);
        if (f < 0.0) f = 0.0;
        x->a_frequency = f;
        if (x->samplerate > 0.0) {
            x->phase_step = x->a_frequency / x->samplerate;
        }
    }
    return MAX_ERR_NONE;
}

/**
 * dsp64: Se ejecuta al compilar el grafo DSP (startwindow o cambio de samplerate)
 */
void mi_objeto_msp_dsp64(t_mi_objeto_msp *x, t_object *dsp64, short *count, double sr, long n, long flags) {
    if (sr > 0.0) {
        x->samplerate = sr;
        x->phase_step = x->a_frequency / x->samplerate;
    }

    // count[0] indica si hay una senal de audio conectada en el inlet 0 (frecuencia modulada)
    if (count[0]) {
        // Modo FM / Senal continua en la entrada
        object_method(dsp64, gensym("dsp_add64"), x, mi_objeto_msp_perform64, 0, NULL);
    } else {
        // Modo Estatico / Control: omite leer el buffer ins[0] para maximo rendimiento
        object_method(dsp64, gensym("dsp_add64"), x, mi_objeto_msp_perform_nosig64, 0, NULL);
    }
}

/**
 * perform64: Bucle de procesamiento de audio en tiempo real (con modulacion de frecuencia)
 * REGLA DE ORO: Jamas llamar malloc, free, mutex locks ni funciones de GUI aqui.
 */
void mi_objeto_msp_perform64(t_mi_objeto_msp *x, t_object *dsp64, double **ins, long numins,
                              double **outs, long numouts, long sampleframes, long flags, void *userparam) {
    t_double *in_freq = ins[0];
    t_double *out = outs[0];
    long n = sampleframes;
    double ph = x->phase;
    double sr_inv = 1.0 / x->samplerate;
    long tbl_len = x->table_length;
    double *table = x->wavetable;
    double gain = x->a_gain;
    double current_peak = 0.0;

    while (n--) {
        // 1. Calcular indice de tabla con interpolacion lineal
        double findex = ph * (double)tbl_len;
        long index0 = (long)findex;
        long index1 = (index0 + 1) % tbl_len;
        double frac = findex - (double)index0;

        double sample = table[index0] + frac * (table[index1] - table[index0]);
        sample *= gain;

        // Anti-denormal guard
        if (fabs(sample) < 1e-15) sample = 0.0;

        *out++ = sample;

        // Rastrear pico absoluto
        if (fabs(sample) > current_peak) current_peak = fabs(sample);

        // 2. Incrementar fase con frecuencia modulada por inlet
        double f = *in_freq++;
        ph += (f * sr_inv);
        if (ph >= 1.0) ph -= 1.0;
        else if (ph < 0.0) ph += 1.0;
    }

    x->phase = ph;

    // Disparar qelem de forma segura si el pico supera el umbral
    if (current_peak > x->peak_tracker) {
        x->peak_tracker = current_peak;
        qelem_set(x->qelem_gui);
    }
}

/**
 * perform_nosig64: Variante optimizada cuando no hay cable de senal en la entrada
 */
void mi_objeto_msp_perform_nosig64(t_mi_objeto_msp *x, t_object *dsp64, double **ins, long numins,
                                   double **outs, long numouts, long sampleframes, long flags, void *userparam) {
    t_double *out = outs[0];
    long n = sampleframes;
    double ph = x->phase;
    double step = x->phase_step;
    long tbl_len = x->table_length;
    double *table = x->wavetable;
    double gain = x->a_gain;

    while (n--) {
        long index = (long)(ph * (double)tbl_len);
        *out++ = table[index] * gain;

        ph += step;
        if (ph >= 1.0) ph -= 1.0;
    }

    x->phase = ph;
}

/**
 * Callback asincrono ejecutado en el Main Thread (seguro para GUI y outlets de control)
 */
void mi_objeto_msp_qelem_callback(t_mi_objeto_msp *x) {
    outlet_float(x->out_peak, x->peak_tracker);
    x->peak_tracker = 0.0; // Reset
}

/**
 * Mensajes de asistencia para inlets y outlets en el patcher
 */
void mi_objeto_msp_assist(t_mi_objeto_msp *x, void *b, long msg, long arg, char *dst) {
    if (msg == ASSIST_INLET) {
        sprintf(dst, "(signal/float) Frecuencia de modulacion");
    } else if (msg == ASSIST_OUTLET) {
        if (arg == 0) sprintf(dst, "(signal) Salida de audio sintetizada");
        else sprintf(dst, "(float) Telemetria asincrona de amplitud pico");
    }
}
