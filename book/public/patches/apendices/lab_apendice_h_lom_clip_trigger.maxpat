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
			960,
			720
		],
		"bglocked": 0,
		"openinpresentation": 1,
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
		"description": "Laboratorio Apendice H: Max for Live, LOM y Disparador Reactivo de Clips",
		"digest": "",
		"tags": "MaxMSP, Ableton Live, M4L, LOM, LiveAPI, live.path, live.observer, live.object",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-header-comment",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30,
						20,
						700,
						26
					],
					"presentation": 1,
					"presentation_rect": [
						15,
						10,
						420,
						24
					],
					"fontsize": 14,
					"fontface": 1,
					"text": "M4L · LOM CLIP TRIGGER & TELEMETRÍA REACTIVA",
					"textcolor": [
						0.92,
						0.42,
						0.21,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-desc-comment",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30,
						50,
						750,
						20
					],
					"presentation": 1,
					"presentation_rect": [
						15,
						32,
						420,
						18
					],
					"fontsize": 10,
					"text": "Detecta canonical_parent, monitorea tempo y dispara clips via live.object.",
					"textcolor": [
						0.65,
						0.65,
						0.65,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-live-thisdevice",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"bang",
						"int",
						"bang"
					],
					"patching_rect": [
						30,
						90,
						110,
						22
					],
					"text": "live.thisdevice"
				}
			},
			{
				"box": {
					"id": "obj-init-msg",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						121,
						125,
						280,
						22
					],
					"text": "path live_set this_device canonical_parent"
				}
			},
			{
				"box": {
					"id": "obj-live-path-parent",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						121,
						160,
						85,
						22
					],
					"text": "live.path"
				}
			},
			{
				"box": {
					"id": "obj-parent-id-comment",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						220,
						160,
						200,
						20
					],
					"text": "ID de la pista actual (canonical_parent)"
				}
			},
			{
				"box": {
					"id": "obj-listen-tempo-msg",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						480,
						125,
						150,
						22
					],
					"text": "path live_set"
				}
			},
			{
				"box": {
					"id": "obj-path-tempo",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						480,
						160,
						85,
						22
					],
					"text": "live.path"
				}
			},
			{
				"box": {
					"id": "obj-observer-tempo",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						480,
						200,
						160,
						22
					],
					"text": "live.observer property tempo"
				}
			},
			{
				"box": {
					"id": "obj-tempo-display",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_type": 0,
							"parameter_unitstyle": 3,
							"parameter_mmin": 20,
							"parameter_mmax": 999,
							"parameter_shortname": "Tempo",
							"parameter_longname": "Tempo"
						}
					},
					"patching_rect": [
						480,
						240,
						60,
						15
					],
					"presentation": 1,
					"presentation_rect": [
						320,
						65,
						65,
						15
					]
				}
			},
			{
				"box": {
					"id": "obj-tempo-label",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						550,
						240,
						100,
						20
					],
					"presentation": 1,
					"presentation_rect": [
						320,
						48,
						80,
						16
					],
					"fontsize": 10,
					"text": "TEMPO (BPM)",
					"textcolor": [
						0.8,
						0.8,
						0.8,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-slot-selector",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_type": 1,
							"parameter_mmin": 0,
							"parameter_mmax": 7,
							"parameter_initial": [
								0
							],
							"parameter_initial_enable": 1,
							"parameter_shortname": "Clip Slot",
							"parameter_longname": "Slot"
						}
					},
					"patching_rect": [
						121,
						240,
						45,
						48
					],
					"presentation": 1,
					"presentation_rect": [
						25,
						55,
						45,
						48
					]
				}
			},
			{
				"box": {
					"id": "obj-btn-fire",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_type": 2,
							"parameter_mmax": 1,
							"parameter_enum": [
								"val1",
								"val2"
							],
							"parameter_shortname": "Fire",
							"parameter_longname": "Fire"
						}
					},
					"patching_rect": [
						180,
						240,
						65,
						25
					],
					"presentation": 1,
					"presentation_rect": [
						85,
						65,
						65,
						26
					],
					"text": "FIRE",
					"texton": "FIRING"
				}
			},
			{
				"box": {
					"id": "obj-btn-stop",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_type": 2,
							"parameter_mmax": 1,
							"parameter_enum": [
								"val1",
								"val2"
							],
							"parameter_shortname": "Stop",
							"parameter_longname": "Stop"
						}
					},
					"patching_rect": [
						255,
						240,
						55,
						25
					],
					"presentation": 1,
					"presentation_rect": [
						160,
						65,
						55,
						26
					],
					"text": "STOP",
					"texton": "STOPPING"
				}
			},
			{
				"box": {
					"id": "obj-clip-path-fmt",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						121,
						310,
						250,
						22
					],
					"text": "sprintf path live_set this_device canonical_parent clip_slots %d clip"
				}
			},
			{
				"box": {
					"id": "obj-live-path-clip",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						121,
						345,
						85,
						22
					],
					"text": "live.path"
				}
			},
			{
				"box": {
					"id": "obj-live-obj-clip",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						121,
						420,
						100,
						22
					],
					"text": "live.object"
				}
			},
			{
				"box": {
					"id": "obj-fire-msg",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						180,
						380,
						55,
						22
					],
					"text": "call fire"
				}
			},
			{
				"box": {
					"id": "obj-stop-msg",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						255,
						380,
						55,
						22
					],
					"text": "call stop"
				}
			},
			{
				"box": {
					"id": "obj-audio-in",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 4,
					"outlettype": [
						"signal",
						"signal",
						"",
						""
					],
					"patching_rect": [
						480,
						310,
						80,
						22
					],
					"text": "plugin~"
				}
			},
			{
				"box": {
					"id": "obj-audio-out",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						"signal"
					],
					"patching_rect": [
						480,
						420,
						80,
						22
					],
					"text": "plugout~"
				}
			},
			{
				"box": {
					"id": "obj-meter",
					"maxclass": "live.meter~",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"float",
						"float"
					],
					"patching_rect": [
						580,
						350,
						15,
						90
					],
					"presentation": 1,
					"presentation_rect": [
						240,
						50,
						18,
						45
					]
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"destination": [
						"obj-init-msg",
						0
					],
					"source": [
						"obj-live-thisdevice",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-listen-tempo-msg",
						0
					],
					"source": [
						"obj-live-thisdevice",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-live-path-parent",
						0
					],
					"source": [
						"obj-init-msg",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-path-tempo",
						0
					],
					"source": [
						"obj-listen-tempo-msg",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-observer-tempo",
						1
					],
					"source": [
						"obj-path-tempo",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-tempo-display",
						0
					],
					"source": [
						"obj-observer-tempo",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-clip-path-fmt",
						0
					],
					"source": [
						"obj-slot-selector",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-live-path-clip",
						0
					],
					"source": [
						"obj-clip-path-fmt",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-live-obj-clip",
						1
					],
					"source": [
						"obj-live-path-clip",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-fire-msg",
						0
					],
					"source": [
						"obj-btn-fire",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-stop-msg",
						0
					],
					"source": [
						"obj-btn-stop",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-live-obj-clip",
						0
					],
					"source": [
						"obj-fire-msg",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-live-obj-clip",
						0
					],
					"source": [
						"obj-stop-msg",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-audio-out",
						0
					],
					"source": [
						"obj-audio-in",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-audio-out",
						1
					],
					"source": [
						"obj-audio-in",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-meter",
						0
					],
					"source": [
						"obj-audio-in",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-meter",
						1
					],
					"source": [
						"obj-audio-in",
						1
					]
				}
			}
		]
	}
}