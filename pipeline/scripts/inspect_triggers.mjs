import fs from 'fs';

function inspectPatch(file) {
  const p = JSON.parse(fs.readFileSync(file, 'utf8'));
  const boxMap = new Map();
  p.patcher.boxes.forEach(b => {
    if (b.box && b.box.id) boxMap.set(b.box.id, b.box);
  });

  console.log(`\n=== Lineas salientes de triggers en ${file} ===`);
  p.patcher.lines.forEach(l => {
    const pl = l.patchline;
    if (pl.source[0].includes('trig') || pl.source[0].startsWith('t ')) {
      const srcBox = boxMap.get(pl.source[0]);
      const destBox = boxMap.get(pl.destination[0]);
      console.log(`  Source: ${pl.source[0]} (${srcBox ? srcBox.text : '?'}) outlet ${pl.source[1]} -> Dest: ${pl.destination[0]} (${destBox ? (destBox.text || destBox.maxclass) : '?'}) inlet ${pl.destination[1]}`);
    }
  });
}

inspectPatch('book/public/patches/modulo-01/proyecto_01_secuenciador.maxpat');
inspectPatch('book/public/patches/modulo-03/laboratorio_10_sintesis_fm.maxpat');
inspectPatch('book/public/patches/modulo-03/proyecto_03_sintetizador_fm.maxpat');
