import { describe, it } from 'node:test';
import assert from 'node:assert/strict';
import { resolveMaxLogPath } from './max_environment.mjs';

describe('Max Environment Resolution Seam', () => {
  it('prefers MAX_LOG_PATH if explicitly configured in environment', () => {
    const env = { MAX_LOG_PATH: 'D:/custom/logs/Max.log' };
    const resolved = resolveMaxLogPath(env, 'win32');
    assert.equal(resolved, 'D:/custom/logs/Max.log');
  });

  it('resolves dynamically under Windows APPDATA', () => {
    const env = { APPDATA: 'C:/Users/Tester/AppData/Roaming' };
    const resolved = resolveMaxLogPath(env, 'win32');
    assert.equal(resolved.replace(/\\/g, '/'), 'C:/Users/Tester/AppData/Roaming/Cycling \'74/Max 9/Logs/Max.log');
  });

  it('resolves under darwin / macOS library path', () => {
    const env = { HOME: '/Users/tester' };
    const resolved = resolveMaxLogPath(env, 'darwin');
    assert.equal(resolved.replace(/\\/g, '/'), '/Users/tester/Library/Logs/Cycling \'74/Max 9/Max.log');
  });

  it('falls back safely to temp directory if no OS path is found', () => {
    const env = {};
    const resolved = resolveMaxLogPath(env, 'linux');
    assert.match(resolved, /Max\.log$/);
  });
});
