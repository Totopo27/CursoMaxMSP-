/**
 * Script de Auditoría de Código C/C++ SDK, GenExpr y JS
 * Ubicación: pipeline/scripts/audit_code.mjs
 */
import fs from 'fs';
import path from 'path';

const CODE_FILES = [
  'book/public/patches/modulo-06/mi_objeto_externo.c',
  'book/public/patches/modulo-06/mi_objeto_msp.c',
  'book/public/patches/modulo-06/servidor_analisis.js',
  'book/public/patches/modulo-06/algoritmo_euclidiano.js',
  'book/public/patches/apendices/mi_objeto_min.cpp',
  'book/public/patches/apendices/filtro_va_min.cpp'
];

console.log('=== AUDITORÍA ESTÁTICA DE CÓDIGO SDK Y SCRIPTS ===\n');

CODE_FILES.forEach(file => {
  const content = fs.readFileSync(file, 'utf8');
  console.log(`--- Archivo: ${file} ---`);
  
  if (file.endsWith('.c') || file.endsWith('.cpp')) {
    // Verificar reglas de perform routine (C/C++)
    // No malloc, no post, no printf, no file IO en perform
    const performMatches = content.match(/perform64[\s\S]*?\{([\s\S]*?)\n\}/);
    if (performMatches) {
      const performBody = performMatches[1];
      if (/malloc|calloc|free|sysmem_newptr|sysmem_freeptr/.test(performBody)) {
        console.log('  [CRITICAL] Asignación/Liberación de memoria detectada en perform64 (rompe tiempo real).');
      } else {
        console.log('  [PASS] perform64 libre de asignaciones dinámicas de memoria.');
      }
      if (/\bpost\(|\bprintf\(/.test(performBody)) {
        console.log('  [WARNING] Llamada a post()/printf() detectada en perform64 (bloqueo potencial de hilo de audio).');
      } else {
        console.log('  [PASS] perform64 libre de llamadas a consola.');
      }
    } else {
      console.log('  [INFO] No se detectó perform64 explícito (posible objeto no-MSP o min-devkit operator()).');
    }

    // min-devkit checks
    if (file.endsWith('.cpp')) {
      if (content.includes('operator()') && content.includes('sample')) {
        console.log('  [PASS] Sintaxis de sample operator() de min-devkit implementada.');
      }
      if (content.includes('attribute<')) {
        console.log('  [PASS] Atributos declarativos de min-devkit utilizados.');
      }
    }
  }

  if (file.endsWith('.js')) {
    if (content.includes('max-api') || content.includes('Max.addHandler')) {
      console.log('  [PASS] Node for Max: usa max-api con arquitectura de handlers.');
    }
    if (content.includes('inlets') && content.includes('outlets')) {
      console.log('  [PASS] JS v8 nativo: definición clara de inlets/outlets.');
    }
  }
  console.log('');
});
