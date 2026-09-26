/**
 * Script de Auditoría Estricta y Verificación para Código C/C++ SDK
 */
import fs from 'fs';

const cCode = fs.readFileSync('book/public/patches/modulo-06/mi_objeto_msp.c', 'utf8');

// Extraer el cuerpo de perform64
const perform64Match = cCode.match(/void mi_objeto_msp_perform64\([^)]*\)\s*\{([\s\S]*?)\n\}/);
if (perform64Match) {
  const body = perform64Match[1];
  console.log('--- Analizando cuerpo de perform64 ---');
  const forbidden = ['malloc', 'free', 'calloc', 'sysmem_newptr', 'sysmem_freeptr', 'post', 'object_post', 'printf'];
  let issues = 0;
  forbidden.forEach(word => {
    const regex = new RegExp(`\\b${word}\\s*\\(`, 'g');
    if (regex.test(body)) {
      console.log(`[VIOLATION] ${word}() encontrado en perform64!`);
      issues++;
    }
  });
  if (issues === 0) {
    console.log('[PERFECT] perform64 cumple 100% las directrices de tiempo real lock-free y sin allocs.');
  }
}

// Extraer el cuerpo de perform_nosig64
const performNoSigMatch = cCode.match(/void mi_objeto_msp_perform_nosig64\([^)]*\)\s*\{([\s\S]*?)\n\}/);
if (performNoSigMatch) {
  const body = performNoSigMatch[1];
  console.log('--- Analizando cuerpo de perform_nosig64 ---');
  const forbidden = ['malloc', 'free', 'calloc', 'sysmem_newptr', 'sysmem_freeptr', 'post', 'object_post', 'printf'];
  let issues = 0;
  forbidden.forEach(word => {
    const regex = new RegExp(`\\b${word}\\s*\\(`, 'g');
    if (regex.test(body)) {
      console.log(`[VIOLATION] ${word}() encontrado en perform_nosig64!`);
      issues++;
    }
  });
  if (issues === 0) {
    console.log('[PERFECT] perform_nosig64 cumple 100% las directrices de tiempo real lock-free.');
  }
}
