import fs from 'fs';

// 1. Corregir proyecto_03_sintetizador_fm.maxpat
// obj-4-vel-trig debe ir a obj-18 (adsr~ carrier) y obj-16 (adsr~ mod), NO a obj-17 (comment)
{
  const pPath = 'book/public/patches/modulo-03/proyecto_03_sintetizador_fm.maxpat';
  const patch = JSON.parse(fs.readFileSync(pPath, 'utf8'));

  // Corregir destino de obj-4-vel-trig outlet 0 -> a obj-18 inlet 0
  patch.patcher.lines.forEach(l => {
    const pl = l.patchline;
    if (pl.source[0] === 'obj-4-vel-trig' && pl.source[1] === 0) {
      pl.destination = ['obj-18', 0];
      console.log('[FIXED] proyecto_03_sintetizador_fm: obj-4-vel-trig conectado a obj-18 (adsr~) en vez de comment obj-17.');
    }
  });
  fs.writeFileSync(pPath, JSON.stringify(patch, null, '\t'), 'utf8');
}

// 2. Corregir laboratorio_10_sintesis_fm.maxpat
// obj-13-trig debe ir a obj-5, obj-8 y obj-12, NO a obj-11 (comment)
{
  const pPath = 'book/public/patches/modulo-03/laboratorio_10_sintesis_fm.maxpat';
  const patch = JSON.parse(fs.readFileSync(pPath, 'utf8'));

  patch.patcher.lines.forEach(l => {
    const pl = l.patchline;
    if (pl.source[0] === 'obj-13-trig') {
      if (pl.source[1] === 2) {
        pl.destination = ['obj-5', 0]; // 220. mensaje
        console.log('[FIXED] laboratorio_10_sintesis_fm: obj-13-trig outlet 2 reconectado a obj-5 en vez de comment obj-11.');
      } else if (pl.source[1] === 1) {
        pl.destination = ['obj-8', 0]; // 1.0 mensaje
      } else if (pl.source[1] === 0) {
        pl.destination = ['obj-12', 0]; // flonum index
      }
    }
  });
  fs.writeFileSync(pPath, JSON.stringify(patch, null, '\t'), 'utf8');
}

// 3. Corregir proyecto_01_secuenciador.maxpat
// obj-16-trig debe ir a obj-17, obj-21 (% 4) y obj-31 (% 3), NO a obj-20 (comment)
{
  const pPath = 'book/public/patches/modulo-01/proyecto_01_secuenciador.maxpat';
  const patch = JSON.parse(fs.readFileSync(pPath, 'utf8'));

  patch.patcher.lines.forEach(l => {
    const pl = l.patchline;
    if (pl.source[0] === 'obj-16-trig') {
      if (pl.source[1] === 2) {
        pl.destination = ['obj-31', 0]; // % 3
        console.log('[FIXED] proyecto_01_secuenciador: obj-16-trig outlet 2 reconectado a obj-31 (% 3) en vez de comment obj-20.');
      } else if (pl.source[1] === 1) {
        pl.destination = ['obj-21', 0]; // % 4
      } else if (pl.source[1] === 0) {
        pl.destination = ['obj-17', 0]; // number
      }
    }
  });
  fs.writeFileSync(pPath, JSON.stringify(patch, null, '\t'), 'utf8');
}
