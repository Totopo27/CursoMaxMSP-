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
      40,
      60,
      1150,
      820
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
    "description": "Laboratorio Apendice A: Computacion Visual Reactiva 3D con Jitter, jit.world y PFFT Spectral Mesh",
    "tags": "MaxMSP, Jitter, OpenGL, 3D, Audio Reactive, jit.world, pfft, jit.poke, jit.gl.mesh",
    "boxes": [
      {
        "box": {
          "fontsize": 18,
          "id": "obj-title",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            30,
            20,
            850,
            27
          ],
          "text": "APENDICE A: Computacion Visual Reactiva 3D con Jitter (jit.world & GPU Pipeline)"
        }
      },
      {
        "box": {
          "id": "obj-desc",
          "linecount": 3,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            30,
            55,
            950,
            47
          ],
          "text": "Demuestra el pipeline de computacion visual acelerado por GPU. Compara dos paradigmas reactivos:\\n1. Event-Rate Control: Modulacion de escala/rotacion en toroide 3D con peakamp~ en hilo de control.\\n2. Signal-to-GPU Pipeline: Analisis espectral FFT en tiempo de audio mediante [pfft~ FreqAnalysis.pfft] con volcado directo por [jit.poke~] a una matriz flotante que deforma una malla 3D [jit.gl.mesh] a 60 FPS."
        }
      },
      {
        "box": {
          "id": "obj-world-toggle",
          "maxclass": "toggle",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            30,
            120,
            30,
            30
          ]
        }
      },
      {
        "box": {
          "id": "obj-comment-world",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            70,
            125,
            280,
            22
          ],
          "text": "<-- Activar Contexto Grafico 3D (jit.world)"
        }
      },
      {
        "box": {
          "id": "obj-world",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "jit_matrix",
            "bang",
            ""
          ],
          "patching_rect": [
            30,
            165,
            320,
            22
          ],
          "text": "jit.world ctx_apendice_a @floating 1 @size 640 480 @fsaa 1 @erase_color 0.08 0.08 0.1 1."
        }
      },
      {
        "box": {
          "fontsize": 14,
          "id": "obj-sec1",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            380,
            120,
            320,
            22
          ],
          "text": "GENERADOR DE SENAL DE AUDIO"
        }
      },
      {
        "box": {
          "id": "obj-osc-audio",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            380,
            150,
            66,
            22
          ],
          "text": "cycle~ 220"
        }
      },
      {
        "box": {
          "id": "obj-saw-audio",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            455,
            150,
            58,
            22
          ],
          "text": "saw~ 330"
        }
      },
      {
        "box": {
          "id": "obj-mix-audio",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            380,
            185,
            94,
            22
          ],
          "text": "+~"
        }
      },
      {
        "box": {
          "id": "obj-gain-audio",
          "maxclass": "gain~",
          "multichannelvariant": 0,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            380,
            225,
            140,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-ezdac",
          "maxclass": "ezdac~",
          "numinlets": 2,
          "numoutlets": 0,
          "patching_rect": [
            380,
            260,
            45,
            45
          ]
        }
      },
      {
        "box": {
          "fontsize": 14,
          "id": "obj-sec2",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            30,
            330,
            360,
            22
          ],
          "text": "PARADIGMA 1: Control-Rate (peakamp~ + Toroide 3D)"
        }
      },
      {
        "box": {
          "id": "obj-peak-amp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "float"
          ],
          "patching_rect": [
            30,
            360,
            81,
            22
          ],
          "text": "peakamp~ 20"
        }
      },
      {
        "box": {
          "id": "obj-scale-mod",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            30,
            395,
            115,
            22
          ],
          "text": "scale 0. 1. 0.3 0.9"
        }
      },
      {
        "box": {
          "id": "obj-msg-scale",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            30,
            430,
            105,
            22
          ],
          "text": "scale   "
        }
      },
      {
        "box": {
          "id": "obj-accum-rot",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            160,
            395,
            60,
            22
          ],
          "text": "accum 1"
        }
      },
      {
        "box": {
          "id": "obj-msg-rot",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            160,
            430,
            110,
            22
          ],
          "text": "rotatexyz   0."
        }
      },
      {
        "box": {
          "id": "obj-gl-shape",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "jit_matrix",
            ""
          ],
          "patching_rect": [
            30,
            475,
            450,
            22
          ],
          "text": "jit.gl.gridshape ctx_apendice_a @shape torus @position -1.2 0. 0. @lighting_enable 1 @smooth_shading 1 @color 1.0 0.4 0.2 1."
        }
      },
      {
        "box": {
          "fontsize": 14,
          "id": "obj-sec3",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            520,
            330,
            520,
            22
          ],
          "text": "PARADIGMA 2: Signal-to-GPU (PFFT + jit.poke~ + Malla 3D a 60 FPS)"
        }
      },
      {
        "box": {
          "id": "obj-pfft",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            520,
            380,
            175,
            22
          ],
          "text": "pfft~ FreqAnalysis.pfft 512 2"
        }
      },
      {
        "box": {
          "id": "obj-dimmap",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "jit_matrix",
            ""
          ],
          "patching_rect": [
            520,
            420,
            128,
            22
          ],
          "text": "jit.dimmap @invert 0 1"
        }
      },
      {
        "box": {
          "id": "obj-gen-mesh",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "jit_matrix",
            ""
          ],
          "patcher": {
            "fileversion": 1,
            "appversion": {
              "major": 8,
              "minor": 5,
              "revision": 0,
              "architecture": "x64",
              "modernui": 1
            },
            "classnamespace": "jit.gen",
            "rect": [
              50,
              50,
              600,
              400
            ],
            "bglocked": 0,
            "openinpresentation": 0,
            "boxes": [
              {
                "box": {
                  "id": "gen-in1",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50,
                    40,
                    30,
                    22
                  ],
                  "text": "in 1"
                }
              },
              {
                "box": {
                  "id": "gen-snorm",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    100,
                    40,
                    45,
                    22
                  ],
                  "text": "snorm"
                }
              },
              {
                "box": {
                  "id": "gen-swiz-x",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    100,
                    80,
                    42,
                    22
                  ],
                  "text": "swiz y"
                }
              },
              {
                "box": {
                  "id": "gen-scale-amp",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50,
                    80,
                    39,
                    22
                  ],
                  "text": "* 0.05"
                }
              },
              {
                "box": {
                  "id": "gen-vec",
                  "maxclass": "newobj",
                  "numinlets": 3,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    50,
                    140,
                    110,
                    22
                  ],
                  "text": "vec 0. 0. 0."
                }
              },
              {
                "box": {
                  "id": "gen-out1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    50,
                    190,
                    35,
                    22
                  ],
                  "text": "out 1"
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "destination": [
                    "gen-scale-amp",
                    0
                  ],
                  "source": [
                    "gen-in1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "gen-swiz-x",
                    0
                  ],
                  "source": [
                    "gen-snorm",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "gen-vec",
                    0
                  ],
                  "source": [
                    "gen-swiz-x",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "gen-vec",
                    1
                  ],
                  "source": [
                    "gen-scale-amp",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "destination": [
                    "gen-out1",
                    0
                  ],
                  "source": [
                    "gen-vec",
                    0
                  ]
                }
              }
            ]
          },
          "patching_rect": [
            520,
            460,
            52,
            22
          ],
          "text": "jit.gen"
        }
      },
      {
        "box": {
          "id": "obj-gl-mesh",
          "maxclass": "newobj",
          "numinlets": 9,
          "numoutlets": 2,
          "outlettype": [
            "jit_matrix",
            ""
          ],
          "patching_rect": [
            520,
            505,
            420,
            22
          ],
          "text": "jit.gl.mesh ctx_apendice_a @draw_mode line_strip @position 0.8 0. 0. @line_width 2.5 @color 0.2 0.8 1. 1."
        }
      },
      {
        "box": {
          "id": "obj-comment-flow",
          "linecount": 4,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            520,
            545,
            450,
            60
          ],
          "text": "FLUJO TECNICO:\\n1. Cada frame grafico (bang de jit.world) solicita la matriz de analisis de pfft~.\\n2. En pfft~, [jit.poke~] ha escrito todas las magnitudes de bins en [jit.matrix analysis].\\n3. [jit.gen] transforma los bins en coordenadas 3D (X = indice de bin, Y = magnitud FFT).\\n4. [jit.gl.mesh] dibuja la curva espectral reactiva con aceleracion directa por GPU."
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "destination": [
            "obj-world",
            0
          ],
          "source": [
            "obj-world-toggle",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-accum-rot",
            0
          ],
          "source": [
            "obj-world",
            1
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-pfft",
            0
          ],
          "midpoints": [
            190,
            200,
            360,
            200,
            360,
            365,
            529.5,
            365
          ],
          "source": [
            "obj-world",
            1
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-msg-rot",
            0
          ],
          "source": [
            "obj-accum-rot",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-gl-shape",
            0
          ],
          "source": [
            "obj-msg-rot",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-mix-audio",
            0
          ],
          "source": [
            "obj-osc-audio",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-mix-audio",
            1
          ],
          "source": [
            "obj-saw-audio",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-gain-audio",
            0
          ],
          "source": [
            "obj-mix-audio",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-peak-amp",
            0
          ],
          "source": [
            "obj-gain-audio",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-ezdac",
            0
          ],
          "source": [
            "obj-gain-audio",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-ezdac",
            1
          ],
          "source": [
            "obj-gain-audio",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-pfft",
            0
          ],
          "midpoints": [
            389.5,
            315,
            529.5,
            315
          ],
          "source": [
            "obj-gain-audio",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-scale-mod",
            0
          ],
          "source": [
            "obj-peak-amp",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-msg-scale",
            0
          ],
          "source": [
            "obj-scale-mod",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-gl-shape",
            0
          ],
          "source": [
            "obj-msg-scale",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-dimmap",
            0
          ],
          "source": [
            "obj-pfft",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-gen-mesh",
            0
          ],
          "source": [
            "obj-dimmap",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-gl-mesh",
            0
          ],
          "source": [
            "obj-gen-mesh",
            0
          ]
        }
      }
    ]
  }
}