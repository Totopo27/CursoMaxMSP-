import fs from 'fs';
import path from 'path';

const DIAGRAMS_DIR = 'D:/DocumentosDiscoD/CursoMaxMSP/book/public/assets/diagrams';
const DOCS_DIR = 'D:/DocumentosDiscoD/CursoMaxMSP/book/src/content/docs';

// Obtener todos los SVGs
const svgFiles = fs.readdirSync(DIAGRAMS_DIR).filter(f => f.endsWith('.svg'));

// Analizar cada SVG
const svgStats = [];

svgFiles.forEach(file => {
  const fullPath = path.join(DIAGRAMS_DIR, file);
  const content = fs.readFileSync(fullPath, 'utf8');
  
  // Extraer título o textos clave
  const hasAudioSignals = content.includes('~') || content.includes('Audio') || content.includes('MSP') || content.includes('DSP');
  const hasTriggerOrControl = content.includes('trigger') || content.includes('[t') || content.includes('bang') || content.includes('Control');
  const widthMatch = content.match(/viewBox="[^"]*\s+[^"]*\s+(\d+)\s+(\d+)"/);
  
  // Buscar en qué documentos markdown se referencia
  svgStats.push({
    file,
    sizeKb: (content.length / 1024).toFixed(1),
    hasAudioSignals,
    hasTriggerOrControl,
    referencedIn: []
  });
});

// Buscar referencias en markdown
function scanDocs(dir) {
  const entries = fs.readdirSync(dir);
  entries.forEach(e => {
    const full = path.join(dir, e);
    if (fs.statSync(full).isDirectory()) {
      scanDocs(full);
    } else if (e.endsWith('.md') || e.endsWith('.mdx')) {
      const mdContent = fs.readFileSync(full, 'utf8');
      const relDoc = path.relative(DOCS_DIR, full).replace(/\\/g, '/');
      svgStats.forEach(stat => {
        if (mdContent.includes(stat.file)) {
          stat.referencedIn.push(relDoc);
        }
      });
    }
  });
}

scanDocs(DOCS_DIR);

const orphanDiagrams = svgStats.filter(s => s.referencedIn.length === 0);
console.log(`Total Diagramas SVG: ${svgStats.length}`);
console.log(`Diagramas huérfanos (sin referencia en docs): ${orphanDiagrams.length}`);
orphanDiagrams.forEach(o => console.log(` - Huérfano: ${o.file}`));
