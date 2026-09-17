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
      450,
      350
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
    "description": "ab.sus: Argument Fallback Dinamico. Si la entrada es 0 o nula, sustituye por el argumento #1",
    "boxes": [
      {
        "box": {
          "id": "obj-comment",
          "linecount": 2,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            140,
            80,
            260,
            33
          ],
          "text": "Si el input es 0, dispara el argumento #1 como valor por defecto de respaldo."
        }
      },
      {
        "box": {
          "comment": "input control / float",
          "id": "obj-inlet",
          "index": 1,
          "maxclass": "inlet",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            50,
            30,
            28,
            28
          ]
        }
      },
      {
        "box": {
          "id": "obj-f",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "float"
          ],
          "patching_rect": [
            50,
            80,
            31,
            22
          ],
          "text": "f"
        }
      },
      {
        "box": {
          "id": "obj-sel",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "bang",
            ""
          ],
          "patching_rect": [
            50,
            120,
            43,
            22
          ],
          "text": "sel 0."
        }
      },
      {
        "box": {
          "id": "obj-msg-arg",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            50,
            170,
            50,
            22
          ],
          "text": "#1"
        }
      },
      {
        "box": {
          "comment": "output con fallback resuelto",
          "id": "obj-outlet",
          "index": 1,
          "maxclass": "outlet",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            50,
            230,
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
            "obj-f",
            0
          ],
          "source": [
            "obj-inlet",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-sel",
            0
          ],
          "source": [
            "obj-f",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-msg-arg",
            0
          ],
          "source": [
            "obj-sel",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-outlet",
            0
          ],
          "source": [
            "obj-msg-arg",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-outlet",
            0
          ],
          "midpoints": [
            83.5,
            205,
            59.5,
            205
          ],
          "source": [
            "obj-sel",
            1
          ]
        }
      }
    ]
  }
}