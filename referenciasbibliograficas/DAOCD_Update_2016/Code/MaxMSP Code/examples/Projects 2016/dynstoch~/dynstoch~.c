/****************************************************
 *  This code is proposed in Chapter 13 of          *
 *  "Designing Audio Objects for Max/MSP and Pd"    *
 *  by Eric Lyon.  The algorithm for dynamic        *
 *	stochastic synthesis was presented by Iannis    *
 *	Xenakis in his book "Formalized Music."         *
 ****************************************************/

/* Required Max/MSP headers */

#include "ext.h"
#include "z_dsp.h"
#include "ext_obex.h"

/* Define the maximum number of waveform extrema */

#define MAX_EXTREMITIES (64)

/* The object structure */

typedef struct _dynstoch
{
    t_pxobject obj;
    t_double *extremities; // extremities
    long countdown; // current sample countdown
    long countdown_points; // how many to count down
    t_double *segment_durs; // durations stored in seconds
    int extremities_count; // how many extremities
    int current_segment; // which segment are we on
    t_double minseg; // minimum segment in seconds
    t_double maxseg; // maximum segment in seconds
    t_double freq; // frequency attribute
    long total_samps; // full size of waveform
    t_double sr; // current sampling rate
    t_double x_devo; // deviation of extremities attribute
    t_double y_devo; // deviation for durations attribute
    t_double minseg_samps; // minimum segment size in samples
    t_double maxseg_samps; // maximum segment size in samples
    t_double minfreq; // minimum frequency
    t_double maxfreq; // maximum frequency
    long minsamps; // minimum total samps
    long maxsamps; // maximum total samps
    long counter; // temp test variable
    short firsttime; // flag for initialization
} t_dynstoch;

/* The class declaration */

static t_class *dynstoch_class;

/* Function prototypes */

void *dynstoch_new(t_symbol *s, short argc, t_atom *argv);
//t_int *dynstoch_perform(t_int *w);
// void dynstoch_dsp(t_dynstoch *x, t_signal **sp, short *count);
void dynstoch_assist(t_dynstoch *x, void *b, long msg, long arg, char *dst);
float dynstoch_rand(float min, float max);
void dynstoch_initwave(t_dynstoch *x);
void dynstoch_transpose(t_dynstoch *x, double tfac);
void dynstoch_setfreq(t_dynstoch *x, double freq);
void dynstoch_freqbounds(t_dynstoch *x, double minf, double maxf);
void dynstoch_free(t_dynstoch *x);
void dynstoch_perform64(t_dynstoch *x, t_object *dsp64, double **ins,
                        long numins, double **outs,long numouts, long n,
                        long flags, void *userparam);
void dynstoch_dsp64(t_dynstoch *x, t_object *dsp64, short *count, double sr, long n, long flags);


/* The main() function */

void ext_main(void *r)
{
    t_class *c = dynstoch_class = class_new("dynstoch~", (method)dynstoch_new,
                                            (method)dynstoch_free, sizeof(t_dynstoch), 0,A_GIMME, 0);
    class_addmethod(c, (method)dynstoch_dsp64, "dsp64", A_CANT, 0);
    class_addmethod(c, (method)dynstoch_assist, "assist", A_CANT, 0);
    class_addmethod(c, (method)dynstoch_initwave, "initwave", A_NOTHING, 0);
    class_addmethod(c, (method)dynstoch_setfreq, "setfreq", A_FLOAT, 0);
    class_addmethod(c, (method)dynstoch_freqbounds, "freqbounds", A_FLOAT,A_FLOAT,0);
    
    /* Define attributes */
    
    CLASS_ATTR_FLOAT(c, "x_deviation", 0, t_dynstoch, x_devo);
    CLASS_ATTR_FLOAT(c, "y_deviation", 0, t_dynstoch, y_devo);
    CLASS_ATTR_FLOAT(c, "frequency", 0, t_dynstoch, freq);
    CLASS_ATTR_LABEL(c, "x_deviation", 0, "Extremities Deviation");
    CLASS_ATTR_LABEL(c, "y_deviation", 0, "Segdur Deviation");
    class_dspinit(c);
    class_register(CLASS_BOX, c);
    post("dynstoch~ from \"Designing Audio Objects\" by Eric Lyon");
}

/* The new instance routine */

void *dynstoch_new(t_symbol *s, short argc, t_atom *argv)
{
    t_dynstoch *x = (t_dynstoch *)object_alloc(dynstoch_class);
    
    dsp_setup((t_pxobject *)x,0);
    outlet_new((t_pxobject *)x, "signal");
    outlet_new((t_pxobject *)x, "signal");
    
    /* Allocate space for the extremities */
    
    x->extremities = (t_double *) sysmem_newptrclear((MAX_EXTREMITIES + 1)* sizeof(t_double));
    x->segment_durs = (t_double *) sysmem_newptr(MAX_EXTREMITIES * sizeof(t_double));
    x->minseg = 0.0001;
    x->maxseg = 0.2;
    x->extremities_count = 12;
    x->freq = 440.0;
    x->x_devo = 0.001;
    x->y_devo = 0.001;
    x->countdown_points = 10;
    x->countdown = 10;
    x->minfreq = 50.0;
    x->maxfreq = 10000.0;
    x->firsttime = 1;
    
    /* Set initial frequency boundaries */
    
    dynstoch_freqbounds(x, 100.0, 800.0);
    
    /* Read attributes */
    
    attr_args_process(x, argc, argv);
    return x;
}

/* The rand utility function */

float dynstoch_rand(float min, float max)
{
    return min + (((rand()%32768)/32767.0) * (max-min));
}

/* The transpose method */

void dynstoch_transpose(t_dynstoch *x, double tfac)
{
    int i;
    if(tfac <= 0 ) return;
    
    for(i = 0; i < x->extremities_count; i++){
        x->segment_durs[i] /= tfac;
    }
}

/* The setfreq method */

void dynstoch_setfreq(t_dynstoch *x, double freq)
{
    t_double totalsamp =  (x->sr / freq);
    int sampcount = 0;
    long segdur = totalsamp / (float)x->extremities_count;
    int i;
    long slop = totalsamp - (segdur * x->extremities_count);
    if(freq < x->minfreq || freq > x->maxfreq){
        post("frequency requested out of range: %f", freq);
        return;
    }
    for(i = 0; i < x->extremities_count; i++){
        x->segment_durs[i] = segdur;
    }
    if(slop > 1){
        i = 0;
        while(slop--){
            x->segment_durs[i++]++;
            i %= x->extremities_count;
        }
    }
    for(i = 0; i < x->extremities_count; i++){
        sampcount += x->segment_durs[i];
    }
    x->freq = x->sr / (float) sampcount;
    x->total_samps = sampcount;
}

/* The nudge routine */

void dynstoch_nudge(t_dynstoch *x)
{
    int i,j;
    t_double devx, devy;
    long maxsamps = x->maxsamps;
    long minsamps = x->minsamps;
    long actual_total;
    int sampdiff; // how many points need to be added or subtracted from period
    x->total_samps = 0;
    x->counter = 0;
    if( x->x_devo || x->y_devo) {
        
        for(i = 0; i < x->extremities_count; i++){
            devx = dynstoch_rand(-x->x_devo, x->x_devo);
            devy = dynstoch_rand(-x->y_devo, x->y_devo);
            
            /* Randomly nudge each y value */
            
            x->extremities[i]  += devy;
            
            /* Prevent extremities from wandering into denorm territory */
            
            if(IS_DENORM_NAN_FLOAT(x->extremities[i])){
                x->extremities[i] = 0.0;
            }
            
            /* Randomly nudge each x value */
            
            x->segment_durs[i] += devx;
            
            /* Keep values within legal range */
            
            if(x->segment_durs[i] < x->minseg_samps){
                x->segment_durs[i] = x->minseg_samps;
                
            }
            if(x->segment_durs[i] > x->maxseg_samps/x->extremities_count){
                x->segment_durs[i] = x->maxseg_samps/x->extremities_count;
            }
            x->total_samps += x->segment_durs[i];
            
            
            
            /* Mirror the point according to Iannis Xenakis's suggestion for out-of-range extremities */
            
            if(x->extremities[i] > 1.0){
                x->extremities[i] = 2.0 - x->extremities[i];
            }
            else if(x->extremities[i] < -1.0)
            {
                /* mirror the point */
                
                x->extremities[i] = -2.0 - x->extremities[i];
            }
        }
        
        /*
         Now force waveform period within frequency boundaries, or
         as close as we can get without zero-length segments
         */
        
        actual_total = x->total_samps;
        if(x->total_samps > maxsamps){
            sampdiff = x->total_samps - maxsamps;
            x->total_samps = maxsamps;
            for(j = 0; j < sampdiff; j++){
                if(x->segment_durs[ j % x->extremities_count ] > 1) {
                    x->segment_durs[ j % x->extremities_count ] -= 1;
                    --actual_total;
                }
            }
        }
        else if(x->total_samps < minsamps) {
            sampdiff = minsamps - x->total_samps;
            x->total_samps = minsamps;
            for(j = 0; j < sampdiff; j++){
                x->segment_durs[ j % x->extremities_count ] += 1;
                ++actual_total;
            }
        }
        x->total_samps = actual_total;
    }
    
    /* Check that durations do not drop below the minimum length */
    
    for(i=0; i < x->extremities_count; i++){
        if(x->segment_durs[i] < x->minseg_samps){
            x->segment_durs[i] = x->minseg_samps;
            
        }
    }
    
    /* Calculate the total sample count of the waveform */
    
    x->total_samps = 0;
    for(i=0; i < x->extremities_count; i++){
        x->total_samps += x->segment_durs[i];
    }
    
    x->freq = x->sr/ x->total_samps;
    x->extremities[x->extremities_count] = x->extremities[0];
    x->countdown = (long)x->segment_durs[0];
    x->countdown_points = x->countdown;
    x->current_segment = 0;
    if(x->countdown_points <= 0){
        x->countdown_points = 8;
    }
}

/* The freebounds method */

void dynstoch_freqbounds(t_dynstoch *x, double minf, double maxf)
{
    if(!x->sr || !minf || !maxf){
        return;
    }
    x->minfreq = minf;
    x->maxfreq = maxf;
    x->maxsamps = x->sr / minf;
    x->minsamps = x->sr / maxf;
}

/* The initwave method */

void dynstoch_initwave(t_dynstoch *x)
{
    int i;
    x->total_samps = x->sr / x->freq;
    x->minseg = 4.0 / x->sr;
    x->maxseg = 1.0 / 45.0;
    x->minseg_samps = 1;
    x->maxseg_samps = x->maxseg * x->sr;
    for(i = 0; i < x->extremities_count; i++){
        x->extremities[i] = dynstoch_rand(-1.0, 1.0);
        x->segment_durs[i] = x->total_samps / x->extremities_count;
        // post("%f %f",x->extremities[i],  x->segment_durs[i]);
        
    }
    
    x->extremities[x->extremities_count] = x->extremities[0];
    x->countdown = x->segment_durs[0];
    x->countdown_points = x->countdown;
    x->current_segment = 0;
}


/* The perform routine */

void dynstoch_perform64(t_dynstoch *x, t_object *dsp64, double **ins,
                        long numins, double **outs,long numouts, long n,
                        long flags, void *userparam)
{
    t_double *output = (t_double *) outs[0];
    t_double *frequency = (t_double *) outs[1];
    t_double frac;
    int current_segment = x->current_segment;
    t_double segpoints = x->segment_durs[x->current_segment];
    t_double *extremities = x->extremities;
    t_double e1, e2;
    t_double sample;
    e1 = extremities[current_segment];
    e2 = extremities[current_segment + 1];
    while(n--){
        if(x->countdown <= 0){
            // last point
            ++current_segment;
            if(current_segment == x->extremities_count){
                
                /*
                 We have reached the end of the period, so we
                 nudge the waveform and start again.
                 */
                
                dynstoch_nudge(x);
                current_segment = 0;
            }
            
            /* Advance to the next extremities point */
            
            else {
                
                e1 = extremities[current_segment];
                e2 = extremities[current_segment + 1];
                segpoints = x->segment_durs[current_segment];
                x->countdown_points = segpoints; // coerced to long
                x->countdown = x->countdown_points;
            }
        }
        
        frac = (float)x->countdown / (float)x->countdown_points;
        sample = e1 + frac * (e2 - e1);
        
        /* Keep sample values legal */
        
        if(IS_DENORM_NAN_FLOAT(sample)){
            post("bad sample: %f, e1: %f e2: %f frac: %f, curseg: %d", sample, e1, e2, frac, current_segment);
            post("countdown %d, segpoints %d", x->countdown, x->countdown_points);
            sample = 0.0;
        }
        if(fabs(sample) > 2.0){
            post("SAMPLE OUT OF RANGE %f", sample);
            post("e1: %f e2: %f frac: %f, curseg: %d", e1, e2, frac, current_segment);
            post("countdown %d, segpoints %d", x->countdown, x->countdown_points);
            sample = 0.0;
        }
        *output++ = sample;
        *frequency++ = x->freq;
        x->countdown--;
        ++x->counter;
    }
    x->current_segment = current_segment;
}

/* The free memory routine */

void dynstoch_free(t_dynstoch *x)
{
    dsp_free((t_pxobject *) x);
    sysmem_freeptr(x->extremities);
    sysmem_freeptr(x->segment_durs);
}

/* The assist method */

void dynstoch_assist(t_dynstoch *x, void *b, long msg, long arg, char *dst)
{
    if (msg == ASSIST_INLET) {
        switch(arg){
            case 0: sprintf(dst,"(signal) Input"); break;				
        }
    } else if (msg == ASSIST_OUTLET) {
        switch(arg){
            case 0: sprintf(dst,"(signal) Output"); break;
            case 1: sprintf(dst,"(signal) Frequency"); break;				
        }	
    }
}

/* The DSP method */

void dynstoch_dsp64(t_dynstoch *x, t_object *dsp64, short *count, double sr, long n, long flags)
{
    x->sr = sr;
    x->maxsamps = x->sr / x->minfreq;
    x->minsamps = x->sr / x->maxfreq;
    if(x->firsttime){
        dynstoch_initwave(x);
        x->firsttime = 0;
    }
    object_method(dsp64, gensym("dsp_add64"),x,dynstoch_perform64,0,NULL);
}

