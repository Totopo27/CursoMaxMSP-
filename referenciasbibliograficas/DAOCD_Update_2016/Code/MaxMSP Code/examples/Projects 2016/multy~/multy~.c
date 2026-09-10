/****************************************************
 *   This code is explicated in Chapter 3 of        *
 *   "Designing Audio Objects for Max/MSP and Pd"   *
 *   by Eric Lyon.                                  *   
 ****************************************************/

/* Header files required by Max/MSP */

#include "ext.h" 
#include "z_dsp.h" 
#include "ext_obex.h"

/* The class pointer */

static t_class *multy_class;

/* The object structure */

typedef struct _multy {
	t_pxobject obj; // The Max/MSP object
} t_multy;

/* Function prototypes */

void *multy_new(void);
void multy_assist(t_multy *x, void *b, long msg, long arg, char *dst);
void multy_perform64(t_multy *x, t_object *dsp64, double **ins,
                      long numins, double **outs,long numouts, long n,
                      long flags, void *userparam);
void multy_dsp64(t_multy *x, t_object *dsp64, short *count, double sr, long n, long flags);

/* The main() function */

void ext_main(void *r)
{
	/* Initialize the class */
	 
	multy_class = class_new("multy~", (method)multy_new, (method)dsp_free, sizeof(t_multy), 0,0);
	
	/* Bind the DSP method, which is called when the DACs are turned on */
	
	class_addmethod(multy_class, (method)multy_dsp64, "dsp64", A_CANT, 0);
	
	/* Bind the assist method, which is called on mouse-overs to inlets and outlets */
	
	class_addmethod(multy_class, (method)multy_assist, "assist", A_CANT, 0);
	
	/* Add standard Max/MSP methods to your class */
	
	class_dspinit(multy_class);
	
	/* Register the class with Max */
	
	class_register(CLASS_BOX, multy_class);
	
	/* Print authorship message to Max window */
	
	post("multy~ from \"Designing Audio Objects\" by Eric Lyon");
}

/* The new instance routine */

void *multy_new(void)
{
	/* Instantiate a new multy~ object */
	
	t_multy *x = (t_multy *)object_alloc(multy_class);
	
	/* Create two signal inlets */
	
	dsp_setup((t_pxobject *)x, 2);
	
	/* Create one signal outlet */
	
	outlet_new((t_object *)x, "signal");
	
	/* Return a pointer to the new object */
	
	return x;
}

/* The perform routine */

void multy_perform64(t_multy *x, t_object *dsp64, double **ins,
                     long numins, double **outs,long numouts, long n,
                     long flags, void *userparam)
{
	/* Copy signal vector pointers */
	
	t_double *in1 = (t_double *) ins[0];
	t_double *in2 = (t_double *) ins[1];
	t_double *out = (t_double *) outs[0];
		
	/* Perform the DSP loop */
	
	while(n--){
		*out++ = *in1++ * *in2++;
	}
}

/* The assist method */

void multy_assist(t_multy *x, void *b, long msg, long arg, char *dst)
{
	/* Document inlet functions*/ 
	
	if (msg==ASSIST_INLET) {
		switch (arg) {
			case 0:
				sprintf(dst,"(signal) Input 1");
				break;
			case 1:
				sprintf(dst,"(signal) Input 2");
				break;
		}
	} 
	
	/* Document outlet function */
	
	else if (msg==ASSIST_OUTLET) {
		sprintf(dst,"(signal) Output");
	}
}

/* The DSP method */

void multy_dsp64(t_multy *x, t_object *dsp64, short *count, double sr, long n, long flags)
{
	/* Attach the object to the DSP chain, passing the DSP routine 
     multy_perform(), inlet and outlet pointers, and the signal vector size */
	
	object_method(dsp64, gensym("dsp_add64"),x,multy_perform64,0,NULL);
}