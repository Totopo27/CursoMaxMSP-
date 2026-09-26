/**
 * Script de Optimización Quirúrgica para Módulos 04, 05, 06 y Apéndices:
 * - voz_sintetizador_completo.maxpat: trigger en mtof
 * - laboratorio_17_multicore.maxpat: triggers en distribución de notas poly~
 * - laboratorio_12_filtros.maxpat: trigger en loadbang
 * - laboratorio_18_gen_basics.maxpat / laboratorio_19_genexpr.maxpat: trigger en loadbang
 * - subsynth.osc~.maxpat: trigger en inlet frecuencia hacia osciladores
 * - lab_apendice_h_lom_clip_trigger.maxpat: trigger en live.thisdevice
 */
import fs from 'fs';
import path from 'path';

const PATCHES_BASE = 'D:/DocumentosDiscoD/CursoMaxMSP/book/public/patches';

// 1. voz_sintetizador_completo.maxpat
function fixVozSintetizador() {
  const p = path.join(PATCHES_BASE, 'modulo-04/voz_sintetizador_completo.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

  // obj-3 [mtof] iba a saw~ (obj-4) y a [* 1.002] (obj-5) sin trigger
  const trigBox = {
    box: {
      id: "obj-3-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 2,
      outlettype: [ "float", "float" ],
      patching_rect: [ 100.0, 160.0, 45.0, 22.0 ],
      text: "t f f"
    }
  };
  patch.patcher.boxes.push(trigBox);

  // Filtrar lineas de obj-3
  patch.patcher.lines = patch.patcher.lines.filter(l => {
    const pl = l.patchline;
    return !(pl.source[0] === 'obj-3' && pl.source[1] === 0);
  });

  patch.patcher.lines.push({
    patchline: { destination: [ "obj-3-trig", 0 ], source: [ "obj-3", 0 ] }
  });
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-5", 0 ], source: [ "obj-3-trig", 1 ] } // * 1.002
  });
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-4", 0 ], source: [ "obj-3-trig", 0 ] } // saw~
  });

  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] modulo-04/voz_sintetizador_completo.maxpat: [mtof] blindado con [t f f].');
}

// 2. subsynth.osc~.maxpat
function fixSubsynthOsc() {
  const p = path.join(PATCHES_BASE, 'modulo-04/subsynth.osc~.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

  // obj-in-freq iba a saw~, tri~, rect~
  const trigBox = {
    box: {
      id: "obj-in-freq-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 3,
      outlettype: [ "float", "float", "float" ],
      patching_rect: [ 80.0, 60.0, 50.0, 22.0 ],
      text: "t f f f"
    }
  };
  patch.patcher.boxes.push(trigBox);

  // Reconectar
  const oldLines = patch.patcher.lines.filter(l => {
    return !(l.patchline.source[0] === 'obj-in-freq' && l.patchline.source[1] === 0);
  });

  oldLines.push({
    patchline: { destination: [ "obj-in-freq-trig", 0 ], source: [ "obj-in-freq", 0 ] }
  });
  oldLines.push({
    patchline: { destination: [ "obj-osc-saw", 0 ], source: [ "obj-in-freq-trig", 2 ] }
  });
  oldLines.push({
    patchline: { destination: [ "obj-osc-tri", 0 ], source: [ "obj-in-freq-trig", 1 ] }
  });
  oldLines.push({
    patchline: { destination: [ "obj-osc-rect", 0 ], source: [ "obj-in-freq-trig", 0 ] }
  });

  patch.patcher.lines = oldLines;
  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] modulo-04/subsynth.osc~.maxpat: osciladores alimentados vía [t f f f].');
}

// 3. laboratorio_18_gen_basics.maxpat & laboratorio_19_genexpr.maxpat
function fixGenLoadbangs() {
  ['modulo-05/laboratorio_18_gen_basics.maxpat', 'modulo-05/laboratorio_19_genexpr.maxpat'].forEach(rel => {
    const p = path.join(PATCHES_BASE, rel);
    const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

    // obj-15 [loadbang] iba a 2 mensajes
    const trigBox = {
      box: {
        id: "obj-15-trig",
        maxclass: "newobj",
        numinlets: 1,
        numoutlets: 2,
        outlettype: [ "bang", "bang" ],
        patching_rect: [ 40.0, 150.0, 45.0, 22.0 ],
        text: "t b b"
      }
    };
    patch.patcher.boxes.push(trigBox);

    // Identificar a qué iba obj-15
    const targets = [];
    patch.patcher.lines.forEach(l => {
      if (l.patchline.source[0] === 'obj-15' && l.patchline.source[1] === 0) {
        targets.push(l.patchline.destination[0]);
      }
    });

    patch.patcher.lines = patch.patcher.lines.filter(l => !(l.patchline.source[0] === 'obj-15' && l.patchline.source[1] === 0));

    patch.patcher.lines.push({
      patchline: { destination: [ "obj-15-trig", 0 ], source: [ "obj-15", 0 ] }
    });
    if (targets.length >= 2) {
      patch.patcher.lines.push({
        patchline: { destination: [ targets[1], 0 ], source: [ "obj-15-trig", 1 ] }
      });
      patch.patcher.lines.push({
        patchline: { destination: [ targets[0], 0 ], source: [ "obj-15-trig", 0 ] }
      });
    }

    fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
    console.log(`[OK] ${rel}: loadbang inicializado con [t b b].`);
  });
}

// 4. lab_apendice_h_lom_clip_trigger.maxpat
function fixLabH() {
  const p = path.join(PATCHES_BASE, 'apendices/lab_apendice_h_lom_clip_trigger.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

  // obj-live-thisdevice outlet 2 iba a 2 paths
  const trigBox = {
    box: {
      id: "obj-thisdev-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 2,
      outlettype: [ "bang", "bang" ],
      patching_rect: [ 80.0, 160.0, 45.0, 22.0 ],
      text: "t b b"
    }
  };
  patch.patcher.boxes.push(trigBox);

  const targets = [];
  patch.patcher.lines.forEach(l => {
    if (l.patchline.source[0] === 'obj-live-thisdevice' && l.patchline.source[1] === 2) {
      targets.push(l.patchline.destination[0]);
    }
  });

  patch.patcher.lines = patch.patcher.lines.filter(l => !(l.patchline.source[0] === 'obj-live-thisdevice' && l.patchline.source[1] === 2));

  patch.patcher.lines.push({
    patchline: { destination: [ "obj-thisdev-trig", 0 ], source: [ "obj-live-thisdevice", 2 ] }
  });
  if (targets.length >= 2) {
    patch.patcher.lines.push({
      patchline: { destination: [ targets[1], 0 ], source: [ "obj-thisdev-trig", 1 ] }
    });
    patch.patcher.lines.push({
      patchline: { destination: [ targets[0], 0 ], source: [ "obj-thisdev-trig", 0 ] }
    });
  }

  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] apendices/lab_apendice_h_lom_clip_trigger.maxpat: live.thisdevice secuenciado con [t b b].');
}

fixVozSintetizador();
fixSubsynthOsc();
fixGenLoadbangs();
fixLabH();
