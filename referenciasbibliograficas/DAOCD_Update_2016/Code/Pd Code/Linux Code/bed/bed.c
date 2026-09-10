/****************************************************
 *   This code is explicated in Chapter 7 of        *
 *   "Designing Audio Objects for Max/MSP and Pd"   *
 *   by Eric Lyon.                                  *   
 ****************************************************/

/* Required header files */

#include "m_pd.h"
#include <math.h>
#include <string.h> // for memcpy

/* The class pointer */

static t_class *bed_class;

/* The object structure */

typedef struct _bed 
{
	t_object	obj; // the Pd object
	t_symbol	*b_name; // the name of the array
	t_garray	*buffy; // the Buffer
	long		b_valid; // state of the array
	long		b_frames; // frame count 
	float		*b_samples; // samples
	float		b_1oversr; // 1 over the sampling rate
	float		*undo_samples; // contains samples to undo the previous operation
	long		undo_start; // start frame for the undo replace
	long		undo_frames; // how many frames in the undo
	long		can_undo; // flag that an undo is possible
	long		undo_resize; // flag that the undo process will resize the array
	long		undo_cut; // flag to undo a cut
	float		b_sr; // sampling rate
} t_bed;

/* Function prototypes */

void *bed_new(t_symbol *n);
int attach_array(t_bed *x);
int attach_any_array(t_garray **dest_array, t_symbol *b_name);
void bed_info(t_bed *x);
void bed_normalize(t_bed *x);
void bed_fadein(t_bed *x, t_floatarg fadetime);
void bed_cut(t_bed *x, t_floatarg start, t_floatarg end);
void bed_paste(t_bed *x, t_symbol *destname);
void bed_undo(t_bed *x);
void bed_free(t_bed *x);
void bed_bufname(t_bed *x, t_symbol *name);

/* 
 The object setup function.
 Since bed is not a signal object, "tilde" is not included in the
 name of the setup function. 
 */

void bed_setup(void)
{	
	/* 
	 Define and use local variable c to hold the bed class pointer,
	 in order to save typing in the class_addmethod() calls.
	 */
	
	t_class *c;
	
	bed_class = class_new(gensym("bed"), (t_newmethod)bed_new, (t_method)bed_free, 
						  sizeof(t_bed), 0, A_SYMBOL, 0);
	c = bed_class;
	
	/* We do not call MAINSIGNALIN() since bed is not a signal object */
	
    class_addmethod(c, (t_method)bed_info, gensym("info"), A_CANT, 0);	
	class_addmethod(c, (t_method)bed_normalize, gensym("normalize"), 0);
	class_addmethod(c, (t_method)bed_fadein, gensym("fadein"), A_FLOAT, 0);
	class_addmethod(c, (t_method)bed_cut, gensym("cut"), A_FLOAT, A_FLOAT, 0);
	class_addmethod(c, (t_method)bed_paste, gensym("paste"), A_SYMBOL, 0);
	class_addmethod(c, (t_method)bed_bufname, gensym("bufname"), A_SYMBOL, 0);
	class_addmethod(c, (t_method)bed_undo, gensym("undo"),A_CANT, 0);
	
	post("bed from \"Designing Audio Objects\" by Eric Lyon");
}

/* The new instance method */

void *bed_new(t_symbol *myname)
{
	t_bed *x = (t_bed *)pd_new(bed_class); 
	x->b_name = myname;
	x->undo_samples = NULL;
	x->can_undo = 0;
	return x;
}

/* The info method */

void bed_info(t_bed *x)
{	
	if(! attach_array(x)){
		return;
	} 	
	post("my name is: %s", x->b_name->s_name);
	post("my frame count is: %d", x->b_frames);
}

/* The bufname method */

void bed_bufname(t_bed *x, t_symbol *name)
{
	x->b_name = name;
}

/* The undo method */

void bed_undo(t_bed *x)
{
	t_garray *a; // hold the main array
	long chunksize; // size of memory alloc in bytes
	float *local_samples; // for storing undo samples
	long local_frames; // framesize of the array
	long offset; // skip time into the array
	long oldsize; // Pd bookkeeping
	
	if(! x->can_undo){
		post("bed: nothing to undo");
		return;
	}	
	
	if(! attach_array(x)){
		return;
	} 

	a = x->buffy;

	/* Take care of special case for undo cut */
	
	if(x->undo_cut){

		/* Copy all samples from the main array to local array */
		
		local_frames = x->b_frames;
		chunksize = local_frames * sizeof(float);
		local_samples = getbytes(chunksize);
		memcpy(local_samples, x->b_samples, chunksize);

		/* Enlarge the main array to incorporate the previously cut segment */
		
		garray_resize(a, x->undo_frames + local_frames);

		/* Reattach the array after resizing it */

		if(! attach_array(x)){
			return;
		} 

		/* Copy the first part back to the main array */
		
		chunksize = x->undo_start * sizeof(float);
		memcpy(x->b_samples, local_samples, chunksize);

		/* Insert the cut piece back to the main array */
		
		chunksize = x->undo_frames * sizeof(float);
		memcpy(x->b_samples + x->undo_start, x->undo_samples, chunksize);

		/* Add the last piece back into the main array */
		
		chunksize = (local_frames - x->undo_start) * sizeof(float);
		offset = x->undo_start + x->undo_frames;
		memcpy(x->b_samples + offset, local_samples + x->undo_start,  chunksize);

		/* Turn off the undo_cut flag */
		
		x->undo_cut = 0;
		oldsize = local_frames * sizeof(float);
		
		/* Free the local sample memory */
		
		freebytes(local_samples, oldsize);
		
		/* Redraw the array */
		
		garray_redraw(a);
		return;
	}
	
	/* Calculate the bytesize of the frames to be undone */
	
	chunksize = x->undo_frames * sizeof(float);
	
	/* Resize the array if we are undoing an operation that previously resized the array */
	
	if(x->undo_resize){
		garray_resize(a, x->undo_frames);
	}

	/* Reattach the array after resizing it */

	if(! attach_array(x)){
		return;
	} 	

	/* Copy the saved samples back into the (possibly resized) array */
	
	memcpy(x->b_samples + x->undo_start, x->undo_samples, chunksize);

	/* Zero the undo flag, since there is nothing left to undo */
	
	x->can_undo = 0;
	
	/* Redraw the array */
	
	garray_redraw(a);
}

/* The normalize method */

void bed_normalize(t_bed *x)
{
	t_garray *a;
	float maxamp = 0.0;
	float rescale;
	long oldsize; // size of undo_samples in bytes
	long chunksize; // size of memory alloc in bytes
	int i;
	
	/* Attach the array and check that it is valid */
	
	if(! attach_array(x)){
		return;
	} 
	a = x->buffy;

	/* Calculate the maximum amplitude */
	
	for(i = 0; i < x->b_frames; i++){
		if(maxamp < fabs(x->b_samples[i]) ){
			maxamp = fabs(x->b_samples[i]);
		}
	}
	/* Generate the rescale factor */
	
	if(maxamp > 0.000001){
		rescale = 1.0 / maxamp;
	} 
	else {
		post("bed: amplitude is too low to rescale: %f", maxamp);
		return;
	}
	
	/* Calculate the byte size for the undo sample block */
	
	chunksize = x->b_frames *  sizeof(float);
	
	/* allocate memory for undo_samples */
	
	if( x->undo_samples == NULL ){
		x->undo_samples = (float *) getbytes(chunksize);
	} 
	else {
		oldsize = x->undo_frames * sizeof(float);
		x->undo_samples = (float *) resizebytes(x->undo_samples,oldsize,chunksize);
	}

	/* Store old samples in undo_samples */

	if(x->undo_samples == NULL){
		post("bed: cannot allocate memory for undo");
		x->can_undo = 0;
		return;
	} 
	else {
		x->can_undo = 1;

		/* In case the last operation was a cut, we must unset the undo_cut flag */

		x->undo_cut = 0;
		x->undo_start = 0;
		x->undo_frames = x->b_frames;
		x->undo_resize = 0;
		memcpy(x->undo_samples, x->b_samples, chunksize);
	}
	
	/* Perform the normalization */
	
	for(i = 0; i < x->b_frames; i++){
		x->b_samples[i] *= rescale;
	}	

	/* Re-attach the array */

	if(! attach_array(x)){
		return;
	} 
	
	/* Redraw the array */
	
	garray_redraw(x->buffy);	
}

/* The cut method */

void bed_cut(t_bed *x, t_floatarg start, t_floatarg end)
{
	
	t_garray *a;
	long chunksize; // size of memory alloc in bytes
	long oldsize; // Pd bookkeeping
	long cutframes; // frames to cut
	long startframe, endframe;
	float *local_samples;
	long local_frames;
	
	if(! attach_array(x)){
		return;
	} 
	
	a = x->buffy;
	
	/* Calculate frame values in samples */
	
	startframe = start * 0.001 * x->b_sr;
	endframe = end * 0.001 * x->b_sr;
	cutframes = endframe - startframe;
	
	/* Check for invalid frame data */
	
	if(cutframes <= 0 || cutframes > x->b_frames){
		post("bed: bad cut data: %f %f", start, end);
		return;
	}	
	
	/* Store undo size */
	
	local_frames = x->b_frames;
	
	/* 
	 Calculate storage size. All Pd arrays are mono so we
	 do not consider the channel count. 
	 */
	
	chunksize = local_frames * sizeof(float); 
	
	/* Store samples for undo  */
	
	local_samples = getbytes(chunksize);
	memcpy(local_samples, x->b_samples, chunksize);
	
	chunksize = cutframes * sizeof(float);
	
	/* Allocate memory for the cut chunk */

	oldsize = x->undo_frames * sizeof(float);

	if( x->undo_samples == NULL ){
		x->undo_samples = getbytes(chunksize);
		post("allocating %d bytes for undo_samples", chunksize);
	}
	else {
		x->undo_samples = resizebytes(x->undo_samples, oldsize, chunksize);
	}
	
	/* Exit if memory allocation fails */
	
	if(x->undo_samples == NULL){
		post("bed: cannot allocate memory for undo");
		x->can_undo = 0;
		return;
	}
	
	/* Otherwise store the cut chunk */
	
	else {
		x->can_undo = 1;
		x->undo_start = startframe; 
		x->undo_frames = cutframes;
		x->undo_resize = 1;
		memcpy(x->undo_samples, x->b_samples + startframe, chunksize);
	}

	/* Resize the array */
	
	garray_resize(a, (x->b_frames - cutframes));

	/* Reattach the array after resizing it */

	if(! attach_array(x)){
		return;
	} 

	/* Copy samples up to the start of the cut */
	
	chunksize = startframe * sizeof(float);
	memcpy(x->b_samples, local_samples, chunksize);

	/* Copy from the end of the cut to the end of the array */
	
	chunksize = (local_frames - endframe) * sizeof(float);
	memcpy(x->b_samples + startframe, local_samples + endframe, chunksize);

	/* Free local memory */
	
	oldsize = local_frames * sizeof(float);
	freebytes(local_samples, oldsize);
	
	/* Set the cut flag */
	
	x->undo_cut = 1;
	
	/* Redraw the array */
	
	garray_redraw(x->buffy);	
}

/* The paste method */

void bed_paste(t_bed *x, t_symbol *destname)
{
	int i;
	t_garray *a; // main array
	t_garray *destbuf = NULL; // destination array
	long chunksize; // bytesize of samples to be copied
	int destbuf_b_frames; // frame count for destination array
	float *destbuf_b_samples; // destination array sample pointer
	
	if(x->can_undo){
		
		/* Attach the main array */
		
		if(! attach_array(x)){
			return;
		} 
		
		/* Attach the destination array */
		
		if( attach_any_array(&destbuf, destname) ){
			if (!garray_getfloatarray(destbuf, &destbuf_b_frames, &destbuf_b_samples)) {
				pd_error(x, "bed: bad array for %s", destname->s_name);
				return;
			}
			
			/* Resize the destination array */
			
			garray_resize(destbuf, x->undo_frames);
			chunksize = x->undo_frames * sizeof(float);
			
			/* 
			 Re-attach the destination array. This step is obligatory
			 after the array has been resized. 
			 */
			
			if (!garray_getfloatarray(destbuf, &destbuf_b_frames, &destbuf_b_samples)) {
				pd_error(x, "bed: bad array for %s", destname->s_name);
				return;
			}
			
			/* Copy samples to the destination array */
			
			memcpy(destbuf_b_samples, x->undo_samples, chunksize);

			/* Redraw the destination array */
			
			garray_redraw(destbuf);
			
		}
	} 
	else {
		post("bed: nothing to paste");
	}
}

/* The fade in method */

void bed_fadein(t_bed *x, t_floatarg fadetime)
{
	
	t_garray *a; // the main array
	long oldsize; // previous bytesize of undo_samples
	long chunksize; // size of memory alloc in bytes
	long fadeframes; // frames to fade for
	int i,j;
	
	if(! attach_array(x)){
		return;
	} 
	
	a = x->buffy;
	
	/* Calculate the fade time in sample frames */
	
	fadeframes = fadetime * 0.001 * x->b_sr;
	if(fadetime <= 0 || fadeframes > x->b_frames){
		post("bed: bad fade time: %f", fadetime);
		return;
	}	
	
	/* Store samples for undo */
	
	chunksize = fadeframes * sizeof(float);
	oldsize = x->undo_frames * sizeof(float);
	if(x->undo_samples == NULL){
		x->undo_samples = (float *) getbytes(chunksize);
	} else {
		x->undo_samples = (float *) resizebytes(x->undo_samples, oldsize, chunksize);
	}
	if(x->undo_samples == NULL){
		post("bed: cannot allocate memory for undo");
		x->can_undo = 0;
		return;
	} else {
		x->can_undo = 1;
		x->undo_cut = 0;
		x->undo_start = 0;
		x->undo_frames = fadeframes;
		x->undo_resize = 0;
		memcpy(x->undo_samples, x->b_samples, chunksize);
	}
	
	/* Perform a linear fadein */
	
	for(i = 0; i < fadeframes; i++){
		x->b_samples[i] *= (float)i / (float) fadeframes;
	}	
	
	/* Redraw the array */
	
	garray_redraw(x->buffy);
}

/* The attach array utility function */

int attach_array(t_bed *x)
{
	t_garray *a; // the array to be attached
	t_symbol *b_name; // the name of the array
	float *b_samples; // pointer to array samples
	int b_frames; // array frame count
	x->b_valid = 0;
	b_name = x->b_name;

	/* Find the array by class and name */
	
	if (!(a = (t_garray *)pd_findbyclass(b_name, garray_class))) {
		if (b_name->s_name){
			pd_error(x, "bed: %s: no such array",b_name->s_name);
		}
		return x->b_valid;
    }
	
	/* Attach the array */
	
	if (!garray_getfloatarray(a, &b_frames, &b_samples)) {
		pd_error(x, "bed: bad array for %s", b_name->s_name);
		return x->b_valid;
    }
	
	/* If the array is valid, store its information */
	
	else  {
		x->b_valid = 1;
		x->b_frames = (long)b_frames;
		x->b_samples = b_samples;	
		x->b_sr = sys_getsr();
		if(x->b_sr <= 0){
			x->b_sr = 44100.0;
		}
		x->b_1oversr = 1.0 / x->b_sr;
		x->buffy = a;
	}
	
	/* Return the status of the array */
	
	return x->b_valid;
}

/* The attach any array utility function */

int attach_any_array(t_garray **dest_array, t_symbol *b_name)
{
	t_garray *a; // the array to be attached
	int b_valid = 0;
	
	/* Find the array by class and name */
	
	if (!(a = (t_garray *)pd_findbyclass(b_name, garray_class))) {
		if (b_name->s_name) post("bed: %s: no such array",b_name->s_name);
		return 0;
    } 
    else {
		b_valid = 1;
	}
	
	/* Attach the array */
	
	*dest_array = a;
	
	/* Return the array status */
	
	return b_valid;
}

/* The free routine */

void bed_free(t_bed *x)
{
	freebytes(x->undo_samples, x->undo_frames * sizeof(float));
}

