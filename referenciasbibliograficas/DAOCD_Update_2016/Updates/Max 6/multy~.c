/****************************************************
 *   This multy~ demonstrates Max 6 coding. From    *
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
void multy_dsp(t_multy *x, t_signal **sp, short *count);
void multy_dsp64(t_multy *x, t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags);
t_int *multy_perform(t_int *w);
void multy_perform64(t_multy *x, t_object *dsp64, double **ins, 
    long numins, double **outs, long numouts, 
    long sampleframes, long flags, void *userparam);
void multy_assist(t_multy *x, void *b, long msg, long arg, char *dst);

/* The main() function */

int main(void)
{
	/* Initialize the class */
	 
	multy_class = class_new("multy~", (method)multy_new, (method)dsp_free, sizeof(t_multy), 0,0);
	
	/* Bind the old DSP method, which is called when the DACs are turned on in Max 5 */
	
	class_addmethod(multy_class, (method)multy_dsp, "dsp", A_CANT, 0);
    
    /* Bind the 64-bit DSP method, which is called when the DACs are turned on in Max 6 */
    
    class_addmethod(multy_class, (method)multy_dsp64, "dsp64", A_CANT, 0);
	
	/* Bind the assist method, which is called on mouse-overs to inlets and outlets */
	
	class_addmethod(multy_class, (method)multy_assist, "assist", A_CANT, 0);
	
	/* Add standard Max/MSP methods to your class */
	
	class_dspinit(multy_class);
	
	/* Register the class with Max */
	
	class_register(CLASS_BOX, multy_class);
	
	/* Print authorship message to Max window */
	
	post("multy~ from \"Designing Audio Objects\" by Eric Lyon");
	
	/* Return with no error */
	
	return 0;
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

t_int *multy_perform(t_int *w)
{
	
	/* Copy the object pointer (though unnecessary in this routine) */
	
	t_multy *x = (t_multy *) (w[1]); 
	
	/* Copy signal vector pointers */
	
	t_float *in1 = (t_float *) (w[2]);
	t_float *in2 = (t_float *) (w[3]);
	t_float *out = (t_float *) (w[4]);
	
	/* Copy the signal vector size */
	
	t_int n = w[5];
	
	/* Perform the DSP loop */
	
	while(n--){
		*out++ = *in1++ * *in2++;
	}
	
	/* Return the next address in the DSP chain */
	
	return w + 6;
}

/* The 64-bit perform routine */

void multy_perform64(t_multy *x, t_object *dsp64, double **ins, 
    long numins, double **outs, long numouts, 
    long sampleframes, long flags, void *userparam)
{
	/* Copy signal vector pointers */
	
	t_double *in1 = ins[0];
	t_double *in2 = ins[1];
	t_double *out = outs[0];
	
	/* Copy the signal vector size */
	
	int n = sampleframes;
	
	/* Perform the DSP loop */
	
	while(n--){
		*out++ = *in1++ * *in2++;
	}
}

/* The assist method */

void multy_assist(t_multy *x, void *b, long msg, long arg, char *dst)
{
	/* Document inlet functions */ 
	
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

/* The dsp method */

void multy_dsp(t_multy *x, t_signal **sp, short *count)
{
	/* Attach the object to the DSP chain, passing the DSP routine multy_perform(), 
	 inlet and outlet pointers, and the signal vector size */
	
    post("Executing the 32-bit perform routine");
	dsp_add(multy_perform, 5, x, sp[0]->s_vec, sp[1]->s_vec,sp[2]->s_vec, sp[0]->s_n);
}

/* The dsp64 method */

void multy_dsp64(t_multy *x, t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)
{
	post("Executing the 64-bit perform routine");
	dsp_add64(dsp64, (t_object*)x, (t_perfroutine64)multy_perform64, 0, NULL);
}