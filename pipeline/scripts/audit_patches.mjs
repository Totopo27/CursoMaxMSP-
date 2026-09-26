/**
 * Script de Auditoría Estática para Parches de Max/MSP (.maxpat)
 * Basado en las reglas de OptimizandoParaMaxSDK y Cycling '74 SDK
 */
import fs from 'fs';
import path from 'path';

const PATCHES_DIR = 'D:/DocumentosDiscoD/CursoMaxMSP/book/public/patches';

// Objetos MSP que hacen auto-summing nativo en sus entradas de señal
const MSP_OBJECTS = new Set([
  '*~', '/~', '+~', '-~', 'sig~', 'cycle~', 'phasor~', 'tri~', 'rect~', 'saw~',
  'biquad~', 'lores~', 'svf~', 'reson~', 'teeth~', 'comb~', 'allpass~',
  'delay~', 'tapin~', 'tapout~', 'groove~', 'play~', 'wave~', 'buffer~',
  'line~', 'curve~', 'rampsmooth~', 'average~', 'peakamp~', 'snapshot~',
  'gain~', 'live.gain~', 'ezdac~', 'ezadc~', 'dac~', 'adc~', 'send~', 'receive~',
  'plugin~', 'poly~', 'pfft~', 'gen~'
]);

function analyzePatch(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  let patch;
  try {
    patch = JSON.parse(content);
  } catch (err) {
    return { error: 'JSON_PARSE_ERROR', details: err.message };
  }

  const patcher = patch.patcher;
  if (!patcher) return { error: 'NO_PATCHER_KEY' };

  const boxes = patcher.boxes || [];
  const lines = patcher.lines || [];

  const findings = [];
  const boxMap = new Map();

  // Mapear cajas
  boxes.forEach(b => {
    const box = b.box;
    if (box && box.id) {
      boxMap.set(box.id, box);
    }
  });

  // 1. Verificar objetos específicos (coll @embed 1, dial @size, etc.)
  boxes.forEach(b => {
    const box = b.box;
    if (!box) return;

    const maxclass = box.maxclass || '';
    const text = box.text || '';
    const tokens = text.split(/\s+/);
    const objName = tokens[0];

    // Regla coll: debe tener @embed 1 si se espera persistencia
    if (objName === 'coll' && !text.includes('@embed 1')) {
      findings.push({
        type: 'PERSISTENCE_WARNING',
        severity: 'MEDIUM',
        boxId: box.id,
        text: text,
        message: 'Objeto [coll] sin atributo [@embed 1]. Los datos se perderán al cerrar el parche a menos que se cargue de un archivo externo.'
      });
    }

    // Regla dial: tamaño > 255 degrada UI o dial sin floatoutput cuando se necesita float
    if (maxclass === 'dial') {
      const sizeAttr = box.size !== undefined ? box.size : (box.min !== undefined && box.size ? box.size : null);
      if (sizeAttr && sizeAttr > 255) {
        findings.push({
          type: 'UI_DEGRADATION',
          severity: 'LOW',
          boxId: box.id,
          message: `Objeto [dial] con size ${sizeAttr} (> 255). La interfaz visual puede degradarse.`
        });
      }
    }

    // Regla unpack con argumentos numéricos sin tipo explícito
    if (objName === 'unpack') {
      const args = tokens.slice(1);
      const hasBareInts = args.some(a => /^\d+$/.test(a));
      if (hasBareInts) {
        findings.push({
          type: 'DATA_TYPE_GOTCHA',
          severity: 'LOW',
          boxId: box.id,
          text: text,
          message: 'Objeto [unpack] usando enteros crudos sin tipo float o especificador ("f"). Si entran floats, serán truncados a int.'
        });
      }
    }
  });

  // 2. Mapear conexiones de salida por outlet
  // boxId -> outletIndex -> array de destinos [{destId, destInlet}]
  const outletConnections = new Map();

  lines.forEach(l => {
    const line = l.patchline;
    if (!line) return;

    const srcId = line.source[0];
    const srcOutlet = line.source[1];
    const destId = line.destination[0];
    const destInlet = line.destination[1];

    if (!outletConnections.has(srcId)) {
      outletConnections.set(srcId, new Map());
    }
    const srcOutlets = outletConnections.get(srcId);
    if (!srcOutlets.has(srcOutlet)) {
      srcOutlets.set(srcOutlet, []);
    }
    srcOutlets.get(srcOutlet).push({ destId, destInlet });
  });

  // 3. Detectar bifurcaciones múltiples sin trigger (Race Condition / Order of Execution)
  outletConnections.forEach((outlets, srcId) => {
    const srcBox = boxMap.get(srcId);
    if (!srcBox) return;

    const srcText = srcBox.text || srcBox.maxclass || '';
    const srcClass = srcBox.maxclass || '';

    // Ignorar si el objeto emisor es de audio (señales MSP se transmiten sincrónicamente por vectores)
    const isSignalSrc = srcText.endsWith('~') || srcClass.endsWith('~');
    if (isSignalSrc) return;

    // Ignorar comentarios, metros directos si disparan cosas independientes, etc., pero revisar bifurcaciones
    outlets.forEach((dests, outletIdx) => {
      if (dests.length > 1) {
        // Verificar si los destinos son inlets calientes (inlet 0 casi siempre)
        const hotDestCount = dests.filter(d => d.destInlet === 0).length;
        if (hotDestCount > 1) {
          // Si el objeto fuente NO es trigger ni t
          if (!srcText.startsWith('t ') && !srcText.startsWith('trigger ') && srcText !== 't' && srcText !== 'trigger') {
            const destDetails = dests.map(d => {
              const b = boxMap.get(d.destId);
              return b ? `[${b.text || b.maxclass} (inlet ${d.destInlet})]` : `ID:${d.destId}`;
            }).join(', ');

            findings.push({
              type: 'RACE_CONDITION_RISK',
              severity: 'HIGH',
              boxId: srcId,
              sourceText: srcText,
              outlet: outletIdx,
              message: `Bifurcación múltiple (${dests.length} destinos, ${hotDestCount} inlets calientes) desde el outlet ${outletIdx} de [${srcText}] sin usar [trigger]. Depende del orden espacial Right-to-Left susceptible a bugs: ${destDetails}`
            });
          }
        }
      }
    });
  });

  // 4. Detectar antipatrón de sumado innecesario con [+~]
  boxes.forEach(b => {
    const box = b.box;
    if (!box) return;
    const text = box.text || '';
    if (text === '+~' || text.startsWith('+~ ')) {
      // Ver si las salidas de +~ van a un inlet de un objeto MSP que ya auto-suma
      const outlets = outletConnections.get(box.id);
      if (outlets && outlets.has(0)) {
        const dests = outlets.get(0);
        dests.forEach(d => {
          const destBox = boxMap.get(d.destId);
          if (destBox) {
            const destText = destBox.text || destBox.maxclass || '';
            const destName = destText.split(/\s+/)[0];
            if (MSP_OBJECTS.has(destName) && d.destInlet === 0 && destName !== 'dac~' && destName !== 'ezdac~') {
              // Si el destino es un objeto que ya hace sumado automático, evaluar si +~ era redundante
              findings.push({
                type: 'REDUNDANT_SUM_MSP',
                severity: 'LOW',
                boxId: box.id,
                message: `Uso de [+~] alimentando [${destText} (inlet ${d.destInlet})]. Max MSP realiza sumado automático (auto-summing) en inlets de señal; verificar si este [+~] es redundante.`
              });
            }
          }
        });
      }
    }
  });

  return {
    boxesCount: boxes.length,
    linesCount: lines.length,
    findings: findings
  };
}

// Escanear todos los parches recursivamente
function scanDir(dir) {
  const files = fs.readdirSync(dir);
  let results = {};

  files.forEach(f => {
    const fullPath = path.join(dir, f);
    const stat = fs.statSync(fullPath);
    if (stat.isDirectory()) {
      Object.assign(results, scanDir(fullPath));
    } else if (f.endsWith('.maxpat')) {
      const relPath = path.relative(PATCHES_DIR, fullPath).replace(/\\/g, '/');
      results[relPath] = analyzePatch(fullPath);
    }
  });

  return results;
}

const audit = scanDir(PATCHES_DIR);
console.log(JSON.stringify(audit, null, 2));
