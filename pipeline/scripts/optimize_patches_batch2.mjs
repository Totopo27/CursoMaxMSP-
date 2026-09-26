/**
 * Script de Optimización Módulo 03:
 * laboratorio_10_sintesis_fm.maxpat y proyecto_03_sintetizador_fm.maxpat
 */
import fs from 'fs';
import path from 'path';

const PATCHES_BASE = 'D:/DocumentosDiscoD/CursoMaxMSP/book/public/patches';

// 1. laboratorio_10_sintesis_fm.maxpat
function fixLab10FM() {
  const p = path.join(PATCHES_BASE, 'modulo-03/laboratorio_10_sintesis_fm.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

  // En Lab 10:
  // obj-4 (flonum Fc) bifurca a [* 1.] y [+~ 220.] -> Intercalar [t f f]
  // obj-13 (loadbang) bifurca a mensajes -> Intercalar [t b b b]
  // obj-14 ([* 1.] Fm) bifurca a flonum y [* 0.] -> Intercalar [t f f]
  // obj-28 ([*~ 0.3]) va a spectroscope~, scope~ y gain~ (es señal de audio, seguro pero podemos limpiar o dejar)
  
  // Agregar trigger para obj-4
  const tObj4 = {
    box: {
      id: "obj-4-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 2,
      outlettype: [ "float", "float" ],
      patching_rect: [ 180.0, 205.0, 45.0, 22.0 ],
      text: "t f f"
    }
  };
  patch.patcher.boxes.push(tObj4);

  // Agregar trigger para obj-13 (loadbang)
  const tObj13 = {
    box: {
      id: "obj-13-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 3,
      outlettype: [ "bang", "bang", "bang" ],
      patching_rect: [ 40.0, 115.0, 50.0, 22.0 ],
      text: "t b b b"
    }
  };
  patch.patcher.boxes.push(tObj13);

  // Reconectar lineas de obj-4
  patch.patcher.lines = patch.patcher.lines.filter(l => {
    const pl = l.patchline;
    if (pl.source[0] === 'obj-4' && pl.source[1] === 0) return false;
    if (pl.source[0] === 'obj-13' && pl.source[1] === 0) return false;
    return true;
  });

  // Conectar obj-4 a obj-4-trig
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-4-trig", 0 ], source: [ "obj-4", 0 ] }
  });
  // Salida 0 (izquierda) a +~ 220. (obj-24)
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-24", 0 ], source: [ "obj-4-trig", 0 ] }
  });
  // Salida 1 (derecha) a * 1. (obj-14)
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-14", 0 ], source: [ "obj-4-trig", 1 ] }
  });

  // Conectar obj-13 a obj-13-trig
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-13-trig", 0 ], source: [ "obj-13", 0 ] }
  });
  // Conectar salidas de trigger a los mensajes de inicializacion
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-11", 0 ], source: [ "obj-13-trig", 2 ] } // 220.
  });
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-12", 0 ], source: [ "obj-13-trig", 1 ] } // 1.0
  });
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-16", 0 ], source: [ "obj-13-trig", 0 ] } // flonum index
  });

  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] modulo-03/laboratorio_10_sintesis_fm.maxpat optimizado con [t].');
}

// 2. proyecto_03_sintetizador_fm.maxpat
function fixProyecto03FM() {
  const p = path.join(PATCHES_BASE, 'modulo-03/proyecto_03_sintetizador_fm.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

  // obj-4 (kslider) outlet 1 (velocidad) iba a dos adsr~ -> Intercalar [t f f]
  const tObj4Vel = {
    box: {
      id: "obj-4-vel-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 2,
      outlettype: [ "float", "float" ],
      patching_rect: [ 100.0, 160.0, 45.0, 22.0 ],
      text: "t f f"
    }
  };
  patch.patcher.boxes.push(tObj4Vel);

  // obj-6 (flonum) iba a [* 1.] y [+~ 220.] -> Intercalar [t f f]
  const tObj6 = {
    box: {
      id: "obj-6-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 2,
      outlettype: [ "float", "float" ],
      patching_rect: [ 220.0, 205.0, 45.0, 22.0 ],
      text: "t f f"
    }
  };
  patch.patcher.boxes.push(tObj6);

  // Reconectar
  patch.patcher.lines = patch.patcher.lines.filter(l => {
    const pl = l.patchline;
    if (pl.source[0] === 'obj-4' && pl.source[1] === 1) return false;
    if (pl.source[0] === 'obj-6' && pl.source[1] === 0) return false;
    return true;
  });

  // kslider vel
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-4-vel-trig", 0 ], source: [ "obj-4", 1 ] }
  });
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-16", 0 ], source: [ "obj-4-vel-trig", 1 ] } // adsr mod
  });
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-17", 0 ], source: [ "obj-4-vel-trig", 0 ] } // adsr carrier
  });

  // flonum carrier freq
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-6-trig", 0 ], source: [ "obj-6", 0 ] }
  });
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-10", 0 ], source: [ "obj-6-trig", 1 ] } // * 1.
  });
  patch.patcher.lines.push({
    patchline: { destination: [ "obj-23", 0 ], source: [ "obj-6-trig", 0 ] } // +~ 220.
  });

  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] modulo-03/proyecto_03_sintetizador_fm.maxpat optimizado con [t].');
}

fixLab10FM();
fixProyecto03FM();
