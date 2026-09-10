const fs = require('fs');
const path = require('path');

// Mapeo exhaustivo de emojis a términos sobrios y profesionales
const emojiReplacements = [
  // Iconos frecuentes
  { regex: /🎯\s*/g, replace: '' },
  { regex: /📚\s*/g, replace: '' },
  { regex: /🧪\s*/g, replace: '' },
  { regex: /🛠️?\s*/g, replace: '' },
  { regex: /🚀\s*/g, replace: '' },
  { regex: /💡\s*/g, replace: '' },
  { regex: /⚠️?\s*/g, replace: '' },
  { regex: /⭐️/g, replace: '*' },
  { regex: /✨\s*/g, replace: '' },
  { regex: /🔥\s*/g, replace: '' },
  { regex: /📦\s*/g, replace: '' },
  { regex: /🔗\s*/g, replace: '' },
  { regex: /⚡\s*/g, replace: '' },
  { regex: /🧠\s*/g, replace: '' },
  { regex: /🎧\s*/g, replace: '' },
  { regex: /🎨\s*/g, replace: '' },
  { regex: /🕹️?\s*/g, replace: '' },
  { regex: /🤖\s*/g, replace: '' },
  { regex: /🔍\s*/g, replace: '' },
  { regex: /📌\s*/g, replace: '' },
  { regex: /👉\s*/g, replace: '' },
  { regex: /✅\s*/g, replace: '' },
  { regex: /❌\s*/g, replace: '' },
  // Expresión regular unicode completa para atrapar cualquier emoji residual
  { regex: /[\u{1F300}-\u{1F9FF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}\u{1F1E6}-\u{1F1FF}\u{1F600}-\u{1F64F}\u{1F680}-\u{1F6FF}\u{1F900}-\u{1F9FF}\u{1FA70}-\u{1FAFF}\u{2300}-\u{23FF}]/gu, replace: '' }
];

function cleanFile(filePath) {
  let content = fs.readFileSync(filePath, 'utf8');
  let original = content;
  for (const item of emojiReplacements) {
    content = content.replace(item.regex, item.replace);
  }
  if (content !== original) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`Purgado de emojis: ${path.relative('d:/DocumentosDiscoD/CursoMaxMSP', filePath)}`);
  }
}

function traverse(dir) {
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      if (entry.name !== 'node_modules' && entry.name !== '.git' && entry.name !== 'dist') {
        traverse(full);
      }
    } else if (entry.isFile() && entry.name.endsWith('.md')) {
      cleanFile(full);
    }
  }
}

// Limpiar book/src/content/docs, book/docs y la raíz
traverse('d:/DocumentosDiscoD/CursoMaxMSP/book/src/content/docs');
traverse('d:/DocumentosDiscoD/CursoMaxMSP/book/docs');
['d:/DocumentosDiscoD/CursoMaxMSP/CURRICULUM_MASTER.md', 
 'd:/DocumentosDiscoD/CursoMaxMSP/MAPEO_CONCEPTUAL_BIBLIO.md',
 'd:/DocumentosDiscoD/CursoMaxMSP/SOURCES_MASTER.md',
 'd:/DocumentosDiscoD/CursoMaxMSP/PROTOCOLO_BIBLIOGRAFICO.md'].forEach(p => {
  if (fs.existsSync(p)) cleanFile(p);
});

console.log('Operación de limpieza terminada. Todo el corpus está libre de emojis.');
