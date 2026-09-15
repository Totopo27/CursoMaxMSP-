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
    console.log(`Purgado de emojis: ${path.relative(__dirname, filePath)}`);
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

// Raíz del repositorio: dos niveles arriba de book/ (donde vive este script)
const REPO_ROOT = path.resolve(__dirname, '..', '..');
const BOOK_DOCS = path.resolve(__dirname, 'src', 'content', 'docs');
const BOOK_DOCS_ALT = path.resolve(__dirname, 'docs'); // directorio legacy opcional

// Limpiar book/src/content/docs
traverse(BOOK_DOCS);

// Limpiar book/docs si existe
if (fs.existsSync(BOOK_DOCS_ALT)) {
  traverse(BOOK_DOCS_ALT);
}

// Limpiar archivos markdown de la raíz del repo
[
  'CURRICULUM_MASTER.md',
  'MAPEO_CONCEPTUAL_BIBLIO.md',
  'SOURCES_MASTER.md',
  'PROTOCOLO_BIBLIOGRAFICO.md'
].forEach(filename => {
  const fullPath = path.join(REPO_ROOT, filename);
  if (fs.existsSync(fullPath)) cleanFile(fullPath);
});

console.log('Operación de limpieza terminada. Todo el corpus está libre de emojis.');

