import os
import zipfile
import re
import json

BIBLIO_DIR = r"D:\DocumentosDiscoD\CursoMaxMSP\referenciasbibliograficas"
OUTPUT_DIR = r"D:\DocumentosDiscoD\CursoMaxMSP\sources\analyzed_biblio"

epub_files = [f for f in os.listdir(BIBLIO_DIR) if f.endswith('.epub')]
mobi_files = [f for f in os.listdir(BIBLIO_DIR) if f.endswith('.mobi')]

results = {}

print(f"Archivos EPUB encontrados: {len(epub_files)}")
print(f"Archivos MOBI encontrados: {len(mobi_files)}")

# 1. Analizar EPUB (que son archivos ZIP internamente)
for epub in epub_files:
    epub_path = os.path.join(BIBLIO_DIR, epub)
    print(f"\n[ANALIZANDO EPUB] {epub}...")
    try:
        with zipfile.ZipFile(epub_path, 'r') as z:
            namelist = z.namelist()
            # Buscar toc.ncx o nav.xhtml o package.opf
            toc_content = ""
            for name in namelist:
                if 'toc' in name.lower() or 'nav' in name.lower() or 'content' in name.lower():
                    try:
                        content = z.read(name).decode('utf-8', errors='ignore')
                        # Extraer textos entre etiquetas <navPoint>, <text>, <a>, etc.
                        matches = re.findall(r'<text[^>]*>(.*?)</text>', content, re.IGNORECASE)
                        if not matches:
                            matches = re.findall(r'<a [^>]*>(.*?)</a>', content, re.IGNORECASE)
                        if matches:
                            clean_matches = [re.sub(r'<[^>]+>', '', m).strip() for m in matches if len(m.strip()) > 2]
                            if len(clean_matches) > 5:
                                toc_content = clean_matches[:60]
                                break
                    except:
                        pass

            # Extraer muestra de texto de capítulos
            sample_chapters = []
            for name in namelist:
                if name.endswith('.xhtml') or name.endswith('.html'):
                    try:
                        c_text = z.read(name).decode('utf-8', errors='ignore')
                        clean_text = re.sub(r'<[^>]+>', ' ', c_text)
                        clean_text = re.sub(r'\s+', ' ', clean_text).strip()
                        if len(clean_text) > 100:
                            sample_chapters.append(clean_text[:400])
                            if len(sample_chapters) >= 10:
                                break
                    except:
                        pass

            results[epub] = {
                "format": "EPUB",
                "files_in_zip": len(namelist),
                "table_of_contents": toc_content or "No explicita en XML estándar",
                "sample_chapters": sample_chapters
            }
            print(f"  -> Archivos internos: {len(namelist)}, Entradas TOC: {len(toc_content) if isinstance(toc_content, list) else 0}")
    except Exception as e:
        print(f"  -> Error analizando EPUB: {e}")
        results[epub] = {"error": str(e)}

# 2. Analizar MOBI (formato binario PalmDOC / Mobipocket)
for mobi in mobi_files:
    mobi_path = os.path.join(BIBLIO_DIR, mobi)
    print(f"\n[ANALIZANDO MOBI] {mobi}...")
    try:
        with open(mobi_path, 'rb') as f:
            data = f.read(1500000) # Leer primer bloque de 1.5MB
            # Los mobi tienen cabeceras con títulos de capítulos y texto en UTF-8 o CP1252
            # Extraer strings legibles en inglés
            text_chunks = re.findall(rb'[A-Z][a-zA-Z0-9\s,:\-~\?\!\(\)]{8,80}', data)
            decoded_titles = []
            for t in text_chunks:
                try:
                    dec = t.decode('utf-8').strip()
                    if any(k in dec.lower() for k in ['chapter', 'gen~', 'operator', 'signal', 'filter', 'time', 'sound', 'noise', 'buffer', 'phase', 'feedback', 'history', 'delay', 'sample']):
                        decoded_titles.append(dec)
                except:
                    pass

            # Descartar duplicados manteniendo orden
            seen = set()
            unique_titles = []
            for ut in decoded_titles:
                if ut not in seen:
                    seen.add(ut)
                    unique_titles.append(ut)

            results[mobi] = {
                "format": "MOBI",
                "file_size_mb": round(os.path.getsize(mobi_path) / (1024*1024), 2),
                "extracted_topics": unique_titles[:50]
            }
            print(f"  -> Tamaño: {results[mobi]['file_size_mb']} MB, Tópicos clave extraídos: {len(unique_titles)}")
    except Exception as e:
        print(f"  -> Error analizando MOBI: {e}")
        results[mobi] = {"error": str(e)}

with open(os.path.join(OUTPUT_DIR, "ebooks_analysis_summary.json"), "w", encoding="utf-8") as out:
    json.dump(results, out, indent=2, ensure_ascii=False)

print("\n=== ANÁLISIS DE EBOOKS COMPLETADO CON ÉXITO ===")
