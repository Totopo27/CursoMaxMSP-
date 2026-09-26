import fs from 'fs';
import path from 'path';

// Parsear seguro audit_results.json
let raw = fs.readFileSync('audit_results.json');
let str = '';
if (raw[0] === 0xff && raw[1] === 0xfe) str = raw.toString('utf16le');
else if (raw[0] === 0xef && raw[1] === 0xbb && raw[2] === 0xbf) str = raw.toString('utf8').slice(1);
else str = raw.toString('utf8');
str = str.replace(/^\uFEFF/, '').trim();
const auditData = JSON.parse(str);

const PATCHES_BASE = 'D:/DocumentosDiscoD/CursoMaxMSP/book/public/patches';

console.log('=== DETALLE DE ARCHIVOS Y HALLAZGOS A CORREGIR ===');
for (const [relPath, info] of Object.entries(auditData)) {
  if (info.findings && info.findings.length > 0) {
    console.log(`\nPARCHE: ${relPath} (${info.findings.length} hallazgos)`);
    info.findings.forEach((f, i) => {
      console.log(`  [${i+1}] [${f.severity}] ${f.type} - Box ID: ${f.boxId}`);
      console.log(`      ${f.message}`);
    });
  }
}
