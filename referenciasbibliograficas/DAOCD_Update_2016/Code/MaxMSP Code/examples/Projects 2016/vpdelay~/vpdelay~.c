/****************************************************
 *   This code is explicated in Chapter 9 of        *
 *   "Designing Audio Objects for Max/MSP and Pd"   *
 *   by Eric Lyon.                                  *   
 ****************************************************/

/* Required Max/MSP header files */

#include "ext.h" 
#include "z_dsp.h" 
#include "ext_obex.h"

/* The object structure */

typedef struct _vpdelay {
	t_pxobject obj;
	float sr; // sampling rate
	float maximum_delay_time; // maximum delay time
	long delay_length; // length of the delay line in samples
	long delay_bytes; // length of delay line in bytes
	float *delay_line; // the delay line itself
	float *read_ptr; // read pointer into delay line
	float *write_ptr; // write pointer into delay line
	float delay_time; // current delay time
	float feedback; // feedback multiplier
	short delaytime_connected; // inlet connection status
	short feedback_connected; // inlet connection status
	float fdelay; // the fractional delay time
	long idelay; // the integer delay time
	float fraction; // the fractional difference between the fractional and integer delay times
	float srms; //sampling rate as milliseconds
} t_vpdelay;

/* The class declaration */

static t_class *vpdelay_class;

/* Function prototypes */

void *vpdelay_new(t_symbol *s, short argc, t_atom *argv);
void vpdelay_assist(t_vpdelay *x, void *b, long msg, long arg, char *dst);
void vpdelay_free(t_vpdelay *x);
void vpdelay_float(t_vpdelay *x, double f);
t_int *vpdelay_perform(t_int *w);
void vpdelay_perform64(t_vpdelay *x, t_object *dsp64, double **ins,
                      long numins, double **outs,long numouts, long n,
                      long flags, void *userparam);
void vpdelay_dsp64(t_vpdelay *x, t_object *dsp64, short *count, double sr, long n, long flags);



/* The main() function */

void ext_main(void *r)
{	
	vpdelay_class = class_new("vpdelay~",(method)vpdelay_new,(method)vpdelay_free,sizeof(t_vpdelay),0,A_GIMME,0);
	class_addmethod(vpdelay_class, (method)vpdelay_dsp64, "dsp64", A_CANT, 0);
	class_addmethod(vpdelay_class, (method)vpdelay_assist, "assist", A_CANT, 0);
	class_addmethod(vpdelay_class, (method)vpdelay_float, "float", A_FLOAT, 0);
	class_dspinit(vpdelay_class);
	class_register(CLASS_BOX, vpdelay_class);
	post("vpdelay~ from \"Designing Audio Objects\" by Eric Lyon");
}

/* The new instance routine */

void *vpdelay_new(t_symbol *s, short argc, t_atom *argv)
{
	/* Initialize parameters */
	
	float delmax = 100.0, deltime = 100.0, feedback = 0.1;
	
	/* Basic object setup */
	
	t_vpdelay *x = object_alloc(vpdelay_class);
	dsp_setup(&x->obj, 3);
	outlet_new((t_object *)x, "signal");
	
	/* Read user parameters */
	
	atom_arg_getfloat(&delmax, 0, argc, argv);
	atom_arg_getfloat(&deltime, 1, argc, argv);
	atom_arg_getfloat(&feedback, 2, argc, argv);
	
	if(delmax <= 0){
		delmax = 250.0; 
	}
	x->maximum_delay_time = delmax * 0.001; 
	
	x->delay_time = deltime; 
	if(x->delay_time > delmax || x->delay_time <= 0.0){
		error("illegal delay time: %f, reset to 1 ms", x->delay_time);
		x->delay_time = 1.0;
	}
	
	/* Force memory initialization in the DSP method by setting the sampling rate to zero */
	
	x->sr = 0.0; 
	x->feedback = feedback;
	return x;
}

/* The free memory routine */

void vpdelay_free(t_vpdelay *x)
{
	dsp_free((t_pxobject *) x);
	sysmem_freeptr(x->delay_line);
}

/* The assist method */

void vpdelay_assist(t_vpdelay *x, void *b, long msg, long arg, char *dst)
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

/* The float method */

void vpdelay_float(t_vpdelay *x, double f)
{
	int inlet = ((t_pxobject*)x)->z_in;
	switch(inlet){
			
			/* If the float came into the second inlet it is delay time */
			
		case 1: 
			if(f < 0.0 || f > x->maximum_delay_time * 1000.0)
			{
				error("vpdelay~: illegal delay: %f reset to 1 ms", f);
			} 
			else {
				x->delay_time = f * 0.001; // convert to seconds
				x->fdelay = x->delay_time * x->srms; // convert to samples
				while(x->fdelay < 0){
					x->fdelay += x->delay_length;
				}
				x->idelay = trunc(x->fdelay);
				x->fraction = x->fdelay - x->idelay;
			}
			break;

		/* If the float came into the third inlet it is feedback factor */
			
		case 2: x->feedback = f; break;
	}
}

/* The revised perform routine */

void vpdelay_perform64(t_vpdelay *x, t_object *dsp64, double **ins,
                       long numins, double **outs,long numouts, long n,
                       long flags, void *userparam)
{
	t_double *input = (t_double *) ins[0];
	t_double *delaytime = (t_double *) ins[1];
	t_double *feedback = (t_double *) ins[2];
	t_double *output = (t_double *) outs[0];
	
	float sr = x->sr;
	float *delay_line = x->delay_line;
	float  *read_ptr  = x->read_ptr;
	float  *write_ptr = x->write_ptr;
	long delay_length = x->delay_length;
	float *endmem = delay_line + delay_length;
	short delaytime_connected = x->delaytime_connected;
	short feedback_connected = x->feedback_connected;
	float delaytime_float = x->delay_time;
	float feedback_float = x->feedback;	
	float fraction;
	float fdelay;
	float samp1, samp2;
	long idelay;
	float srms = sr / 1000.0;
	float out_sample, feedback_sample;
	
	/* 
	 Roll out a different DSP loop depending on the
	 connection states for feedback and delaytime inlets.
	 */
	
	if(delaytime_connected && feedback_connected){
		while(n--){
			fdelay = *delaytime++ * srms;
			while(fdelay > delay_length){
				fdelay -= delay_length;
			}
			while(fdelay < 0){
				fdelay += delay_length;
			}
			idelay = (int)fdelay;
			fraction = fdelay - idelay;
			read_ptr = write_ptr - idelay;
			while(read_ptr < delay_line){
				read_ptr += delay_length;
			}
			samp1 = *read_ptr++;
			if(read_ptr == endmem){
				read_ptr = delay_line;
			}
			samp2 = *read_ptr;
			out_sample = samp1 + fraction * (samp2-samp1);
			feedback_sample = out_sample * *feedback++;	
			if(fabs(feedback_sample)  < 0.0000001){
				feedback_sample = 0.0;
			}
			*write_ptr++ = *input++ + feedback_sample;
			*output++ = out_sample;
			if(write_ptr == endmem){
				write_ptr = delay_line;
			}
		}
	} 
	else if(delaytime_connected){
		while(n--){
			fdelay = *delaytime++ * srms;
			if(fdelay < 0){
				fdelay = 0.;
			}
			else if(fdelay >= delay_length) {
				fdelay = delay_length - 1;
			}
			idelay = trunc(fdelay);
			fraction = fdelay - idelay;
			read_ptr = write_ptr - idelay;
			while(read_ptr < delay_line){
				read_ptr += delay_length;
			}
			samp1 = *read_ptr++;
			if(read_ptr == endmem){
				read_ptr = delay_line;
			}
			samp2 = *read_ptr;
			out_sample = samp1 + fraction * (samp2-samp1);
			feedback_sample = out_sample * feedback_float;	
			if(fabs(feedback_sample)  < 0.0000001){
				feedback_sample = 0.0;
			}
			*write_ptr++ = *input++ + feedback_sample;
			*output++ = out_sample;
			if(write_ptr == endmem){
				write_ptr = delay_line;
			}
		}
	}
	else if(feedback_connected){
		fdelay = delaytime_float * srms;
		while(fdelay > delay_length){
			fdelay -= delay_length;
		}
		while(fdelay < 0){
			fdelay += delay_length;
		}
		idelay = trunc(fdelay);
		fraction = fdelay - idelay;
		while(n--){
			
			read_ptr = write_ptr - idelay;
			while(read_ptr < delay_line){
				read_ptr += delay_length;
			}
			samp1 = *read_ptr++;
			if(read_ptr == endmem){
				read_ptr = delay_line;
			}
			samp2 = *read_ptr;
			out_sample = samp1 + fraction * (samp2-samp1);
			feedback_sample = out_sample * *feedback++;	
			if(fabs(feedback_sample)  < 0.0000001){
				feedback_sample = 0.0;
			}
			*write_ptr++ = *input++ + feedback_sample;
			*output++ = out_sample;
			if(write_ptr == endmem){
				write_ptr = delay_line;
			}
		}
	}
	else {
		fdelay = delaytime_float * srms;
		while(fdelay > delay_length){
			fdelay -= delay_length;
		}
		while(fdelay < 0){
			fdelay += delay_length;
		}
		idelay = trunc(fdelay);
		fraction = fdelay - idelay;
		while(n--){
			
			read_ptr = write_ptr - idelay;
			while(read_ptr < delay_line){
				read_ptr += delay_length;
			}
			samp1 = *read_ptr++;
			if(read_ptr == endmem){
				read_ptr = delay_line;
			}
			samp2 = *read_ptr;
			out_sample = samp1 + fraction * (samp2-samp1);
			feedback_sample = out_sample * feedback_float;	
			if(fabs(feedback_sample) < 0.0000001){
				feedback_sample = 0.0;
			}
			*write_ptr++ = *input++ + feedback_sample;
			*output++ = out_sample;
			if(write_ptr == endmem){
				write_ptr = delay_line;
			}
		}
	}
	x->write_ptr = write_ptr;
}

void vpdelay_dsp64(t_vpdelay *x, t_object *dsp64, short *count, double sr, long n, long flags)
{
	/* Exit if the sampling rate is zero */
	
	if(!sr){
		return;
	}
	
	/* Store the states of signal inlet connections */
	
	x->delaytime_connected = count[1];
	x->feedback_connected = count[2];
	
	/* Reset the delayline if the sampling rate has changed */
	
	if(x->sr != sr){
		x->sr = sr;
		x->delay_length = x->sr * x->maximum_delay_time + 1;
		x->delay_bytes = x->delay_length * sizeof(float);
		
		/* 
		 If the delayline pointer is NULL, allocate a new memory block. Note the
		 use of sysmem_newptrclear() so that the memory is returned with all of
		 its values set to zero. 
		 */
		
		if(x->delay_line == NULL){
			x->delay_line = (float *) sysmem_newptrclear(x->delay_bytes);
		}
		
		/* 
		 Otherwise, resize the existing memory block. Note the use of sysmem_resizeptrclear()
		 to set all of the returned memory locations to zero. 
		 */
		
		else {
			x->delay_line = (float *) 
			sysmem_resizeptrclear((void *)x->delay_line,
								  x->delay_bytes);
		}
		if(x->delay_line == NULL){
			error("vpdelay~: cannot realloc %d bytes of memory", x->delay_bytes);
			return;
		}
		
		/* Assign the write pointer to the start of the delayline */
		
		x->write_ptr = x->delay_line; 
	}
	object_method(dsp64, gensym("dsp_add64"),x,vpdelay_perform64,0,NULL);
}
