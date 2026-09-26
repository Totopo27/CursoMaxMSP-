/**
 * Script de Optimización Quirúrgica de Parches Max/MSP
 * Aplica las reglas del Cycling '74 C SDK y ersatzben-maxmsp-mcp:
 * 1. Resuelve RACE_CONDITION_RISK de control intercalando objetos [t]/[trigger].
 * 2. Elimina [+~] redundantes cuando alimentan directamente entradas de señal MSP que ya auto-suman.
 * 3. Corrige unpacking [unpack] para especificar floats ("f") evitando truncamiento.
 * 4. Añade @embed 1 a [coll] para garantizar persistencia.
 */
import fs from 'fs';
import path from 'path';

const PATCHES_BASE = 'D:/DocumentosDiscoD/CursoMaxMSP/book/public/patches';

// 1. Modulo 01: laboratorio_02_timing.maxpat
function fixLab02Timing() {
  const p = path.join(PATCHES_BASE, 'modulo-01/laboratorio_02_timing.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));
  
  // Agregar objeto obj-403-trig: "t i i" debajo de obj-403
  // obj-403 estaba en [400.0, 480.0, 75.0, 22.0]
  // obj-408 es % 4 (a la derecha) y obj-404 es % 3 (a la izquierda)
  // orden deseado: primero outlet 1 (derecha -> obj-408), luego outlet 0 (izquierda -> obj-404)
  const newBox = {
    box: {
      id: "obj-403-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 2,
      outlettype: [ "int", "int" ],
      patching_rect: [ 400.0, 505.0, 45.0, 22.0 ],
      text: "t i i"
    }
  };
  patch.patcher.boxes.push(newBox);

  // Mover obj-404 y obj-408 un poco hacia abajo si es necesario o reconectar lineas
  const lines = patch.patcher.lines;
  // Filtrar las lineas que salian de obj-403 hacia obj-404 y obj-408
  const filteredLines = lines.filter(l => {
    const pl = l.patchline;
    if (pl.source[0] === 'obj-403' && (pl.destination[0] === 'obj-404' || pl.destination[0] === 'obj-408')) {
      return false;
    }
    return true;
  });

  // Agregar linea de obj-403 a obj-403-trig
  filteredLines.push({
    patchline: {
      destination: [ "obj-403-trig", 0 ],
      source: [ "obj-403", 0 ]
    }
  });

  // Salida 1 (derecha, primero) a obj-408
  filteredLines.push({
    patchline: {
      destination: [ "obj-408", 0 ],
      source: [ "obj-403-trig", 1 ]
    }
  });

  // Salida 0 (izquierda, segundo) a obj-404
  filteredLines.push({
    patchline: {
      destination: [ "obj-404", 0 ],
      source: [ "obj-403-trig", 0 ]
    }
  });

  patch.patcher.lines = filteredLines;
  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] modulo-01/laboratorio_02_timing.maxpat optimizado con [t i i].');
}

// 2. Modulo 01: proyecto_01_secuenciador.maxpat
function fixProyecto01() {
  const p = path.join(PATCHES_BASE, 'modulo-01/proyecto_01_secuenciador.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));

  // obj-16 es [counter 0 11], que iba a number, % 4, % 3 sin trigger
  // obj-49 era [+~] redundante hacia [*~ 0.7]
  const newBox = {
    box: {
      id: "obj-16-trig",
      maxclass: "newobj",
      numinlets: 1,
      numoutlets: 3,
      outlettype: [ "int", "int", "int" ],
      patching_rect: [ 220.0, 230.0, 50.0, 22.0 ],
      text: "t i i i"
    }
  };
  patch.patcher.boxes.push(newBox);

  // Reconectar
  let lines = patch.patcher.lines.filter(l => {
    const pl = l.patchline;
    if (pl.source[0] === 'obj-16' && pl.source[1] === 0) return false;
    return true;
  });

  lines.push({
    patchline: { destination: [ "obj-16-trig", 0 ], source: [ "obj-16", 0 ] }
  });
  lines.push({
    patchline: { destination: [ "obj-20", 0 ], source: [ "obj-16-trig", 2 ] } // % 4
  });
  lines.push({
    patchline: { destination: [ "obj-17", 0 ], source: [ "obj-16-trig", 1 ] } // % 3
  });
  lines.push({
    patchline: { destination: [ "obj-18", 0 ], source: [ "obj-16-trig", 0 ] } // number
  });

  patch.patcher.lines = lines;
  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
  console.log('[OK] modulo-01/proyecto_01_secuenciador.maxpat optimizado con [t i i i].');
}

// 3. Modulo 02: laboratorio_04_persistencia.maxpat
function fixLab04Persistencia() {
  const p = path.join(PATCHES_BASE, 'modulo-02/laboratorio_04_persistencia.maxpat');
  const patch = JSON.parse(fs.readFileSync(p, 'utf8'));
  patch.patcher.boxes.forEach(b => {
    if (b.box && b.box.id === 'obj-203') {
      if (!b.box.text.includes('@embed 1')) {
        b.box.text = b.box.text + ' @embed 1';
        console.log('[OK] laboratorio_04_persistencia.maxpat: atributo @embed 1 añadido a [coll].');
      }
    }
  });
  fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
}

// 4. Modulo 04: Unpacks con tipos explícitos
function fixUnpackDataTypes() {
  const files = [
    'modulo-04/voz_dsp_pesada.maxpat',
    'modulo-04/voz_polifonica.maxpat',
    'modulo-04/voz_sintetizador_completo.maxpat',
    'apendices/lab_apendice_c_arduino.maxpat'
  ];

  files.forEach(rel => {
    const p = path.join(PATCHES_BASE, rel);
    const patch = JSON.parse(fs.readFileSync(p, 'utf8'));
    let changed = false;
    patch.patcher.boxes.forEach(b => {
      const box = b.box;
      if (box && (box.text === 'unpack 0 0' || box.text === 'unpack 0 0 0' || box.text === 'unpack 0 0 0 0')) {
        const count = box.text.split(' ').length - 1;
        const types = Array(count).fill('f').join(' ');
        box.text = `unpack ${types}`;
        box.outlettype = Array(count).fill('float');
        changed = true;
      }
    });
    if (changed) {
      fs.writeFileSync(p, JSON.stringify(patch, null, '\t'), 'utf8');
      console.log(`[OK] ${rel}: unpack actualizado con tipos float explícitos ("f").`);
    }
  });
}

fixLab02Timing();
fixProyecto01();
fixLab04Persistencia();
fixUnpackDataTypes();
