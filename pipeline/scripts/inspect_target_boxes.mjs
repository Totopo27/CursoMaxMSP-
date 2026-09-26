import fs from 'fs';

function inspect(patchPath) {
  const p = JSON.parse(fs.readFileSync(patchPath, 'utf8'));
  console.log(`\n=== Parche: ${patchPath} ===`);
  p.patcher.boxes.forEach(b => {
    const box = b.box;
    if (['obj-11', 'obj-12', 'obj-16', 'obj-17', 'obj-20'].includes(box.id)) {
      console.log(`  Box ${box.id}: maxclass=${box.maxclass}, text="${box.text}"`);
    }
  });
}

inspect('book/public/patches/modulo-01/proyecto_01_secuenciador.maxpat');
inspect('book/public/patches/modulo-03/laboratorio_10_sintesis_fm.maxpat');
inspect('book/public/patches/modulo-03/proyecto_03_sintetizador_fm.maxpat');
