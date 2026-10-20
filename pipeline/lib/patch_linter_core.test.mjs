import { describe, it } from 'node:test';
import assert from 'node:assert/strict';
import { lintPatchContent } from './patch_linter_core.mjs';

describe('Patch Linter Core - Pure Functional Seam', () => {
  it('detects missing @embed 1 in [coll]', () => {
    const patch = {
      patcher: {
        boxes: [
          { box: { id: 'obj-1', maxclass: 'newobj', text: 'coll myData' } }
        ],
        lines: []
      }
    };
    const findings = lintPatchContent(patch);
    assert.equal(findings.length, 1);
    assert.equal(findings[0].type, 'PERSISTENCE_WARNING');
  });

  it('detects bare integers in [unpack] causing float truncation', () => {
    const patch = {
      patcher: {
        boxes: [
          { box: { id: 'obj-1', maxclass: 'newobj', text: 'unpack 0 0' } }
        ],
        lines: []
      }
    };
    const findings = lintPatchContent(patch);
    assert.equal(findings.length, 1);
    assert.equal(findings[0].type, 'DATA_TYPE_GOTCHA');
  });

  it('detects control branching to multiple cold/hot inlets without [trigger]', () => {
    const patch = {
      patcher: {
        boxes: [
          { box: { id: 'obj-1', maxclass: 'newobj', text: 'counter 1 10' } },
          { box: { id: 'obj-2', maxclass: 'newobj', text: '% 4' } },
          { box: { id: 'obj-3', maxclass: 'newobj', text: '% 3' } }
        ],
        lines: [
          { patchline: { source: ['obj-1', 0], destination: ['obj-2', 0] } },
          { patchline: { source: ['obj-1', 0], destination: ['obj-3', 0] } }
        ]
      }
    };
    const findings = lintPatchContent(patch);
    assert.equal(findings.length, 1);
    assert.equal(findings[0].type, 'RACE_CONDITION_RISK');
  });

  it('passes cleanly when branching goes through [trigger]', () => {
    const patch = {
      patcher: {
        boxes: [
          { box: { id: 'obj-1', maxclass: 'newobj', text: 't i i' } },
          { box: { id: 'obj-2', maxclass: 'newobj', text: '% 4' } },
          { box: { id: 'obj-3', maxclass: 'newobj', text: '% 3' } }
        ],
        lines: [
          { patchline: { source: ['obj-1', 0], destination: ['obj-2', 0] } },
          { patchline: { source: ['obj-1', 1], destination: ['obj-3', 0] } }
        ]
      }
    };
    const findings = lintPatchContent(patch);
    assert.equal(findings.length, 0);
  });
});
