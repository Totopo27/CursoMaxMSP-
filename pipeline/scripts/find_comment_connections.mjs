import fs from 'fs';
import path from 'path';

const PATCHES_BASE = 'book/public/patches';

function scanLines(dir) {
  const files = fs.readdirSync(dir);
  files.forEach(f => {
    const full = path.join(dir, f);
    if (fs.statSync(full).isDirectory()) {
      scanLines(full);
    } else if (f.endsWith('.maxpat')) {
      const content = fs.readFileSync(full, 'utf8');
      const patch = JSON.parse(content);
      const boxes = patch.patcher.boxes || [];
      const lines = patch.patcher.lines || [];
      
      const boxMap = new Map();
      boxes.forEach(b => {
        if (b.box && b.box.id) boxMap.set(b.box.id, b.box);
      });

      lines.forEach((l, idx) => {
        const pl = l.patchline;
        const destBox = boxMap.get(pl.destination[0]);
        if (destBox && destBox.maxclass === 'comment') {
          console.log(`[ANOMALY FOUND] En parche ${f}:`);
          console.log(`  Cable desde ${pl.source[0]} (outlet ${pl.source[1]}) hacia comment ${pl.destination[0]} (inlet ${pl.destination[1]})!`);
        }
      });
    }
  });
}

scanLines(PATCHES_BASE);
