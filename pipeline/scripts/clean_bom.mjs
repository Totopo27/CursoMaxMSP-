import fs from 'fs';

const filePath = 'book/public/patches/apendices/lab_apendice_g_casos_estudio.maxpat';
let content = fs.readFileSync(filePath, 'utf8');
if (content.charCodeAt(0) === 0xFEFF) {
  content = content.slice(1);
  fs.writeFileSync(filePath, content, 'utf8');
  console.log('[OK] BOM eliminado de lab_apendice_g_casos_estudio.maxpat');
} else {
  console.log('No tenía BOM UTF-8.');
}
