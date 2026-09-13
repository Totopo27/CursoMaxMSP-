// Service Worker para Curso Max/MSP
const CACHE_NAME = 'curso-max-cache-v1';

const STATIC_ASSETS = [
  '/',
  '/favicon.svg',
  '/manifest.json',
  '/progress-tracker.js',
  '/curso-maxmsp-patches-completos.zip'
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(STATIC_ASSETS);
    })
  );
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.map((key) => {
          if (key !== CACHE_NAME) {
            return caches.delete(key);
          }
        })
      );
    })
  );
  self.clients.claim();
});

// Estrategia Network-First con fallback a Cache para navegación y documentos
self.addEventListener('fetch', (event) => {
  const req = event.request;
  if (req.method !== 'GET') return;

  event.respondWith(
    fetch(req)
      .then((networkRes) => {
        // Clonar y guardar en cache si es respuesta válida
        if (networkRes && networkRes.status === 200) {
          const resClone = networkRes.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(req, resClone));
        }
        return networkRes;
      })
      .catch(() => {
        return caches.match(req).then((cachedRes) => {
          if (cachedRes) return cachedRes;
          // Si no está en cache y es navegación html, devolver la raíz
          if (req.headers.get('accept') && req.headers.get('accept').includes('text/html')) {
            return caches.match('/');
          }
        });
      })
  );
});
