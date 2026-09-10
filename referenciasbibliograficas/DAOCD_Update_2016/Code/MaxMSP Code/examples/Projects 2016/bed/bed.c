/****************************************************
 *   This code is explicated in Chapter 7 of        *
 *   "Designing Audio Objects for Max/MSP and Pd"   *
 *   by Eric Lyon.                                  *   
 ****************************************************/

/* Required header files */

#include "ext.h"			
#include "ext_obex.h"	

/*
 Since bed is not a signal object, we do not include "z_dsp.h". 
 We do include "buffer.h" for access to various buffer-related declarations.
 */

#include "buffer.h"			

/* The class pointer */

void *bed_class;

/* The object structure */

typedef struct _bed 
{
	t_object	obj; // the Max object
    t_buffer_ref *buffy_ref;
    t_buffer_ref *destbuf_ref;
	t_symbol	*b_name; // the name of the buffer
	float		*undo_samples; // contains samples to undo the previous operation
	long		undo_start; // start frame for the undo replace
	long		undo_frames; // how many frames in the undo
	long		cut_frames; // how many frames were cut?
	long		can_undo; // flag that an undo is possible
	long		undo_resize; // flag that the undo process will resize the buffer
	long		undo_cut; // flag that last operation was a cut
} t_bed;

/* Function prototypes */

void *bed_new(t_symbol *s, short argc, t_atom *argv);
void attach_buffer(t_bed *x);
void bed_info(t_bed *x);
void bed_normalize(t_bed *x);
void bed_fadein(t_bed *x, double fadetime);
void bed_cut(t_bed *x, double start, double end);
void bed_undo(t_bed *x);
t_max_err bed_notify(t_bed *x, t_symbol *s, t_symbol *msg, void *sender, void *data);
void bed_dblclick(t_bed *x);
void attach_dest_buffer(t_bed *x, t_symbol *b_name);
void bed_paste(t_bed *x, t_symbol *destname);
void bed_free(t_bed *x);
void bed_bufname(t_bed *x, t_symbol *name);
void bed_assist(t_bed *x, void *b, long m, long a, char *s);

/* The main() function */

void ext_main(void *r)
{	
	/* 
	 Define and use local variable c to hold the bed class pointer,
	 in order to save typing in the class_addmethod() calls.
	*/
	
	t_class *c; 
	c = class_new("bed", (method)bed_new, (method)bed_free, (long)sizeof(t_bed), 0, A_GIMME, 0);
	class_addmethod(c, (method)bed_bufname, "bufname", A_SYM, 0);
    class_addmethod(c, (method)bed_info, "info", 0);	
	class_addmethod(c, (method)bed_normalize, "normalize", 0);
	class_addmethod(c, (method)bed_fadein, "fadein", A_FLOAT, 0);
	class_addmethod(c, (method)bed_cut, "cut", A_FLOAT, A_FLOAT, 0);
	class_addmethod(c, (method)bed_paste, "paste", A_SYM, 0);
	class_addmethod(c, (method)bed_dblclick, "dblclick", A_CANT, 0);
    class_addmethod(c, (method)bed_notify, "notify", A_CANT, 0);
	class_addmethod(c, (method)bed_assist, "assist", A_CANT, 0);
	class_addmethod(c, (method)bed_undo, "undo", 0);
	
	/* We do not call class_dspinit() since bed is not a signal object */
	
	class_register(CLASS_BOX, c);
	
	/* 
	 Copy the class address from the local pointer c to the 
	 global pointer bed_class */
	
	bed_class = c;
	post("bed from \"Designing Audio Objects\" by Eric Lyon");
}

/* The new instance method */

void *bed_new(t_symbol *s, short argc, t_atom *argv)
{
	t_bed *x = (t_bed *)object_alloc(bed_class); 
	atom_arg_getsym(&x->b_name, 0, argc, argv);
    attach_buffer(x);
	x->undo_samples = NULL;
	x->can_undo = 0;
	x->undo_cut = 0;
	return x;
}


/* The info method */

void bed_info(t_bed *x)
{
    t_buffer_obj	*b = buffer_ref_getobject(x->buffy_ref);
	post("my name is: %s", x->b_name->s_name);
	post("my frame count is: %d", buffer_getframecount(b));
	post("my channel count is: %d", buffer_getchannelcount(b));
}

/* The bufname method */

void bed_bufname(t_bed *x, t_symbol *name)
{
	x->b_name = name;
}

/* The undo method */

void bed_undo(t_bed *x)
{
	t_buffer_obj *b = buffer_ref_getobject(x->buffy_ref);
	float *local_samples; // for storing undo samples
    float *b_samples; // buffer samples
    long b_nchans;
    long b_frames;
	long local_frames; // framesize of the buffer
	long chunksize; // size of memory alloc in bytes
	long offset; // skip time into the buffer
	t_atom rv; // needed for message call
	if(! x->can_undo ){
		object_post((t_object *)x,"nothing to undo");
		return;
	}	
    b_samples = buffer_locksamples(b);
    if(! b_samples){
        object_post((t_object *)x, "bed undo: not a valid buffer!");
        return;
    }
    b_frames = buffer_getframecount(b);
    b_nchans = buffer_getchannelcount(b);
	/* Take care of the special case for undoing a cut */
	
	if(x->undo_cut){
		/* Copy all samples from the main buffer to local buffer */
		
		local_frames = b_frames;
		chunksize = local_frames * b_nchans * sizeof(float);
		local_samples = (float *) sysmem_newptr(chunksize);
		sysmem_copyptr(b_samples, local_samples,  chunksize);
		
		
		/* 
		 Release the main buffer so that it can be accessed through the subsequent
		 call to "sizeinsamps." 
		 */
		
		buffer_unlocksamples(b);
		
		/* Enlarge the main buffer to incorporate the previously cut segment */
		
		object_method_long(b, gensym("sizeinsamps"), x->undo_frames + local_frames, &rv);
		
		/* Re-acquire the main buffer */
		
		b_samples = buffer_locksamples(b);
		
		/* Copy the first part back to the main buffer */
		
		
		chunksize = x->undo_start * b_nchans * sizeof(float);
		sysmem_copyptr(local_samples, b_samples, chunksize);
		
		
		/* Insert the cut piece back to the main buffer */
		
		chunksize = x->undo_frames * b_nchans * sizeof(float);
		offset = x->undo_start * b_nchans;
		sysmem_copyptr(x->undo_samples, b_samples + offset, chunksize);
		
		
		/* Add the last piece back into the main buffer */
		
		chunksize = (local_frames - x->undo_start) * b_nchans * sizeof(float);
		offset = (x->undo_start + x->undo_frames) * b_nchans;
		sysmem_copyptr(local_samples + (x->undo_start * b_nchans), b_samples + offset, chunksize);
		
		/* Release the buffer */
		 
		buffer_unlocksamples(b);
		
		/* Turn off the undo_cut flag */
		
		x->undo_cut = 0;
		
		/* Free the local sample memory */
		
		sysmem_freeptr(local_samples);
		
		/* Instruct any waveform~ objects to redraw the buffer */
		
		object_method((t_object *)b, gensym("dirty"));
        buffer_setdirty(b);
        x->can_undo = 0;
		return;
	}
	/* This is the block for undoing in-place processing */
	
	/* Calculate the bytesize of the frames to be undone */
	
	chunksize = x->undo_frames * b_nchans * sizeof(float);
	
	/* The block for undoing a resize */
	
	if(x->undo_resize){
		
		/*
		 The buffer must be resized using "sizeinsamps." Note that "sizeinsamps" 
		 actually refers to sample frames, not individual samples. So if the buffer
		 is stereo, the call "sizeinsamps 1000" generates space for 2000 samples.
		 */
		
		/* Release the buffer */
			
		buffer_unlocksamples(b);
		
		/* Resize the buffer */
		
		object_method_long(b, gensym("sizeinsamps"), x->undo_frames, &rv);
		
		/* Reacquire the buffer */
		
		buffer_locksamples(b);
	}
	/* Copy the saved samples back into the (possibly resized) buffer */
	
	sysmem_copyptr(x->undo_samples,  b_samples + x->undo_start, chunksize);

	/* Reset undo flag, since there is nothing left to undo */
	
	x->can_undo = 0;
	
	/* Force a waveform~ redraw if necessary */
	
	buffer_setdirty(b);
	
	/* Release the buffer */
	
	buffer_unlocksamples(b);
}

/* The normalize method */

void bed_normalize(t_bed *x)
{
	t_buffer_obj *b = buffer_ref_getobject(x->buffy_ref);
	float maxamp = 0.0;
	float rescale;
    float *b_samples;
    long b_frames;
    long b_nchans;
	long chunksize;
	int i;
	
	/* Attach the buffer and check that it is valid */
	
    b_samples = buffer_locksamples(b);
    if(! b_samples){
        object_post((t_object *)x, "bed normalize: not a valid buffer!");
        return;
    }
    b_frames = buffer_getframecount(b);
    b_nchans = buffer_getchannelcount(b);
	
	/* Calculate the maximum amplitude */
	
	for(i = 0; i < b_frames * b_nchans; i++){
		if(maxamp < fabs(b_samples[i]) ){
			maxamp = fabs(b_samples[i]);
		}
	}
	
	/* Generate the rescale factor */

	if(maxamp > 0.000001){
		rescale = 1.0 / maxamp;
	} 
	else {
		object_post((t_object *)x,"amplitude is too low to rescale: %f", maxamp);
        buffer_unlocksamples(b);
		return;
	}
	
	/* Calculate the byte size for the undo sample block */
	
	chunksize = b_frames * b_nchans * sizeof(float);
	
	/* Store samples for undo */
	
	if( x->undo_samples == NULL ){
		x->undo_samples = (float *) sysmem_newptr(chunksize);
	} else {
		x->undo_samples = (float *) sysmem_resizeptr(x->undo_samples, chunksize);
	}
	if(x->undo_samples == NULL){
		object_post((t_object *)x,"cannot allocate memory for undo");
		x->can_undo = 0;
		buffer_unlocksamples(b);
		return;
	} 
	else {
		x->can_undo = 1;
		x->undo_start = 0;
		x->undo_frames = b_frames;
		x->undo_resize = 0;

		sysmem_copyptr( b_samples, x->undo_samples,chunksize);
		
	}
	
	/* Perform the normalization */
	
	for(i = 0; i < b_frames * b_nchans; i++){
		b_samples[i] *= rescale;
	}	
	/* Force waveform~ to redraw the buffer */
	
	buffer_setdirty(b);
	
	/* Release the buffer */

	buffer_unlocksamples(b);
    
}


/* The cut method */

void bed_cut(t_bed *x, double start, double end)
{
	t_buffer_obj *b = buffer_ref_getobject(x->buffy_ref);
	long chunksize; // size of cut chunk in bytes
	long cutframes; // frames to cut
	long startframe, endframe;
	t_atom rv; // return value, needed for message call
	long offset1, offset2; // memory offsets
	float *local_samples; // storage for undo samples
	long local_frames; // buffer frame count
    long b_nchans;
    float *b_samples;
    long b_frames;
    long b_sr;
	
    b_samples = buffer_locksamples(b);
    if(! b_samples){
        object_post((t_object *)x, "bed cut: not a valid buffer!");
        return;
    }
    b_frames = buffer_getframecount(b);
    b_nchans = buffer_getchannelcount(b);
	/* Calculate frame values in samples */
    b_sr = buffer_getsamplerate(b);
	startframe = start * 0.001 * b_sr;
	endframe = end * 0.001 * b_sr;
	cutframes = endframe - startframe;
	
	/* Check for invalid frame data */
	
	if(cutframes <= 0 || cutframes > b_frames){
		object_post((t_object *)x,"bad cut data: %f %f", start, end);
		buffer_unlocksamples(b);
		return;
	}	
	
	/* Store undo size */
	
	x->undo_frames = cutframes;
	
	/* Store samples for undo  */
	
	local_frames = b_frames;
	chunksize = local_frames * b_nchans * sizeof(float);
	local_samples = (float *) sysmem_newptr(chunksize);
	sysmem_copyptr(b_samples, local_samples,  chunksize);
	
	/* Exit if memory allocation fails */
	
	if(local_samples == NULL){
		object_post((t_object *)x,"cannot allocate memory for undo");
		x->can_undo = 0;
		buffer_unlocksamples(b);
		return;
	}
	
	/* Allocate memory for just the cut segment */
	
	chunksize = cutframes * b_nchans * sizeof(float);
	if( x->undo_samples == NULL ){
		x->undo_samples = (float *) sysmem_newptr(chunksize);
	} 
	else {
		x->undo_samples = (float *) sysmem_resizeptr(x->undo_samples, chunksize);
	}
	if(x->undo_samples == NULL){
		object_post((t_object *)x,"cannot allocate memory for cut segment");
		x->can_undo = 0;
		buffer_unlocksamples(b);
		return;
	} 
	else {
		x->can_undo = 1;
		x->undo_start = startframe; 
		x->undo_frames = cutframes;
		x->undo_resize = 1;
		sysmem_copyptr(b_samples + (startframe * b_nchans), x->undo_samples,  chunksize);
	}
	
	/* Release and resize the main buffer */
	buffer_unlocksamples(b);
	// reduce size of the buffer
	object_method_long(b, gensym("sizeinsamps"), (b_frames - cutframes), &rv);
	buffer_locksamples(b);
	
	
	/* Copy samples up to the start of the cut */
	
	chunksize = startframe * b_nchans * sizeof(float);
	sysmem_copyptr(local_samples, b_samples,  chunksize);
	
	/* Copy from the end of the cut to the end of the buffer */
	
	chunksize = (local_frames - endframe) * b_nchans * sizeof(float);
	offset1 = startframe * b_nchans;
	offset2 = endframe * b_nchans;
	sysmem_copyptr(local_samples + offset2, b_samples + offset1,  chunksize);
		
	/* Redraw the buffer */
    buffer_setdirty(b);
	buffer_unlocksamples(b);
	
	/* Free local memory */

	sysmem_freeptr(local_samples);
	
	/* Set the undo cut flag */
	
	x->undo_cut = 1;
}

/* The paste method */

void bed_paste(t_bed *x, t_symbol *destname)
{
	t_atom rv; // return value from "sizeinsamps" message
//    float *b_samples;
    float *b_samples_dest;
    t_buffer_obj *buffy, *destbuf;
	long chunksize; // bytesize of samples to be copied
	if(x->can_undo){
        attach_dest_buffer(x, destname);
        destbuf = buffer_ref_getobject(x->destbuf_ref);
        buffy = buffer_ref_getobject(x->buffy_ref);
        if(destbuf){
			
			/* Return if there is a channel mismatch */
            if(buffer_getchannelcount(destbuf) != buffer_getchannelcount(buffy))
            {
				object_post((t_object *)x, "bed: channel mismatch between %s and %s", destname->s_name, x->b_name->s_name);
				return;
			}			
			
			/* Resize the destination buffer */
			
			object_method_long(destbuf, gensym("sizeinsamps"), x->undo_frames, &rv);
            
			
			/* Acquire exclusive access to the destination buffer */
			
            b_samples_dest = buffer_locksamples(destbuf);
			
			/* Copy samples to the destination buffer */
			
			chunksize = x->undo_frames * buffer_getchannelcount(destbuf) * sizeof(float);
			sysmem_copyptr(x->undo_samples,  b_samples_dest, chunksize);
			
			/* Release the destination buffer */
			
            buffer_unlocksamples(destbuf);
		}
		else{
			/* Error message for an invalid destination object */
			
			object_post((t_object *)x,"%s is not a valid destination buffer", destname->s_name);
		}
	} else {
		
		/* Error message for when there is nothing in the undo buffer */
		
		object_post((t_object *)x,"nothing to paste");
	}
}


/* The fade in method */

void bed_fadein(t_bed *x, double fadetime)
{
    t_buffer_obj *b = buffer_ref_getobject(x->buffy_ref);
	long chunksize; // size of memory alloc in bytes
	long fadeframes; // frames to fade over
    long b_sr;
    long b_frames;
    long b_nchans;
    float *b_samples;
	int i,j;

	
	/* Calculate the fade time in sample frames */
    b_sr = buffer_getsamplerate(b);
    b_frames = buffer_getframecount(b);
    b_nchans = buffer_getchannelcount(b);
    b_samples = buffer_locksamples(b);
    if(! b_samples){
        object_post((t_object *)x, "bed fadein: not a valid buffer!");
        return;
    }
	fadeframes = fadetime * 0.001 * b_sr;
	if(fadetime <= 0 || fadeframes > b_frames){
		object_post((t_object *)x,"bad fade time: %f", fadetime);
		return;
	}	

	/* Store samples for undo */
	
	chunksize = fadeframes * b_nchans * sizeof(float);
	if( x->undo_samples == NULL ){
		x->undo_samples = (float *) sysmem_newptr(chunksize);
	} else {
		x->undo_samples = (float *) sysmem_resizeptr(x->undo_samples, chunksize);
	}
	if(x->undo_samples == NULL){
		object_post((t_object *)x,"cannot allocate memory for undo");
		x->can_undo = 0;
        buffer_unlocksamples(b);
		return;
	} else {
		x->can_undo = 1;
		x->undo_start = 0;
		x->undo_frames = fadeframes;
		x->undo_resize = 0;
		sysmem_copyptr(b_samples, x->undo_samples,  chunksize);
	}
	
	/* Perform a linear fadein */
	
	for(i = 0; i < fadeframes; i++){
		for(j = 0; j < b_nchans; j++){
			b_samples[(i * b_nchans) + j] *= (float)i / (float) fadeframes;
		}
	}	
	
	/* Redraw the buffer */
    buffer_setdirty(b);
	buffer_unlocksamples(b);
}

/* The attach buffer utility function */

void attach_buffer(t_bed *x)
{	
    if (!x->buffy_ref)
        x->buffy_ref = buffer_ref_new((t_object *)x, x->b_name);
    else
        buffer_ref_set(x->buffy_ref, x->b_name);
}

/* The attach any buffer utility function */

void attach_dest_buffer(t_bed *x, t_symbol *b_name)
{
    if (!x->destbuf_ref)
        x->destbuf_ref = buffer_ref_new((t_object *)x, b_name);
    else
        buffer_ref_set(x->destbuf_ref, b_name);
}


/* the free memory routine */

void bed_free(t_bed *x)
{
	/* bed is not an MSP object so there is no need to free it from the DSP chain */
	
	sysmem_freeptr(x->undo_samples);
}

/* The double click method */

void bed_dblclick(t_bed *x)
{
    buffer_view(buffer_ref_getobject(x->buffy_ref));
}

/* The notify method */

t_max_err bed_notify(t_bed *x, t_symbol *s, t_symbol *msg, void *sender, void *data)
{
    return buffer_ref_notify(x->buffy_ref, s, msg, sender, data);
}

/* The assist method */

void bed_assist(t_bed *x, void *b, long m, long a, char *s)
{
	/* There is only an inlet on this object, so no branching is required */
	
	sprintf(s, "messages");
}

