var points = 8192;
outlets = 2;
function linefunc1(segs){
    var seglen = points / segs;
    var firstpoint = x1 = (Math.random() * 2) - 1;
    var x2 = (Math.random() * 2) - 1;
    var i,j;
    var sample, frac;
    for(i = 0; i < segs; i++){
        for(j = 0; j < seglen; j++){
            sample = x1 + ((j/seglen) * (x2 - x1));
            outlet(1, (i*seglen)+j);
            outlet(0, sample);
        }
        x1 = x2;
        if(i == segs - 2){
            x2 = firstpoint;
        } else {
            x2 = (Math.random() * 2) - 1;
        }
    }        
}
