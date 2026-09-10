var ocnt = 200;
var p = this.patcher;

// cycle connected to 200 vpdelay~ objects
function build_vdelay_neither_connected()
{
var i;
var h = 20, v = 20;
var source = p.newdefault(h,v,"cycle~", "440");
var newdel;
v += 30;
for(i = 0; i < ocnt; i++){
    newdel = p.newdefault(h,v,"vpdelay~", 10, 10, 0.5);
    p.connect(source, 0, newdel, 0);
    v++;
    h++;
}

}

// cycle connected to 200 vdelay~ objects
function build_vdelay_both_connected()
{
var i;
var h = 20, v = 20;
var source = p.newdefault(h,v,"cycle~", "440");
var newdel;
v += 30;
for(i = 0; i < ocnt; i++){
    newdel = p.newdefault(h,v,"vdelay~", 10, 10, 0.5);
    p.connect(source, 0, newdel, 0);
    v++;
    h++;
}

}
// 200 vdelay~ objects with all inputs connected
function build2v()
{
var i;
var h = 20, v = 20;
var source = p.newdefault(h,v,"cycle~", "440");
var sdel = p.newdefault(h+100,v, "sig~", 2.0);
var sfeed= p.newdefault(h+200,v, "sig~", 0.5);
var newdel;
v += 30;
for(i = 0; i < ocnt; i++){
    newdel = p.newdefault(h,v,"vdelay~", 10, 10, 0.5);
    p.connect(source, 0, newdel, 0);
    p.connect(sdel,0, newdel,1);
    p.connect(sfeed,0, newdel,2);
    v++;
    h++;
}
}

// just delay connected to 200 vpdelay~ objects
function build_delay_connected()
{
var i;
var h = 20, v = 20;
var source = p.newdefault(h,v,"cycle~", "440");
var sdel = p.newdefault(h+160,v, "sig~", 2.0);
var newdel;
v += 30;
for(i = 0; i < ocnt; i++){
    newdel = p.newdefault(h,v,"vpdelay~", 10, 10, 0.5);
    p.connect(source, 0, newdel, 0);
    p.connect(sdel,0, newdel,1);
    v++;
    h++;
}
}

// 200 vpdelay objects with no connections
function build_neither_connected()
{
var i;
var h = 20, v = 20;
var source = p.newdefault(h,v,"cycle~", "440");
var newdel;
v += 30;
for(i = 0; i < ocnt; i++){
    newdel = p.newdefault(h,v,"vpdelay~", 10, 10, 0.5);
    p.connect(source, 0, newdel, 0);
    v++;
    h++;
}
}

// 200 vpdelay~ objects with just feedback connected
function build_feedback_connected()
{
var i;
var h = 20, v = 20;
var source = p.newdefault(h,v,"cycle~", "440");
var sfeed= p.newdefault(h+200,v, "sig~", 0.5);
var newdel;
v += 30;
for(i = 0; i < ocnt; i++){
    newdel = p.newdefault(h,v,"vpdelay~", 10, 10, 0.5);
    p.connect(source, 0, newdel, 0);
    p.connect(sfeed,0, newdel,2);
    v++;
    h++;
}
}

// 200 vpdelay~ objects with both connected
function build_both_connected()
{
var i;
var h = 20, v = 20;
var source = p.newdefault(h,v,"cycle~", "440");
var sdel = p.newdefault(h+100,v, "sig~", 2.0);
var sfeed= p.newdefault(h+200,v, "sig~", 0.5);
var newdel;
v += 30;
for(i = 0; i < ocnt; i++){
    newdel = p.newdefault(h,v,"vpdelay~", 10, 10, 0.5);
    p.connect(source, 0, newdel, 0);
    p.connect(sdel,0, newdel,1);
    p.connect(sfeed,0, newdel,2);
    v++;
    h++;
}
}

// 200 comb~ units for comparison
function build_combs_both_connected()
{
var i;
var h = 20, v = 20;
var source = p.newdefault(h,v,"cycle~", "440");
var sdel = p.newdefault(h+60,v, "sig~", 2.0);
var sfeed= p.newdefault(h+120,v, "sig~", 0.5);
var newdel;
v += 30;
for(i = 0; i < ocnt; i++){
    newdel = p.newdefault(h,v,"comb~", 10, 10, 1.0, 0.0, 0.5);
    p.connect(source, 0, newdel, 0);
    p.connect(sdel,0, newdel,1);
    p.connect(sfeed,0, newdel,4);
    v++;
    h++;
}
}
