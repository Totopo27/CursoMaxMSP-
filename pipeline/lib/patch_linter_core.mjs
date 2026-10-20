export const MSP_OBJECTS = new Set([
  '*~', '/~', '+~', '-~', 'sig~', 'cycle~', 'phasor~', 'tri~', 'rect~', 'saw~',
  'biquad~', 'lores~', 'svf~', 'reson~', 'teeth~', 'comb~', 'allpass~',
  'delay~', 'tapin~', 'tapout~', 'groove~', 'play~', 'wave~', 'buffer~',
  'line~', 'curve~', 'rampsmooth~', 'average~', 'peakamp~', 'snapshot~',
  'gain~', 'live.gain~', 'ezdac~', 'ezadc~', 'dac~', 'adc~', 'send~', 'receive~',
  'plugin~', 'poly~', 'pfft~', 'gen~', 'meter~', 'live.meter~', 'scope~', 'spectroscope~'
]);

export function isSignalObject(box) {
  if (!box) return false;
  const text = (box.text || '').trim();
  const maxclass = (box.maxclass || '').trim();
  const firstToken = text.split(/\s+/)[0];
  return firstToken.endsWith('~') || maxclass.endsWith('~') || MSP_OBJECTS.has(firstToken);
}

/**
 * Función pura que audita un objeto JSON ya deserializado de un patcher Max/MSP.
 * Seam desacoplado de filesystem y procesos externos.
 * @param {object} patch - Objeto JSON del parche
 * @returns {Array<object>} Lista de hallazgos
 */
export function lintPatchContent(patch) {
  if (!patch || typeof patch !== 'object') {
    return [{ type: 'INVALID_PATCH_DATA', severity: 'HIGH', message: 'Entrada nula o inválida' }];
  }

  const patcher = patch.patcher;
  if (!patcher) {
    return [{ type: 'INVALID_PATCHER', severity: 'HIGH', message: 'No patcher key' }];
  }

  const boxes = patcher.boxes || [];
  const lines = patcher.lines || [];
  const findings = [];
  const boxMap = new Map();

  boxes.forEach(b => {
    if (b.box && b.box.id) boxMap.set(b.box.id, b.box);
  });

  // 1. Verificación de atributos críticos y tipos
  boxes.forEach(b => {
    const box = b.box;
    if (!box) return;
    const text = box.text || '';
    const tokens = text.split(/\s+/);
    const objName = tokens[0];

    // Persistencia en coll
    if (objName === 'coll' && !text.includes('@embed 1')) {
      findings.push({
        type: 'PERSISTENCE_WARNING',
        severity: 'MEDIUM',
        boxId: box.id,
        message: 'Objeto [coll] sin atributo [@embed 1]. Los datos se perderán al cerrar el parche.'
      });
    }

    // Gotcha de tipos de datos en unpack
    if (objName === 'unpack') {
      const args = tokens.slice(1);
      const hasBareInts = args.some(a => /^\d+$/.test(a));
      if (hasBareInts) {
        findings.push({
          type: 'DATA_TYPE_GOTCHA',
          severity: 'HIGH',
          boxId: box.id,
          message: 'Objeto [unpack] usando enteros crudos sin tipo float ("f"). Truncará valores en coma flotante.'
        });
      }
    }
  });

  // 2. Mapear conexiones de control y validar destinos ilegales
  const outletConnections = new Map();
  lines.forEach(l => {
    const line = l.patchline;
    if (!line) return;
    const srcId = line.source[0];
    const srcOutlet = line.source[1];
    const destId = line.destination[0];
    const destInlet = line.destination[1];

    const destBox = boxMap.get(destId);
    if (destBox && destBox.maxclass === 'comment') {
      findings.push({
        type: 'ILLEGAL_COMMENT_CONNECTION',
        severity: 'CRITICAL',
        boxId: srcId,
        message: `Cable desde [${srcId} outlet ${srcOutlet}] conectado a un [comment] (${destId}). Los comentarios no procesan datos ni tienen inlets funcionales.`
      });
    }

    if (!outletConnections.has(srcId)) outletConnections.set(srcId, new Map());
    const srcOutlets = outletConnections.get(srcId);
    if (!srcOutlets.has(srcOutlet)) srcOutlets.set(srcOutlet, []);
    srcOutlets.get(srcOutlet).push({ destId, destInlet });
  });

  // 3. Detectar Race Conditions por falta de [trigger]
  outletConnections.forEach((outlets, srcId) => {
    const srcBox = boxMap.get(srcId);
    if (!srcBox || isSignalObject(srcBox)) return;

    const srcText = (srcBox.text || srcBox.maxclass || '').trim();

    outlets.forEach((dests, outletIdx) => {
      if (dests.length > 1) {
        const controlDests = dests.filter(d => {
          const destBox = boxMap.get(d.destId);
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
              message: `Bifurcación de control (${controlDests.length} destinos) desde outlet ${outletIdx} de [${srcText}] sin [trigger]: ${destDetails}`
            });
          }
        }
      }
    });
  });

  return findings;
}
