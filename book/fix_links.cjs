const fs = require('fs');
const path = require('path');

function walk(dir, fileList = []) {
  if (!fs.existsSync(dir)) return fileList;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      walk(fullPath, fileList);
    } else if (entry.name.endsWith('.md')) {
      fileList.push(fullPath);
    }
  }
  return fileList;
}

const baseDir = __dirname;
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
