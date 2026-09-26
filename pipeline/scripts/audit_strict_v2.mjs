/**
 * Script de Auditoría Estática Refinado para Parches de Max/MSP (.maxpat)
 * Distingue apropiadamente:
 * 1. Dominio de SEÑAL MSP (~): No sufre de race conditions R-to-L de Max control,
 *    ya que el motor DSP transmite vectores sincrónicos en perform64.
 * 2. Dominio de CONTROL: Requiere obligatoriamente [trigger] ante bifurcaciones.
 */
import fs from 'fs';
import path from 'path';

const PATCHES_DIR = 'D:/DocumentosDiscoD/CursoMaxMSP/book/public/patches';

const MSP_OBJECTS = new Set([
  '*~', '/~', '+~', '-~', 'sig~', 'cycle~', 'phasor~', 'tri~', 'rect~', 'saw~',
  'biquad~', 'lores~', 'svf~', 'reson~', 'teeth~', 'comb~', 'allpass~',
  'delay~', 'tapin~', 'tapout~', 'groove~', 'play~', 'wave~', 'buffer~',
  'line~', 'curve~', 'rampsmooth~', 'average~', 'peakamp~', 'snapshot~',
  'gain~', 'live.gain~', 'ezdac~', 'ezadc~', 'dac~', 'adc~', 'send~', 'receive~',
  'plugin~', 'poly~', 'pfft~', 'gen~', 'meter~', 'live.meter~', 'scope~', 'spectroscope~'
]);

function isSignalObject(box) {
  if (!box) return false;
  const text = (box.text || '').trim();
  const maxclass = (box.maxclass || '').trim();
  const firstToken = text.split(/\s+/)[0];
  return firstToken.endsWith('~') || maxclass.endsWith('~') || MSP_OBJECTS.has(firstToken);
}

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

  boxes.forEach(b => {
    const box = b.box;
    if (box && box.id) {
      boxMap.set(box.id, box);
    }
  });

  // 1. Verificaciones de objetos específicos
  boxes.forEach(b => {
    const box = b.box;
    if (!box) return;

    const maxclass = box.maxclass || '';
    const text = box.text || '';
    const tokens = text.split(/\s+/);
    const objName = tokens[0];

    // Coll embed
    if (objName === 'coll' && !text.includes('@embed 1')) {
      findings.push({
        type: 'PERSISTENCE_WARNING',
        severity: 'MEDIUM',
        boxId: box.id,
        text: text,
        message: 'Objeto [coll] sin atributo [@embed 1].'
      });
    }

    // Unpack enteros
    if (objName === 'unpack') {
      const args = tokens.slice(1);
      const hasBareInts = args.some(a => /^\d+$/.test(a));
      if (hasBareInts) {
        findings.push({
          type: 'DATA_TYPE_GOTCHA',
          severity: 'LOW',
          boxId: box.id,
          text: text,
          message: 'Objeto [unpack] usando enteros crudos sin tipo float o especificador ("f").'
        });
      }
    }
  });

  // 2. Mapear conexiones de salida por outlet
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

  // 3. Detectar bifurcaciones múltiples de CONTROL sin trigger
  outletConnections.forEach((outlets, srcId) => {
    const srcBox = boxMap.get(srcId);
    if (!srcBox) return;

    // Si el objeto emisor es MSP/señal de audio, la transmisión es sincrónica por vectores
    if (isSignalObject(srcBox)) return;

    const srcText = (srcBox.text || srcBox.maxclass || '').trim();

    outlets.forEach((dests, outletIdx) => {
      if (dests.length > 1) {
        // Contar destinos de control
        const controlDests = dests.filter(d => {
          const destBox = boxMap.get(d.destId);
          // Si el destino es visualizador o entrada de audio MSP sin control, no compite en Scheduler
          return destBox && !isSignalObject(destBox);
        });

        if (controlDests.length > 1) {
          if (!srcText.startsWith('t ') && !srcText.startsWith('trigger ') && srcText !== 't' && srcText !== 'trigger') {
            const destDetails = controlDests.map(d => {
              const b = boxMap.get(d.destId);
              return b ? `[${b.text || b.maxclass} (inlet ${d.destInlet})]` : `ID:${d.destId}`;
            }).join(', ');

            findings.push({
              type: 'RACE_CONDITION_RISK',
              severity: 'HIGH',
              boxId: srcId,
              sourceText: srcText,
              outlet: outletIdx,
              message: `Bifurcación de control (${controlDests.length} destinos) desde outlet ${outletIdx} de [${srcText}] sin [trigger]: ${destDetails}`
            });
          }
        }
      }
    });
  });

  return {
    boxesCount: boxes.length,
    linesCount: lines.length,
    findings: findings
  };
}

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

let totalPatches = 0;
let totalFindings = 0;
const findingsByType = {};
const findingsBySeverity = { HIGH: 0, MEDIUM: 0, LOW: 0 };
const remaining = [];

for (const [patchPath, res] of Object.entries(audit)) {
  totalPatches++;
  if (res.findings && res.findings.length > 0) {
    totalFindings += res.findings.length;
    res.findings.forEach(f => {
      findingsByType[f.type] = (findingsByType[f.type] || 0) + 1;
      findingsBySeverity[f.severity] = (findingsBySeverity[f.severity] || 0) + 1;
    });
    remaining.push({ patch: patchPath, findings: res.findings });
  }
}

console.log('=== AUDITORÍA RIGUROSA POST-OPTIMIZACIÓN ===');
console.log(`Total Patches Analizados: ${totalPatches}`);
console.log(`Total Hallazgos Restantes: ${totalFindings}`);
console.log('Por Severidad:', JSON.stringify(findingsBySeverity));
console.log('Por Tipo:', JSON.stringify(findingsByType));
if (remaining.length > 0) {
  console.log('\nDetalles restantes:');
  remaining.forEach(r => {
    console.log(`\n- ${r.patch}:`);
    r.findings.forEach(f => console.log(`   [${f.severity}] ${f.type}: ${f.message}`));
  });
}
