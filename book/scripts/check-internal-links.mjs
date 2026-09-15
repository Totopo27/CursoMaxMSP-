import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.resolve(__dirname, '..');
const docsDir = path.resolve(rootDir, 'src/content/docs');
const publicDir = path.resolve(rootDir, 'public');

function getMarkdownFiles(dir) {
  let files = [];
  for (const item of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, item.name);
    if (item.isDirectory()) files = files.concat(getMarkdownFiles(full));
    else if (item.name.endsWith('.md')) files.push(full);
  }
  return files;
}

const mdFiles = getMarkdownFiles(docsDir);

const validSlugs = new Set();
for (const file of mdFiles) {
  const rel = path.relative(docsDir, file).replace(/\\/g, '/');
  if (rel === 'index.md') {
    validSlugs.add('/');
  } else {
    const slug = '/' + rel.replace(/\.md$/, '') + '/';
    validSlugs.add(slug);
    validSlugs.add(slug.slice(0, -1));
  }
}

let brokenCount = 0;
const errors = [];

for (const file of mdFiles) {
  const content = fs.readFileSync(file, 'utf8');
  const relFile = path.relative(docsDir, file).replace(/\\/g, '/');

  // Match Markdown links [text](/some/path)
  const mdRegex = /\[([^\]]*)\]\(((\/[^)#?\s]+)(?:#[^)]*)?)\)/g;
  let m;
  while ((m = mdRegex.exec(content)) !== null) {
    const href = m[3];
    if (href.startsWith('/patches/') || href.startsWith('/assets/')) {
      const pubPath = path.join(publicDir, href.replace(/^\//, ''));
      if (!fs.existsSync(pubPath)) {
        brokenCount++;
        errors.push(`[BROKEN ASSET] ${relFile} -> ${href}`);
      }
    } else {
      const testHref = href.endsWith('/') ? href : href + '/';
      if (!validSlugs.has(testHref) && !validSlugs.has(href)) {
        brokenCount++;
        errors.push(`[BROKEN DOC LINK] ${relFile} -> ${href}`);
      }
    }
  }

  // Match HTML links href="/some/path"
  const htmlRegex = /href="((\/[^"#?\s]+)(?:#[^"]*)?)"/g;
  while ((m = htmlRegex.exec(content)) !== null) {
    const href = m[2];
    if (href.startsWith('/patches/') || href.startsWith('/assets/')) {
      const pubPath = path.join(publicDir, href.replace(/^\//, ''));
      if (!fs.existsSync(pubPath)) {
        brokenCount++;
        errors.push(`[BROKEN HTML ASSET] ${relFile} -> ${href}`);
      }
    } else {
      const testHref = href.endsWith('/') ? href : href + '/';
      if (!validSlugs.has(testHref) && !validSlugs.has(href)) {
        brokenCount++;
        errors.push(`[BROKEN HTML DOC LINK] ${relFile} -> ${href}`);
      }
    }
  }
}

if (brokenCount > 0) {
  console.error(`\x1b[31mSe encontraron ${brokenCount} enlaces internos rotos:\x1b[0m`);
  errors.forEach(e => console.error(`  ${e}`));
  process.exit(1);
} else {
  console.log(`\x1b[32m✔ Verificación de enlaces exitosa: ${mdFiles.length} documentos auditados, 0 enlaces rotos.\x1b[0m`);
  process.exit(0);
}
