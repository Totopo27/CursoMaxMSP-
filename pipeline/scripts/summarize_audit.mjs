import fs from 'fs';

const raw = fs.readFileSync('audit_results.json');
// Limpiar BOM o UTF-16 si PowerShell redirigió en UTF-16LE
let str = '';
if (raw[0] === 0xff && raw[1] === 0xfe) {
  str = raw.toString('utf16le');
} else if (raw[0] === 0xef && raw[1] === 0xbb && raw[2] === 0xbf) {
  str = raw.toString('utf8').slice(1);
} else {
  str = raw.toString('utf8');
}
str = str.replace(/^\uFEFF/, '').trim();
const data = JSON.parse(str);

let totalPatches = 0;
let totalFindings = 0;
const findingsByType = {};
const findingsBySeverity = { HIGH: 0, MEDIUM: 0, LOW: 0 };
const patchSummaries = [];

for (const [patchPath, res] of Object.entries(data)) {
  totalPatches++;
  if (res.findings && res.findings.length > 0) {
    totalFindings += res.findings.length;
    res.findings.forEach(f => {
      findingsByType[f.type] = (findingsByType[f.type] || 0) + 1;
      findingsBySeverity[f.severity] = (findingsBySeverity[f.severity] || 0) + 1;
    });
    patchSummaries.push({
      patch: patchPath,
      count: res.findings.length,
      findings: res.findings
    });
  }
}

console.log(`Total Patches Analizados: ${totalPatches}`);
console.log(`Total Hallazgos: ${totalFindings}`);
console.log('Por Severidad:', JSON.stringify(findingsBySeverity));
console.log('Por Tipo:', JSON.stringify(findingsByType));
console.log('\nTop parches con observaciones:');
patchSummaries.sort((a,b) => b.count - a.count).slice(0, 15).forEach(p => {
  console.log(`- ${p.patch} (${p.count} hallazgos)`);
  p.findings.forEach(f => {
    console.log(`   [${f.severity}] ${f.type}: ${f.message}`);
  });
});
