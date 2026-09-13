/**
 * Max/MSP Book - Client-Side Local Progress Tracker
 * Persists completion of lessons and labs directly in browser localStorage.
 * Zero-backend, zero-tracking, private and local.
 */
(function () {
  'use strict';

  const STORAGE_KEY = 'curso_max_progress:v1';

  function getStoredProgress() {
    try {
      const data = localStorage.getItem(STORAGE_KEY);
      return data ? JSON.parse(data) : { completed: [], lastVisited: '' };
    } catch (e) {
      return { completed: [], lastVisited: '' };
    }
  }

  function saveStoredProgress(progress) {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(progress));
    } catch (e) {}
  }

  function getCurrentPath() {
    let path = window.location.pathname;
    if (!path.endsWith('/')) path += '/';
    return path;
  }

  function isLessonPage() {
    const path = getCurrentPath();
    if (path === '/' || path === '') return false;
    return (
      path.includes('/00-prologo/') ||
      path.includes('/01-fundamentos/') ||
      path.includes('/02-datos-y-persistencia/') ||
      path.includes('/03-dsp-y-audio-digital/') ||
      path.includes('/04-polifonia-y-modularidad/') ||
      path.includes('/05-gen-y-dsp-avanzado/') ||
      path.includes('/06-extensiones-sdk-y-sistemas/') ||
      path.includes('/apendices/') ||
      path.includes('/glosario/') ||
      path.includes('/referencias-bibliograficas/')
    );
  }

  function updateSidebarBadges() {
    const progress = getStoredProgress();
    const completedSet = new Set(progress.completed);

    const links = document.querySelectorAll('.sidebar-content a, nav.sidebar a, .sl-sidebar a');
    links.forEach(a => {
      let href = a.getAttribute('href');
      if (!href) return;
      try {
        const url = new URL(href, window.location.origin);
        let path = url.pathname;
        if (!path.endsWith('/')) path += '/';

        let badge = a.querySelector('.progress-badge-check');
        if (completedSet.has(path)) {
          if (!badge) {
            badge = document.createElement('span');
            badge.className = 'progress-badge-check';
            badge.textContent = '✓';
            badge.title = 'Lección completada';
            a.appendChild(badge);
          }
        } else {
          if (badge) badge.remove();
        }
      } catch (e) {}
    });

    updateHeaderSummary();
  }

  function updateHeaderSummary() {
    const progress = getStoredProgress();
    const totalLessons = 44;
    const completedCount = progress.completed.length;
    const percent = Math.min(100, Math.round((completedCount / totalLessons) * 100));

    let summaryEl = document.getElementById('global-progress-pill');
    if (summaryEl) {
      summaryEl.innerHTML = `
        <span class="progress-pill-icon">⚡</span>
        <span class="progress-pill-text">Avance: <strong>${completedCount}/${totalLessons}</strong> (${percent}%)</span>
        <div class="progress-pill-bar"><div class="progress-pill-bar-fill" style="width: ${percent}%;"></div></div>
      `;
    }
  }

  function mountLessonCompletionCard() {
    if (!isLessonPage()) return;
    const currentPath = getCurrentPath();

    if (document.getElementById('lesson-completion-card')) return;

    const content = document.querySelector('.sl-markdown-content') || document.querySelector('article') || document.querySelector('main');
    if (!content) return;

    const progress = getStoredProgress();
    const isCompleted = progress.completed.includes(currentPath);

    const card = document.createElement('div');
    card.id = 'lesson-completion-card';
    card.className = 'lesson-completion-card not-content';

    function renderCardContent(completed) {
      card.innerHTML = `
        <div class="completion-card-inner">
          <div class="completion-info">
            <span class="completion-eyebrow">REGISTRO DE APRENDIZAJE LOCAL</span>
            <h4 class="completion-title">${completed ? '¡Lección y Laboratorio Completados!' : '¿Terminaste de estudiar esta lección?'}</h4>
            <p class="completion-desc">${completed ? 'Esta lección está guardada como dominada en tu navegador.' : 'Marcá tu avance para llevar control de los conceptos y parches asimilados.'}</p>
          </div>
          <button id="btn-toggle-completion" class="btn-completion ${completed ? 'is-completed' : ''}" type="button">
            <span class="btn-icon">${completed ? '✓' : '○'}</span>
            <span class="btn-text">${completed ? 'Completada' : 'Marcar como Completada'}</span>
          </button>
        </div>
      `;

      const btn = card.querySelector('#btn-toggle-completion');
      btn.addEventListener('click', function () {
        const currentProg = getStoredProgress();
        const index = currentProg.completed.indexOf(currentPath);
        if (index === -1) {
          currentProg.completed.push(currentPath);
        } else {
          currentProg.completed.splice(index, 1);
        }
        currentProg.lastVisited = currentPath;
        saveStoredProgress(currentProg);
        renderCardContent(!completed);
        updateSidebarBadges();
      });
    }

    renderCardContent(isCompleted);
    content.appendChild(card);
  }

  function mountGlobalHeaderWidget() {
    const headerRight = document.querySelector('.header .right-group') || document.querySelector('header .sl-flex') || document.querySelector('.right-group');
    if (!headerRight || document.getElementById('global-progress-pill')) return;

    const pill = document.createElement('div');
    pill.id = 'global-progress-pill';
    pill.className = 'global-progress-pill';
    pill.title = 'Tu avance en el curso guardado en este navegador';

    headerRight.insertBefore(pill, headerRight.firstChild);
    updateHeaderSummary();
  }

  function init() {
    mountGlobalHeaderWidget();
    mountLessonCompletionCard();
    updateSidebarBadges();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  document.addEventListener('astro:page-load', init);
  document.addEventListener('astro:after-swap', init);

  // Register Service Worker for offline PWA support
  if ('serviceWorker' in navigator && window.location.protocol.startsWith('http')) {
    window.addEventListener('load', function () {
      navigator.serviceWorker.register('/sw.js').catch(function (err) {
        console.debug('SW registration note:', err);
      });
    });
  }

})();
