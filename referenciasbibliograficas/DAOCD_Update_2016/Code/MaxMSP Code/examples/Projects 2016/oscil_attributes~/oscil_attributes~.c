/****************************************************
 *   This code is explicated in Chapter 10 of       *
 *   "Designing Audio Objects for Max/MSP and Pd"   *
 *   by Eric Lyon.                                  *   
 ****************************************************/

/* Required Max/MSP header files */

#include "ext.h"
#include "z_dsp.h"
#include "ext_obex.h"

/* Define constants and defaults */

#define OSCIL_DEFAULT_TABLESIZE 8192
#define OSCIL_DEFAULT_HARMS 10
#define OSCIL_MAX_HARMS 1024
#define OSCIL_DEFAULT_FREQUENCY 440.0
#define OSCIL_DEFAULT_WAVEFORM "Sine"
#define OSCIL_MAX_TABLESIZE 1048576
#define OSCIL_NOFADE 0
#define OSCIL_LINEAR 1
#define OSCIL_POWER 2

/* The object structure */

typedef struct _oscil
{
	t_pxobject obj; // the Max/MSP object
	long table_length; // length of wavetable
	float *wavetable; // wavetable
	float *amplitudes; // list of amplitudes for each harmonic
	t_symbol *waveform; // the waveform used currently
	long harmonic_count; // number of harmonics
	float phase; // phase
	float si; // sampling increment
	float si_factor; // factor for generating sampling increment
	long bl_harms; // number of harmonics for band limited waveforms
	float piotwo; // pi over two
	float twopi; // two pi
	float sr; // sampling rate
	long wavetable_bytes;// number of bytes stored in wavetable
	long amplitude_bytes;// number of bytes stored in amplitude table
	float xfade_duration;
	int xfade_samples;
	int xfade_countdown;
	short firsttime; // initialization flag for the crossfade
	float *old_wavetable;// older wave table
	short dirty;// wavetable is dirty
	t_symbol *a_waveform; // waveform attribute
	t_float *a_amplitudes; // user spec harmonic weightings
	float a_frequency; // frequency attribute
	long a_xfadetype; // user spec fade type	
} t_oscil;

/* The class declaration */

static t_class *oscil_class;

/* Function prototypes */

void *oscil_new(t_symbol *s, short argc, t_atom *argv);
void oscil_build_waveform( t_oscil *x );
void oscil_assist(t_oscil *x, void *b, long msg, long arg, char *dst);
void oscil_float(t_oscil *x, double f);
void oscil_sine(t_oscil *x);
void oscil_triangle(t_oscil *x);
void oscil_sawtooth(t_oscil *x);
void oscil_square(t_oscil *x);
void oscil_pulse(t_oscil *x);
void oscil_additive(t_oscil *x);
void oscil_list (t_oscil *x, t_symbol *msg, short argc, t_atom *argv);
void oscil_fadetime (t_oscil *x, double fade_ms);
void oscil_free(t_oscil *x);
t_max_err a_frequency_set(t_oscil *x, void *attr, long ac, t_atom *av);
t_max_err a_amplitudes_set(t_oscil *x, void *attr, long ac, t_atom *av);
t_max_err a_amplitudes_get(t_oscil *x, void *attr, long *ac, t_atom **av);
t_max_err a_waveform_set(t_oscil *x, void *attr, long ac, t_atom *av);
void oscil_perform64(t_oscil *x, t_object *dsp64, double **ins,
                      long numins, double **outs,long numouts, long n,
                      long flags, void *userparam);
void oscil_perform264(t_oscil *x, t_object *dsp64, double **ins,
                      long numins, double **outs,long numouts, long n,
                      long flags, void *userparam);
void oscil_dsp64(t_oscil *x, t_object *dsp64, short *count, double sr, long n, long flags);


/* The main() function */

void ext_main(void *r)
{
	/* 
	 Declare a shorthand local pointer c and assign
	 oscil_class to c just after initializing the class.
	 */
	
	/* Use the symbol "oscil_attributes" to identify this variant of oscil~ */
	
	t_class *c = oscil_class = class_new("oscil_attributes~", (method)oscil_new, 
        (method)oscil_free, sizeof(t_oscil), 0,A_GIMME,0);
	class_addmethod(c, (method)oscil_dsp64, "dsp64", A_CANT, 0);
	class_addmethod(c, (method)oscil_assist, "assist", A_CANT, 0);
	class_addmethod(c, (method)oscil_float, "float", A_FLOAT, 0);
	class_addmethod(c,(method)oscil_sine, "sine", 0);
	class_addmethod(c,(method)oscil_triangle, "triangle", 0);
	class_addmethod(c,(method)oscil_square, "square", 0);
	class_addmethod(c,(method)oscil_sawtooth, "sawtooth", 0);
	class_addmethod(c,(method)oscil_pulse, "pulse", 0);
	class_addmethod(c,(method)oscil_list, "list", A_GIMME, 0);
	class_addmethod(c,(method)oscil_fadetime, "fadetime", A_FLOAT, 0);
	class_dspinit(c);
	
	/* Define the frequency attribute */
	
	CLASS_ATTR_FLOAT(c, "frequency", 0, t_oscil, a_frequency);
	CLASS_ATTR_ACCESSORS(c, "frequency", NULL, a_frequency_set);
	CLASS_ATTR_LABEL(c, "frequency", 0, "Frequency");
	
	/* Define the waveform attribute */
	
	CLASS_ATTR_SYM(c, "waveform", 0, t_oscil, a_waveform);
	CLASS_ATTR_LABEL(c, "waveform", 0, "Oscillator Waveform");
	CLASS_ATTR_ENUM(c, "waveform", 0, "Sine Triangle Square Sawtooth Pulse Additive");
	CLASS_ATTR_ACCESSORS(c, "waveform",  NULL, a_waveform_set);
	
	/* Define the amplitudes attribute */
	
	CLASS_ATTR_FLOAT_ARRAY(c,"amplitudes",0,t_oscil,a_amplitudes, OSCIL_MAX_HARMS);
	CLASS_ATTR_ACCESSORS(c, "amplitudes", a_amplitudes_get, a_amplitudes_set);
	CLASS_ATTR_LABEL(c, "amplitudes", 0, "Harmonic Weightings");

	/* Define the xfade attribute */
	
	CLASS_ATTR_LONG(c, "xfade", 0, t_oscil, a_xfadetype);
	CLASS_ATTR_LABEL(c, "xfade", 0, "Crossfade");
	CLASS_ATTR_ENUMINDEX(c, "xfade", 0, "\"No Fade\" \"Linear Fade\" \"Equal Power Fade\"");

	/* Set the display order of the attributes in the Max inspector */
	
	CLASS_ATTR_ORDER(c, "frequency",    0, "1");
	CLASS_ATTR_ORDER(c, "waveform",  0, "2");
	CLASS_ATTR_ORDER(c, "xfade", 0, "3");
	CLASS_ATTR_ORDER(c, "amplitudes", 0, "4");

	class_register(CLASS_BOX, c);
	post("oscil_attributes~ from \"Designing Audio Objects\" by Eric Lyon");
}

/* The new instance routine */

void *oscil_new(t_symbol *s, short argc, t_atom *argv)
{
		
	t_oscil *x = (t_oscil *)object_alloc(oscil_class);
	
	/* Set up one inlet and one outlet */
	
	dsp_setup((t_pxobject *)x,1);
	outlet_new((t_pxobject *)x, "signal");
	
	/* Set default parameters  */

	x->firsttime = 1;
	
	x->table_length = OSCIL_DEFAULT_TABLESIZE;
	x->bl_harms = OSCIL_DEFAULT_HARMS;
	
	/* Set attribute defaults */
	
	x->a_frequency = OSCIL_DEFAULT_FREQUENCY;
	x->a_waveform = gensym(OSCIL_DEFAULT_WAVEFORM);
		
	/* Generate 2π and π/2 */
	
	x->twopi = 8.0 * atan(1.0);
	x->piotwo = 2. * atan(1.0);
	
	x->wavetable_bytes = x->table_length * sizeof(float);
	x->wavetable = (float *) sysmem_newptr(x->wavetable_bytes);
	x->amplitude_bytes = OSCIL_MAX_HARMS * sizeof(t_float);
	x->amplitudes = (t_float *)sysmem_newptr(x->amplitude_bytes);
	x->a_amplitudes = (t_float *)sysmem_newptr(x->amplitude_bytes);
	x->dirty = 0;
	x->old_wavetable = (float *) sysmem_newptr(x->wavetable_bytes);
	
	/*
	 It is essential to initialize the phase variable. 
	 Otherwise the phase could be some random value outside 0 - (table_length - 1). 
	 The first lookup from the table would then crash the program.
	 */
	
	x->phase = 0;
	
	/* 
	 Programmatically determine the sampling rate, but note that we will need
	 to recheck this value in the DSP method. 
	 */
	
	x->sr = sys_getsr(); 

	/* 
	 Note that it is dangerous to divide by the x->sr below, which could in 
	 certain cases be zero. This code could be improved by first checking the
	 value of x->sr. 
	 */
	
	x->si_factor = (float) x->table_length / x->sr;
	x->si = x->a_frequency * x->si_factor;
	

	/* Initialize fade parameters */
	
	x->xfade_countdown = 0;
	x->xfade_duration = 1000.;
	x->xfade_samples = x->xfade_duration * x->sr / 1000.0;
	x->a_xfadetype = OSCIL_LINEAR;
	
	/* Read in attribute values */
	
	attr_args_process(x, argc, argv);

	
	/* Check for bad frequency values */
	
	if(fabs(x->a_frequency) > 1000000){
		x->a_frequency = OSCIL_DEFAULT_FREQUENCY;
		object_post((t_object *)x, "frequency reset to 440");
	} 
	
	/* Set the sampling increment based on the frequency attribute */
	
	x->si_factor = (float) x->table_length / x->sr;
	x->si = x->a_frequency * x->si_factor;
	
	/* Generate a waveform based on the attribute */
	
	if (x->a_waveform == gensym("Sine")) {
		oscil_sine(x);
	} 
	else if (x->a_waveform == gensym("Triangle")) {
		oscil_triangle(x);
	} 
	else if (x->a_waveform == gensym("Square")) {
		oscil_square(x);
	} 
	else if (x->a_waveform == gensym("Sawtooth")) {
		oscil_sawtooth(x);
	} 
	else if (x->a_waveform == gensym("Pulse")) {
		oscil_pulse(x);
	} 
	else if (x->a_waveform == gensym("Additive")) {
		oscil_additive(x);
	} 
	else {
		error("%s is not a legal waveform - using sine wave instead", x->a_waveform->s_name);
		oscil_sine(x);
	}

	/* Turn off firsttime flag now that the waveform has been initialized */

	x->firsttime = 0;
	
	/* Return a pointer to the object */
	
	return x;
}

/* The frequency setter method */

t_max_err a_frequency_set(t_oscil *x, void *attr, long ac, t_atom *av) 
{
	/* This function is called when the user sets the frequency attribute */
	
	if (ac&&av) {
		
		/* Read the new attribute into the object component a_frequency */
		
		x->a_frequency = atom_getfloat(av);
		
		/* Set the sampling increment based on the new frequency */
		
		x->si = x->a_frequency * x->si_factor;
	} 
	return MAX_ERR_NONE;
}

/* The waveform setter method */

t_max_err a_waveform_set(t_oscil *x, void *attr, long ac, t_atom *av) 
{
	/* 
	 Regenerate the wavetable whenever the user sets the a_waveform attribute. 
	 This code could be improved by keeping track of the last waveform and then
	 only regenerating the waveform if the new waveform is different. An illegal
	 waveform should be ignored if a valid wavetable has already been generated.
	 */
	
	if (av) {
		x->a_waveform = atom_getsym(av);
		if (x->a_waveform == gensym("Sine")) {
			oscil_sine(x);
		} 
		else if (x->a_waveform == gensym("Triangle")) {
			oscil_triangle(x);
		} 
		else if (x->a_waveform == gensym("Square")) {
			oscil_square(x);
		} 
		else if (x->a_waveform == gensym("Sawtooth")) {
			oscil_sawtooth(x);
		} 
		else if (x->a_waveform == gensym("Pulse")) {
			oscil_pulse(x);
		} 
		else if(x->a_waveform == gensym("Additive")){
			oscil_additive(x);
		}
		else { 
			error("%s is not a legal waveform - using sine wave instead", x->waveform->s_name);
			oscil_sine(x);
		}	
	}
	return MAX_ERR_NONE;
}

/* The amplitude setter method */

t_max_err a_amplitudes_set(t_oscil *x, void *attr, long ac, t_atom *av) 
{
	int i;
	t_atom *rv = NULL;
	
	/* Read all harmonic weightings into the attribute array a_amplitudes[] */
	
	if (ac&&av) {
		for(i = 0; i < OSCIL_MAX_HARMS; i++){
			x->a_amplitudes[i] = atom_getfloatarg(i, ac, av);
		}
	}
	
	/* Set the waveform attribute, which will build the waveform in turn. */
	
	object_method_sym((t_object *)x, gensym("waveform"), gensym("Additive"), rv);
	return MAX_ERR_NONE;
}

/* The amplitudes getter method */

t_max_err a_amplitudes_get(t_oscil *x, void *attr, long *ac, t_atom **av) 
{
	int i;
	
	if (!((*ac)&&(*av))) {
		*ac = OSCIL_MAX_HARMS;
		if (!(*av = (t_atom *)sysmem_newptr(sizeof(t_atom) * (*ac)))) {
			*ac = 0;
			return MAX_ERR_OUT_OF_MEM;
		}
	}
	
	/* Copy the attribute array a_amplitudes[] to the atom vector *av */
	
	for(i = 0; i < OSCIL_MAX_HARMS; i++){
		atom_setfloat(*av + i,x->a_amplitudes[i]);
	}
	return MAX_ERR_NONE;
}

/* The sine method */

void oscil_sine(t_oscil *x)
{
	x->amplitudes[0] = 0.0;
	x->amplitudes[1] = 1.0;
	x->harmonic_count = 1;
	oscil_build_waveform(x);
}

/* The additive method */

void oscil_additive(t_oscil *x)
{
	int i;
	x->harmonic_count = 0;
	for(i = 0; i < OSCIL_MAX_HARMS; i++){
		x->amplitudes[i] = x->a_amplitudes[i];
		if(x->a_amplitudes[i]){
			x->harmonic_count = i;
		}
	} 
	oscil_build_waveform(x);
}

/* The triangle method */

void oscil_triangle(t_oscil *x)
{
	int i;
	float sign = 1.0;
	x-> amplitudes [0] = 0.0; // DC
	x->harmonic_count = x->bl_harms;
	for( i = 1 ; i < x->bl_harms; i += 2 ){
		x->amplitudes[i] = sign * 1.0/((float)i * (float)i);
		x->amplitudes[i + 1] = 0.0;
		sign *= -1;
	}
	oscil_build_waveform(x);
}

/* The sawtooth method */

void oscil_sawtooth(t_oscil *x)
{
	int i;
	float sign = 1.0;
	
	x->amplitudes[0] = 0.0;
	x->harmonic_count = x->bl_harms;
	for(i = 1 ; i < x->bl_harms; i++){
		x->amplitudes[i] = sign * 1.0/(float)i;
		sign *= -1. ;
	}
	oscil_build_waveform(x);
}

/* The square method */

void oscil_square(t_oscil *x)
{
	int i;
	x-> amplitudes [0] = 0.0;
	x->harmonic_count = x->bl_harms;
	for(i = 1 ; i < x->bl_harms; i += 2){
		x->amplitudes[i] = 1.0/(float)i;
		x->amplitudes[i + 1] = 0.0;
	}
	oscil_build_waveform(x);
}

/* The pulse method */

void oscil_pulse(t_oscil *x)
{
	int i;
	x->amplitudes[0] = 0.0;
	x->harmonic_count = x->bl_harms;
	for(i = 1 ; i < x->bl_harms; i++){
		x->amplitudes[i] = 1.0;
	}
	oscil_build_waveform(x);
}

/* The list method (now obsolete) */

void oscil_list (t_oscil *x, t_symbol *msg, short argc, t_atom *argv)
{
	short i;
	int harmonic_count = 0;
	float *amplitudes = x->amplitudes;
	for (i=0; i < argc; i++) {
		amplitudes[harmonic_count++] = atom_getfloat(argv + i);
	}  
	x->harmonic_count = harmonic_count;
	oscil_build_waveform(x);
}

/* The utility function to build the waveform */

void oscil_build_waveform(t_oscil *x) {
	float rescale;
	int i, j;
	float max;
	float *wavetable = x->wavetable;
	float *amplitudes = x->amplitudes;
	int partial_count = x->harmonic_count + 1;
	int table_length = x->table_length;
	float twopi = x->twopi;
	float *old_wavetable = x->old_wavetable;
	
	for(i = 0; i < table_length ; i++){
		old_wavetable[i] = wavetable[i];
	}
	x->dirty = 1;
	if( x->a_xfadetype  && ! x->firsttime){
		x->xfade_countdown = x->xfade_samples; 
	}	
	
	if(partial_count < 1){
		error("no harmonics specified, waveform not created.");
		return;
	}
		
	max = 0.0;
	for(i = 0; i < partial_count; i++){
		max += fabs(amplitudes[i]);
	}
	if(! max){
		error("all zero function specified, waveform not created.");
		return; // game over
	}
	
	for(i = 0; i < table_length; i++){
		wavetable[i] = amplitudes[0];
	}
		
	for(i = 1 ; i < partial_count; i++){
		if(amplitudes[i]){
			for(j = 0; j < table_length; j++){
				wavetable[j] += amplitudes[i] * sin(twopi * ((float)i * ((float)j/(float)table_length))) ;
			}
		}
	}
		
	max = 0.0;
	for(i = 0; i < table_length / 2; i++){
		if(max < fabs(wavetable[i])){
			max = fabs(wavetable[i]) ;
		}
	}
		
	if(max == 0) {
		post("oscil~: weird all zero error - exiting!");
		return;
	}
		
	rescale = 1.0 / max ;
	for(i = 0; i < table_length; i++){
		wavetable[i] *= rescale ;
	}
	
	x->dirty = 0; 
}

/* The fadetime method */

void oscil_fadetime (t_oscil *x, double fade_ms)
{
	if(fade_ms < 0.0 || fade_ms > 600000.0){
		error("%f is not a legal fade time", fade_ms);
		fade_ms = 50.;
	}
	x->xfade_duration = fade_ms;
	x->xfade_samples = x->xfade_duration * x->sr / 1000.0;
}

/* The free memory function */

void oscil_free(t_oscil *x)
{
	dsp_free((t_pxobject *) x);
	sysmem_freeptr(x->wavetable);
	sysmem_freeptr(x->old_wavetable);
	sysmem_freeptr(x->amplitudes);
	sysmem_freeptr(x->a_amplitudes);
}

/* The perform method used when a signal is connected to the frequency inlet */

void oscil_perform64(t_oscil *x, t_object *dsp64, double **ins,
                     long numins, double **outs,long numouts, long n,
                     long flags, void *userparam)
{
	t_double *frequency = (t_double *)ins[0];
	t_double *out = (t_double *)outs[0];
	
	float si_factor = x->si_factor;
	float si = x->si;
	float phase = x->phase;
	int table_length = x->table_length;
	float *wavetable = x->wavetable;
	float *old_wavetable = x->old_wavetable;
	long iphase;
	int xfade_countdown = x->xfade_countdown;
	int xfade_samples = x->xfade_samples;
	long xfadetype = x->a_xfadetype;
	float piotwo = x->piotwo;
	float fraction;	
	while (n--) {
		si = *frequency++ * si_factor;
		iphase = trunc(phase);
		if(x->dirty){
			*out++ = old_wavetable[iphase];
		} 
		else if (xfade_countdown > 0) { 
			fraction = (float)xfade_countdown--/(float)xfade_samples;
			if(xfadetype == OSCIL_LINEAR){
				*out++ = wavetable[iphase] + fraction * 	   
				(old_wavetable[iphase] - wavetable[iphase]);
			} 
			else if (xfadetype == OSCIL_POWER) {
				fraction *= piotwo; 
				*out++ = sin(fraction) * old_wavetable[iphase] + 
				cos(fraction) * wavetable[iphase];
			}
		}	
		else {
			*out++ = wavetable[iphase];	
		}		
		phase += si;
		while(phase >= table_length) {
			phase -= table_length;
		}
		while(phase < 0) {
			phase += table_length;
		}
	}
	x->xfade_countdown = xfade_countdown;
	x->phase = phase;
}

/* The perform routine used when no signal is connected to the inlet */

void oscil_perform264(t_oscil *x, t_object *dsp64, double **ins,
                      long numins, double **outs,long numouts, long n,
                      long flags, void *userparam)
{
	t_double *out = (t_double *)outs[0];
	float si = x->si;
	float phase = x->phase;
	int table_length = x->table_length;
	float *wavetable = x->wavetable;
	float *old_wavetable = x->old_wavetable;
	long iphase;
	int xfade_countdown = x->xfade_countdown;
	int xfade_samples = x->xfade_samples;
	long xfadetype = x->a_xfadetype;
	float piotwo = x->piotwo;
	float fraction;
	while (n--) {
		iphase = trunc(phase);
		if(x->dirty){
			*out++ = old_wavetable[iphase];
		}
		else if (xfade_countdown > 0) { 
			fraction = (float)xfade_countdown--/(float)xfade_samples;
			if(xfadetype == OSCIL_LINEAR){
				*out++ = wavetable[iphase] + fraction * 	   
				(old_wavetable[iphase] - wavetable[iphase]);
			} 
			else if (xfadetype == OSCIL_POWER) {
				fraction *= piotwo; 
				*out++ = sin(fraction) * old_wavetable[iphase] + 
				cos(fraction) * wavetable[iphase];
			}
		}		
		else {
			*out++ = wavetable[iphase];	
		}		
		phase += si;
		while(phase >= table_length) {
			phase -= table_length;
		}
		while(phase < 0) {
			phase += table_length;
		}
	}
	x->phase = phase;
	x->xfade_countdown = xfade_countdown;
}

/* The float method */

void oscil_float(t_oscil *x, double f) 
{
	x->si = f * x->si_factor;
}

/* The assist method */

void oscil_assist(t_oscil *x, void *b, long msg, long arg, char *dst)
{
	if (msg == ASSIST_INLET) {
		sprintf(dst,"(signal/float) Frequency");
	} else if (msg == ASSIST_OUTLET) {
		sprintf(dst,"(signal) Output");
	}
}

/* The DSP method */

void oscil_dsp64(t_oscil *x, t_object *dsp64, short *count, double sr, long n, long flags)
{
	if(x->sr != sr){
		x->si *= x->sr / sr;
		x->sr = sr;
		x->si_factor = (float) x->table_length / x->sr;
		x->xfade_samples = x->xfade_duration * x->sr / 1000.0;
	}
	
	if(count[0]) {
		object_method(dsp64, gensym("dsp_add64"),x,oscil_perform64,0,NULL);
	} else {
		object_method(dsp64, gensym("dsp_add64"),x,oscil_perform264,0,NULL);
	}
}


