import { execSync } from 'child_process';
import fs from 'fs';

function checkOrig(relPath, srcId) {
  const oldJson = execSync(`git show cf4ed04~1:${relPath}`, { encoding: 'utf8' });
  const patch = JSON.parse(oldJson);
  console.log(`\n--- CONEXIONES ORIGINALES DE ${srcId} EN ${relPath} ---`);
  patch.patcher.lines.forEach(l => {
    if (l.patchline.source[0] === srcId) {
      console.log(`Outlet ${l.patchline.source[1]} -> Destino: ${l.patchline.destination[0]} (inlet ${l.patchline.destination[1]})`);
    }
  });
}

checkOrig('book/public/patches/modulo-01/proyecto_01_secuenciador.maxpat', 'obj-16');
checkOrig('book/public/patches/modulo-03/laboratorio_10_sintesis_fm.maxpat', 'obj-13');
