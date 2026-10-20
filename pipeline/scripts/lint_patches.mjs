/**
 * Linter Estricto de Parches Max/MSP para CI y Desarrollo Local
 * Basado en las directrices de Cycling '74 C SDK y ersatzben-maxmsp-mcp
 * Salida: Código 0 si pasa limpio, Código 1 si detecta violaciones críticas.
 */
import fs from 'fs';
import path from 'path';
import { lintPatchContent } from '../lib/patch_linter_core.mjs';

const PATCHES_DIR = 'book/public/patches';

function lintPatch(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  let patch;
  try {
    patch = JSON.parse(content);
  } catch (err) {
    return [{ type: 'JSON_PARSE_ERROR', severity: 'HIGH', message: err.message }];
  }
  return lintPatchContent(patch);
}

function scanDir(dir) {
  let allFindings = [];
  const files = fs.readdirSync(dir);

  files.forEach(f => {
    const fullPath = path.join(dir, f);
    const stat = fs.statSync(fullPath);
    if (stat.isDirectory()) {
      allFindings = allFindings.concat(scanDir(fullPath));
    } else if (f.endsWith('.maxpat')) {
      const relPath = path.relative(PATCHES_DIR, fullPath).replace(/\\/g, '/');
      const findings = lintPatch(fullPath);
      if (findings.length > 0) {
        allFindings.push({ patch: relPath, findings });
      }
    }
  });

  return allFindings;
}

console.log('🔍 Ejecutando Linter de Parches Max/MSP (Cycling \'74 SDK Standard)...');
const results = scanDir(PATCHES_DIR);

if (results.length === 0) {
  console.log('✅ [PASSED] Todos los parches cumplen 100% con los estándares de determinismo y tipos.');
  process.exit(0);
} else {
  console.error(`❌ [FAILED] Se encontraron violaciones en ${results.length} parche(s):`);
  results.forEach(r => {
    console.error(`\n📄 ${r.patch}:`);
    r.findings.forEach(f => {
      console.error(`   - [${f.severity}] ${f.type}: ${f.message}`);
    });
  });
  process.exit(1);
}
