const fs = require('fs');
const path = require('path');

function walk(dir, fileList = []) {
  const files = fs.readdirSync(dir);
  files.forEach(file => {
    const filePath = path.join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      walk(filePath, fileList);
    } else if (filePath.endsWith('.md')) {
      fileList.push(filePath);
    }
  });
  return fileList;
}

const baseDir = 'd:\\DocumentosDiscoD\\CursoMaxMSP\\book';
const targets = [
  path.join(baseDir, 'src', 'content', 'docs'),
  path.join(baseDir, 'docs')
];

let totalPatches = 0;
let totalSdk = 0;

targets.forEach(targetDir => {
  if (!fs.existsSync(targetDir)) return;
  const mdFiles = walk(targetDir);
  mdFiles.forEach(file => {
    let content = fs.readFileSync(file, 'utf8');
    let original = content;

    content = content.replace(/\[([^\]]+)\]\(file:\/\/\/[^\)]*?\/book\/patches\/([^\)]+)\)/g, (match, text, patchPath) => {
      totalPatches++;
      return `[${text}](/patches/${patchPath})`;
    });

    content = content.replace(/\[([^\]]+)\]\(file:\/\/\/[^\)]*?\/sources\/max-sdk\/([^\)]+)\)/g, (match, text, sdkPath) => {
      totalSdk++;
      return `[${text}](https://github.com/Cycling74/max-sdk/blob/main/${sdkPath})`;
    });

    if (content !== original) {
      fs.writeFileSync(file, content, 'utf8');
      console.log('Enlaces corregidos en:', path.relative(baseDir, file));
    }
  });
});

console.log(`Finalizado. Total parches enlazados: ${totalPatches}, Enlaces SDK actualizados: ${totalSdk}`);
