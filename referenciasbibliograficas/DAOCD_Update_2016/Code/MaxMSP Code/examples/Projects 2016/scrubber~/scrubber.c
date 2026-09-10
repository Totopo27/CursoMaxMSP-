/****************************************************
 *   This code is explicated in Chapter 8 of        *
 *   "Designing Audio Objects for Max/MSP and Pd"   *
 *   by Eric Lyon.                                  *   
 ****************************************************/

/* Required Max/MSP Header Files */

#include "ext.h" 
#include "z_dsp.h" 
#include "ext_obex.h"

/* Define status constants */

#define SCRUBBER_EMPTY 0
#define SCRUBBER_FULL 1

/* The object structure */

typedef struct _scrubber {
	t_pxobject obj; // Max/MSP proxy object
	float **magnitudes; // contains spectral frames
	float **phases; // contains spectral frames
	float duration_ms; // duration in milliseconds
	long recorded_frames; // counter for recording of frames
	long framecount; // total frames in spectrum
	long oldframes; // for resizing memory
	long fftsize; // number of bins in a frame
	float sr; // sampling rate
	float frame_position; // current frame
	float increment; // speed to advance through the spectrum
	short acquire_sample; //flag to begin sampling
	float sync; // location in buffer (playback or recording)
	float overlap;// overlap factor for STFT
	short buffer_status; // check if need to force memory initialization
	float last_position; //last spectrum position (scaled 0-1)
} t_scrubber;

/* The class pointer */

static t_class *scrubber_class;

/* Function prototypes */

void *scrubber_new(t_symbol *s, int argc, t_atom *argv);
void scrubber_assist(t_scrubber *x, void *b, long msg, long arg, char *dst);
void scrubber_init_memory(t_scrubber *x);
void scrubber_sample(t_scrubber *x);
void scrubber_overlap(t_scrubber *x, t_symbol *msg, short argc, t_atom *argv);
void scrubber_resize(t_scrubber *x, t_symbol *msg, short argc, t_atom *argv);
void scrubber_free(t_scrubber *x);
void scrubber_info(t_scrubber *x);
void scrubber_perform64(t_scrubber *x, t_object *dsp64, double **ins,
                      long numins, double **outs,long numouts, long n,
                      long flags, void *userparam);
void scrubber_dsp64(t_scrubber *x, t_object *dsp64, short *count, double sr, long n, long flags);


/* The main() function */

void ext_main(void *r)
{
	t_class *c;
	scrubber_class = class_new("scrubber~", (method)scrubber_new, (method)scrubber_free, sizeof(t_scrubber), 0, A_GIMME, 0);
	c = scrubber_class;
	class_addmethod(c, (method)scrubber_dsp64, "dsp64", A_CANT, 0);
	class_addmethod(c, (method)scrubber_assist, "assist", A_CANT, 0);
	class_addmethod(c, (method)scrubber_sample, "sample", 0);
	class_addmethod(c, (method)scrubber_overlap, "overlap", A_GIMME, 0);
	class_addmethod(c, (method)scrubber_resize, "resize", A_GIMME, 0);
	class_dspinit(scrubber_class);
	class_register(CLASS_BOX, scrubber_class);
	post("scrubber~ from \"Designing Audio Objects\" by Eric Lyon");
}

/* The new instance routine */

void *scrubber_new(t_symbol *s, int argc, t_atom *argv)
{
	t_scrubber *x = (t_scrubber *)object_alloc(scrubber_class);
	dsp_setup((t_pxobject *)x, 4);
	outlet_new((t_object *)x, "signal");
	outlet_new((t_object *)x, "signal");
	outlet_new((t_object *)x, "signal");
	
	/* 
	 Ensure that *magitudes pointer is NULL so that memory is allocated with the
	 first scrubber_init_memory() call.
	 */
	
	x->magnitudes = NULL;
	
	/* Set the frame size to 1 for initialization purposes */
	
	x->framecount = 1; 
	x->acquire_sample = 0;
	x->fftsize = 1024;
	x->frame_position = 0;
	x->oldframes = 0;
	

	
	/* Initialize the buffer state to empty */
	
	x->buffer_status = SCRUBBER_EMPTY;
	
	/* Set duration according to user paramter or by default */
	
	if( argc >= 1){
		x->duration_ms = atom_getfloatarg(0, argc, argv);
	} else {
        
		/* Default buffer size is 5 seconds */
		
		x->duration_ms = 5000.0; 
	}
	x->last_position = 0;
	x->overlap = 8.0;	
	
	/* Initialize sampling rate */
	
	x->sr = sys_getsr();
	
	/* Initialize memory */
	
	scrubber_init_memory(x);
	
	/* Return a pointer to the object */
	
	return x;
}

/* The overlap method */

void scrubber_overlap(t_scrubber *x, t_symbol *msg, short argc, t_atom *argv)
{
	/* Store the old overlap value */
    
	float old_overlap = x->overlap;
	
	if(argc >= 1){
		
		/* Read the new overlap value */
		
		x->overlap = atom_getfloatarg(0,argc,argv);
		
		/* If the user value is bad, restore the old value and exit */
		
		if(x->overlap <= 0){
			object_post((t_object *)x, "bad overlap: %f", x->overlap);
			x->overlap = old_overlap;
			return;
		}
		
		/* if the new overlap is different than the old one, reset the memory */
		
		if(x->overlap != old_overlap){
			scrubber_init_memory(x);			
		}
	}
}

/* The resize method */

void scrubber_resize(t_scrubber *x, t_symbol *msg, short argc, t_atom *argv)
{
	/* Store the old size */
	
	float old_size = x->duration_ms;
	
	/* 
	 Compute the frame duration. Notice a potential divide-by-zero bug. The code
	 could be improved by first checking that x->sr is not zero.
	 */
	
	float framedur = 2.0 * x->fftsize / x->sr;
	
	/* Read the user supplied duration value */
	
	if(argc >= 1){
		x->duration_ms = atom_getfloatarg(0,argc,argv);
	} 
	else {
		return;
	}
	
	/* Exit if the new duration is the same as the old one */
	
	if(old_size == x->duration_ms){
		return;
	}
	
	/* If the input values are good, resize the memory */
	
	if(x->duration_ms > 0.0 && x->sr > 0.0 && x->fftsize > 0.0 && x->overlap > 0.0){
		x->oldframes = x->framecount;
		x->framecount = 0.001 * x->duration_ms * x->overlap / framedur;
		scrubber_init_memory(x);
	} 	
	else {
		post("scrubber~: cannot resize to: %f", x->duration_ms);
		x->duration_ms = old_size;
	}
}

/* The sample method */

void scrubber_sample(t_scrubber *x)
{
	/* Turn on the flag to acquire a sample */
	
	x->acquire_sample = 1;
	
	/* Set the frame count to 0 */
	
	x->recorded_frames = 0;
	
	/* Set the buffer state to "empty" */
	
	x->buffer_status = SCRUBBER_EMPTY;
}

/* The memory initialization routine */

void scrubber_init_memory(t_scrubber *x)
{
	long framecount = x->framecount;
	long oldframes = x->oldframes;
	long fftsize = x->fftsize;
	long framesize = fftsize / 2;
	long bytesize;
	int i;

	if(framecount <= 0){
		post("scrubber~: bad frame count: %d", framecount);
		return;
	}
	if(fftsize <= 0){
		post("scrubber~: bad size: %d", fftsize);
		return;
	}
	
	/* Set the buffer status to empty, so that any contents will be cleared */
	
	x->buffer_status = SCRUBBER_EMPTY; 
	
	/* If the memory pointer is NULL allocate new memory blocks */
	
	if(x->magnitudes == NULL){
		bytesize = framecount * sizeof(float *);
		x->magnitudes = (float **) sysmem_newptr(bytesize);
		x->phases = (float **) sysmem_newptr(bytesize);
		bytesize = framesize * sizeof(float);
		for(i = 0; i < framecount; i++){
			x->magnitudes[i] = (float *) sysmem_newptr(bytesize);
			x->phases[i] = (float *) sysmem_newptr(bytesize);
		}
	} 
	
	/* Otherwise resize existing memory blocks */
	
	else {
        
		/* Free old frames */
		
		for(i = 0; i < oldframes; i++){
			sysmem_freeptr(x->magnitudes[i]);
			sysmem_freeptr(x->phases[i]);
		}
		
		/* Then resize pointers */
		
		bytesize = framecount * sizeof(float *);
		x->magnitudes = (float **)sysmem_resizeptr(x->magnitudes, bytesize);
		x->phases = (float **)sysmem_resizeptr(x->phases, bytesize);
		
		/* Allocate new frames */
		
		bytesize = framesize * sizeof(float);
		for(i = 0; i < framecount; i++){
			x->magnitudes[i] = (float*)sysmem_newptr(bytesize);
			x->phases[i] = (float*)sysmem_newptr(bytesize);
		}
		
		/* Store the new frame count */
		
		x->oldframes = framecount;
	}
}

/* The free memory function*/

void scrubber_free(t_scrubber *x)
{
	int i;
	dsp_free(&x->obj);
	if(x->magnitudes != NULL){
		for(i = 0; i < x->framecount; i++){
			sysmem_freeptr(x->magnitudes[i]);
			sysmem_freeptr(x->phases[i]);
		}
		sysmem_freeptr(x->magnitudes);
		sysmem_freeptr(x->phases);
	} 
}

/* The assist method */

void scrubber_assist(t_scrubber *x, void *b, long msg, long arg, char *dst)
{
	if (msg==ASSIST_INLET) {
		switch (arg) {
			case 0:
				sprintf(dst,"(signal) Magnitudes In");
				break;
			case 1:
				sprintf(dst,"(signal) Phases In");
				break;
			case 2:
				sprintf(dst,"(signal) Increment");
				break;
			case 3:
				sprintf(dst,"(signal) Position");
				break;
		}
	} 
	else if (msg==ASSIST_OUTLET) {
		switch(arg){
			case 0:
				sprintf(dst,"(signal) Magnitudes Out");
				break;
			case 1:
				sprintf(dst,"(signal) Phases Out");
				break;	
			case 2:
				sprintf(dst,"(signal) Sync");
				break;		
		}
	}
}

/* The perform routine */

void scrubber_perform64(t_scrubber *x, t_object *dsp64, double **ins,
                        long numins, double **outs,long numouts, long n,
                        long flags, void *userparam)
{
	t_double *mag_in = (t_double *) ins[0]; // input magnitude
	t_double *phase_in = (t_double *) ins[1]; // input phase
	t_double *increment = (t_double *) ins[2]; // speed of playback
	t_double *position = (t_double *) ins[3]; // location in the frame array
	t_double *mag_out = (t_double *) outs[0]; // output magnitude
	t_double *phase_out = (t_double *) outs[1]; // output phase
	t_double *sync = (t_double *) outs[2]; // sync signal
	
	/* Dereference object components */
	
	long framecount = x->framecount;
	long recorded_frames = x->recorded_frames;
	float frame_position = x->frame_position;
	float **magnitudes = x->magnitudes;
	float **phases = x->phases;
	short acquire_sample = x->acquire_sample;
	float last_position = x->last_position;
	
	int i;
	long iframe_position;
	float sync_val;

	/* Sample acquisition block */
	
	if(acquire_sample){
		
		/* Calculate the sync signal value */
		
		sync_val = (float) recorded_frames / (float) framecount;
		
		/* Store the magnitudes and phases in the current frame */
		
		for ( i = 0; i < n; i++ ) {
			magnitudes[recorded_frames][i] = mag_in[i];
			phases[recorded_frames][i] = phase_in[i];
		}
		for(i = 0; i < n; i++){
			
			/* Output silence while sampling */
			
			mag_out[i] = 0.;
			phase_out[i] = 0.;
			
			/* Send the sync value to its signal outlet */
			
			sync[i] = sync_val;
		}
		
		/* Increment the frame count */
		
		++recorded_frames;
		
		/* If the limit has been reached, terminate the recording process */
		
		if(recorded_frames >= framecount){
			acquire_sample = 0;
			x->buffer_status = SCRUBBER_FULL;
		}
	} 
	
	/* Playback block */
	
	else if(x->buffer_status == SCRUBBER_FULL) {
		
		/* Compute the sync value */
		
		sync_val = frame_position / (float) framecount;
		
		/* If the input position has changed, set the frame lookup position */
		
		if(last_position != *position && *position >= 0.0 && *position <= 1.0){
			last_position = *position;
			frame_position = last_position * (float)(framecount - 1);
		}
		
		/* Always increment the frame position */
		
		frame_position += *increment;

		/* Keep the frame position within legal range */
		
		while(frame_position < 0.){
			frame_position += framecount;
		}
		while(frame_position >= framecount){
			frame_position -= framecount;
		}
		
		/* Drop the fractional part of the frame position */
		
		iframe_position = floor(frame_position);
				
		/* Output the magnitude and phase frames stored at the frame position */
		
		for (i = 0; i < n; i++) {
			mag_out[i] = magnitudes[iframe_position][i];
			phase_out[i] = phases[iframe_position][i];
			sync[i] = sync_val;
		}
	} 
	
	/* If the buffer is empty, output silence */
	
	else {
		for(i = 0; i < n; i++){
			mag_out[i] = 0.0;
			phase_out[i] = 0.0;
			sync[i] = 0.0;
		}
	}
	
	/* Save state values to corresponding object components */
	
	x->last_position = last_position;
	x->frame_position = frame_position;
	x->acquire_sample = acquire_sample;
	x->recorded_frames = recorded_frames;
}

/* The DSP method */

void scrubber_dsp64(t_scrubber *x, t_object *dsp64, short *count, double sr, long n, long flags)
{
    /* 
	 Scrubber~ will be deployed inside a pfft~ patch so
	 we compute values on the assumption that the signal
	 vector size is 1/2 of the FFT size */
	
	/* Store the signal vector size in a local variable */
	
	long blocksize = n;
	
	float local_sr = sr;
	
	/* Compute the FFT size */
	
	long local_fftsize = blocksize * 2;
	float framedur;
	long new_framecount;

	/* Do not add scrubber~ to DSP chain if the sampling rate is zero */
	
	if(!local_sr){
		return;
	}
	
	/* Compute the frame duration */
	
	framedur = local_fftsize / x->sr;
	
	/* Compute the frame count */
	
	new_framecount = 0.001 * x->duration_ms * x->overlap / framedur;
	
	/* If FFT size, frame count, or sampling rate have changed, resize the memory */
	
	if(x->fftsize != local_fftsize || x->sr != sr || x->framecount != new_framecount){
		x->fftsize = local_fftsize;
		x->sr = sr;
		x->framecount = new_framecount;
		scrubber_init_memory(x);
	} 	
	
	/* Add scrubber~ to the DSP chain */
	
	object_method(dsp64, gensym("dsp_add64"),x,scrubber_perform64,0,NULL);
}
