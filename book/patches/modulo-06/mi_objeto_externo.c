/**
 * @file mi_objeto_externo.c
 * @brief Objeto externo de referencia para Max C SDK.
 * Implementa procesamiento aritmético con memoria interna y despacho dinámico de tipos.
 */

#include "ext.h"
#include "ext_obex.h"

typedef struct _mi_objeto {
    t_object ob;          // Estructura base de Max obligatoria (debe ser el primer miembro)
    long offset_acumulado; // Estado interno persistente
    void *outlet_resultado; // Puntero al outlet principal
    void *outlet_bang;      // Puntero al outlet de sincronía
} t_mi_objeto;

// Puntero global a la clase registrada en Max
static t_class *mi_objeto_class = NULL;

// Declaración de prototipos
void *mi_objeto_new(t_symbol *s, long argc, t_atom *argv);
void mi_objeto_free(t_mi_objeto *x);
void mi_objeto_bang(t_mi_objeto *x);
void mi_objeto_int(t_mi_objeto *x, long n);
void mi_objeto_reset(t_mi_objeto *x);

/**
 * @brief Punto de entrada principal invocado por Max al cargar la librería externa.
 */
void C74_EXPORT ext_main(void *r) {
    t_class *c = class_new("mi_objeto_externo", 
                           (method)mi_objeto_new, 
                           (method)mi_objeto_free, 
                           (long)sizeof(t_mi_objeto), 
                           0L, 
                           A_GIMME, 
                           0);

    // Asociación de métodos a selectores de mensajes
    class_addmethod(c, (method)mi_objeto_bang,  "bang", 0);
    class_addmethod(c, (method)mi_objeto_int,   "int",  A_LONG, 0);
    class_addmethod(c, (method)mi_objeto_reset, "reset", 0);

    class_register(CLASS_BOX, c);
    mi_objeto_class = c;
}

/**
 * @brief Constructor de la instancia. Se invoca cada vez que se crea la caja en un patcher.
 */
void *mi_objeto_new(t_symbol *s, long argc, t_atom *argv) {
    t_mi_objeto *x = (t_mi_objeto *)object_alloc(mi_objeto_class);
    if (!x) return NULL;

    x->offset_acumulado = 0;

    // Lectura de argumentos opcionales pasados en la caja: [mi_objeto_externo 100]
    if (argc > 0 && atom_gettype(argv) == A_LONG) {
        x->offset_acumulado = atom_getlong(argv);
    }

    // Creación de outlets en orden de DERECHA a IZQUIERDA
    x->outlet_bang = bangout((t_object *)x);
    x->outlet_resultado = intout((t_object *)x);

    return x;
}

/**
 * @brief Destructor de la instancia.
 */
void mi_objeto_free(t_mi_objeto *x) {
    // Si hubiéramos alocado buffers dinámicos con sysmem_newptr, aquí se liberarían
}

/**
 * @brief Manejador de mensaje 'bang': emite el valor acumulado actual.
 */
void mi_objeto_bang(t_mi_objeto *x) {
    outlet_int(x->outlet_resultado, x->offset_acumulado);
    outlet_bang(x->outlet_bang);
}

/**
 * @brief Manejador de mensaje 'int': suma el valor recibido y emite el nuevo total.
 */
void mi_objeto_int(t_mi_objeto *x, long n) {
    x->offset_acumulado += n;
    outlet_int(x->outlet_resultado, x->offset_acumulado);
}

/**
 * @brief Restablece el acumulador a cero.
 */
void mi_objeto_reset(t_mi_objeto *x) {
    x->offset_acumulado = 0;
    post("mi_objeto_externo: acumulador restablecido a 0.\n");
}
