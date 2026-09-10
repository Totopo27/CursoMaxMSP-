/****************************************************
 *   This code is explicated in Chapter 11 of       *
 *   "Designing Audio Objects for Max/MSP and Pd"   *
 *   by Eric Lyon.                                  *   
 ****************************************************/

/* Since it is your job to find and fix problems in the code, this file is uncommented */

#include "ext.h"
#include "z_dsp.h"
#include "ext_obex.h"

void *ramp_class;

typedef struct _ramp
{
	t_pxobject x_obj;
	long counter;
	long maximum;
} t_ramp;

void *ramp_new(void);
t_int *ramp_perform(t_int *w);
void ramp_dsp(t_ramp *x, t_signal **sp, short *count);

int C74_EXPORT main()
{
	ramp_class = class_new("ramp~", (method)ramp_new, 
						   (method)dsp_free, sizeof(t_ramp), 0,0);
	t_class *c;
	class_addmethod(c, (method)ramp_dsp, "dsp", A_CANT, 0);
	class_dspinit(c);
	class_register(CLASS_BOX, c);
	post("ramp~: from \"Designing Audio Objects\" by Eric Lyon");
	return 0;
}

void *ramp_new(void)
{
    t_ramp *x = (t_ramp *)object_alloc(ramp_class);

    dsp_setup((t_pxobject *)x,2);	
    outlet_new((t_pxobject *)x, "signal");
	outlet_new((t_pxobject *)x, "signal");
	x->maximum = 44100;
	x->counter = 0;
    return NULL;
}

t_int *ramp_perform(t_int *w)
{
	t_ramp *x = (t_ramp *) (w[1]);
	float *trigger = (t_float *)(w[2]);
	float *maxcount = (t_float *)(w[3]);
	float *out = (t_float *)(w[4]);
	int n = w[5];
	long maximum = x->maximum;
	long counter = x->counter;
	float invmax; 
	for(i = 0; i < n; i++){
		if(trigger[i]){
			counter = 0;
			maximum = maxcount[i];
		}
		out[i] = counter * invmax;
		if(counter < maximum){
			counter++;
		}
	}
	return w + 7;
}

void ramp_dsp(t_ramp *x, t_signal **sp, short *count)
{
	dsp_add(ramp_perform, 7, x, sp[0]->s_vec, sp[1]->s_vec, sp[0]->s_n);
}

