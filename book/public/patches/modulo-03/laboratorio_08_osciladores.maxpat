{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 8,
      "minor": 6,
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
    "description": "Curso Max/MSP - Laboratorio 08: Generadores de Señal, Tablas de Onda y Anti-Aliasing",
    "digest": "",
    "tags": "cycle phasor saw rect noise aliasing band-limited",
    "style": "",
    "subpatcher_template": "",
    "assistshowspatchername": 0,
    "boxes": [
      {
        "box": {
          "fontsize": 22,
          "id": "obj-1",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            30,
            20,
            850,
            31
          ],
          "text": "LABORATORIO 08: Osciladores Básicos, Formas de Onda y Anti-Aliasing"
        }
      },
      {
        "box": {
          "id": "obj-2",
          "linecount": 2,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            30,
            55,
            850,
            33
          ],
          "text": "Estudio acústico y espectral: Comparativa auditi va de aliasing entre [phasor~] (naive) y [saw~] (band-limited), generador PWM y percusión con [noise~]."
        }
      },
      {
        "box": {
          "fontface": 1,
          "fontsize": 14,
          "id": "obj-10",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            40,
            110,
            380,
            22
          ],
          "text": "1. TEST DE ALIASING: [phasor~] VS [saw~]"
        }
      },
      {
        "box": {
          "id": "obj-11",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            40,
            140,
            140,
            20
          ],
          "text": "Frecuencia de Test (Hz)"
        }
      },
      {
        "box": {
          "format": 6,
          "id": "obj-12",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            40,
            165,
            70,
            22
          ],
          "value": 4000
        }
      },
      {
        "box": {
          "id": "obj-13",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            120,
            165,
            50,
            22
          ],
          "text": "8000."
        }
      },
      {
        "box": {
          "id": "obj-14",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            180,
            165,
            50,
            22
          ],
          "text": "12000."
        }
      },
      {
        "box": {
          "color": [
            0.9,
            0.2,
            0.2,
            1
          ],
          "id": "obj-15",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            40,
            215,
            80,
            22
          ],
          "text": "phasor~ 4000"
        }
      },
      {
        "box": {
          "color": [
            0.2,
            0.7,
            0.3,
            1
          ],
          "id": "obj-16",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            150,
            215,
            68,
            22
          ],
          "text": "saw~ 4000"
        }
      },
      {
        "box": {
          "id": "obj-17",
          "linecount": 3,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            40,
            255,
            360,
            47
          ],
          "text": "Conmuta entre ambos: A 8000 Hz, [phasor~] produce armónicos inarmónicos que rebotan hacia abajo (aliasing sucio). [saw~] mantiene el espectro limpio y musical."
        }
      },
      {
        "box": {
          "fontface": 1,
          "fontsize": 14,
          "id": "obj-30",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            460,
            110,
            380,
            22
          ],
          "text": "2. SELECTOR DE FORMA DE ONDA AUDIBLE"
        }
      },
      {
        "box": {
          "id": "obj-31",
          "maxclass": "radiogroup",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            460,
            140,
            18,
            66
          ],
          "size": 4,
          "value": 1
        }
      },
      {
        "box": {
          "id": "obj-32",
          "linecount": 4,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            490,
            140,
            140,
            60
          ],
          "text": "0: Phasor (Naive Saw)\n1: Saw~ (Band-limited)\n2: Cycle~ (Sinusoide)\n3: Noise~ (Ruido Blanco)"
        }
      },
      {
        "box": {
          "id": "obj-33",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            460,
            220,
            29.5,
            22
          ],
          "text": "+ 1"
        }
      },
      {
        "box": {
          "color": [
            0.9,
            0.5,
            0.2,
            1
          ],
          "id": "obj-34",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            240,
            215,
            75,
            22
          ],
          "text": "cycle~ 4000"
        }
      },
      {
        "box": {
          "color": [
            0.7,
            0.4,
            0.9,
            1
          ],
          "id": "obj-35",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            330,
            215,
            44,
            22
          ],
          "text": "noise~"
        }
      },
      {
        "box": {
          "color": [
            0.9,
            0.5,
            0.2,
            1
          ],
          "id": "obj-36",
          "maxclass": "newobj",
          "numinlets": 5,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            460,
            260,
            80,
            22
          ],
          "text": "selector~ 4 1"
        }
      },
      {
        "box": {
          "id": "obj-37",
          "maxclass": "scope~",
          "numinlets": 2,
          "numoutlets": 0,
          "patching_rect": [
            570,
            260,
            200,
            100
          ]
        }
      },
      {
        "box": {
          "fontface": 1,
          "fontsize": 14,
          "id": "obj-50",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            40,
            360,
            480,
            22
          ],
          "text": "3. MODULACIÓN DE ANCHO DE PULSO (PWM)"
        }
      },
      {
        "box": {
          "id": "obj-51",
          "linecount": 3,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            40,
            390,
            420,
            47
          ],
          "text": "PWM clásico: [phasor~ 110] comparado con un umbral móvil mediante [>~]. Modula el slider de ancho de 0.05 a 0.95 para mutar el timbre."
        }
      },
      {
        "box": {
          "id": "obj-52",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            40,
            450,
            72,
            22
          ],
          "text": "phasor~ 110"
        }
      },
      {
        "box": {
          "floatoutput": 1,
          "id": "obj-53",
          "maxclass": "slider",
          "min": 0.05,
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            130,
            450,
            140,
            20
          ],
          "size": 0.9
        }
      },
      {
        "box": {
          "color": [
            0.2,
            0.7,
            0.3,
            1
          ],
          "id": "obj-54",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            130,
            485,
            31,
            22
          ],
          "text": "sig~"
        }
      },
      {
        "box": {
          "color": [
            0.9,
            0.2,
            0.2,
            1
          ],
          "id": "obj-55",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            40,
            520,
            109,
            22
          ],
          "text": ">~ 0.5"
        }
      },
      {
        "box": {
          "id": "obj-56",
          "maxclass": "scope~",
          "numinlets": 2,
          "numoutlets": 0,
          "patching_rect": [
            40,
            560,
            180,
            80
          ]
        }
      },
      {
        "box": {
          "fontface": 1,
          "fontsize": 14,
          "id": "obj-60",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            460,
            410,
            380,
            22
          ],
          "text": "4. ETAPA MASTER CON GANANCIA Y DAC"
        }
      },
      {
        "box": {
          "id": "obj-61",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            460,
            450,
            40,
            22
          ],
          "text": "*~ 0.2"
        }
      },
      {
        "box": {
          "id": "obj-62",
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
            460,
            490,
            35,
            100
          ]
        }
      },
      {
        "box": {
          "id": "obj-63",
          "maxclass": "ezdac~",
          "numinlets": 2,
          "numoutlets": 0,
          "patching_rect": [
            460,
            610,
            45,
            45
          ]
        }
      },
      {
        "box": {
          "id": "obj-70",
          "linecount": 3,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            520,
            610,
            380,
            47
          ],
          "text": "Instrucciones de Laboratorio:\n1. Enciende el ezdac~ y sube gain~.\n2. Conmuta en el radiogroup entre 0 (Phasor) y 1 (Saw).\n3. Modula la frecuencia a 8000 o 12000 Hz para oír el aliasing."
        }
      },
      {
        "box": {
          "fontface": 1,
          "fontsize": 14,
          "id": "obj-mc-sec-title",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            40,
            680,
            480,
            22
          ],
          "text": "5. SINTESIS ADITIVA MULTICANAL ([mc.cycle~] & [mc.*~])"
        }
      },
      {
        "box": {
          "id": "obj-mc-desc",
          "linecount": 2,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            40,
            705,
            550,
            33
          ],
          "text": "Genera 10 osciladores en paralelo dentro de un unico cable multicanal. Modula amplitudes individuales con multislider y conmuta entre espectro armonico e inarmonico."
        }
      },
      {
        "box": {
          "id": "obj-mc-f0-comment",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            40,
            745,
            110,
            20
          ],
          "text": "Fundamental (Hz)"
        }
      },
      {
        "box": {
          "format": 6,
          "id": "obj-mc-f0",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            40,
            770,
            65,
            22
          ],
          "value": 110
        }
      },
      {
        "box": {
          "id": "obj-mc-msg-harmonic",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            40,
            805,
            88,
            22
          ],
          "text": "harmonic 1 $1"
        }
      },
      {
        "box": {
          "id": "obj-mc-msg-inharmonic",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            140,
            805,
            310,
            22
          ],
          "text": "values 110. 303.6 594. 982.3 1475. 2040. 2700. 3450. 4280. 5200."
        }
      },
      {
        "box": {
          "id": "obj-mc-cycle",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "multichansignal"
          ],
          "patching_rect": [
            40,
            845,
            145,
            22
          ],
          "text": "mc.cycle~ @chans 10"
        }
      },
      {
        "box": {
          "candycane": 10,
          "contdata": 1,
          "id": "obj-mc-multislider",
          "maxclass": "multislider",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            480,
            755,
            180,
            75
          ],
          "setminmax": [
            0,
            1
          ],
          "size": 10
        }
      },
      {
        "box": {
          "id": "obj-mc-prepend-amps",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            480,
            840,
            115,
            22
          ],
          "text": "prepend applyvalues"
        }
      },
      {
        "box": {
          "id": "obj-mc-mult",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "multichansignal"
          ],
          "patching_rect": [
            40,
            885,
            459,
            22
          ],
          "text": "mc.*~"
        }
      },
      {
        "box": {
          "id": "obj-mc-mixdown",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            40,
            920,
            160,
            22
          ],
          "text": "mc.mixdown~ 1 @autogain 1"
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "destination": [
            "obj-15",
            0
          ],
          "order": 3,
          "source": [
            "obj-12",
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
          "order": 2,
          "source": [
            "obj-12",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-34",
            0
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
            "obj-12",
            0
          ],
          "source": [
            "obj-13",
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
          "source": [
            "obj-14",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-36",
            1
          ],
          "source": [
            "obj-15",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-36",
            2
          ],
          "source": [
            "obj-16",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-33",
            0
          ],
          "source": [
            "obj-31",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-36",
            0
          ],
          "source": [
            "obj-33",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-36",
            3
          ],
          "source": [
            "obj-34",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-36",
            4
          ],
          "source": [
            "obj-35",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-37",
            0
          ],
          "order": 0,
          "source": [
            "obj-36",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-61",
            0
          ],
          "order": 1,
          "source": [
            "obj-36",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-55",
            0
          ],
          "source": [
            "obj-52",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-54",
            0
          ],
          "source": [
            "obj-53",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-55",
            1
          ],
          "source": [
            "obj-54",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-56",
            0
          ],
          "source": [
            "obj-55",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-62",
            0
          ],
          "source": [
            "obj-61",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-63",
            1
          ],
          "order": 0,
          "source": [
            "obj-62",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-63",
            0
          ],
          "order": 1,
          "source": [
            "obj-62",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-mc-msg-harmonic",
            0
          ],
          "source": [
            "obj-mc-f0",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-mc-cycle",
            0
          ],
          "source": [
            "obj-mc-msg-harmonic",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-mc-cycle",
            0
          ],
          "source": [
            "obj-mc-msg-inharmonic",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-mc-mult",
            0
          ],
          "source": [
            "obj-mc-cycle",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-mc-prepend-amps",
            0
          ],
          "source": [
            "obj-mc-multislider",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-mc-mult",
            1
          ],
          "source": [
            "obj-mc-prepend-amps",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-mc-mixdown",
            0
          ],
          "source": [
            "obj-mc-mult",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-61",
            0
          ],
          "source": [
            "obj-mc-mixdown",
            0
          ]
        }
      }
    ]
  }
}