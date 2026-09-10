const fs = require('fs');
const path = require('path');

function processDirectory(dir) {
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      processDirectory(fullPath);
    } else if (entry.isFile() && entry.name.endsWith('.md')) {
      const raw = fs.readFileSync(fullPath, 'utf8');
      if (!raw.startsWith('---')) {
        const lines = raw.split(/\r?\n/);
        let title = entry.name.replace('.md', '');
        for (const line of lines) {
          if (line.startsWith('# ')) {
            title = line.replace('# ', '').replace(/\"/g, '').trim();
            break;
          }
        }
        const frontmatter = `---\ntitle: "${title}"\ndescription: "Capítulo del curso universitario de Max/MSP"\n---\n\n`;
        fs.writeFileSync(fullPath, frontmatter + raw, 'utf8');
        console.log(`Frontmatter agregado a: ${entry.name}`);
      }
    }
  }
}

const targetDir = path.join(__dirname, 'src', 'content', 'docs');
processDirectory(targetDir);
console.log('Todos los archivos Markdown de Starlight han sido validados exitosamente.');
