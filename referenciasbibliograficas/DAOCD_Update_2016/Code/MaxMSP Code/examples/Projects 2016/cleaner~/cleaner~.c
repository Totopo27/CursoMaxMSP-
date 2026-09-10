/****************************************************
 *   This code is explicated in Chapter 8 of        *
 *   "Designing Audio Objects for Max/MSP and Pd"   *
 *   by Eric Lyon.                                  *   
 ****************************************************/

/* Required Max/MSP Header Files */

#include "ext.h" 
#include "z_dsp.h" 
#include "ext_obex.h"

/* The object structure */

typedef struct _cleaner {
	t_pxobject obj;
} t_cleaner;

/* The class declaration */

static t_class *cleaner_class;

/* Function prototypes */

void *cleaner_new(void);
void cleaner_assist(t_cleaner *x, void *b, long msg, long arg, char *dst);
void cleaner_perform64(t_cleaner *x, t_object *dsp64, double **ins,
                      long numins, double **outs,long numouts, long n,
                      long flags, void *userparam);
void cleaner_dsp64(t_cleaner *x, t_object *dsp64, short *count, double sr, long n, long flags);
/* The main() function */

void ext_main(void *r)
{	
	cleaner_class = class_new("cleaner~", (method)cleaner_new, (method)dsp_free, sizeof(t_cleaner), 0,0);
	class_addmethod(cleaner_class, (method)cleaner_dsp64, "dsp64", A_CANT, 0);
	class_addmethod(cleaner_class, (method)cleaner_assist, "assist", A_CANT, 0);
	class_dspinit(cleaner_class);
	class_register(CLASS_BOX, cleaner_class);
	post("cleaner~ from \"Designing Audio Objects\" by Eric Lyon");
}

/* The new instance routine */

void *cleaner_new(void)
{
	t_cleaner *x = (t_cleaner *)object_alloc(cleaner_class);
	dsp_setup((t_pxobject *)x, 3);
	outlet_new((t_object *)x, "signal");
	return x;
}

/* The perform routine */

void cleaner_perform64(t_cleaner *x, t_object *dsp64, double **ins,
                     long numins, double **outs,long numouts, long n,
                     long flags, void *userparam)
{
	t_double *input = ins[0];
	t_double *threshmult = ins[1];
	t_double *multiplier = ins[2];
	t_double *output = outs[0];
	
	/* Initialize the maximum amplitude to 0.0 */
	
	t_double maxamp = 0.0;
	t_double threshold; // locally generated threshold
	t_double mult; // hold first value of *multiplier
	int i;
	
	/* 
	 Extract the maximum amplitude from the input vector. We
	 assume here that all amplitude values will be positive. 
	 */
	
	for(i = 0; i < n; i++){
		if(maxamp < input[i]){
			maxamp = input[i];
		}
	}
	
	/* 
	 Calculate the synthesis threshold relative to the 
	 maximum amplitude for the current FFT frame. 
	 */
	
	threshold = *threshmult * maxamp;
	
	/* Get first value in *multiplier vector */
	
	mult = *multiplier;
	
	/* Rescale any amplitude values that fall below the threshold */

	for(i = 0; i < n; i++){
		
		if(input[i] < threshold){
			input[i] *= mult;
		}		
		output[i] = input[i];
	}
}

/* The assist method */

void cleaner_assist(t_cleaner *x, void *b, long msg, long arg, char *dst)
{
	if (msg==ASSIST_INLET) {
		switch (arg) {
			case 0:
				sprintf(dst,"(signal) Input");
				break;
			case 1:
				sprintf(dst,"(signal) Threshold Generating Multiplier");
				break;
			case 2:
				sprintf(dst,"(signal) Noise Multiplier");
				break;
		}
	} else if (msg==ASSIST_OUTLET) {
		sprintf(dst,"(signal) Output");
	}
}

/* The DSP method */

void cleaner_dsp64(t_cleaner *x, t_object *dsp64, short *count, double sr, long n, long flags)
{
    /* call the dsp_add() function, passing the DSP routine to
     be used, which is cleaner_perform() in this case; the number of remaining
     arguments; a pointer to the signal inlet; a pointer to the signal outlet;
     and finally, the signal vector size in samples.
     */
    
    object_method(dsp64, gensym("dsp_add64"), x, cleaner_perform64, 0, NULL);
}
