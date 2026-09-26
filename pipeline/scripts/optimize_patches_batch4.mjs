/**
 * Script de Optimización Quirúrgica Final para Parches Max:
 * Corrige los 5 Race Conditions restantes:
 * 1. modulo-01/laboratorio_01.maxpat ([number] -> [+ 0 inlet 1], [+ 0 inlet 0])
 * 2. modulo-03/laboratorio_10_sintesis_fm.maxpat ([* 1.] -> [flonum], [* 0.])
 * 3. modulo-03/laboratorio_11_envolventes.maxpat ([button] -> 2 mensajes de envelope)
 * 4. modulo-03/laboratorio_12_filtros.maxpat ([loadbang] -> 800., 0.8)
 * 5. modulo-04/laboratorio_17_multicore.maxpat ([button] -> 2 acordes)
 */
import fs from 'fs';
import path from 'path';

const PATCHES_BASE = 'D:/DocumentosDiscoD/CursoMaxMSP/book/public/patches';

// 1. modulo-01/laboratorio_01.maxpat
function fixLab01() {
  const p = path.join(PATCHES_BASE, 'modulo-01/laboratorio_01.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

  // Buscar el number que bifurca a los inlets de [+ 0]
  // El inlet 1 es frío (estado), inlet 0 es caliente (disparo).
  // ¡Caso de libro de texto de Max! Debe enviarse PRIMERO a inlet 1 y LUEGO a inlet 0 -> [t i i]
  patch.patcher.boxes.forEach(b => {
    if (b.box && b.box.maxclass === 'number') {
      const srcId = b.box.id;
      const linesFromSrc = patch.patcher.lines.filter(l => l.patchline.source[0] === srcId);
      if (linesFromSrc.length >= 2) {
        // Encontramos el number
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

        // Reconectar: outlet 1 (derecha, primero) al inlet 1 (frio), outlet 0 (izquierda, segundo) al inlet 0 (caliente)
        const destInlet1 = linesFromSrc.find(l => l.patchline.destination[1] === 1);
        const destInlet0 = linesFromSrc.find(l => l.patchline.destination[1] === 0);

        patch.patcher.lines = patch.patcher.lines.filter(l => l.patchline.source[0] !== srcId);

        patch.patcher.lines.push({
          patchline: { destination: [ `${srcId}-trig`, 0 ], source: [ srcId, 0 ] }
        });
        if (destInlet1) {
          patch.patcher.lines.push({
            patchline: { destination: [ destInlet1.patchline.destination[0], 1 ], source: [ `${srcId}-trig`, 1 ] }
          });
        }
        if (destInlet0) {
          patch.patcher.lines.push({
            patchline: { destination: [ destInlet0.patchline.destination[0], 0 ], source: [ `${srcId}-trig`, 0 ] }
          });
        }
      }
    }
  });

  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] modulo-01/laboratorio_01.maxpat resuelto con orden frío->caliente mediante [t i i].');
}

// 2. modulo-03/laboratorio_10_sintesis_fm.maxpat
function fixLab10FmFinal() {
  const p = path.join(PATCHES_BASE, 'modulo-03/laboratorio_10_sintesis_fm.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

  // obj-14 [* 1.] va a flonum y [* 0.]
  const trigBox = {
    box: {
      id: "obj-14-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 2,
      outlettype: [ "float", "float" ],
      patching_rect: [ 180.0, 275.0, 45.0, 22.0 ],
      text: "t f f"
    }
  };
  patch.patcher.boxes.push(trigBox);

  const targets = [];
  patch.patcher.lines.forEach(l => {
    if (l.patchline.source[0] === 'obj-14' && l.patchline.source[1] === 0) {
      targets.push(l.patchline);
    }
  });

  patch.patcher.lines = patch.patcher.lines.filter(l => !(l.patchline.source[0] === 'obj-14' && l.patchline.source[1] === 0));

  patch.patcher.lines.push({
    patchline: { destination: [ "obj-14-trig", 0 ], source: [ "obj-14", 0 ] }
  });
  if (targets.length >= 2) {
    patch.patcher.lines.push({
      patchline: { destination: [ targets[1].destination[0], targets[1].destination[1] ], source: [ "obj-14-trig", 1 ] }
    });
    patch.patcher.lines.push({
      patchline: { destination: [ targets[0].destination[0], targets[0].destination[1] ], source: [ "obj-14-trig", 0 ] }
    });
  }

  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] modulo-03/laboratorio_10_sintesis_fm.maxpat: [* 1.] asegurado con [t f f].');
}

// 3. modulo-03/laboratorio_11_envolventes.maxpat
function fixLab11Env() {
  const p = path.join(PATCHES_BASE, 'modulo-03/laboratorio_11_envolventes.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

  const trigBox = {
    box: {
      id: "obj-4-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 2,
      outlettype: [ "bang", "bang" ],
      patching_rect: [ 40.0, 140.0, 45.0, 22.0 ],
      text: "t b b"
    }
  };
  patch.patcher.boxes.push(trigBox);

  const targets = [];
  patch.patcher.lines.forEach(l => {
    if (l.patchline.source[0] === 'obj-4' && l.patchline.source[1] === 0) {
      targets.push(l.patchline);
    }
  });

  patch.patcher.lines = patch.patcher.lines.filter(l => !(l.patchline.source[0] === 'obj-4' && l.patchline.source[1] === 0));

  patch.patcher.lines.push({
    patchline: { destination: [ "obj-4-trig", 0 ], source: [ "obj-4", 0 ] }
  });
  if (targets.length >= 2) {
    patch.patcher.lines.push({
      patchline: { destination: [ targets[1].destination[0], targets[1].destination[1] ], source: [ "obj-4-trig", 1 ] }
    });
    patch.patcher.lines.push({
      patchline: { destination: [ targets[0].destination[0], targets[0].destination[1] ], source: [ "obj-4-trig", 0 ] }
    });
  }

  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] modulo-03/laboratorio_11_envolventes.maxpat: button disparado con [t b b].');
}

// 4. modulo-03/laboratorio_12_filtros.maxpat
function fixLab12Filtros() {
  const p = path.join(PATCHES_BASE, 'modulo-03/laboratorio_12_filtros.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

  const trigBox = {
    box: {
      id: "obj-33-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 2,
      outlettype: [ "bang", "bang" ],
      patching_rect: [ 40.0, 140.0, 45.0, 22.0 ],
      text: "t b b"
    }
  };
  patch.patcher.boxes.push(trigBox);

  const targets = [];
  patch.patcher.lines.forEach(l => {
    if (l.patchline.source[0] === 'obj-33' && l.patchline.source[1] === 0) {
      targets.push(l.patchline);
    }
  });

  patch.patcher.lines = patch.patcher.lines.filter(l => !(l.patchline.source[0] === 'obj-33' && l.patchline.source[1] === 0));

  patch.patcher.lines.push({
    patchline: { destination: [ "obj-33-trig", 0 ], source: [ "obj-33", 0 ] }
  });
  if (targets.length >= 2) {
    patch.patcher.lines.push({
      patchline: { destination: [ targets[1].destination[0], targets[1].destination[1] ], source: [ "obj-33-trig", 1 ] }
    });
    patch.patcher.lines.push({
      patchline: { destination: [ targets[0].destination[0], targets[0].destination[1] ], source: [ "obj-33-trig", 0 ] }
    });
  }

  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] modulo-03/laboratorio_12_filtros.maxpat: loadbang secuenciado con [t b b].');
}

// 5. modulo-04/laboratorio_17_multicore.maxpat
function fixLab17Multicore() {
  const p = path.join(PATCHES_BASE, 'modulo-04/laboratorio_17_multicore.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

  const trigBox = {
    box: {
      id: "obj-4-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 2,
      outlettype: [ "bang", "bang" ],
      patching_rect: [ 40.0, 140.0, 45.0, 22.0 ],
      text: "t b b"
    }
  };
  patch.patcher.boxes.push(trigBox);

  const targets = [];
  patch.patcher.lines.forEach(l => {
    if (l.patchline.source[0] === 'obj-4' && l.patchline.source[1] === 0) {
      targets.push(l.patchline);
    }
  });

  patch.patcher.lines = patch.patcher.lines.filter(l => !(l.patchline.source[0] === 'obj-4' && l.patchline.source[1] === 0));

  patch.patcher.lines.push({
    patchline: { destination: [ "obj-4-trig", 0 ], source: [ "obj-4", 0 ] }
  });
  if (targets.length >= 2) {
    patch.patcher.lines.push({
      patchline: { destination: [ targets[1].destination[0], targets[1].destination[1] ], source: [ "obj-4-trig", 1 ] }
    });
    patch.patcher.lines.push({
      patchline: { destination: [ targets[0].destination[0], targets[0].destination[1] ], source: [ "obj-4-trig", 0 ] }
    });
  }

  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] modulo-04/laboratorio_17_multicore.maxpat: disparo de acordes secuenciado con [t b b].');
}

fixLab01();
fixLab10FmFinal();
fixLab11Env();
fixLab12Filtros();
fixLab17Multicore();
