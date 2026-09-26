import fs from 'fs';

const logPath = "C:/Users/Gustavo/AppData/Roaming/Cycling '74/Max 9/Logs/Max.log";
if (fs.existsSync(logPath)) {
  fs.writeFileSync(logPath, '', 'utf8');
  console.log('[OK] Max.log limpiado.');
}
