outlets = 2;

function buildsine()
{
var srate = 1024;
var i;
for(i = 0; i < srate; i++){
    outlet(1, Math.sin(6.23 * i / srate) );
    outlet(0,i);
}

}