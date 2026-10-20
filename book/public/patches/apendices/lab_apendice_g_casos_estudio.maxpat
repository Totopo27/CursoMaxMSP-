{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 8,
            "minor": 5,
            "revision": 0,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            80,
            80,
            1050,
            780
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
        "description": "Laboratorio Apendice G: Casos de Estudio y Ecosistema Creativo \u2014 AMI (Colasanto), Composicion Algoritmica Markov, jsui y mgraphics",
        "digest": "",
        "tags": "MaxMSP, Composicion Algoritmica, Markov, AMI, Colasanto, jsui, mgraphics, ecosistema creativo",
        "style": "",
        "subpatcher_template": "",
        "assistshowspatchername": 0,
        "boxes": [
            {
                "box": {
                    "fontsize": 18,
                    "fontface": 1,
                    "id": "obj-title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20,
                        15,
                        850,
                        27
                    ],
                    "text": "APENDICE G - Ecosistema Creativo: Composicion Algoritmica (AMI/Markov) + Render Visual (jsui)",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-desc",
                    "linecount": 4,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20,
                        50,
                        900,
                        64
                    ],
                    "text": "CONCEPTO: Tres pilares del ecosistema creativo profesional de Max/MSP. BLOQUE 1: Motor de cadenas de Markov de primer orden para composicion algoritmica (inspirado en el sistema AMI de Francisco Colasanto / CMMAS-UNAM). BLOQUE 2: Parametro grabado/reproducido con [pattr]. BLOQUE 3: Render de particulas vectoriales en tiempo real con [jsui] y mgraphics API.",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-sep1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20,
                        125,
                        700,
                        20
                    ],
                    "text": "--- BLOQUE 1: Cadena de Markov de 1er Orden para Melodia Algoritmica ---",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-metro",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        20,
                        153,
                        100,
                        22
                    ],
                    "text": "metro 400",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-toggle-metro",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        20,
                        123,
                        22,
                        22
                    ],
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-scale-list",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        140,
                        153,
                        260,
                        22
                    ],
                    "text": "57 60 62 64 67 69 72 74 76",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-coll-markov",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        20,
                        188,
                        200,
                        22
                    ],
                    "text": "coll markov_pentatonic @embed 1",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-random-step",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "patching_rect": [
                        240,
                        188,
                        80,
                        22
                    ],
                    "text": "random 9",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-zl-lookup",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "patching_rect": [
                        20,
                        220,
                        120,
                        22
                    ],
                    "text": "zl.lookup",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-pitch-out",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        20,
                        252,
                        80,
                        22
                    ],
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-pitch-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        110,
                        255,
                        150,
                        20
                    ],
                    "text": "<- MIDI Note (Pentatonica La)",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-noteout",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 0,
                    "patching_rect": [
                        20,
                        285,
                        80,
                        22
                    ],
                    "text": "noteout",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-vel-msg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        110,
                        285,
                        40,
                        22
                    ],
                    "text": "90",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-sep2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20,
                        325,
                        700,
                        20
                    ],
                    "text": "--- BLOQUE 2: Grabacion y Reproduccion de Gesto con [pattr] (Parameter Recording) ---",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-slider-gesto",
                    "maxclass": "slider",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        20,
                        353,
                        200,
                        30
                    ],
                    "size": 128,
                    "parameter_enable": 1,
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Gesto_Continuo",
                            "parameter_shortname": "Gesto",
                            "parameter_type": 1,
                            "parameter_mmin": 0,
                            "parameter_mmax": 127,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                64
                            ]
                        }
                    },
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-pattr-gesto",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 3,
                    "patching_rect": [
                        240,
                        353,
                        160,
                        22
                    ],
                    "text": "pattrstorage gesto_storage",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-store-btn",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        240,
                        388,
                        30,
                        30
                    ],
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-store-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        280,
                        395,
                        150,
                        20
                    ],
                    "text": "Guardar preset 1",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-store-msg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        240,
                        430,
                        80,
                        22
                    ],
                    "text": "store 1",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-recall-msg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        340,
                        430,
                        80,
                        22
                    ],
                    "text": "recall 1",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-sep3",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20,
                        475,
                        700,
                        20
                    ],
                    "text": "--- BLOQUE 3: Render Visual Vectorial en Tiempo Real con [jsui] y mgraphics ---",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-jsui-vis",
                    "maxclass": "jsui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        20,
                        500,
                        300,
                        200
                    ],
                    "parameter_enable": 0,
                    "file": "visualizador_markov.js",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-jsui-note",
                    "linecount": 4,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        340,
                        500,
                        500,
                        65
                    ],
                    "text": "JSUI: Visualizador vectorial que recibe el MIDI note y dibuja un circulo cuyo radio y color var\u00edan con el pitch. Usa mgraphics.set_source_rgba() y mgraphics.arc(). Crea el archivo 'visualizador_markov.js' en tu Max search path con el codigo incluido en el Apendice G del libro.",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-nota-markov",
                    "linecount": 5,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        460,
                        153,
                        560,
                        80
                    ],
                    "text": "CADENA DE MARKOV: El objeto [coll markov_pentatonic] almacena las probabilidades de transicion P(S_t | S_{t-1}). La escala Pentatonica de La (MIDI 57,60,62,64,67,69,72,74,76) se usa como espacio de estados. [random 9] selecciona el proximo estado. Conecta [pitch-out] a un sintetizador MSP para audio. Inspirado en el sistema AMI de Francisco Colasanto (CMMAS/UNAM).",
                    "fontname": "Arial"
                }
            },
            {
                "box": {
                    "id": "obj-pitch-out-trig",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        20,
                        277,
                        45,
                        22
                    ],
                    "text": "t i i",
                    "fontname": "Arial"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-toggle-metro",
                        0
                    ],
                    "destination": [
                        "obj-metro",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-metro",
                        0
                    ],
                    "destination": [
                        "obj-random-step",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-scale-list",
                        0
                    ],
                    "destination": [
                        "obj-zl-lookup",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-random-step",
                        0
                    ],
                    "destination": [
                        "obj-zl-lookup",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-zl-lookup",
                        0
                    ],
                    "destination": [
                        "obj-pitch-out",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-vel-msg",
                        0
                    ],
                    "destination": [
                        "obj-noteout",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-store-btn",
                        0
                    ],
                    "destination": [
                        "obj-store-msg",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-store-msg",
                        0
                    ],
                    "destination": [
                        "obj-pattr-gesto",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-recall-msg",
                        0
                    ],
                    "destination": [
                        "obj-pattr-gesto",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-pitch-out-trig",
                        0
                    ],
                    "source": [
                        "obj-pitch-out",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-jsui-vis",
                        0
                    ],
                    "source": [
                        "obj-pitch-out-trig",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-noteout",
                        0
                    ],
                    "source": [
                        "obj-pitch-out-trig",
                        0
                    ]
                }
            }
        ]
    }
}