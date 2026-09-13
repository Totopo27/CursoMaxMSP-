import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import remarkMath from 'remark-math';
import rehypeKatex from 'rehype-katex';
export default defineConfig({
  site: 'https://curso-max.pajarobobo.xyz',
  markdown: {
    remarkPlugins: [remarkMath],
    rehypePlugins: [rehypeKatex],
  },
  integrations: [
    starlight({
      title: 'Max/MSP: Del Concepto al Motor Nativo',
      description: 'Curso integral de Max/MSP, MSP Audio, Gen~, C SDK y Sistemas Multimedia.',
      favicon: '/favicon.svg',
      defaultLocale: 'root',
      locales: {
        root: {
          label: 'Español',
          lang: 'es',
        },
      },
      social: {
        github: 'https://github.com/Totopo27/CursoMaxMSP-',
      },
      sidebar: [
        {
          label: 'Módulo 0: Entorno, Interfaz y Flujo de Trabajo',
          autogenerate: { directory: '00-prologo' },
        },
        {
          label: 'Módulo 1: Fundamentos y Paradigma Dataflow',
          autogenerate: { directory: '01-fundamentos' },
        },
        {
          label: 'Módulo 2: Datos, Persistencia y Comunicación',
          autogenerate: { directory: '02-datos-y-persistencia' },
        },
        {
          label: 'Módulo 3: El Universo DSP y Audio Digital',
          autogenerate: { directory: '03-dsp-y-audio-digital' },
        },
        {
          label: 'Módulo 4: Abstracciones y Polifonía Avanzada',
          autogenerate: { directory: '04-polifonia-y-modularidad' },
        },
        {
          label: 'Módulo 5: Gen~ y DSP de Bajo Nivel',
          autogenerate: { directory: '05-gen-y-dsp-avanzado' },
        },
        {
          label: 'Módulo 6: Extensiones, Node for Max y C SDK',
          autogenerate: { directory: '06-extensiones-sdk-y-sistemas' },
        },
        {
          label: 'Apéndices Especializados',
          autogenerate: { directory: 'apendices' },
        },
        {
          label: 'Referencias Bibliográficas',
          slug: 'referencias-bibliograficas',
        },
      ],
      customCss: ['./src/styles/custom.css'],
    }),
  ],
});
