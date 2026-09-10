/****************************************************
 *   This code is explicated in Chapter 4 of        *
 *   "Designing Audio Objects for Max/MSP and Pd"   *
 *   by Eric Lyon.                                  *   
 ****************************************************/

/* Required header files */

#include "ext.h" 
#include "z_dsp.h" 
#include "ext_obex.h"

/* The class pointer */

static t_class *vdelay_class;

/* The object structure */

typedef struct _vdelay {
	t_pxobject obj; // the Max/MSP object
	float sr; // sampling rate
	float maximum_delay_time; // maximum delay time
	long delay_length; // length of the delay line in samples
	long delay_bytes; // length of delay line in bytes
	float *delay_line; // the delay line itself
	float delay_time; // current delay time
	float feedback; // feedback multiplier
	long write_index; // write point in delay line
	long read_index; // read point in delay line
	short delaytime_connected; // inlet connection status
	short feedback_connected; // inlet connection status
} t_vdelay;

/* Function prototypes */

void *vdelay_new(t_symbol *s, short argc, t_atom *argv);
t_int *vdelay_perform_denormals(t_int *w);
void vdelay_assist(t_vdelay *x, void *b, long msg, long arg, char *dst);
void vdelay_free(t_vdelay *x);
void vdelay_float(t_vdelay *x, double f);
void vdelay_perform64(t_vdelay *x, t_object *dsp64, double **ins,
                      long numins, double **outs,long numouts, long n,
                      long flags, void *userparam);
void vdelay_dsp64(t_vdelay *x, t_object *dsp64, short *count, double sr, long n, long flags);

/* The main() function */

void ext_main(void *r)
{	
	vdelay_class = class_new("vdelay~",(method)vdelay_new,(method)vdelay_free,sizeof(t_vdelay),0,A_GIMME,0);
	class_addmethod(vdelay_class, (method)vdelay_dsp64, "dsp64", A_CANT, 0);
	class_addmethod(vdelay_class, (method)vdelay_assist, "assist", A_CANT, 0);
	class_addmethod(vdelay_class, (method)vdelay_float, "float", A_FLOAT, 0);
	class_dspinit(vdelay_class);
	class_register(CLASS_BOX, vdelay_class);
	post("vdelay~ from \"Designing Audio Objects\" by Eric Lyon");
}

/* The new instance routine */

void *vdelay_new(t_symbol *s, short argc, t_atom *argv)
{
	int i;
	
	/* Initialize parameters */
	
	float delmax = 100.0, deltime = 100.0, feedback = 0.1;
	
	/* Instantiate a new vdelay~ object */
	
	t_vdelay *x = object_alloc(vdelay_class);
	
	/* Create three signal inlets */
	
	dsp_setup(&x->obj, 3);
	
	/* Create one outlet */
	
	outlet_new((t_object *)x, "signal");
	x->obj.z_misc |= Z_NO_INPLACE; //force independent signal vectors
	
	/* Programmatically discover the sampling rate */
	
	x->sr = sys_getsr(); 
	
	/* Read optional user parameters */
	
	atom_arg_getfloat(&delmax, 0, argc, argv);
	atom_arg_getfloat(&deltime, 1, argc, argv);
	atom_arg_getfloat(&feedback, 2, argc, argv);
	
	 /* Set the  maximum delay if necessary */
	
	if(delmax <= 0){
		delmax = 250.0;
	}
	
	/* Convert from ms to secs */
	
	x->maximum_delay_time = delmax * 0.001; 
	
	/* Store initial delay time */
	
	x->delay_time = deltime; 
	
	/* Check that the delay times is legal */
	
	if(x->delay_time > delmax || x->delay_time <= 0.0){
		error("vdelay~: illegal delay time: %f, reset to 1 ms", x->delay_time);
		x->delay_time = 1.0;
	}
	
	/* Allocate memory for the delay line */
	
	x->delay_length = x->sr * x->maximum_delay_time + 1;
	x->delay_bytes = x->delay_length * sizeof(float);
	x->delay_line = (float *) sysmem_newptr(x->delay_bytes);
	if(x->delay_line == NULL){
		error("vdelay~: cannot allocate %d bytes of memory", x->delay_bytes);
		return NULL;
	}
	
	/* 
	 Clear the delayline. In Max/MSP one can alternatively use
	 sysmem_newptrclear() and avoid this step.
	 */
	
	for(i = 0; i < x->delay_length; i++){
		x->delay_line[i] = 0.0;
	}
	
	/* Store the feedback parameter */
	
	x->feedback = feedback;
	
	/* Initialize the write index */
	
	x->write_index = 0;

	/* Return a pointer to the object */
	
	return x;
}

/* The free memory routine */

void vdelay_free(t_vdelay *x)
{
	/* We must call dsp_free() before freeing any dynamic memory 
		allocated for the external. This removes the object from the
		Max/MSP DSP chain. */
	
	dsp_free((t_pxobject *) x);
	
	/* Now we safely free the delay line memory */
	
	sysmem_freeptr(x->delay_line);
}

/* The float method */

void vdelay_float(t_vdelay *x, double f)
{	
	/* Programmatically determine the calling inlet */
	
	int inlet = ((t_pxobject*)x)->z_in;
	
	/* Select response based on which inlet received a float */
	
	switch(inlet){
			
		/* The second inlet is the delay time */
			
		case 1: 
			if(f < 0.0 ||
			   f > x->maximum_delay_time * 1000.0){
				error("vdelay~: illegal delay: %f reset to 1 ms", f);
			} else {
				x->delay_time = f;
			}
			break;
			
		/* The third inlet is the feedback factor */
			
		case 2: 
			x->feedback = f;
			break;
	}
}

/* The perform routine */

void vdelay_perform64(t_vdelay *x, t_object *dsp64, double **ins,
                      long numins, double **outs,long numouts, long n,
                      long flags, void *userparam)
{
	t_double *input = (t_double *) ins[0];
	t_double *delaytime = (t_double *) ins[1];
	t_double *feedback = (t_double *) ins[2];
	t_double *output = (t_double *) outs[0];
	
	/* Dereference components from the object structure */
	
	float sr = x->sr;
	float *delay_line = x->delay_line;
	long read_index = x->read_index;
	long write_index = x->write_index;
	long delay_length = x->delay_length;
	short delaytime_connected = x->delaytime_connected;
	short feedback_connected = x->feedback_connected;
	float delaytime_float = x->delay_time;
	float feedback_float = x->feedback;	
	
	/* Local variables */

	float fraction;
	float fdelay;
	float samp1, samp2;
	long idelay;
	float srms = sr / 1000.0;
	float out_sample;
	
	/* Perform the DSP loop */
	
	while(n--){
		
		/* Process the delay time as either signal or float input */
		
		if(delaytime_connected){
			fdelay = *delaytime++ * srms;
		}
		else { 
			fdelay = delaytime_float * srms; 
		}
		while(fdelay < 0){
			fdelay += delay_length;
		}
		
		/* Truncate the delay time */
		
		idelay = trunc(fdelay);
		fraction = fdelay - idelay;
		
		/* Calculate the read index and keep it within legal range */
		
		read_index = write_index - idelay;
		while(read_index < 0){
			read_index += delay_length;
		}
		
		/* Do the lookup with linear interpolation */
		
		samp1 = delay_line[read_index];
		samp2 = delay_line[(read_index + 1) % delay_length];
		out_sample = samp1 + fraction * (samp2-samp1);
		
		/* Process the feedback as either signal or float input */
		
		if(feedback_connected) {
			delay_line[write_index++] = *input++ + out_sample * *feedback++;
		}
		else { 
			delay_line[write_index++] = *input++ + out_sample * 
			feedback_float;
		}		
		
		/* Output the delayed sample */
		
		*output++ = out_sample;
		
		/* Keep the write index within legal range */
		
		if(write_index >= delay_length){
			write_index -= delay_length;
		}
	}
	
	/* Copy the incremented write index back to its object component */
	
	x->write_index = write_index;
}

/* The assist method */

void vdelay_assist(t_vdelay *x, void *b, long msg, long arg, char *dst)
{
	if (msg == ASSIST_INLET) {
		switch (arg) {
			case 0: sprintf(dst,"(signal) Input"); break;
			case 1: sprintf(dst,"(signal) Delay Time"); break;
			case 2: sprintf(dst,"(signal) Feedback"); break;
		}
	} else if (msg == ASSIST_OUTLET) {
		sprintf(dst,"(signal) Output");
	}
}

/* The DSP method */

void vdelay_dsp64(t_vdelay *x, t_object *dsp64, short *count, double sr, long n, long flags)
{
	int i;
	
	/* Store inlet connection states */
	
	x->delaytime_connected = count[1];
	x->feedback_connected = count[2];
	
	/* Reset delayline if the sampling rate has changed */
	
	if(x->sr != sr){
		x->sr = sr;
		x->delay_length = x->sr * x->maximum_delay_time + 1;
		x->delay_bytes = x->delay_length * sizeof(float);
		
		/* Resize memory - only safe if memory has previously been allocated */
		
		x->delay_line = (float *) sysmem_resizeptr((void *)x->delay_line,x->delay_bytes);
		
		/* Test that sufficient memory was returned */
		
		if(x->delay_line == NULL){
			error("vdelay~: cannot realloc %d bytes of memory", x->delay_bytes);
			return;
		}
		
		/* Clear the delay line */
		
		for(i = 0; i < x->delay_length; i++){ 
			x->delay_line[i] = 0.0;
		}
		
		/* Reset the write point */
		
		x->write_index = 0; 
	}
	
	/* Add vdelay~ to the Max/MSP DSP chain */
	
	object_method(dsp64, gensym("dsp_add64"),x,vdelay_perform64,0,NULL);
}