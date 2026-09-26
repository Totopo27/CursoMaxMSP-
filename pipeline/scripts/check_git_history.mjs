import { execSync } from 'child_process';
import fs from 'fs';

// Leer version del commit previo a nuestras modificaciones
const oldJson = execSync('git show cf4ed04~1:book/public/patches/modulo-03/proyecto_03_sintetizador_fm.maxpat', { encoding: 'utf8' });
const patch = JSON.parse(oldJson);

console.log('--- LINEAS ORIGINALES DEL KSLIDER (obj-4) ---');
patch.patcher.lines.forEach(l => {
  if (l.patchline.source[0] === 'obj-4') {
    console.log(`Outlet ${l.patchline.source[1]} -> Destino: ${l.patchline.destination[0]} (inlet ${l.patchline.destination[1]})`);
  }
});
