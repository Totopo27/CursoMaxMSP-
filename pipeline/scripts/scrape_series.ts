import fs from 'fs';
import path from 'path';

interface SeriesIndexResponse {
  title: string;
  url: string;
  articles: Array<{
    title: string;
    slug: string;
    url: string;
    description?: string;
  }>;
}

const SERIES = [
  { name: 'max-tutorials', url: 'https://docs.cycling74.com/learn/series/max-tutorials/' },
  { name: 'msp-tutorials', url: 'https://docs.cycling74.com/learn/series/msp-tutorials/' },
  { name: 'jitter-geometry', url: 'https://docs.cycling74.com/learn/series/jitter_geometry/' }
];

async function extractSeries(seriesName: string, url: string): Promise<SeriesIndexResponse | null> {
  console.log(`[CRAWLER] Obteniendo página: ${url}`);
  try {
    const res = await fetch(url);
    if (!res.ok) {
      console.error(`[ERROR] Status ${res.status} al solicitar ${url}`);
      return null;
    }
    const html = await res.text();
    
    // Extraer el JSON dentro de __NEXT_DATA__
    const match = html.match(/<script id="__NEXT_DATA__" type="application\/json">([\s\S]*?)<\/script>/);
    if (!match || !match[1]) {
      console.warn(`[WARN] No se encontró __NEXT_DATA__ en ${url}`);
      return null;
    }

    const nextData = JSON.parse(match[1]);
    const pageProps = nextData?.props?.pageProps;
    
    const title = pageProps?.series?.title || seriesName;
    const articles = pageProps?.series?.articles || pageProps?.articles || [];

    const formattedArticles = articles.map((art: any) => ({
      title: art.title,
      slug: art.slug,
      url: `https://docs.cycling74.com${art.href || `/learn/${art.slug}`}`,
      description: art.description || ''
    }));

    return {
      title,
      url,
      articles: formattedArticles
    };
  } catch (err) {
    console.error(`[ERROR] Falló extracción para ${seriesName}:`, err);
    return null;
  }
}

async function main() {
  const outputDir = path.resolve('sources/official_docs/series');
  fs.mkdirSync(outputDir, { recursive: true });

  console.log('=== INICIANDO EXTRACCIÓN DE SERIES OFICIALES (Cycling 74) ===\n');

  for (const s of SERIES) {
    const data = await extractSeries(s.name, s.url);
    if (data) {
      const targetPath = path.join(outputDir, `${s.name}.json`);
      fs.writeFileSync(targetPath, JSON.stringify(data, null, 2), 'utf-8');
      console.log(`-> Guardado: ${targetPath} (${data.articles.length} tutoriales encontrados)`);
    }
  }

  console.log('\n=== EXTRACCIÓN COMPLETADA CON ÉXITO ===');
}

main().catch(console.error);
