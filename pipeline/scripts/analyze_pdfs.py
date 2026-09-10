import os
import json
from pypdf import PdfReader

BIBLIO_DIR = r"D:\DocumentosDiscoD\CursoMaxMSP\referenciasbibliograficas"
OUTPUT_DIR = r"D:\DocumentosDiscoD\CursoMaxMSP\sources\analyzed_biblio"

os.makedirs(OUTPUT_DIR, exist_ok=True)

pdf_files = [f for f in os.listdir(BIBLIO_DIR) if f.endswith('.pdf')]

print(f"Total PDFs encontrados: {len(pdf_files)}")

summary = {}

for pdf in pdf_files:
    pdf_path = os.path.join(BIBLIO_DIR, pdf)
    print(f"\n[ANALIZANDO] {pdf}...")
    try:
        reader = PdfReader(pdf_path)
        num_pages = len(reader.pages)
        outline_titles = []
        try:
            outline = reader.outline
            def extract_outline(entries):
                titles = []
                for item in entries:
                    if isinstance(item, list):
                        titles.extend(extract_outline(item))
                    elif hasattr(item, 'title'):
                        titles.append(item.title)
                return titles
            if outline:
                outline_titles = extract_outline(outline)
        except Exception as e:
            pass

        # Extraer texto de las primeras 15 páginas (TOC, Prólogo, Estructura)
        sample_text = ""
        for i in range(min(15, num_pages)):
            try:
                page_text = reader.pages[i].extract_text() or ""
                sample_text += f"\n--- PAGINA {i+1} ---\n" + page_text[:1000]
            except:
                pass

        summary[pdf] = {
            "num_pages": num_pages,
            "outline_count": len(outline_titles),
            "outline_sample": outline_titles[:30],
            "sample_snippet": sample_text[:3000]
        }
        print(f"  -> {num_pages} páginas, {len(outline_titles)} entradas de índice.")
    except Exception as err:
        print(f"  -> Error al leer {pdf}: {err}")
        summary[pdf] = {"error": str(err)}

with open(os.path.join(OUTPUT_DIR, "pdf_analysis_summary.json"), "w", encoding="utf-8") as out:
    json.dump(summary, out, indent=2, ensure_ascii=False)

print("\n=== ANÁLISIS COMPLETADO Y GUARDADO ===")
