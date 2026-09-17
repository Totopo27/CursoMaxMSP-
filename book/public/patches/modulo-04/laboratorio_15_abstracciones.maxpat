{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 9,
      "minor": 0,
      "revision": 0,
      "architecture": "x64",
      "modernui": 1
    },
    "classnamespace": "box",
    "rect": [
      50,
      50,
      1250,
      950
    ],
    "bglocked": 0,
    "openinpresentation": 0,
    "default_fontsize": 12,
    "default_fontface": 0,
    "default_fontname": "Arial",
    "gridonopen": 1,
    "gridsize": [
      15,
      15
    ],
    "gridsnaponopen": 1,
    "objectsnaponopen": 1,
    "statusbarvisible": 2,
    "toolbarvisible": 1,
    "lefttoolbarpinned": 0,
    "toptoolbarpinned": 0,
    "righttoolbarpinned": 0,
    "bottomtoolbarpinned": 0,
    "toolbars_unpinned_last_save": 0,
    "tallnewobj": 0,
    "boxanimatetime": 200,
    "enablehscroll": 1,
    "enablevscroll": 1,
    "devicewidth": 0,
    "description": "Laboratorio 15: Modularidad, Abstracciones y Namespaces (#0)",
    "digest": "",
    "tags": "Max Abstractions Modular Architecture Namespace Instances",
    "style": "",
    "subpatcher_template": "",
    "assistshowspreset": 0,
    "boxes": [
      {
        "box": {
          "id": "obj-1",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            25,
            20,
            750,
            30
          ],
          "text": "LABORATORIO 15: ABSTRACCIONES, ARGUMENTOS (#1 #2) Y AISLAMIENTO (#0)",
          "fontname": "Arial Bold",
          "fontsize": 18
        }
      },
      {
        "box": {
          "id": "obj-2",
          "linecount": 3,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            25,
            55,
            850,
            47
          ],
          "text": "Demostración práctica de instanciación múltiple de la abstracción [mi_filtro_voz].\nInstancia 1 inicializada en 300 Hz con resonancia 0.85.\nInstancia 2 inicializada en 1200 Hz con resonancia 0.50.\nCada módulo opera con su propio bus local aislado (#0_mod) sin colisiones cruzadas."
        }
      },
      {
        "box": {
          "id": "obj-3",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            35,
            120,
            180,
            20
          ],
          "text": "EXCITADOR DE ENTRADA",
          "fontname": "Arial Bold"
        }
      },
      {
        "box": {
          "id": "obj-4",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            35,
            150,
            66,
            22
          ],
          "text": "saw~ 110."
        }
      },
      {
        "box": {
          "id": "obj-5",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            250,
            120,
            280,
            20
          ],
          "text": "INSTANCIA 1: [mi_filtro_voz 300. 0.85]",
          "fontname": "Arial Bold"
        }
      },
      {
        "box": {
          "id": "obj-6",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            380,
            150,
            60,
            22
          ],
          "minimum": -200,
          "maximum": 500
        }
      },
      {
        "box": {
          "id": "obj-7",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            445,
            150,
            140,
            20
          ],
          "text": "Offset Local Instancia 1"
        }
      },
      {
        "box": {
          "id": "obj-8",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            250,
            190,
            149,
            22
          ],
          "text": "mi_filtro_voz 300. 0.85"
        }
      },
      {
        "box": {
          "id": "obj-9",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            650,
            120,
            280,
            20
          ],
          "text": "INSTANCIA 2: [mi_filtro_voz 1200. 0.50]",
          "fontname": "Arial Bold"
        }
      },
      {
        "box": {
          "id": "obj-10",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            780,
            150,
            60,
            22
          ],
          "minimum": -500,
          "maximum": 1000
        }
      },
      {
        "box": {
          "id": "obj-11",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            845,
            150,
            140,
            20
          ],
          "text": "Offset Local Instancia 2"
        }
      },
      {
        "box": {
          "id": "obj-12",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            650,
            190,
            149,
            22
          ],
          "text": "mi_filtro_voz 1200. 0.5"
        }
      },
      {
        "box": {
          "id": "obj-13",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            250,
            250,
            250,
            20
          ],
          "text": "ESPECTRO INSTANCIA 1 (Pico 300 Hz)",
          "fontname": "Arial Bold"
        }
      },
      {
        "box": {
          "id": "obj-14",
          "maxclass": "spectroscope~",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            250,
            275,
            360,
            140
          ]
        }
      },
      {
        "box": {
          "id": "obj-15",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            650,
            250,
            260,
            20
          ],
          "text": "ESPECTRO INSTANCIA 2 (Pico 1200 Hz)",
          "fontname": "Arial Bold"
        }
      },
      {
        "box": {
          "id": "obj-16",
          "maxclass": "spectroscope~",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            650,
            275,
            360,
            140
          ]
        }
      },
      {
        "box": {
          "id": "obj-17",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            250,
            440,
            419,
            22
          ],
          "text": "+~"
        }
      },
      {
        "box": {
          "id": "obj-18",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            250,
            480,
            47,
            22
          ],
          "text": "*~ 0.3"
        }
      },
      {
        "box": {
          "id": "obj-19",
          "maxclass": "gain~",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            250,
            520,
            130,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-20",
          "maxclass": "ezdac~",
          "numinlets": 2,
          "numoutlets": 0,
          "patching_rect": [
            250,
            565,
            45,
            45
          ]
        }
      },
      {
        "box": {
          "id": "obj-sec3-title",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            25,
            560,
            580,
            24
          ],
          "text": "PATRON DE ROBUSTEZ: ARGUMENT FALLBACK DINAMICO ([ab.sus])",
          "fontname": "Arial Bold",
          "fontsize": 14
        }
      },
      {
        "box": {
          "id": "obj-sec3-desc",
          "linecount": 2,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            25,
            585,
            550,
            33
          ],
          "text": "Si la entrada de control recibe 0. o un valor nulo, [ab.sus 440.] sustituye dinamicamente el valor por el argumento por defecto #1 (440 Hz)."
        }
      },
      {
        "box": {
          "format": 6,
          "id": "obj-sus-in",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            25,
            625,
            60,
            22
          ],
          "value": 0
        }
      },
      {
        "box": {
          "id": "obj-sus-inst",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25,
            660,
            80,
            22
          ],
          "text": "ab.sus 440."
        }
      },
      {
        "box": {
          "format": 6,
          "id": "obj-sus-out",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            25,
            695,
            60,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-sec4-title",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            620,
            560,
            550,
            24
          ],
          "text": "ARQUITECTURA DE VOZ MODULAR: [subsynth.osc~]",
          "fontname": "Arial Bold",
          "fontsize": 14
        }
      },
      {
        "box": {
          "id": "obj-sec4-desc",
          "linecount": 2,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            620,
            585,
            550,
            33
          ],
          "text": "Abstraccion modular de 4 formas de onda (saw, tri, rect con PWM, noise) con hard-sync y conmutacion limpia por [selector~ 4]."
        }
      },
      {
        "box": {
          "id": "obj-osc-type-label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            620,
            625,
            110,
            20
          ],
          "text": "Forma (0..3)"
        }
      },
      {
        "box": {
          "id": "obj-osc-type",
          "maxclass": "number",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            620,
            650,
            50,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-osc-pw-label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            750,
            625,
            90,
            20
          ],
          "text": "Pulse Width"
        }
      },
      {
        "box": {
          "format": 6,
          "id": "obj-osc-pw",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            750,
            650,
            50,
            22
          ],
          "value": 0.5
        }
      },
      {
        "box": {
          "id": "obj-osc-inst",
          "maxclass": "newobj",
          "numinlets": 4,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            620,
            710,
            160,
            22
          ],
          "text": "subsynth.osc~ 220."
        }
      },
      {
        "box": {
          "id": "obj-osc-scope",
          "maxclass": "scope~",
          "numinlets": 2,
          "numoutlets": 0,
          "patching_rect": [
            620,
            755,
            150,
            100
          ]
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "destination": [
            "obj-8",
            0
          ],
          "order": 1,
          "source": [
            "obj-4",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-12",
            0
          ],
          "order": 0,
          "source": [
            "obj-4",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-8",
            1
          ],
          "source": [
            "obj-6",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-14",
            0
          ],
          "order": 0,
          "source": [
            "obj-8",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-17",
            0
          ],
          "order": 1,
          "source": [
            "obj-8",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-12",
            1
          ],
          "source": [
            "obj-10",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-16",
            0
          ],
          "order": 0,
          "source": [
            "obj-12",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-17",
            1
          ],
          "order": 1,
          "source": [
            "obj-12",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-18",
            0
          ],
          "source": [
            "obj-17",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-19",
            0
          ],
          "source": [
            "obj-18",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-20",
            1
          ],
          "order": 0,
          "source": [
            "obj-19",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-20",
            0
          ],
          "order": 1,
          "source": [
            "obj-19",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-sus-inst",
            0
          ],
          "source": [
            "obj-sus-in",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-sus-out",
            0
          ],
          "source": [
            "obj-sus-inst",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-osc-inst",
            1
          ],
          "source": [
            "obj-sus-out",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-osc-inst",
            0
          ],
          "source": [
            "obj-osc-type",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-osc-inst",
            2
          ],
          "source": [
            "obj-osc-pw",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-osc-scope",
            0
          ],
          "source": [
            "obj-osc-inst",
            0
          ]
        }
      }
    ]
  }
}