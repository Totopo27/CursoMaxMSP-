/**
 * Max/MSP Book - Image Zoom & Fullscreen Viewer
 * Lightweight, zero-dependency, accessible image modal for mobile & desktop.
 * Allows expanding technical diagrams with pinch-zoom support, caption display,
 * backdrop click to close, ESC key, and clean animations.
 */
(function () {
  'use strict';

  let modal = null;
  let modalImg = null;
  let modalCaption = null;
  let closeBtn = null;
  let lastActiveElement = null;

  function createModal() {
    if (document.getElementById('image-zoom-modal')) {
      modal = document.getElementById('image-zoom-modal');
      modalImg = modal.querySelector('.image-zoom-img');
      modalCaption = modal.querySelector('.image-zoom-caption');
      closeBtn = modal.querySelector('.image-zoom-close');
      return;
    }

    modal = document.createElement('dialog');
    modal.id = 'image-zoom-modal';
    modal.className = 'image-zoom-modal';
    modal.setAttribute('aria-label', 'Visor de diagrama a pantalla completa');

    const container = document.createElement('div');
    container.className = 'image-zoom-container';

    closeBtn = document.createElement('button');
    closeBtn.type = 'button';
    closeBtn.className = 'image-zoom-close';
    closeBtn.setAttribute('aria-label', 'Cerrar vista previa');
    closeBtn.innerHTML = '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>';

    const imgWrapper = document.createElement('div');
    imgWrapper.className = 'image-zoom-img-wrapper';

    modalImg = document.createElement('img');
    modalImg.className = 'image-zoom-img';
    modalImg.setAttribute('alt', '');

    modalCaption = document.createElement('div');
    modalCaption.className = 'image-zoom-caption';

    imgWrapper.appendChild(modalImg);
    container.appendChild(closeBtn);
    container.appendChild(imgWrapper);
    container.appendChild(modalCaption);
    modal.appendChild(container);

    document.body.appendChild(modal);

    closeBtn.addEventListener('click', closeModal);

    modal.addEventListener('click', function (e) {
      if (e.target === modal || e.target === imgWrapper || e.target === container) {
        closeModal();
      }
    });

    modal.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') {
        e.preventDefault();
        closeModal();
      }
    });

    modal.addEventListener('cancel', function (e) {
      e.preventDefault();
      closeModal();
    });
  }

  function openModal(src, alt) {
    if (!modal) createModal();
    lastActiveElement = document.activeElement;

    modalImg.src = src;
    modalImg.alt = alt || 'Diagrama ampliado';

    if (alt) {
      modalCaption.textContent = alt;
      modalCaption.style.display = 'block';
    } else {
      modalCaption.textContent = '';
      modalCaption.style.display = 'none';
    }

    if (typeof modal.showModal === 'function') {
      modal.showModal();
    } else {
      modal.setAttribute('open', '');
    }

    document.body.classList.add('image-zoom-active');
    closeBtn.focus();
  }

  function closeModal() {
    if (!modal) return;
    if (typeof modal.close === 'function') {
      modal.close();
    } else {
      modal.removeAttribute('open');
    }
    document.body.classList.remove('image-zoom-active');
    modalImg.src = '';
    if (lastActiveElement && typeof lastActiveElement.focus === 'function') {
      lastActiveElement.focus();
    }
  }

  function attachImageListeners() {
    createModal();
    const images = document.querySelectorAll('.sl-markdown-content img');
    images.forEach(function (img) {
      if (img.dataset.zoomAttached === 'true') return;
      img.dataset.zoomAttached = 'true';
      img.classList.add('zoomable-image');
      img.setAttribute('tabindex', '0');
      img.setAttribute('role', 'button');
      img.setAttribute('aria-label', (img.alt ? img.alt + ' - ' : '') + 'Tocar para expandir imagen');

      img.addEventListener('click', function () {
        openModal(img.currentSrc || img.src, img.alt);
      });

      img.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          openModal(img.currentSrc || img.src, img.alt);
        }
      });
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', attachImageListeners);
  } else {
    attachImageListeners();
  }

  document.addEventListener('astro:page-load', attachImageListeners);
  window.addEventListener('pageshow', attachImageListeners);
})();
