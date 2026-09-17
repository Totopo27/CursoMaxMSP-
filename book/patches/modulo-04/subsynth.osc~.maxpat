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
      100,
      100,
      600,
      480
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
    "description": "subsynth.osc~: Oscilador compuesto multi-forma (saw, tri, rect-PWM, noise) con hard-sync",
    "boxes": [
      {
        "box": {
          "id": "obj-title",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            25,
            15,
            420,
            20
          ],
          "text": "subsynth.osc~: Oscilador compuesto con hard-sync y PWM"
        }
      },
      {
        "box": {
          "comment": "waveform selector (0=saw, 1=tri, 2=rect, 3=noise)",
          "id": "obj-in-type",
          "index": 1,
          "maxclass": "inlet",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            40,
            50,
            25,
            25
          ]
        }
      },
      {
        "box": {
          "comment": "frequency (signal/float)",
          "id": "obj-in-freq",
          "index": 2,
          "maxclass": "inlet",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            120,
            50,
            25,
            25
          ]
        }
      },
      {
        "box": {
          "comment": "pulse width duty cycle (0.0 - 1.0)",
          "id": "obj-in-pw",
          "index": 3,
          "maxclass": "inlet",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            240,
            50,
            25,
            25
          ]
        }
      },
      {
        "box": {
          "comment": "hard-sync trigger (signal)",
          "id": "obj-in-sync",
          "index": 4,
          "maxclass": "inlet",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            320,
            50,
            25,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-offset",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "patching_rect": [
            40,
            110,
            31,
            22
          ],
          "text": "+ 1"
        }
      },
      {
        "box": {
          "id": "obj-saw",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            110,
            150,
            60,
            22
          ],
          "text": "saw~ #1"
        }
      },
      {
        "box": {
          "id": "obj-tri",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            185,
            150,
            52,
            22
          ],
          "text": "tri~ #1"
        }
      },
      {
        "box": {
          "id": "obj-rect",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            250,
            150,
            58,
            22
          ],
          "text": "rect~ #1"
        }
      },
      {
        "box": {
          "id": "obj-noise",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            325,
            150,
            44,
            22
          ],
          "text": "noise~"
        }
      },
      {
        "box": {
          "id": "obj-selector",
          "maxclass": "newobj",
          "numinlets": 5,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            40,
            220,
            304,
            22
          ],
          "text": "selector~ 4"
        }
      },
      {
        "box": {
          "comment": "audio output",
          "id": "obj-out",
          "index": 1,
          "maxclass": "outlet",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            40,
            280,
            28,
            28
          ]
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "destination": [
            "obj-offset",
            0
          ],
          "source": [
            "obj-in-type",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-selector",
            0
          ],
          "source": [
            "obj-offset",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-saw",
            0
          ],
          "order": 2,
          "source": [
            "obj-in-freq",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-tri",
            0
          ],
          "order": 1,
          "source": [
            "obj-in-freq",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-rect",
            0
          ],
          "order": 0,
          "source": [
            "obj-in-freq",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-rect",
            1
          ],
          "source": [
            "obj-in-pw",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-saw",
            1
          ],
          "order": 2,
          "source": [
            "obj-in-sync",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-tri",
            2
          ],
          "order": 1,
          "source": [
            "obj-in-sync",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-rect",
            2
          ],
          "order": 0,
          "source": [
            "obj-in-sync",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-selector",
            1
          ],
          "source": [
            "obj-saw",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-selector",
            2
          ],
          "source": [
            "obj-tri",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-selector",
            3
          ],
          "source": [
            "obj-rect",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-selector",
            4
          ],
          "source": [
            "obj-noise",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-out",
            0
          ],
          "source": [
            "obj-selector",
            0
          ]
        }
      }
    ]
  }
}