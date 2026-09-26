import fs from 'fs';

const filePath = 'book/public/patches/apendices/lab_apendice_g_casos_estudio.maxpat';
const patch = JSON.parse(fs.readFileSync(filePath, 'utf8'));

// 1. Añadir @embed 1 a coll
patch.patcher.boxes.forEach(b => {
  if (b.box && b.box.text && b.box.text.startsWith('coll') && !b.box.text.includes('@embed 1')) {
    b.box.text += ' @embed 1';
    console.log('[OK] @embed 1 añadido a coll en lab_apendice_g_casos_estudio.maxpat');
  }
});

// 2. Resolver race condition en [number] -> noteout y jsui
patch.patcher.boxes.forEach(b => {
  if (b.box && b.box.maxclass === 'number') {
    const srcId = b.box.id;
    const linesFromSrc = patch.patcher.lines.filter(l => l.patchline.source[0] === srcId);
    if (linesFromSrc.length >= 2) {
      const trigBox = {
        box: {
          id: `${srcId}-trig`,
          maxclass: "newobj",
          numinlets: 1,
          numoutlets: 2,
          outlettype: [ "int", "int" ],
          patching_rect: [ b.box.patching_rect[0], b.box.patching_rect[1] + 25, 45.0, 22.0 ],
          text: "t i i"
        }
      };
      patch.patcher.boxes.push(trigBox);

      const dest0 = linesFromSrc[0].patchline;
      const dest1 = linesFromSrc[1].patchline;

      patch.patcher.lines = patch.patcher.lines.filter(l => l.patchline.source[0] !== srcId);

      patch.patcher.lines.push({
        patchline: { destination: [ `${srcId}-trig`, 0 ], source: [ srcId, 0 ] }
      });
      patch.patcher.lines.push({
        patchline: { destination: [ dest1.destination[0], dest1.destination[1] ], source: [ `${srcId}-trig`, 1 ] }
      });
      patch.patcher.lines.push({
        patchline: { destination: [ dest0.destination[0], dest0.destination[1] ], source: [ `${srcId}-trig`, 0 ] }
      });
      console.log(`[OK] Intercalado [t i i] para ${srcId} en lab_apendice_g_casos_estudio.maxpat`);
    }
  }
});

fs.writeFileSync(filePath, JSON.stringify(patch, null, '\t'), 'utf8');
