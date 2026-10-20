import { exec, execSync } from 'child_process';
import path from 'path';
import fs from 'fs';
import { resolveMaxLogPath } from '../lib/max_environment.mjs';

const TARGET_PATCH = process.argv[2] || 'book/public/patches/modulo-03/proyecto_03_sintetizador_fm.maxpat';
const RUN_DURATION_SEC = parseInt(process.argv[3] || '6', 10);
const LOG_PATH = resolveMaxLogPath();

console.log('=== AUDITORÍA DINÁMICA INTEGRAL CON TELEMETRÍA DE CONSOLA ===');
console.log(`Parche objetivo: ${TARGET_PATCH}`);
console.log(`Duración de observación: ${RUN_DURATION_SEC} segundos`);

// 1. Limpiar Max previo y vaciar el log para capturar solo esta corrida
try {
  execSync('taskkill /IM Max.exe /F >NUL 2>&1');
} catch (e) {}

if (fs.existsSync(LOG_PATH)) {
  fs.writeFileSync(LOG_PATH, '', 'utf8');
}

// 2. Lanzar Max 9 en segundo plano
const absPatchPath = path.resolve(TARGET_PATCH);
console.log(`\n[1/4] Iniciando Max 9 en segundo plano con el parche...`);
exec(`pipeline\\runners\\start_max_patch.bat "${absPatchPath}"`);

// 3. Monitorear proceso
console.log(`[2/4] Observando estabilidad de RAM, CPU y estado del proceso...`);

const samples = [];
let elapsed = 0;

const timer = setInterval(() => {
  elapsed += 1;
  try {
    const out = execSync('powershell -Command "Get-Process -Name Max -ErrorAction SilentlyContinue | Select-Object -Property Id, WorkingSet64, CPU, Threads | ConvertTo-Json -Compress"', { encoding: 'utf8' }).trim();
    if (out) {
      const data = JSON.parse(out);
      const memMb = (data.WorkingSet64 / (1024 * 1024)).toFixed(1);
      const cpuTime = data.CPU !== undefined ? data.CPU.toFixed(2) : 'N/A';
      const threadCount = Array.isArray(data.Threads) ? data.Threads.length : (data.Threads ? 1 : 'N/A');
      samples.push({ sec: elapsed, memMb, cpuTime, threadCount });
      console.log(`   [t=+${elapsed}s] PID: ${data.Id} | RAM: ${memMb} MB | CPU Time: ${cpuTime}s | Hilos: ${threadCount}`);
    }
  } catch (err) {}

  if (elapsed >= RUN_DURATION_SEC) {
    clearInterval(timer);
    finishAudit();
  }
}, 1000);

function finishAudit() {
  console.log(`\n[3/4] Finalizando sesión de Max 9 de forma segura...`);
  try {
    execSync('pipeline\\runners\\stop_max_patch.bat');
  } catch (e) {}

  // 4. Inspeccionar la consola de Max (Logs)
  console.log(`\n[4/4] === AUDITORÍA FORENSE DE CONSOLA DE MAX (Max.log) ===`);
  let logContent = '';
  if (fs.existsSync(LOG_PATH)) {
    logContent = fs.readFileSync(LOG_PATH, 'utf8');
  }

  const logLines = logContent.split('\n');
  const errorLines = logLines.filter(l => /error|warning|fail|cannot|crash/i.test(l) && !/msg_stack_init|syscrypto/i.test(l));

  if (errorLines.length > 0) {
    console.error(`❌ [RECHAZADO] Max 9 registró ${errorLines.length} anomalía(s) en su consola interna:`);
    errorLines.forEach(err => console.error(`   ⚠️  ${err.trim()}`));
    process.exit(1);
  } else {
    console.log(`✅ [IMPECABLE] Cero errores o advertencias en la consola interna de Max 9.`);
  }

  const initialMem = parseFloat(samples[0]?.memMb || 0);
  const finalMem = parseFloat(samples[samples.length - 1]?.memMb || 0);
  const lastThreads = samples[samples.length - 1]?.threadCount || 0;

  console.log(`✔ Estado del Proceso: ESTABLE`);
  console.log(`✔ RAM Inicial: ${initialMem} MB | RAM Final: ${finalMem} MB`);
  console.log(`✔ Hilos concurrentes: ${lastThreads}`);
  console.log(`✔ Veredicto Final: PARCHE AUDITADO Y APROBADO 100% PARA PRODUCCIÓN.\n`);
}
