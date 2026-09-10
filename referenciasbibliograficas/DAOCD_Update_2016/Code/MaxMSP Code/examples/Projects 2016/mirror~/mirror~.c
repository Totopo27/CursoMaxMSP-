/****************************************************
 *   This code is used in Chapter 1 of              *
 *   "Designing Audio Objects for Max/MSP and Pd"   *
 *   by Eric Lyon.                                  *   
 ****************************************************/

/* Header files required by Max/MSP */

#include "ext.h"
#include "z_dsp.h"
#include "ext_obex.h"

/* The class pointer */

static t_class *mirror_class;

/* The object structure */

typedef struct _mirror
{
	t_pxobject obj; // The Max/MSP object
} t_mirror;

/* Function prototypes */

void *mirror_new(void);
//void ext_main(void);
void mirror_assist(t_mirror *x, void *b, long io, long inlet, char *dest);
void mirror_perform64(t_mirror *x, t_object *dsp64, double **ins,
                      long numins, double **outs,long numouts, long n,
                      long flags, void *userparam);
void mirror_dsp64(t_mirror *x, t_object *dsp64, short *count, double sr, long n, long flags);


/* 
 The main() function, where the class is defined, and messages are bound to it. 
 This function is run just once when the external is loaded to Max/MSP. Even if multiple
 copies of the external are instantiated, main() is called only once. So this is a good
 place to print information about the external to the Max window.
 */

void ext_main(void *r)
{
	/* Initialize the class */
	
	mirror_class = class_new("mirror~", (method)mirror_new, (method)dsp_free, sizeof(t_mirror), 0, 0);

	/* bind the DSP method, which is called when the DACs are turned on */
    
	class_addmethod(mirror_class,(method)mirror_dsp64, "dsp64", A_CANT, 0);
	
	/* bind the assist method for mouse-overs on inlets/outlets */
	
	class_addmethod(mirror_class,(method)mirror_assist, "assist", A_CANT, 0);
	
	/* Add standard Max/MSP methods to your class */

	class_dspinit(mirror_class);
	
	/* Register the class with Max */
	
	class_register(CLASS_BOX, mirror_class);
	
	/* Print authorship message to the Max window */
	
	post("mirror~ from \"Designing Audio Objects\" by Eric Lyon");

}

/* The new instance routine */

void *mirror_new(void)
{
	/* Instantiate a new mirror~ object */
	
    t_mirror *x = (t_mirror *)object_alloc(mirror_class);
	
	/* Create one signal inlet */

    dsp_setup((t_pxobject *)x,1);	
	
	/* Create one signal outlet */
	
    outlet_new((t_pxobject *)x, "signal");
	
	/* Return a pointer to the new object */

    return x;
}

/* The perform routine */

void mirror_perform64(t_mirror *x, t_object *dsp64, double **ins,
                        long numins, double **outs,long numouts, long n,
                        long flags, void *userparam)
{
	/* Copy the signal inlet pointer */
	
	t_double *in = (t_double *) ins[0];
	
	/* Copy the signal outlet pointer */
	
	t_double *out = (t_double *) outs[0];
	
	
	/* copy 'n' samples from the signal inlet to the signal outlet */
	
	while (n--) { 
		*out++ = *in++;
	}
    
	/* return the next address on the signal chain */
}


/* The DSP method */

void mirror_dsp64(t_mirror *x, t_object *dsp64, short *count, double sr, long n, long flags)
{
	/* call the dsp_add() function, passing the DSP routine to
	 be used, which is mirror_perform() in this case; the number of remaining 
	 arguments; a pointer to the signal inlet; a pointer to the signal outlet; 
	 and finally, the signal vector size in samples.
	 */
	
    object_method(dsp64, gensym("dsp_add64"),x,mirror_perform64,0,NULL);
}

/* The assist method */

void mirror_assist(t_mirror *x, void *b, long io, long index, char *dest)
{
    switch (io) {
        case ASSIST_INLET: 
            switch (index) {
                case 0: sprintf(dest, "(Signal) input to be copied"); break;
        }
        case ASSIST_OUTLET:
            switch(index){
                case 0: sprintf(dest, "(Signal) copied output"); break;
        }
    }
}

