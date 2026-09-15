// Service Worker para Curso Max/MSP
// Aislamiento estricto de cache y seguridad de ciclo de vida
const CACHE_PREFIX = 'curso-max-cache-';
const CACHE_VERSION = 'v1';
const CURRENT_CACHE_NAME = `${CACHE_PREFIX}${CACHE_VERSION}`;

const STATIC_ASSETS = [
  '/',
  '/favicon.svg',
  '/manifest.json',
  '/progress-tracker.js'
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CURRENT_CACHE_NAME).then((cache) => {
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
          // Eliminar UNICAMENTE caches antiguos que pertenezcan a esta aplicacion
          if (key.startsWith(CACHE_PREFIX) && key !== CURRENT_CACHE_NAME) {
            return caches.delete(key);
          }
        })
      );
    })
  );
  self.clients.claim();
});

// Estrategia Network-First con fallback seguro a Cache
self.addEventListener('fetch', (event) => {
  const req = event.request;
  if (req.method !== 'GET') return;

  const url = new URL(req.url);
  // Restringir el almacenamiento en cache exclusivamente al mismo origen
  if (url.origin !== self.location.origin) return;

  event.respondWith(
    fetch(req)
      .then((networkRes) => {
        // Guardar en cache solo respuestas exitosas del mismo origen
        if (networkRes && networkRes.status === 200 && networkRes.type === 'basic') {
          const resClone = networkRes.clone();
          caches.open(CURRENT_CACHE_NAME).then((cache) => cache.put(req, resClone));
        }
        return networkRes;
      })
      .catch(() => {
        return caches.match(req).then((cachedRes) => {
          if (cachedRes) return cachedRes;
          // Si falla la red y no hay cache, devolver 503 controlado para evitar falsas paginas de inicio
          return new Response('Contenido no disponible sin conexión.', {
            status: 503,
            statusText: 'Service Unavailable',
            headers: { 'Content-Type': 'text/plain; charset=utf-8' }
          });
        });
      })
  );
});
