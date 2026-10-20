import sys
import json
from pathlib import Path

# Inyectar Harmos
sys.path.insert(0, 'D:/DocumentosDiscoD/OptimizandoParaMaxSDK')
from core.compiler.contract_engine import ContractEngine

ce = ContractEngine()
patches_dir = Path('book/public/patches')
all_patches = sorted(list(patches_dir.glob('**/*.maxpat')))

report = {
    'total_patches': len(all_patches),
    'harmos_contracts_loaded': len(ce._contracts),
    'patches_analyzed': []
}

for p in all_patches:
    with open(p, 'r', encoding='utf-8') as f:
        data = json.load(f)
    patcher = data.get('patcher', {})
    boxes = {b['box']['id']: b['box'] for b in patcher.get('boxes', []) if 'box' in b and 'id' in b['box']}
    lines = patcher.get('lines', [])

    item = {
        'patch': str(p.relative_to(patches_dir)).replace('\\', '/'),
        'boxes_count': len(boxes),
        'lines_count': len(lines),
        'observations': []
    }

    for l in lines:
        line = l.get('patchline', {})
        if not line:
            continue
        src_id, src_out = line['source']
        dst_id, dst_in = line['destination']

        src_box = boxes.get(src_id)
        dst_box = boxes.get(dst_id)
        if not src_box or not dst_box:
            continue

        src_text = src_box.get('text', src_box.get('maxclass', '')).split()[0]
        dst_text = dst_box.get('text', dst_box.get('maxclass', '')).split()[0]

        src_c = ce.get_object_contract(src_text)
        dst_c = ce.get_object_contract(dst_text)

        if src_c and dst_c:
            outlets = ce.get_outlets(src_text)
            inlets = ce.get_inlets(dst_text)
            if src_out < len(outlets) and dst_in < len(inlets):
                out_t = outlets[src_out].get('type')
                in_t = inlets[dst_in].get('type')
                if in_t == 'signal' and out_t not in ['signal', 'anything']:
                    item['observations'].append({
                        'type': 'DISCRETE_CONTROL_TO_SIGNAL_DOMAIN',
                        'source': f'{src_text} (outlet {src_out}: {out_t})',
                        'destination': f'{dst_text} (inlet {dst_in}: {in_t})',
                        'note': f'El inlet {dst_in} de [{dst_text}] recibe control numérico directo en lugar de flujo continuo a tasa de muestreo. En audio crítico se recomienda interpolación con [line~] o [sig~] para mitigar zippering.'
                    })

    report['patches_analyzed'].append(item)

with open('pipeline/harmos_audit_report.json', 'w', encoding='utf-8') as f:
    json.dump(report, f, indent=2)

print(f"Reporte Harmos generado exitosamente.")
print(f"Parches evaluados: {report['total_patches']}")
flagged = [p for p in report['patches_analyzed'] if p['observations']]
print(f"Parches con observaciones de contrato cruzado: {len(flagged)}")
for f in flagged:
    print(f" - {f['patch']}: {len(f['observations'])} observación(es)")
