import path from 'path';
import os from 'os';

/**
 * Resuelve la ruta al log interno de Max MSP de forma portable e independiente de usuario.
 * @param {Record<string, string | undefined>} env - Objeto de entorno (default: process.env)
 * @param {string} platform - Plataforma del sistema operativo (default: process.platform)
 * @returns {string} Ruta absoluta o canónica al archivo Max.log
 */
export function resolveMaxLogPath(env = process.env, platform = process.platform) {
  if (env.MAX_LOG_PATH) {
    return env.MAX_LOG_PATH;
  }

  if (platform === 'win32' && env.APPDATA) {
    return path.join(env.APPDATA, 'Cycling \'74', 'Max 9', 'Logs', 'Max.log');
  }

  if (platform === 'darwin' && env.HOME) {
    return path.join(env.HOME, 'Library', 'Logs', 'Cycling \'74', 'Max 9', 'Max.log');
  }

  return path.join(os.tmpdir(), 'Cycling \'74', 'Max 9', 'Logs', 'Max.log');
}
